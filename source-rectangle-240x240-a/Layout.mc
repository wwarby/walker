import Toybox.Lang;

/* 
 * 240 x 240 SQUARE FONT GROUP A
 * DEVICES:
 * - Venu Square
 * - Venu Square Music
 */
 
function getLayout() as Array {
	return [
		30, 70, 145, 203, // [0-3] lines
		0,                // [4]   stepGoalProgressOffsetX
		3,                // [5]   stepGoalProgressHeight
		8,                // [6]   centerOffsetX
		15,               // [7]   clockY
		0,                // [8]   clockOffsetX
		50,               // [9]   topRowY
		90,               // [10]  middleRowLabelY
		120,              // [11]  middleRowValueY
		87,               // [12]  heartRateIconY
		83,               // [13]  heartRateIconHRZY
		20,               // [14]  heartRateIconWidth
		28,               // [15]  heartRateIconHRZWidth
		2,                // [16]  heartRateIconXOffset
		2,                // [17]  heartRateIconHRZXOffset
		123,              // [18]  heartRateTextY
		160,              // [19]  bottomRowUpperTextY
		185,              // [20]  bottomRowLowerTextY
		10,               // [21]  bottomRowIconX
		157,              // [22]  bottomRowIconY
		220,              // [23]  batteryY
		0,                // [24]  batteryX
		49,               // [25]  batteryWidth
		22,               // [26]  batteryHeight
		0,                // [27]  timeFont                 Gfx.FONT_XTINY
		4,                // [28]  topRowFont               Gfx.FONT_LARGE
		3,                // [29]  heartRateFont            Gfx.FONT_MEDIUM
		3,                // [30]  middleRowLabelFont       Gfx.FONT_MEDIUM
		4,                // [31]  middleRowValueFontShrunk Gfx.FONT_LARGE
		6,                // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MEDIUM
		3,                // [33]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                // [34]  batteryFont              Gfx.FONT_XTINY
    false             // [35]  eightColourPalette
	];
}