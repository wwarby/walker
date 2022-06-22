import Toybox.Lang;

// An efficient circular queue implementation that will store the most recently added X entries
class DataQueue {

	var data as Array;
	var maxSize = 0;
	var pos = 0;

	function initialize(arraySize) {
		data = new[arraySize];
		maxSize = arraySize;
	}
	
	// Add a new element to the array
	function add(element) {
		data[pos] = element;
		pos = (pos + 1) % maxSize;
	}

	// Reset all the entries in the array to null
	function reset() {
		for (var i = 0; i < data.size(); i++) { data[i] = null; }
		pos = 0;
	}
	
	// Get the average value of the items in the array, discounting nulls
	function average() {
		var size = 0;
		var sumOfData = 0.0;
		for (var i = 0; i < data.size(); i++) {
			if (data[i] != null) {
				sumOfData = sumOfData + data[i];
				size++;
			}
		}
		return sumOfData > 0 ? sumOfData.toFloat() / size : 0.0;
	}
	
	// Get the least recently added entry in the array
	function oldest() { return data[pos] != null ? data[pos] : data[0]; }
	
	// Get the most recently added entry in the array
	function newest() { return data[pos == 0 ? maxSize - 1 : (pos - 1) % maxSize]; }
	
}
