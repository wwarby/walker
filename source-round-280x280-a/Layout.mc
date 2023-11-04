import Toybox.Lang;

/* 
 * 280 x 280 FONT GROUP A
 * DEVICES:
 * - fenix 6X Pro
 * - fenix 7X
 * - fenix 7X Pro
 * - Descent MK2
 * - Enduro
 */

function getLayout() as Array {
	return [
		36, 86, 176, 243, // [0-3] lines
		4,                // [4]   stepGoalProgressOffsetX
		4,                // [5]   stepGoalProgressHeight
		10,               // [6]   centerOffsetX
		18,               // [7]   clockY
		0,                // [8]   clockOffsetX
		60,               // [9]   topRowY
		110,              // [10]  middleRowLabelY
		146,              // [11]  middleRowValueY
		109,              // [12]  heartRateIconY
		105,              // [13]  heartRateIconHRZY
		20,               // [14]  heartRateIconWidth
		28,               // [15]  heartRateIconHRZWidth
		2,                // [16]  heartRateIconXOffset
		2,                // [17]  heartRateIconHRZXOffset
		145,              // [18]  heartRateTextY
		196,              // [19]  bottomRowUpperTextY
		222,              // [20]  bottomRowLowerTextY
		32,               // [21]  bottomRowIconX
		192,              // [22]  bottomRowIconY
		260,              // [23]  batteryY
		0,                // [24]  batteryX
		45,               // [25]  batteryWidth
		20,               // [26]  batteryHeight
		1,                // [27]  timeFont                 Gfx.FONT_TINY
		1,                // [28]  topRowFont               Gfx.FONT_TINY
		1,                // [29]  heartRateFont            Gfx.FONT_TINY
		1,                // [30]  middleRowLabelFont       Gfx.FONT_TINY
		3,                // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		2,                // [33]  bottomRowFont            Gfx.FONT_SMALL
		0,                // [34]  batteryFont              Gfx.FONT_XTINY
    false             // [35]  eightColourPalette
	];
}