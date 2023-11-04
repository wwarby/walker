import Toybox.Lang;

/* 
 * 260 x 260 FONT GROUP B
 * DEVICES:
 * - fenix 6
 * - fenix 6 Pro
 * - fenix 7
 * - fenix 7 Pro
 */

function getLayout() as Array {
	return [
		34, 80, 161, 223, // [0-3] lines
		4,                // [4]   stepGoalProgressOffsetX
		4,                // [5]   stepGoalProgressHeight
		10,               // [6]   centerOffsetX
		17,               // [7]   clockY
		0,                // [8]   clockOffsetX
		58,               // [9]   topRowY
		103,              // [10]  middleRowLabelY
		134,              // [11]  middleRowValueY
		100,              // [12]  heartRateIconY
		96,               // [13]  heartRateIconHRZY
		20,               // [14]  heartRateIconWidth
		28,               // [15]  heartRateIconHRZWidth
		2,                // [16]  heartRateIconXOffset
		2,                // [17]  heartRateIconHRZXOffset
		136,              // [18]  heartRateTextY
		180,              // [19]  bottomRowUpperTextY
		203,              // [20]  bottomRowLowerTextY
		25,               // [21]  bottomRowIconX
		172,              // [22]  bottomRowIconY
		240,              // [23]  batteryY
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