import Toybox.Lang;

/* 
 * 208 x 208 FONT GROUP A
 * DEVICES:
 * - Forerunner 55
 */

function getLayout() as Array {
	return [
		26, 62, 126, 182, // [0-3] lines
		2,                // [4]   stepGoalProgressOffsetX
		3,                // [5]   stepGoalProgressHeight
		6,                // [6]   centerOffsetX
		13,               // [7]   clockY
		0,                // [8]   clockOffsetX
		44,               // [9]   topRowY
		78,               // [10]  middleRowLabelY
		106,              // [11]  middleRowValueY
		72,               // [12]  heartRateIconY
		67,               // [13]  heartRateIconHRZY
		20,               // [14]  heartRateIconWidth
		28,               // [15]  heartRateIconHRZWidth
		2,                // [16]  heartRateIconXOffset
		2,                // [17]  heartRateIconHRZXOffset
		105,              // [18]  heartRateTextY
		142,              // [19]  bottomRowUpperTextY
		164,              // [20]  bottomRowLowerTextY
		14,               // [21]  bottomRowIconX
		132,              // [22]  bottomRowIconY
		194,              // [23]  batteryY
		0,                // [24]  batteryX
		40,               // [25]  batteryWidth
		18,               // [26]  batteryHeight
		1,                // [27]  timeFont                 Gfx.FONT_TINY
		1,                // [28]  topRowFont               Gfx.FONT_TINY
		1,                // [29]  heartRateFont            Gfx.FONT_TINY
		0,                // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		2,                // [31]  middleRowValueFontShrunk Gfx.FONT_SMALL
		5,                // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		1,                // [33]  bottomRowFont            Gfx.FONT_TINY
		0,                // [34]  batteryFont              Gfx.FONT_XTINY
    true              // [35]  eightColourPalette
	];
}