class DataQueue {

	var data;
	
	var maxSize = 0;
	var pos = 0;

	function initialize(arraySize) {
		data = new[arraySize];
		maxSize = arraySize;
	}
	
	function add(element) {
		data[pos] = element;
		pos = (pos + 1) % maxSize;
	}

	function reset() {
		for (var i = 0; i < data.size(); i++) { data[i] = null; }
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
		return sumOfData > 0 ? sumOfData.toFloat() / size : 0.0;
	}
	
	function oldest() { return data[pos] != null ? data[pos] : data[0]; }
	
	function newest() {
		return data[pos == 0 ? maxSize - 1 : (pos - 1) % maxSize];
	}
	
}
