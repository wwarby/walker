using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class ActivityMetrics {

	hidden var paceData;
	hidden var heartRateData;
	
	hidden var stepsWhenTimerBecameActive = 0;
	hidden var unconsolidatedSteps = 0;
	hidden var consolidatedSteps = 0;
	
	hidden var paceMode = 0;
	hidden var heartRateMode = 0;
	
	var timerActive = false;
	
	var kmOrMileInMeters;
	var kmOrMilesLabel;
	
	var averagePace;
	var distance;
	var heartRate;
	var pace;
	var time;
	var steps;
	var daySteps;
	var calories;
	var dayCalories;
	
	function initialize() {}
	
	function readSettings(deviceSettings) {
		
		kmOrMileInMeters = deviceSettings.distanceUnits == System.UNIT_METRIC ? 1000.0f : 1609.34f;
		kmOrMilesLabel = Ui.loadResource(deviceSettings.distanceUnits == System.UNIT_METRIC ? Rez.Strings.metric : Rez.Strings.imperial);
		
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
	
	function onTimerStart() {
		consolidatedSteps = 0;
		unconsolidatedSteps = 0;
		steps = 0;
		stepsWhenTimerBecameActive = ActivityMonitor.getInfo().steps;
		timerActive = true;
	}
	
	function onTimerStop() {
		consolidatedSteps = 0;
		unconsolidatedSteps = 0;
		timerActive = false;
	}
	
	function onTimerReset() {
		consolidatedSteps = steps;
		unconsolidatedSteps = 0;
		stepsWhenTimerBecameActive = 0;
		timerActive = false;
	}
	
	function onTimerPause() {
		consolidatedSteps = steps;
		unconsolidatedSteps = 0;
		timerActive = false;
	}
	
	function onTimerResume() {
		stepsWhenTimerBecameActive = ActivityMonitor.getInfo().steps;
		timerActive = true;
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
				
		// Steps
		if (timerActive) {
			unconsolidatedSteps = activityMonitorInfo.steps - stepsWhenTimerBecameActive;
			steps = consolidatedSteps + unconsolidatedSteps;
		}
		daySteps = activityMonitorInfo.steps;
		
		// Calories
		calories = info.calories;
		dayCalories = activityMonitorInfo.calories;
		
		// Max width values for layout debugging
		/*
		distance = 888888.888;
		heartRate = 888;
		pace = 100000;
		averagePace = 100000;
		time = 20000000;
		steps = 88888;
		daySteps = 88888;
		calories = 88888;
		dayCalories = 88888;
		*/
	}
	
}
