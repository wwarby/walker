using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Math as Math;

class WalkerView extends Ui.DataField {
	
	/* NOTE: Violation of SOLID principles (and general good maintainable code hygene) here is intentional. Some Garmin watches only
	 * give you 16KB (!) of memory to work with for a DataField, and about 9KB of that allowance gets used up on the DataField itself
	 * before you've written a line of code. Keeping memory usage that low is a challenge, and requires a Scrooge-like accounting of
	 * memory allocations. No unnecessary intermediate variables, no single instance classes, no single call functions etc. It makes
	 * the code hard to read, but the codebase is sufficiently small that it shouldn't be a problem
	 */
	
	hidden var doUpdates = false;
	hidden var is24Hour = false;
	
	hidden var previousDarkMode;
	hidden var previousBatteryState;
	
	hidden var heartRateIcon;
	hidden var stepsIcon;
	hidden var caloriesIcon;
	hidden var batteryIcon;
	
	hidden var batteryTextColour;
	
	hidden var paceData;
	hidden var heartRateData;
	
	hidden var previousDaySteps = 0;
	hidden var stepsWhenTimerBecameActive = 0;
	hidden var activityStepsAtPreviousLap = 0;
	hidden var consolidatedSteps = 0;
	
	// User definable settings. Stored as numbers rather than enums because enums waste valuable memory.
	hidden var paceMode = 0;
	hidden var heartRateMode = 0;
	
	hidden var timerActive = false;
	
	hidden var kmOrMileInMeters;
	hidden var kmOrMilesLabel;
	
	// Calculated values that change on every call to compute()
	var steps;
	var lapSteps;
	hidden var averagePace;
	hidden var distance;
	hidden var heartRate;
	hidden var pace;
	hidden var time;
	hidden var daySteps;
	hidden var calories;
	hidden var dayCalories;
	hidden var stepGoalProgress;
	
	// FIT contributor fields
	hidden var stepsActivityField = null;
	hidden var stepsLapField = null;
	
	function initialize() {
	
		DataField.initialize();
		
		readSettings();
		
		var app = Application.getApp();
		var info = Activity.getActivityInfo();
		
		// If the activity has restarted after "resume later", load previously stored steps values
		if (info != null && info.elapsedTime > 0) {
	        steps = app.getProperty("as");
	        lapSteps = app.getProperty("ls");
	        if (steps == null) { steps = 0; }
	        if (lapSteps == null) { lapSteps = 0; }
	    }
		
		// Create FIT contributor fields
		stepsActivityField = createField(Ui.loadResource(Rez.Strings.steps), 0, 4 /* Fit.DATA_TYPE_UINT16 */,
            { :mesgType => 18 /* Fit.MESG_TYPE_SESSION */, :units => Ui.loadResource(Rez.Strings.stepsUnits) });
        stepsLapField = createField(Ui.loadResource(Rez.Strings.steps), 1, 4 /* Fit.DATA_TYPE_UINT16 */,
            { :mesgType => 19 /* Fit.MESG_TYPE_LAP */, :units => Ui.loadResource(Rez.Strings.stepsUnits) });
        
        // Set initial steps FIT contributions to zero
        stepsActivityField.setData(0);
        stepsLapField.setData(0);
	}
	
	// Called on initialization and when settings change (from a hook in WalkerApp.mc)
	function readSettings() {
		
		var deviceSettings = System.getDeviceSettings();
		
		is24Hour = deviceSettings.is24Hour;
		
		kmOrMileInMeters = deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? 1000.0f : 1609.34f;
		kmOrMilesLabel = deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? "km" : "mi";
		
		paceMode = Application.getApp().getProperty("pm");
		if (paceMode > 0) {
			paceData = new DataQueue(paceMode);
		} else {
			paceData = null;
		}
		
		heartRateMode = Application.getApp().getProperty("hm");
		if (heartRateMode > 0) {
			heartRateData = new DataQueue(heartRateMode);
		} else {
			heartRateData = null;
		}
	}
	
	// Avoid drawing to the screen when we're not visible
	function onShow() { doUpdates = true; }
	function onHide() { doUpdates = false; }
	
	// Handle activity timer events
	function onTimerStart() { timerStart(); }
	function onTimerResume() { timerStart(); }
	function onTimerStop() { timerStop(); }
	function onTimerPause() { timerStop(); }
	function onTimerLap() { activityStepsAtPreviousLap = steps; }
	
	function onTimerReset() {
		consolidatedSteps = 0;
		stepsWhenTimerBecameActive = 0;
		activityStepsAtPreviousLap = 0;
		previousDaySteps = 0;
		steps = 0;
		lapSteps = 0;
		timerActive = false;
	}
	
	function timerStart() {
		stepsWhenTimerBecameActive = ActivityMonitor.getInfo().steps;
		timerActive = true;
	}
	
	function timerStop() {
		consolidatedSteps = steps;
		timerActive = false;
	}
	
	function compute(info) {
		
		var activityMonitorInfo = ActivityMonitor.getInfo();
		
		// Distance
		distance = info.elapsedDistance;
		
		// Heart Rate
		if (heartRateData != null) {
			if (info.currentHeartRate != null) {
				heartRateData.add(info.currentHeartRate);
			} else {
				heartRateData.reset();
			}
		}
		heartRate = heartRateMode <= 0
			? info.currentHeartRate
			: heartRateData != null
				? heartRateData.average()
				: null;
		
		// Pace
		if (paceData != null) {
			if (info.currentSpeed != null) {
				paceData.add(info.currentSpeed);
			} else {
				paceData.reset();
			}
		}
		var speed = paceMode == 0
			? info.currentSpeed
			: paceData != null
				? paceData.average()
				: null;
		pace = (speed != null && speed > 0.2) ? (kmOrMileInMeters / speed) : null;
		averagePace = (info.averageSpeed != null && info.averageSpeed > 0.2) ? (kmOrMileInMeters / info.averageSpeed) : null;
		
		// Time
		time = info.timerTime;
		
		// Day steps
		daySteps = activityMonitorInfo.steps;
		if (previousDaySteps > 0 && daySteps < previousDaySteps) {
			// Uh-oh, the daily step count has reduced - out for a midnight stroll are we?
			stepsWhenTimerBecameActive -= previousDaySteps;
		}
		previousDaySteps = daySteps;
		
		// Steps
		if (timerActive) {
			steps = consolidatedSteps + daySteps - stepsWhenTimerBecameActive;
			lapSteps = steps - activityStepsAtPreviousLap;
			
			// Update step FIT contributions
			stepsActivityField.setData(steps);
			stepsLapField.setData(lapSteps);
		}
		stepGoalProgress = activityMonitorInfo.stepGoal != null && activityMonitorInfo.stepGoal > 0
			? daySteps > activityMonitorInfo.stepGoal
				? 1
				: daySteps / activityMonitorInfo.stepGoal.toFloat()
			: 0;
		
		// Calories
		calories = info.calories;
		dayCalories = activityMonitorInfo.calories;
	}
	
	function onUpdate(dc) {
	
		if (doUpdates == false) { return; }
		
		var halfWidth = dc.getWidth() / 2;
		
		var paceText = formatTime(pace == null ? null : pace * 1000.0, false);
		var timeText = formatTime(time == null ? null : time, false);
		var shrinkMiddleText = paceText.length() > 5 || timeText.length() > 5;
		
		// Set colours
		var backgroundColour = self has :getBackgroundColor ? getBackgroundColor() : 0xFFFFFF /* Gfx.COLOR_WHITE */;
		var darkMode = backgroundColour == 0x000000 /* Gfx.COLOR_BLACK */;
		
		// Choose the colour of the battery based on it's state
		var battery = System.getSystemStats().battery;
		var batteryState = battery >= 50
			? 0
			: battery <= 10
				? 1
				: battery <= 20
					? 2
					: 3;
		if (batteryState != previousBatteryState || (batteryState == 3 && previousDarkMode != darkMode)) {
			switch (batteryState) {
				case 0:
					batteryIcon = Ui.loadResource(Rez.Drawables.ibf);
					batteryTextColour = 0xFFFFFF /* Gfx.COLOR_WHITE */;
					break;
				case 1:
					batteryIcon = Ui.loadResource(Rez.Drawables.ibe);
					batteryTextColour = 0xFFFFFF /* Gfx.COLOR_WHITE */;
					break;
				case 2:
					batteryIcon = Ui.loadResource(Rez.Drawables.ibw);
					batteryTextColour = 0xFFFFFF /* Gfx.COLOR_WHITE */;
					break;
				case 3:
					batteryIcon = Ui.loadResource(darkMode ? Rez.Drawables.ibd : Rez.Drawables.ib);
					batteryTextColour = darkMode ? 0x000000 /* Gfx.COLOR_BLACK */ : 0xFFFFFF /* Gfx.COLOR_WHITE */;
					break;
			}
		}
		
		// Max width values for layout debugging
		/*
		averagePace = 100000;
		distance = 888888.888;
		heartRate = 888;
		paceText = 8:88:88;
		timeText = 8:88:88;
		steps = 88888;
		daySteps = 88888;
		calories = 88888;
		dayCalories = 88888;
		stepGoalProgress = 0.75;
		*/
		
		// Realistic static values for screenshots
		/*
		averagePace = 44520;
		distance = 1921;
		heartRate = 106;
		paceText = "12:15";
		timeText = "23:31";
		steps = 2331;
		daySteps = 7490;
		calories = 135;
		dayCalories = 1742;
		stepGoalProgress = 0.75;
		*/
		
		// If we've never loaded the icons before or dark mode has been toggled, load the icons
		if (previousDarkMode != darkMode) {
			previousDarkMode = darkMode;
			heartRateIcon = Ui.loadResource(Rez.Drawables.ihr);
			stepsIcon = Ui.loadResource(darkMode ? Rez.Drawables.isd : Rez.Drawables.is);
			caloriesIcon = Ui.loadResource(darkMode ? Rez.Drawables.icd : Rez.Drawables.ic);
		}
		
		// Render background
		dc.setColor(backgroundColour, backgroundColour);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
		
		// Render horizontal lines
		dc.setColor(0xAAAAAA /* Gfx.COLOR_LT_GRAY */, -1 /* Gfx.COLOR_TRANSPARENT */);
		for (var x = 0; x < lines.size(); x++) {
        	dc.drawLine(0, lines[x], dc.getWidth(), lines[x]);
		}
		
		// Render vertical lines
		dc.drawLine(halfWidth, lines[0], halfWidth, lines[1]);
		dc.drawLine(halfWidth, lines[2], halfWidth, lines[3]);
		
		// Render step goal progress bar
		if (stepGoalProgress != null && stepGoalProgress > 0) {
			dc.setColor(darkMode ? 0x00FF00 /* Gfx.COLOR_GREEN */ : 0x00AA00 /* Gfx.COLOR_DK_GREEN */, -1 /* Gfx.COLOR_TRANSPARENT */);
			dc.drawRectangle(stepGoalProgressOffsetX, lines[2] - 1, (dc.getWidth() - (stepGoalProgressOffsetX * 2)) * stepGoalProgress, 3);
		}
		
		// Set text rendering colour
		dc.setColor(darkMode ? 0xFFFFFF /* Gfx.COLOR_WHITE */ : 0x000000 /* Gfx.COLOR_BLACK */, -1 /* Gfx.COLOR_TRANSPARENT */);
		
		// Render clock
		var currentTime = System.getClockTime();
		var hour = is24Hour ? currentTime.hour : currentTime.hour % 12;
		if (!is24Hour && hour == 0) { hour = 12; }
		dc.drawText(halfWidth + clockOffsetX, clockY, 0 /* Gfx.FONT_XTINY */,
			hour.format(is24Hour ? "%02d" : "%d")
			  + ":"
			  + currentTime.min.format("%02d")
			  + (is24Hour ? "" : currentTime.hour >= 12 ? "pm" : "am"),
			  1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render average pace
		dc.drawText(halfWidth - centerOffsetX, topRowY, 0 /* Gfx.FONT_XTINY */,
			formatTime(averagePace == null ? null : averagePace * 1000.0, true) + "/" + kmOrMilesLabel, 0 /* Gfx.TEXT_JUSTIFY_RIGHT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render distance
		var distanceText;
		if (distance != null && distance > 0) {
			var distanceKmOrMiles = distance / kmOrMileInMeters;
			if (distanceKmOrMiles >= 1000) {
				distanceText = distanceKmOrMiles.format("%d");
			} else if (distanceKmOrMiles >= 100) {
				distanceText = distanceKmOrMiles.format("%.1f");
			} else {
				distanceText = distanceKmOrMiles.format("%.2f");
			}
		} else {
			distanceText = "0:00";
		}
		dc.drawText(halfWidth + centerOffsetX, topRowY, 0 /* Gfx.FONT_XTINY */,
			distanceText + kmOrMilesLabel, 2 /* Gfx.TEXT_JUSTIFY_LEFT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render heart rate
		var heartRateText = (heartRate == null ? 0 : heartRate).format("%d");
		var heartRateWidth = dc.getTextDimensions(heartRateText, 0 /* Gfx.FONT_XTINY */)[0];
		dc.drawBitmap(halfWidth - (heartRateIcon.getWidth() / 2), heartRateIconY, heartRateIcon);
		dc.drawText(halfWidth, heartRateTextY, 0 /* Gfx.FONT_XTINY */,
			heartRateText, 1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render current pace
		dc.drawText((halfWidth / 2) - (heartRateWidth / 2) + 5, middleRowLabelY, 0 /* Gfx.FONT_XTINY */,
			Ui.loadResource(Rez.Strings.pace), 1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		dc.drawText(
		(halfWidth / 2) - (heartRateWidth / 2) + 5,
			middleRowValueY,
			shrinkMiddleText ? 2 /* Gfx.FONT_SMALL */ : 5 /* Gfx.FONT_NUMBER_MILD */,
			paceText,
			1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
			
		// Render timer
		dc.drawText((halfWidth * 1.5) + (heartRateWidth / 2) - 5, middleRowLabelY, 0 /* Gfx.FONT_XTINY */,
			Ui.loadResource(Rez.Strings.timer), 1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		dc.drawText(
			(halfWidth * 1.5) + (heartRateWidth / 2) - 5,
			middleRowValueY,
			shrinkMiddleText ? 2 /* Gfx.FONT_SMALL */ : 5 /* Gfx.FONT_NUMBER_MILD */,
			timeText,
			1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render steps
		dc.drawBitmap(bottomRowIconX, bottomRowIconY, stepsIcon);
		dc.drawText(halfWidth - centerOffsetX, bottomRowUpperTextY, 0 /* Gfx.FONT_XTINY */,
			(steps == null ? 0 : steps).format("%d"), 0 /* Gfx.TEXT_JUSTIFY_RIGHT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render calories
		dc.drawBitmap(dc.getWidth() - bottomRowIconX - caloriesIcon.getWidth(), bottomRowIconY, caloriesIcon);
		dc.drawText(halfWidth + centerOffsetX, bottomRowUpperTextY, 0 /* Gfx.FONT_XTINY */,
			(calories == null ? 0 : calories).format("%d"), 2 /* Gfx.TEXT_JUSTIFY_LEFT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Set grey colour for day counts
		dc.setColor(darkMode ? 0x555555 /* Gfx.COLOR_DK_GRAY */ : 0xAAAAAA /* Gfx.COLOR_LT_GRAY */, -1 /* Gfx.COLOR_TRANSPARENT */);
		
		// Render day steps
		dc.drawText(halfWidth - centerOffsetX, bottomRowLowerTextY, 0 /* Gfx.FONT_XTINY */,
			(daySteps == null ? 0 : daySteps).format("%d"), 0 /* Gfx.TEXT_JUSTIFY_RIGHT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render day calories
		dc.drawText(halfWidth + centerOffsetX, bottomRowLowerTextY, 0 /* Gfx.FONT_XTINY */,
			(dayCalories == null ? 0 : dayCalories).format("%d"), 2 /* Gfx.TEXT_JUSTIFY_LEFT */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
		
		// Render battery
		dc.drawBitmap(halfWidth - (batteryIcon.getWidth() / 2) + 2 + batteryX, batteryY - (batteryIcon.getHeight() / 2), batteryIcon);
		dc.setColor(batteryTextColour, -1 /* Gfx.COLOR_TRANSPARENT */);
		dc.drawText(halfWidth + batteryX, batteryY - 1, 0 /* Gfx.FONT_XTINY */,
			System.getSystemStats().battery.format("%d") + "%", 1 /* Gfx.TEXT_JUSTIFY_CENTER */ | 4 /* Gfx.TEXT_JUSTIFY_VCENTER */);
	}
	
	function formatTime(milliseconds, short) {
		if (milliseconds != null && milliseconds > 0) {
			var hours = null;
			var minutes = Math.floor(milliseconds / 1000 / 60).toNumber();
			var seconds = Math.floor(milliseconds / 1000).toNumber() % 60;
			if (minutes >= 60) {
				hours = minutes / 60;
				minutes = minutes % 60;
			}
			if (hours == null) {
				return minutes.format("%d") + ":" + seconds.format("%02d");
			} else if (short) {
				return hours.format("%d") + ":" + minutes.format("%02d");
			} else {
				return hours.format("%d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d");
			}
		} else {
			return "0:00";
		}
	}

}
