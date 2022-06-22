using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WalkerApp extends App.AppBase {
	
	var mainView;
	
	function initialize() {
		AppBase.initialize();
	}

	function onStop(state) {
		// Store current step counts for later usage (e.g., resume later)
		var app = Application.getApp();
		app.setProperty("as", mainView.steps);
		app.setProperty("ls", mainView.lapSteps);
	}
	
	function onSettingsChanged() {
		mainView.readSettings();
		Ui.requestUpdate();
	}
	
	function getInitialView() {
		mainView = new WalkerView();
		return [mainView];
	}

}