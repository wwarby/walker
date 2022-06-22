import Toybox.Lang;

// An efficient circular queue implementation that will store the most recently added X entries
class DataQueue {

	var data as Array;
	var trackAvg = false;
	var maxSize = 0;
	var pos = 0;
	var total = 0.0;
	var size = 0;
	var average = 0.0;

	function initialize(arraySize, trackAverage) {
		data = new[arraySize];
		maxSize = arraySize;
		trackAvg = trackAverage;
	}
	
	// Add a new element to the array
	function add(element) {
		if (trackAvg) {
			var oldestVal = data[pos];
			if (oldestVal != null) { total -= oldestVal; }
			total += element;
			if (size < maxSize) { size++; }
			average = total > 0 ? total.toFloat() / size : 0.0;
		}
		data[pos] = element;
		pos = (pos + 1) % maxSize;
	}

	// Reset all the entries in the array to null
	function reset() {
		data = new[maxSize];
		pos = 0;
		total = 0.0;
		size = 0;
		average = 0.0;
	}
	
	// Get the least recently added entry in the array
	function oldest() { return data[pos] != null ? data[pos] : data[0]; }
	
	// Get the most recently added entry in the array
	function newest() { return data[pos == 0 ? maxSize - 1 : (pos - 1) % maxSize]; }
	
}
