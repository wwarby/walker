import Toybox.Lang;

/* 
 * 218 x 218 FONT GROUP B
 * DEVICES:
 * - D2 Bravo
 * - D2 Bravo Titanium
 * - fenix 3
 * - fenix 3 HR
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
		40,               // [25]  batteryWidth
		18,               // [26]  batteryHeight
		1,                // [27]  timeFont                 Gfx.FONT_TINY
		1,                // [28]  topRowFont               Gfx.FONT_TINY
		1,                // [29]  heartRateFont            Gfx.FONT_TINY
		0,                // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		4,                // [32]  middleRowValueFont       Gfx.FONT_LARGE
		1,                // [33]  bottomRowFont            Gfx.FONT_TINY
		0,                // [34]  batteryFont              Gfx.FONT_XTINY
    false             // [35]  eightColourPalette
	];
}