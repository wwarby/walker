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
		6,                // [5]   centerOffsetX
		13,               // [6]   clockY
		0,                // [7]   clockOffsetX
		44,               // [8]   topRowY
		78,               // [9]   middleRowLabelY
		106,              // [10]  middleRowValueY
		72,               // [11]  heartRateIconY
		67,               // [12]  heartRateIconHRZY
		20,               // [13]  heartRateIconWidth
		28,               // [14]  heartRateIconHRZWidth
		2,                // [15]  heartRateIconXOffset
		2,                // [16]  heartRateIconHRZXOffset
		105,              // [17]  heartRateTextY
		142,              // [18]  bottomRowUpperTextY
		164,              // [19]  bottomRowLowerTextY
		14,               // [20]  bottomRowIconX
		132,              // [21]  bottomRowIconY
		194,              // [22]  batteryY
		0,                // [23]  batteryX
		40,               // [24]  batteryWidth
		18,               // [25]  batteryHeight
		1,                // [26]  timeFont                 Gfx.FONT_TINY
		1,                // [27]  topRowFont               Gfx.FONT_TINY
		1,                // [28]  heartRateFont            Gfx.FONT_TINY
		0,                // [29]  middleRowLabelFont       Gfx.FONT_XTINY
		2,                // [30]  middleRowValueFontShrunk Gfx.FONT_SMALL
		5,                // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		1,                // [32]  bottomRowFont            Gfx.FONT_TINY
		0,                // [33]  batteryFont              Gfx.FONT_XTINY
    true              // [34]  eightColourPalette
	];
}