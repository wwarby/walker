import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Math as Math;
using Toybox.UserProfile as User;
using Toybox.Graphics as Gfx;
using Toybox.FitContributor as Fit;

class WalkerView extends Ui.DataField {
	
	/* NOTE: This version of the codebase is intended to support Garmin watches with 32KB of working memory per DataField, of which about
	 * 9KB of gets used up on the DataField itself before you've written a line of code. Whilst not quite as severe as the 16KB models,
	 * it is good practice on Garmin watches to keep memory as low as possible to keep space available for new feature development. This means
	 * using no unnecessary intermediate variables, single instance classes, no single call functions etc. It makes the code hard to read,
	 * but it's necessary to squeeze the required functionality into the available memory space.
	 */
	
	var is24Hour = false;
	
	var previousDarkMode;
	var darkModeFromSetting = false;
	
	var stepsIcon;
	var caloriesIcon;
	
	var batteryIconColour;
	var batteryTextColour;
	var heartRateIconColour;
	var heartRateZoneTextColour;
	
	var paceOrSpeedData;
	var heartRateData;
	
	var previousDaySteps = 0;
	var stepsWhenTimerBecameActive = 0;
	var activityStepsAtPreviousLap = 0;
	var consolidatedSteps = 0;
	
	// User definable settings. Stored as numbers rather than enums because enums waste valuable memory.
	var paceOrSpeedMode = 0;
	var heartRateMode = 0;
	var showHeartRateZone = false;
	var showSpeedInsteadOfPace = false;
	
	var timerActive = false;
	
	var kmOrMileInMetersDistance;
	var kmOrMileInKmPace;
	var averagePaceOrSpeedUnitsLabel;
	var distanceUnitsLabel;
	
	// Calculated values that change on every call to compute()
	var steps;
	var lapSteps;
	var averagePaceOrSpeed;
	var distance;
	var heartRate;
	var heartRateZone;
	var paceOrSpeed;
	var time;
	var daySteps;
	var calories;
	var dayCalories;
	var stepGoalProgress;
	
	// FIT contributor fields
	var stepsActivityField;
	var stepsLapField;
	var stepsPerKmOrMileField;
	var stepsPerHourField;
	var averageStepsPerKmOrMileField;
	var averageStepsPerHourField;

	var previousDistanceUnits;

	// Fixed window of 60 seconds for determining "steps per" values for chart FIT contributions
	var stepData = new DataQueue(60, false);
	var stepDataCount = 0;
	
	function initialize() {
	
		DataField.initialize();
		
		readSettings();
		
		var info = Activity.getActivityInfo();
		
		// If the activity has restarted after "resume later", load previously stored steps values
		if (info != null && info.elapsedTime > 0) {
			var app = Application.getApp();
			steps = app.getProperty("as");
			activityStepsAtPreviousLap = app.getProperty("ls");
			app = null;
			if (steps == null) { steps = 0; }
			if (lapSteps == null) { lapSteps = 0; }
			// Consolidate the previously stored steps, otherwise we will lose them when steps are next calculated
			consolidatedSteps = steps;
		}
		
		var stepsLabel = Ui.loadResource(Rez.Strings.steps);
		var stepsUnits = Ui.loadResource(Rez.Strings.stepsUnits);
		
		// Create FIT contributor fields
		stepsActivityField = createField("steps", 0, Fit.DATA_TYPE_UINT32, { :mesgType => Fit.MESG_TYPE_SESSION, :units => stepsUnits });
		stepsLapField = createField("steps", 1, Fit.DATA_TYPE_UINT32, { :mesgType => Fit.MESG_TYPE_LAP, :units => stepsUnits });

		// Set initial steps FIT contributions to zero
		stepsActivityField.setData(0);
		stepsLapField.setData(0);
	}
	
	// Called on initialization and when settings change (from a hook in WalkerApp.mc)
	function readSettings() {
		
		var deviceSettings = System.getDeviceSettings();
		var app = Application.getApp();
		
		// 12 / 24 hour mode
		is24Hour = deviceSettings.is24Hour;
		
		// Dark mode
		darkModeFromSetting = app.getProperty("d") == true;
		
		// Speed / pace mode 
		paceOrSpeedMode = app.getProperty("pm");
		if (paceOrSpeedMode > 0) {
			paceOrSpeedData = new DataQueue(paceOrSpeedMode, true);
		} else {
			paceOrSpeedData = null;
		}
		
		heartRateMode = app.getProperty("hm");
		if (heartRateMode > 0) {
			heartRateData = new DataQueue(heartRateMode, true);
		} else {
			heartRateData = null;
		}
		
		showHeartRateZone = app.getProperty("z");
		showSpeedInsteadOfPace = app.getProperty("s");
		
		kmOrMileInMetersDistance = deviceSettings.distanceUnits == System.UNIT_METRIC ? 1000.0f : 1609.34f;
		kmOrMileInKmPace = deviceSettings.paceUnits == System.UNIT_METRIC ? 1.0f : 1.60934f;
		distanceUnitsLabel = deviceSettings.distanceUnits == System.UNIT_METRIC ? "km" : "mi";
		averagePaceOrSpeedUnitsLabel = showSpeedInsteadOfPace ? "/hr" : "/" + (deviceSettings.paceUnits == System.UNIT_METRIC ? "km" : "mi");
		
		// Short circuit if we have already created our FIT contributor fields and the distance unit setting hasn't changed
		if (deviceSettings.distanceUnits == previousDistanceUnits) { return; }
		
		// Create FIT contributor fields
		
		var stepsUnits = Ui.loadResource(Rez.Strings.stepsUnits);
		
		stepsPerKmOrMileField = createField(
			deviceSettings.distanceUnits == System.UNIT_METRIC ? "stepsPerKm" : "stepsPerMile",
			deviceSettings.distanceUnits == System.UNIT_METRIC ? 2 : 3,	Fit.DATA_TYPE_FLOAT, { :mesgType => Fit.MESG_TYPE_RECORD, :units => stepsUnits });
		
		stepsPerHourField = createField("stepsPerHour", 4, Fit.DATA_TYPE_FLOAT, { :mesgType => Fit.MESG_TYPE_RECORD, :units => stepsUnits });

		averageStepsPerKmOrMileField = createField(
			deviceSettings.distanceUnits == System.UNIT_METRIC ? "avgStepsPerKm" : "avgStepsPerMile",
			deviceSettings.distanceUnits == System.UNIT_METRIC ? 5 : 6, Fit.DATA_TYPE_FLOAT, { :mesgType => Fit.MESG_TYPE_SESSION, :units => stepsUnits });
		
		averageStepsPerHourField = createField("avgStepsPerHour", 7, Fit.DATA_TYPE_FLOAT, { :mesgType => Fit.MESG_TYPE_SESSION, :units => stepsUnits });
			
		// Set initial steps FIT contributions to zero
		stepsPerKmOrMileField.setData(0);
		stepsPerHourField.setData(0);
		averageStepsPerKmOrMileField.setData(0);
		averageStepsPerHourField.setData(0);
		
		previousDistanceUnits = deviceSettings.distanceUnits;
	}
	
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
		distance = (info.elapsedDistance != null ? info.elapsedDistance : 0) / kmOrMileInMetersDistance;
		
		// Heart rate
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
				? heartRateData.average
				: null;
		
		// Heart rate zone
		heartRateZone = null;
		if (showHeartRateZone) {
			var heartRateZones = User.getHeartRateZones(User.getCurrentSport());
			heartRateZone = '-';
			if (heartRate != null && heartRate > heartRateZones[0]) {
				for (var x = 1; x < heartRateZones.size(); x++) {
					if (heartRate <= heartRateZones[x]) {
						heartRateZone = x;
						break;
					}
					// We're apparently over the maximum for the highest heart rate zone, so just max out.
					heartRateZone = '+';
				}
			}
		}
		
		// Pace or speed
		if (paceOrSpeedData != null) {
			if (info.currentSpeed != null) {
				paceOrSpeedData.add(info.currentSpeed);
			} else {
				paceOrSpeedData.reset();
			}
		}
		var speed = paceOrSpeedMode == 0
			? info.currentSpeed
			: paceOrSpeedData != null
				? paceOrSpeedData.average
				: null;
		paceOrSpeed = speed != null && speed > 0.1 // Walking at a speed of less than 0.22 miles per hour probably isn't walking
			? showSpeedInsteadOfPace
				// Speed is in meters per second
				? (speed / kmOrMileInKmPace) * 3.6
				: (kmOrMileInKmPace / speed) * 1000000.0
			: null;
		averagePaceOrSpeed = info.averageSpeed != null && info.averageSpeed > 0.1 // Walking at a speed of less than 0.22 miles per hour probably isn't walking
			? showSpeedInsteadOfPace
				? (info.averageSpeed / kmOrMileInKmPace) * 3.6
				: (kmOrMileInKmPace / info.averageSpeed) * 1000000.0
			: null;
		
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
		
		// Add step data to the circular queue
		if (time != null && time > 0 && info.elapsedDistance != null && info.elapsedDistance > 0 && steps != null && steps > 0) {
			stepData.add([time, info.elapsedDistance, steps]);
			
			// Short circuit at this point if we have less than 30 seconds worth of data to avoid a massive spike at the beginning
			// of the charts where the numbers are too low to make sensible averages from
			if (stepDataCount <= 30) {
				stepDataCount++;
				return;
			}
		}
		
		var oldestStepData = stepData.oldest() as Array;
		var newestStepData = stepData.newest() as Array;
		
		// Update "record" (chart) FIT contributions
		if (oldestStepData != null && newestStepData != null) {
			var milliseconds = newestStepData[0] - oldestStepData[0];
			var distance = newestStepData[1] - oldestStepData[1];
			var steps = newestStepData[2] - oldestStepData[2];
			if (milliseconds > 0 && distance > 0 && steps > 0) {
				stepsPerKmOrMileField.setData((steps / distance) * (kmOrMileInMetersDistance / 1000.0) * 1000.0);
				stepsPerHourField.setData((steps / (milliseconds.toFloat())) * 3600000.0);
			}
		}
		
		// Update activity average FIT contributions
		if (steps != null && steps > 0) {
			if (info.elapsedDistance != null && info.elapsedDistance > 0) {
				averageStepsPerKmOrMileField.setData((steps / info.elapsedDistance) * (kmOrMileInMetersDistance / 1000.0) * 1000.0);
			}
			if (time != null && time > 0) {
				averageStepsPerHourField.setData((steps / (time.toFloat())) * 3600000.0);
			}
		}
	}
	
	function onUpdate(dc) {
	
		var layout = getLayout();
	
		var halfWidth = dc.getWidth() / 2;
		var paceOrSpeedText = showSpeedInsteadOfPace ? formatDistance(paceOrSpeed) : formatTime(paceOrSpeed, false);
		var timeText = formatTime(time, false);
		var shrinkMiddleText = paceOrSpeedText.length() > 5 || timeText.length() > 5;
		
		// Background colour
		var backgroundColour =
			darkModeFromSetting
		 		? Gfx.COLOR_BLACK
		 		: WalkerView has :getBackgroundColor
		 			? getBackgroundColor()
		 			: Gfx.COLOR_WHITE;
		var darkMode = backgroundColour == Gfx.COLOR_BLACK;

		var lightGray = layout[34] /* eightColourPalette */ ? Gfx.COLOR_WHITE : Gfx.COLOR_LT_GRAY;
		var darkGray = layout[34] /* eightColourPalette */ ? Gfx.COLOR_BLACK : Gfx.COLOR_DK_GRAY;
		var darkGreen = layout[34] /* eightColourPalette */ ? Gfx.COLOR_GREEN : Gfx.COLOR_DK_GREEN;
		
		// Choose the colour of the battery based on it's state
		var battery = System.getSystemStats().battery;
		var batteryState = battery >= 50
			? 0
			: battery <= 10
				? 1
				: battery <= 20
					? 2
					: 3;
		batteryTextColour = Gfx.COLOR_WHITE;
		if (batteryState == 0) {
			batteryIconColour = darkGreen;
			if (layout[34] /* eightColourPalette */) { batteryTextColour = Gfx.COLOR_BLACK; }
		} else if (batteryState == 1) {
			batteryIconColour = Gfx.COLOR_RED;
		} else if (batteryState == 2) {
			batteryIconColour = Gfx.COLOR_YELLOW;
			batteryTextColour = Gfx.COLOR_BLACK;
		} else {
			batteryIconColour = darkMode ? lightGray : darkGray;
			if (darkMode) { batteryTextColour = Gfx.COLOR_BLACK; }
		}
		
		// Choose the colour of the heart rate icon based on heart rate zone
		heartRateZoneTextColour = Gfx.COLOR_WHITE;
		if (heartRateZone == '-') {
			if (darkMode) {
				heartRateIconColour = darkGray;
			} else {
				heartRateIconColour = lightGray;
				heartRateZoneTextColour = Gfx.COLOR_BLACK;
			}
		} else if (heartRateZone == 1) {
			if (darkMode) {
				heartRateIconColour = lightGray;
				heartRateZoneTextColour = Gfx.COLOR_BLACK;
			} else {
				heartRateIconColour = darkGray;
			}
		} else if (heartRateZone == 2) {
			heartRateIconColour = Gfx.COLOR_BLUE;
			if (layout[34] /* eightColourPalette */) { heartRateZoneTextColour = Gfx.COLOR_BLACK; }
		} else if (heartRateZone == 3) {
			heartRateIconColour = darkGreen;
		} else if (heartRateZone == 4) {
			heartRateIconColour = Gfx.COLOR_YELLOW;
			heartRateZoneTextColour = Gfx.COLOR_BLACK;
		} else {
			heartRateIconColour = Gfx.COLOR_RED;
		}
		
		// Max width values for layout debugging
		/*
		averagePaceOrSpeed = 888888;
		distance = 808.88;
		heartRate = 888;
		paceOrSpeedText = "8:88:88";
		timeText = "8:88:88";
		steps = 88888;
		daySteps = 88888;
		calories = 88888;
		dayCalories = 88888;
		stepGoalProgress = 0.75;
		shrinkMiddleText = true;
		*/
		
		// Realistic static values for screenshots
		/*
		averagePaceOrSpeed = 888888;
		distance = 1.92;
		heartRate = 106;
		paceOrSpeedText = "12:15";
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
			stepsIcon = Ui.loadResource(darkMode ? Rez.Drawables.isd : Rez.Drawables.is);
			caloriesIcon = Ui.loadResource(darkMode ? Rez.Drawables.icd : Rez.Drawables.ic);
		}
		
		// Render background
		dc.setColor(backgroundColour, backgroundColour);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
		
		// Render horizontal lines
		dc.setColor(layout[34] /* eightColourPalette */ ? (darkMode ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK) : Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		for (var x = 0; x < (layout[3] /* lines[3] */ > 0 ? 4 : 3); x++) {
			dc.drawLine(0, layout[x] /* lines[x] */, dc.getWidth(), layout[x]);
		}
		
		// Render vertical lines
		dc.drawLine(halfWidth, layout[0] /* lines[0] */, halfWidth, layout[1] /* lines[1] */);
		dc.drawLine(halfWidth, layout[2] /* lines[2] */, halfWidth, layout[3] /* lines[3] */ > 0 ? layout[3] /* lines[3] */ : dc.getHeight());
		
		// Render step goal progress bar
		if (stepGoalProgress != null && stepGoalProgress > 0) {
			dc.setColor(darkMode ? Gfx.COLOR_GREEN : darkGreen, Gfx.COLOR_TRANSPARENT);
			dc.drawRectangle(layout[4] /* stepGoalProgressOffsetX */, layout[2] /* lines[2] */ - 1, (dc.getWidth() - (layout[4] /* stepGoalProgressOffsetX */ * 2)) * stepGoalProgress, 3);
		}
		
		// Set text rendering colour
		dc.setColor(darkMode ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		
		// Render clock
		var currentTime = System.getClockTime();
		var hour = is24Hour ? currentTime.hour : currentTime.hour % 12;
		if (!is24Hour && hour == 0) { hour = 12; }
		dc.drawText(halfWidth + layout[7] /* clockOffsetX */, layout[6] /* clockY */, layout[26] /* timeFont */,
			hour.format(is24Hour ? "%02d" : "%d")
				+ ":"
				+ currentTime.min.format("%02d")
				+ (is24Hour ? "" : currentTime.hour >= 12 ? "pm" : "am"),
				Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render average pace or speed
		dc.drawText(halfWidth - layout[5] /* centerOffsetX */, layout[8] /* topRowY */, layout[27] /* topRowFont */,
			(showSpeedInsteadOfPace ? formatDistance(averagePaceOrSpeed) : formatTime(averagePaceOrSpeed, true)) + averagePaceOrSpeedUnitsLabel,
			Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render distance
		dc.drawText(halfWidth + layout[5] /* centerOffsetX */, layout[8] /* topRowY */, layout[27] /* topRowFont */,
			formatDistance(distance) + distanceUnitsLabel, Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render heart rate text
		var heartRateText = (heartRate == null ? 0 : heartRate).format("%d");
		var heartRateWidth = dc.getTextDimensions(heartRateText, layout[28] /* heartRateFont */)[0];
		dc.drawText(halfWidth, layout[17] /* heartRateTextY */, layout[28] /* heartRateFont */,
			heartRateText, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render heart rate icon
		var hrIconY;
		var hrIconWidth;
		var hrIconXOffset;
		if (showHeartRateZone && heartRateZone != null) {
			hrIconY = layout[12] /* heartRateIconHRZY */;
			hrIconWidth = layout[14] /* heartRateIconHRZWidth */;
			hrIconXOffset = layout[16] /* heartRateIconHRZXOffset */;
		} else {
			hrIconY = layout[11] /* heartRateIconY */;
			hrIconWidth = layout[13] /* heartRateIconWidth */;
			hrIconXOffset = layout[15] /* heartRateIconXOffset */;
		}
		dc.setColor(heartRateIconColour, Gfx.COLOR_TRANSPARENT);
		dc.fillCircle(halfWidth - (hrIconWidth / 4.7), hrIconY + (hrIconWidth / 3.2), hrIconWidth / 3.2);
		dc.fillCircle(halfWidth + (hrIconWidth / 4.7), hrIconY + (hrIconWidth / 3.2), hrIconWidth / 3.2);
		dc.fillPolygon([
			[halfWidth - (hrIconWidth / 2.2), hrIconY + (hrIconWidth / 1.8) - hrIconXOffset],
			[halfWidth, hrIconY + (hrIconWidth * 0.95)],
			[halfWidth + (hrIconWidth / 2.2), hrIconY + (hrIconWidth / 1.8) - hrIconXOffset]
		]);
		
		if (showHeartRateZone && heartRateZone != null) {
			dc.setColor(heartRateZoneTextColour, Gfx.COLOR_TRANSPARENT);
			dc.drawText(halfWidth, hrIconY + (hrIconWidth / 2) - 3, Gfx.FONT_XTINY,
				heartRateZone.toString(), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		}
		
		// Reset text rendering colour
		dc.setColor(darkMode ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		
		// Render current pace or speed
		dc.drawText((halfWidth / 2) - (heartRateWidth / 2) + 5, layout[9] /* middleRowLabelY */, layout[29] /* middleRowLabelFont */,
			Ui.loadResource(showSpeedInsteadOfPace ? Rez.Strings.speed : Rez.Strings.pace),
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText(
		(halfWidth / 2) - (heartRateWidth / 2) + 5,
			layout[10] /* middleRowValueY */,
			shrinkMiddleText ? layout[30] /* middleRowValueFontShrunk */ : layout[31] /* middleRowValueFont */,
			paceOrSpeedText,
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render timer
		dc.drawText((halfWidth * 1.5) + (heartRateWidth / 2) - 5, layout[9] /* middleRowLabelY */, layout[29] /* middleRowLabelFont */,
			Ui.loadResource(Rez.Strings.timer), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText(
			(halfWidth * 1.5) + (heartRateWidth / 2) - 5,
			layout[10] /* middleRowValueY */,
			shrinkMiddleText ? layout[30] /* middleRowValueFontShrunk */ : layout[31] /* middleRowValueFont */,
			timeText,
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render steps
		dc.drawBitmap(layout[20] /* bottomRowIconX */, layout[21] /* bottomRowIconY */, stepsIcon);
		dc.drawText(halfWidth - layout[5] /* centerOffsetX */, layout[18] /* bottomRowUpperTextY */, layout[32] /* bottomRowFont */,
			(steps == null ? 0 : steps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render calories
		dc.drawBitmap(dc.getWidth() - layout[20] /* bottomRowIconX */ - caloriesIcon.getWidth(), layout[21] /* bottomRowIconY */, caloriesIcon);
		dc.drawText(halfWidth + layout[5] /* centerOffsetX */, layout[18] /* bottomRowUpperTextY */, layout[32] /* bottomRowFont */,
			(calories == null ? 0 : calories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Set grey colour for day counts
		dc.setColor(layout[34] /* eightColourPalette */ ? Gfx.COLOR_DK_BLUE : Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		
		// Render day steps
		dc.drawText(halfWidth - layout[5] /* centerOffsetX */, layout[19] /* bottomRowLowerTextY */, layout[32] /* bottomRowFont */,
			(daySteps == null ? 0 : daySteps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render day calories
		dc.drawText(halfWidth + layout[5] /* centerOffsetX */, layout[19] /* bottomRowLowerTextY */, layout[32] /* bottomRowFont */,
			(dayCalories == null ? 0 : dayCalories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render battery
		dc.setColor(batteryIconColour, Gfx.COLOR_TRANSPARENT);
		dc.fillRoundedRectangle(halfWidth - (layout[24] /* batteryWidth */ / 2) + 2 + layout[23] /* batteryX */, layout[22] /* batteryY */ - (layout[25] /* batteryHeight */ / 2), layout[24] /* batteryWidth */ - 4, layout[25] /* batteryHeight */, 2);
		dc.fillRoundedRectangle(halfWidth - (layout[24] /* batteryWidth */ / 2) + 2 + layout[23] /* batteryX */ + layout[24] /* batteryWidth */ - 7, layout[22] /* batteryY */ - (layout[25] /* batteryHeight */ / 2) + 4, 7, layout[25] /* batteryHeight */ - 8, 2);
		dc.setColor(batteryTextColour, Gfx.COLOR_TRANSPARENT);
		dc.drawText(halfWidth + layout[23] /* batteryX */, layout[22] /* batteryY */ - 1, layout[33] /* batteryFont */,
			battery.format("%d") + "%", Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
	}
	
	function formatTime(milliseconds, short) {
		if (milliseconds != null && milliseconds > 0) {
			var hours = null;
			var minutes = Math.floor(milliseconds / 60000).toNumber();
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
	
	function formatDistance(distance) {
		if (distance != null && distance > 0) {
			if (distance >= 1000) {
				return distance.format("%d");
			} else if (distance >= 100) {
				return distance.format("%.1f");
			} else {
				return distance.format("%.2f");
			}
		} else {
			return "0.00";
		}
	}

}