class DataQueue {

	var data;
	
	hidden var maxSize = 0;
	hidden var pos = 0;

	function initialize(arraySize) {
		data = new[arraySize];
		maxSize = arraySize;
	}
	
	function add(element) {
		data[pos] = element;
		pos = (pos + 1) % maxSize;
	}

	function reset() {
		for (var i = 0; i < data.size(); i++) {
			data[i] = null;
		}
		pos = 0;
	}
	
	function average() {
		var size = 0;
		var sumOfData = 0.0;
		for (var i = 0; i < data.size(); i++) {
			if (data[i] != null) {
				sumOfData = sumOfData + data[i];
				size++;
			}
		}
		if (sumOfData > 0) {
			return sumOfData / size;
		}
		return 0.0;
	}
	
}
