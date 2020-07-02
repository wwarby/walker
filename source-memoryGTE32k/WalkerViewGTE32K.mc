using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WalkerViewGTE32K {
	
	// FIT contributor fields
	var stepsPerKmOrMileField;
	var stepsPerHourField;
	var averageStepsPerKmOrMileField;
	var averageStepsPerHourField;
	
	var stepData;
	
	function initialize() {
		// Fixed window of 60 seconds for determining "steps per" values for chart FIT contributions
		stepData = new DataQueue(60);
	}
	
	function readSettings(mainView, deviceSettings, app) {
		
		var stepUnits = Ui.loadResource(Rez.Strings.stepsUnits);
		
		// Create FIT contributor fields
		
		var distanceStepUnits = Ui.loadResource(deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? Rez.Strings.stepsPerKmUnits : Rez.Strings.stepsPerMileUnits);
		var hourStepsUnits = Ui.loadResource(Rez.Strings.stepsPerHourUnits);
		
		stepsPerKmOrMileField = mainView.createField(distanceStepUnits,
			deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? 2 : 3,
			4 /* Fit.DATA_TYPE_UINT16 */,
            { :mesgType => 20 /* Fit.MESG_TYPE_RECORD */, :units => stepUnits });
        
        stepsPerHourField = mainView.createField(hourStepsUnits, 4, 4 /* Fit.DATA_TYPE_UINT16 */,
            { :mesgType => 20 /* Fit.MESG_TYPE_RECORD */, :units => stepUnits });
        
        averageStepsPerKmOrMileField = mainView.createField(distanceStepUnits,
        	deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? 5 : 6,
        	4 /* Fit.DATA_TYPE_UINT16 */,
            { :mesgType => 18 /* Fit.MESG_TYPE_SESSION */, :units => stepUnits });
        
        averageStepsPerHourField = mainView.createField(hourStepsUnits, 7, 4 /* Fit.DATA_TYPE_UINT16 */,
        	{ :mesgType => 18 /* Fit.MESG_TYPE_SESSION */, :units => stepUnits });
        
        // Set initial steps FIT contributions to zero
        stepsPerKmOrMileField.setData(0);
        stepsPerHourField.setData(0);
        averageStepsPerKmOrMileField.setData(0);
        averageStepsPerHourField.setData(0);
	}
	
	function compute(mainView, info, activityMonitorInfo) {
		
		// Add step data to the circular queue
		if (mainView.time != null && mainView.time > 0 && info.elapsedDistance != null && info.elapsedDistance > 0 && mainView.steps != null && mainView.steps > 0) {
			stepData.add([mainView.time, info.elapsedDistance, mainView.steps]);
		}
		
		var oldestStepData = stepData.oldest();
		var newestStepData = stepData.newest();
		
		// Update "record" (chart) FIT contributions
		if (oldestStepData != null && newestStepData != null) {
			var milliseconds = newestStepData[0] - oldestStepData[0];
			var distance = newestStepData[1] - oldestStepData[1];
			var steps = newestStepData[2] - oldestStepData[2];
			if (milliseconds > 0 && distance > 0 && steps > 0) {
				stepsPerKmOrMileField.setData((steps / distance) * (mainView.kmOrMileInMetersDistance / 1000.0) * 1000.0);
		        stepsPerHourField.setData((steps / (milliseconds.toFloat())) * 3600000.0);
	        }
		}
		
		// Update activity average FIT contributions
		if (mainView.steps != null && mainView.steps > 0) {
			if (info.elapsedDistance != null && info.elapsedDistance > 0) {
				averageStepsPerKmOrMileField.setData((mainView.steps / info.elapsedDistance) * (mainView.kmOrMileInMetersDistance / 1000.0) * 1000.0);
			}
			if (mainView.time != null && mainView.time > 0) {
				averageStepsPerHourField.setData((mainView.steps / (mainView.time.toFloat())) * 3600000.0);
			}
		}
	}
	
	function onUpdate(mainView, dc) { }
	
}