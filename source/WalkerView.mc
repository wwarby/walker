using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Calc;

class WalkerView extends Ui.DataField {
	
	hidden var doUpdates = 0;
	
	hidden var activityMetrics;
	
	hidden var previousDarkMode;
	
	hidden var heartRateIcon;
	hidden var stepsIcon;
	hidden var caloriesIcon;
	hidden var batteryIcon;
	
	hidden var lines;
	hidden var inlineHeartRate;
	hidden var clockY;
	hidden var topRowY;
	hidden var middleRowLabelY;
	hidden var middleRowValueY;
	hidden var heartRateIconY;
	hidden var heartRateTextY;
	hidden var bottomRowUpperTextY;
	hidden var bottomRowLowerTextY;
	hidden var bottomRowIconX;
	hidden var bottomRowIconY;
	hidden var batteryIconY;
	hidden var batteryTextY;
	
	function initialize() {
		DataField.initialize();
		activityMetrics = new ActivityMetrics();
		readSettings();
		
		// Read layout variables that differ by device from JSON array. Stored in an array to save memory.
		var layout = WatchUi.loadResource(Rez.JsonData.l);
		lines = layout.slice(0, 4);
		inlineHeartRate = layout[4];
		clockY = layout[5];
		topRowY = layout[6];
		middleRowLabelY = layout[7];
		middleRowValueY = layout[8];
		heartRateIconY = layout[9];
		heartRateTextY = layout[10];
		bottomRowUpperTextY = layout[11];
		bottomRowLowerTextY = layout[12];
		bottomRowIconX = layout[13];
		bottomRowIconY = layout[14];
		batteryIconY = layout[15];
		batteryTextY = layout[16];
	}
	
	function readSettings() {
		activityMetrics.readSettings(System.getDeviceSettings());
	}
	
	function onLayout(dc) { }
	
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
	
	function onUpdate(dc) {
		
		if (doUpdates == false) { return; }
		
		var am = activityMetrics.weak().get();
		var halfWidth = dc.getWidth() / 2;
		
		// Set colours
		var backgroundColour = self has :getBackgroundColor ? getBackgroundColor() : Gfx.COLOR_WHITE;
		var darkMode = (backgroundColour == Gfx.COLOR_BLACK);
		
		// If we've never loaded the icons before or dark mode has been toggled, load the icons
		if (previousDarkMode != darkMode) {
			previousDarkMode = darkMode;
			heartRateIcon = Ui.loadResource(Rez.Drawables.ihr);
			stepsIcon = Ui.loadResource(darkMode ? Rez.Drawables.isd : Rez.Drawables.is);
			caloriesIcon = Ui.loadResource(darkMode ? Rez.Drawables.icd : Rez.Drawables.ic);
			batteryIcon = Ui.loadResource(darkMode ? Rez.Drawables.ibd : Rez.Drawables.ib);
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
		dc.drawText(halfWidth, clockY, Gfx.FONT_XTINY,
			currentTime.hour.format("%02d") + ":" + currentTime.min.format("%02d"), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render average pace
		dc.drawText(halfWidth - 10, topRowY, Gfx.FONT_XTINY,
			formatTime(am.averagePace == null ? null : am.averagePace * 1000.0, true) + "/" + am.kmOrMilesLabel, Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render distance
		dc.drawText(halfWidth + 10, topRowY, Gfx.FONT_XTINY,
			formatDistance(am.distance, am.kmOrMileInMeters) + am.kmOrMilesLabel, Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render current pace
		dc.drawText((halfWidth / 2) - 10, middleRowLabelY, Gfx.FONT_XTINY,
			Ui.loadResource(Rez.Strings.pace), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText((halfWidth / 2) - 10, middleRowValueY, Gfx.FONT_NUMBER_MILD,
			formatTime(am.pace == null ? null : am.pace * 1000.0, true), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
			
		// Render timer
		dc.drawText((halfWidth * 1.5) + 10, middleRowLabelY, Gfx.FONT_XTINY,
			Ui.loadResource(Rez.Strings.time), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		dc.drawText((halfWidth * 1.5) + 10, middleRowValueY, Gfx.FONT_NUMBER_MILD,
			formatTime(am.time, true), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render heart rate
		dc.drawBitmap(halfWidth - (heartRateIcon.getWidth() / 2), heartRateIconY, heartRateIcon);
		dc.drawText(halfWidth, heartRateTextY, Gfx.FONT_XTINY,
			(am.heartRate == null ? 0 : am.heartRate).format("%d"), Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render steps
		dc.drawBitmap(bottomRowIconX, bottomRowIconY, stepsIcon);
		dc.drawText(halfWidth - 10, bottomRowUpperTextY, Gfx.FONT_XTINY,
			(am.steps == null ? 0 : am.steps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render calories
		dc.drawBitmap(dc.getWidth() - bottomRowIconX - caloriesIcon.getWidth(), bottomRowIconY, caloriesIcon);
		dc.drawText(halfWidth + 10, bottomRowUpperTextY, Gfx.FONT_XTINY,
			(am.calories == null ? 0 : am.calories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Set grey colour for day counts
		dc.setColor(darkMode ? Gfx.COLOR_DK_GRAY : Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
		
		// Render day steps
		dc.drawText(halfWidth - 10, bottomRowLowerTextY, Gfx.FONT_XTINY,
			(am.daySteps == null ? 0 : am.daySteps).format("%d"), Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render day calories
		dc.drawText(halfWidth + 10, bottomRowLowerTextY, Gfx.FONT_XTINY,
			(am.dayCalories == null ? 0 : am.dayCalories).format("%d"), Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER);
		
		// Render battery
		dc.drawBitmap(halfWidth - (batteryIcon.getWidth() / 2) + 2, batteryIconY, batteryIcon);
		dc.setColor(darkMode ? Gfx.COLOR_BLACK : Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(halfWidth, batteryTextY, Gfx.FONT_XTINY,
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
