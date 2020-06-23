using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Math as Math;

class WalkerView extends Ui.DataField {
	
	hidden var doUpdates = false;
	hidden var is24Hour = false;
	
	hidden var activityMetrics;
	
	hidden var previousDarkMode;
	hidden var previousBatteryState;
	
	hidden var heartRateIcon;
	hidden var stepsIcon;
	hidden var caloriesIcon;
	hidden var batteryIcon;
	
	hidden var batteryTextColour;
	
	hidden var lines;
	hidden var centerOffsetX;
	hidden var clockY;
	hidden var clockOffsetX;
	hidden var topRowY;
	hidden var middleRowLabelY;
	hidden var middleRowValueY;
	hidden var heartRateIconY;
	hidden var heartRateTextY;
	hidden var bottomRowUpperTextY;
	hidden var bottomRowLowerTextY;
	hidden var bottomRowIconX;
	hidden var bottomRowIconY;
	hidden var batteryY;
	hidden var batteryX;
	
	function initialize() {
		DataField.initialize();
		activityMetrics = new ActivityMetrics();
		readSettings();
		
		// Layout variables stored as strings because SDK < 2.x doesn't support JSON resources
		var app = Application.getApp();
		lines = [
			Ui.loadResource(Rez.Strings.hl1).toNumber(),
			Ui.loadResource(Rez.Strings.hl2).toNumber(),
			Ui.loadResource(Rez.Strings.hl3).toNumber(),
			Ui.loadResource(Rez.Strings.hl4).toNumber()
		];
		centerOffsetX = Ui.loadResource(Rez.Strings.cx).toNumber();
		clockY = Ui.loadResource(Rez.Strings.cy).toNumber();
		clockOffsetX = Ui.loadResource(Rez.Strings.cox).toNumber();
		topRowY = Ui.loadResource(Rez.Strings.ty).toNumber();
		middleRowLabelY = Ui.loadResource(Rez.Strings.mly).toNumber();
		middleRowValueY = Ui.loadResource(Rez.Strings.mvy).toNumber();
		heartRateIconY = Ui.loadResource(Rez.Strings.hiy).toNumber();
		heartRateTextY = Ui.loadResource(Rez.Strings.hty).toNumber();
		bottomRowUpperTextY = Ui.loadResource(Rez.Strings.buy).toNumber();
		bottomRowLowerTextY = Ui.loadResource(Rez.Strings.bly).toNumber();
		bottomRowIconX = Ui.loadResource(Rez.Strings.brix).toNumber();
		bottomRowIconY = Ui.loadResource(Rez.Strings.briy).toNumber();
		batteryY = Ui.loadResource(Rez.Strings.by).toNumber();
		batteryX = Ui.loadResource(Rez.Strings.bx).toNumber();
	}
	
	function readSettings() {
		var deviceSettings = System.getDeviceSettings();
		is24Hour = deviceSettings.is24Hour;
		activityMetrics.readSettings(deviceSettings);
	}
	
	function compute(info) {
		activityMetrics.compute(info);
	}
	
	function onShow() {
		doUpdates = true;
		return true;
	}
	
	function onHide() {
		doUpdates = false;
	}
	
	// Forward timer events to activity metrics
	function onTimerStart() { activityMetrics.weak().get().onTimerStart(); }
	function onTimerStop() { activityMetrics.weak().get().onTimerStop(); }
	function onTimerReset() { activityMetrics.weak().get().onTimerReset(); }
	function onTimerPause() { activityMetrics.weak().get().onTimerPause(); }
	function onTimerResume() { activityMetrics.weak().get().onTimerResume(); }
	
	function onUpdate(dc) {
		
		if (doUpdates == false) { return; }
		
		var am = activityMetrics.weak().get();
		var halfWidth = dc.getWidth() / 2;
		
		var time = formatTime(am.time == null ? null : am.time, false);
		var pace = formatTime(am.pace == null ? null : am.pace * 1000.0, false);
		var shrinkMiddleText = time.length() > 5 || pace.length() > 5;
		
		// Set colours
		var backgroundColour = self has :getBackgroundColor ? getBackgroundColor() : Gfx.COLOR_WHITE;
		var darkMode = (backgroundColour == Gfx.COLOR_BLACK);
		
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
					batteryTextColour = Gfx.COLOR_WHITE;
					break;
				case 1:
					batteryIcon = Ui.loadResource(Rez.Drawables.ibe);
					batteryTextColour = Gfx.COLOR_WHITE;
					break;
				case 2:
					batteryIcon = Ui.loadResource(Rez.Drawables.ibw);
					batteryTextColour = Gfx.COLOR_WHITE;
					break;
				case 3:
					batteryIcon = Ui.loadResource(darkMode ? Rez.Drawables.ibd : Rez.Drawables.ib);
					batteryTextColour = darkMode ? Gfx.COLOR_BLACK : Gfx.COLOR_WHITE;
					break;
			}
		}
		
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
		dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		for (var x = 0; x < lines.size(); x++) {
        	dc.drawLine(0, lines[x], dc.getWidth(), lines[x]);
		}
		
		// Render vertical lines
		dc.drawLine(halfWidth, lines[0], halfWidth, lines[1]);
		dc.drawLine(halfWidth, lines[2], halfWidth, lines[3]);
		
		// Set text rendering colour
		dc.setColor(darkMode ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
		
		// Render clock
		var currentTime = System.getClockTime();
		var hour = is24Hour ? currentTime.hour : currentTime.hour % 12;
		if (!is24Hour && hour == 0) { hour = 12; }
		dc.drawText(halfWidth + clockOffsetX, clockY, Gfx.FONT_XTINY,
			hour.format(is24Hour ? "%02d" : "%d")
			  + ":"
			  + currentTime.min.format("%02d")
			  + (is24Hour ? "" : Ui.loadResource(currentTime.hour >= 12 ? Rez.Strings.pm : Rez.Strings.am)),
			  Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render average pace
		dc.drawText(halfWidth - centerOffsetX, topRowY, Gfx.FONT_XTINY,
			formatTime(am.averagePace == null ? null : am.averagePace * 1000.0, true) + "/" + am.kmOrMilesLabel, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render distance
		dc.drawText(halfWidth + centerOffsetX, topRowY, Gfx.FONT_XTINY,
			formatDistance(am.distance, am.kmOrMileInMeters) + am.kmOrMilesLabel, Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render heart rate
		var heartRate = (am.heartRate == null ? 0 : am.heartRate).format("%d");
		var heartRateWidth = dc.getTextDimensions(heartRate, Gfx.FONT_XTINY)[0];
		dc.drawBitmap(halfWidth - (heartRateIcon.getWidth() / 2), heartRateIconY, heartRateIcon);
		dc.drawText(halfWidth, heartRateTextY, Gfx.FONT_XTINY,
			heartRate, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render current pace
		dc.drawText((halfWidth / 2) - (heartRateWidth / 2) + 5, middleRowLabelY, Gfx.FONT_XTINY,
			Ui.loadResource(Rez.Strings.pace), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText(
		(halfWidth / 2) - (heartRateWidth / 2) + 5,
			middleRowValueY,
			shrinkMiddleText ? Gfx.FONT_SMALL : Gfx.FONT_NUMBER_MILD,
			pace,
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
			
		// Render timer
		dc.drawText((halfWidth * 1.5) + (heartRateWidth / 2) - 5, middleRowLabelY, Gfx.FONT_XTINY,
			Ui.loadResource(Rez.Strings.timer), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText(
			(halfWidth * 1.5) + (heartRateWidth / 2) - 5,
			middleRowValueY,
			shrinkMiddleText ? Gfx.FONT_SMALL : Gfx.FONT_NUMBER_MILD,
			time,
			Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render steps
		dc.drawBitmap(bottomRowIconX, bottomRowIconY, stepsIcon);
		dc.drawText(halfWidth - centerOffsetX, bottomRowUpperTextY, Gfx.FONT_XTINY,
			(am.steps == null ? 0 : am.steps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render calories
		dc.drawBitmap(dc.getWidth() - bottomRowIconX - caloriesIcon.getWidth(), bottomRowIconY, caloriesIcon);
		dc.drawText(halfWidth + centerOffsetX, bottomRowUpperTextY, Gfx.FONT_XTINY,
			(am.calories == null ? 0 : am.calories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Set grey colour for day counts
		dc.setColor(darkMode ? Gfx.COLOR_DK_GRAY : Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		
		// Render day steps
		dc.drawText(halfWidth - centerOffsetX, bottomRowLowerTextY, Gfx.FONT_XTINY,
			(am.daySteps == null ? 0 : am.daySteps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render day calories
		dc.drawText(halfWidth + centerOffsetX, bottomRowLowerTextY, Gfx.FONT_XTINY,
			(am.dayCalories == null ? 0 : am.dayCalories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render battery
		dc.drawBitmap(halfWidth - (batteryIcon.getWidth() / 2) + 2 + batteryX, batteryY - (batteryIcon.getHeight() / 2), batteryIcon);
		dc.setColor(batteryTextColour, Gfx.COLOR_TRANSPARENT);
		dc.drawText(halfWidth + batteryX, batteryY - 1, Gfx.FONT_XTINY,
			System.getSystemStats().battery.format("%d") + "%", Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
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
			return Ui.loadResource(Rez.Strings.zeroTime);
		}
	}
	
	function formatDistance(meters, kmOrMileInMeters) {
		if (meters != null && meters > 0) {
			var distanceKmOrMiles = meters / kmOrMileInMeters;
			if (distanceKmOrMiles >= 1000) {
				return distanceKmOrMiles.format("%d");
			} else if (distanceKmOrMiles >= 100) {
				return distanceKmOrMiles.format("%.1f");
			} else {
				return distanceKmOrMiles.format("%.2f");
			}
		} else {
			return Ui.loadResource(Rez.Strings.zeroDistance);
		}
	}

}
