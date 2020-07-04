using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WalkerViewGTE32K {

	var previousDistanceUnits;
	
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
	
		// Short circuit if we have already created our FIT contributor fields and the distance unit setting hasn't changed
		if (deviceSettings.distanceUnits == previousDistanceUnits) { return; }
		
		// Create FIT contributor fields
		
		var stepsUnits = Ui.loadResource(Rez.Strings.stepsUnits);
		
		stepsPerKmOrMileField = mainView.createField(
			Ui.loadResource(deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? Rez.Strings.stepsPerKm : Rez.Strings.stepsPerMile),
			deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? 2 : 3,
			8 /* Fit.DATA_TYPE_FLOAT */,
            { :mesgType => 20 /* Fit.MESG_TYPE_RECORD */, :units => stepsUnits });
        
        stepsPerHourField = mainView.createField(Ui.loadResource(Rez.Strings.stepsPerHour),
	        4,
	        8 /* Fit.DATA_TYPE_FLOAT */,
            { :mesgType => 20 /* Fit.MESG_TYPE_RECORD */, :units => stepsUnits });
        
        averageStepsPerKmOrMileField = mainView.createField(
        	Ui.loadResource(deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? Rez.Strings.averageStepsPerKm : Rez.Strings.averageStepsPerMile),
			deviceSettings.distanceUnits == 0 /* System.UNIT_METRIC */ ? 5 : 6,
        	8 /* Fit.DATA_TYPE_FLOAT */,
            { :mesgType => 18 /* Fit.MESG_TYPE_SESSION */, :units => stepsUnits });
        
        averageStepsPerHourField = mainView.createField(Ui.loadResource(Rez.Strings.averageStepsPerHour),
        	7,
        	8 /* Fit.DATA_TYPE_FLOAT */,
        	{ :mesgType => 18 /* Fit.MESG_TYPE_SESSION */, :units => stepsUnits });
        
        // Set initial steps FIT contributions to zero
        stepsPerKmOrMileField.setData(0);
        stepsPerHourField.setData(0);
        averageStepsPerKmOrMileField.setData(0);
        averageStepsPerHourField.setData(0);
        
        previousDistanceUnits = deviceSettings.distanceUnits;
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