import Toybox.Lang;

/* 
 * 280 x 280 FONT GROUP A
 * DEVICES:
 * - fenix 6X Pro
 * - fenix 7X
 * - Descent MK2
 * - Enduro
 */

function getLayout() as Array {
	return [
		36, 86, 176, 243, // [0-3] lines
		4,                // [4]   stepGoalProgressOffsetX
		10,               // [5]   centerOffsetX
		18,               // [6]   clockY
		0,                // [7]   clockOffsetX
		60,               // [8]   topRowY
		110,              // [9]   middleRowLabelY
		146,              // [10]  middleRowValueY
		109,              // [11]  heartRateIconY
		105,              // [12]  heartRateIconHRZY
		20,               // [13]  heartRateIconWidth
		28,               // [14]  heartRateIconHRZWidth
		2,                // [15]  heartRateIconXOffset
		2,                // [16]  heartRateIconHRZXOffset
		145,              // [17]  heartRateTextY
		196,              // [18]  bottomRowUpperTextY
		222,              // [19]  bottomRowLowerTextY
		32,               // [20]  bottomRowIconX
		192,              // [21]  bottomRowIconY
		260,              // [22]  batteryY
		0,                // [23]  batteryX
		45,               // [24]  batteryWidth
		20,               // [25]  batteryHeight
		1,                // [26]  timeFont                 Gfx.FONT_TINY
		1,                // [27]  topRowFont               Gfx.FONT_TINY
		1,                // [28]  heartRateFont            Gfx.FONT_TINY
		1,                // [29]  middleRowLabelFont       Gfx.FONT_TINY
		3,                // [30]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		2,                // [32]  bottomRowFont            Gfx.FONT_SMALL
		0,                // [33]  batteryFont              Gfx.FONT_XTINY
    false             // [34]  eightColourPalette
	];
}