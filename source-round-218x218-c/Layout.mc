import Toybox.Lang;

/* 
 * 218 x 218 FONT GROUP C
 * DEVICES:
 * - fenix 5S
 * - fenix 5S Plus
 * - fenix Chronos
 */

function getLayout() as Array {
	return [
		26, 62, 130, 187, // [0-3] lines
		2,                // [4]   stepGoalProgressOffsetX
		3,                // [5]   stepGoalProgressHeight
		10,               // [6]   centerOffsetX
		13,               // [7]   clockY
		0,                // [8]   clockOffsetX
		44,               // [9]   topRowY
		78,               // [10]  middleRowLabelY
		106,              // [11]  middleRowValueY
		77,               // [12]  heartRateIconY
		72,               // [13]  heartRateIconHRZY
		20,               // [14]  heartRateIconWidth
		28,               // [15]  heartRateIconHRZWidth
		2,                // [16]  heartRateIconXOffset
		2,                // [17]  heartRateIconHRZXOffset
		110,              // [18]  heartRateTextY
		147,              // [19]  bottomRowUpperTextY
		169,              // [20]  bottomRowLowerTextY
		22,               // [21]  bottomRowIconX
		142,              // [22]  bottomRowIconY
		201,              // [23]  batteryY
		0,                // [24]  batteryX
		45,               // [25]  batteryWidth
		20,               // [26]  batteryHeight
		0,                // [27]  timeFont                 Gfx.FONT_XTINY
		0,                // [28]  topRowFont               Gfx.FONT_XTINY
		0,                // [29]  heartRateFont            Gfx.FONT_XTINY
		0,                // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		2,                // [31]  middleRowValueFontShrunk Gfx.FONT_SMALL
		5,                // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		0,                // [33]  bottomRowFont            Gfx.FONT_XTINY
		0,                // [34]  batteryFont              Gfx.FONT_XTINY
    false             // [35]  eightColourPalette
	];
}