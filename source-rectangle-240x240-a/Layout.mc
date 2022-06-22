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
		8,                // [5]   centerOffsetX
		15,               // [6]   clockY
		0,                // [7]   clockOffsetX
		50,               // [8]   topRowY
		90,               // [9]   middleRowLabelY
		120,              // [10]  middleRowValueY
		87,               // [11]  heartRateIconY
		83,               // [12]  heartRateIconHRZY
		20,               // [13]  heartRateIconWidth
		28,               // [14]  heartRateIconHRZWidth
		2,                // [15]  heartRateIconXOffset
		2,                // [16]  heartRateIconHRZXOffset
		123,              // [17]  heartRateTextY
		160,              // [18]  bottomRowUpperTextY
		185,              // [19]  bottomRowLowerTextY
		10,               // [20]  bottomRowIconX
		157,              // [21]  bottomRowIconY
		220,              // [22]  batteryY
		0,                // [23]  batteryX
		49,               // [24]  batteryWidth
		22,               // [25]  batteryHeight
		0,                // [26]  timeFont                 Gfx.FONT_XTINY
		4,                // [27]  topRowFont               Gfx.FONT_LARGE
		3,                // [28]  heartRateFont            Gfx.FONT_MEDIUM
		3,                // [29]  middleRowLabelFont       Gfx.FONT_MEDIUM
		4,                // [30]  middleRowValueFontShrunk Gfx.FONT_LARGE
		6,                // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MEDIUM
		3,                // [32]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                // [33]  batteryFont              Gfx.FONT_XTINY
    false             // [34]  eightColourPalette
	];
}