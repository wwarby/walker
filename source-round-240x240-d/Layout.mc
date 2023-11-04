import Toybox.Lang;

/* 
 * 240 x 240 FONT GROUP D
 * DEVICES:
 * - Forerunner 245
 * - Forerunner 245 Music
 * - Forerunner 745
 * - Forerunner 945
 * - Forerunner 945 LTE
 * - Descent MK2 S
 */

function getLayout() as Array {
	return [
		30, 70, 145, 203, // [0-3] lines
		3,                // [4]   stepGoalProgressOffsetX
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
		23,               // [21]  bottomRowIconX
		157,              // [22]  bottomRowIconY
		220,              // [23]  batteryY
		0,                // [24]  batteryX
		40,               // [25]  batteryWidth
		18,               // [26]  batteryHeight
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