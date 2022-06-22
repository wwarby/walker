import Toybox.Lang;

/* 
 * 260 x 260 FONT GROUP A
 * DEVICES:
 * - Approach S62
 * - Darth Vader
 * - First Avenger
 * - vivoactive 4
 * - Forerunner 255
 * - Forerunner 255 Music
 * - Forerunner 955
 */
 
function getLayout() as Array {
	return [
		34, 80, 161, 223, // [0-3] lines
		4,                // [4]   stepGoalProgressOffsetX
		10,               // [5]   centerOffsetX
		17,               // [6]   clockY
		0,                // [7]   clockOffsetX
		58,               // [8]   topRowY
		103,              // [9]   middleRowLabelY
		134,              // [10]  middleRowValueY
		100,              // [11]  heartRateIconY
		96,               // [12]  heartRateIconHRZY
		20,               // [13]  heartRateIconWidth
		28,               // [14]  heartRateIconHRZWidth
		2,                // [15]  heartRateIconXOffset
		2,                // [16]  heartRateIconHRZXOffset
		136,              // [17]  heartRateTextY
		180,              // [18]  bottomRowUpperTextY
		203,              // [19]  bottomRowLowerTextY
		25,               // [20]  bottomRowIconX
		172,              // [21]  bottomRowIconY
		240,              // [22]  batteryY
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