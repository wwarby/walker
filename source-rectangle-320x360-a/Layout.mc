import Toybox.Lang;

/* 
 * 320 x 360 SQUARE FONT GROUP A
 * DEVICES:
 * - Venu Square 2
 * - Venu Square 2 Music
 */
 
function getLayout() as Array {
	return [
		46, 110, 226, 316, // [0-3] lines
		0,                 // [4]   stepGoalProgressOffsetX
		3,                 // [5]   stepGoalProgressHeight
		8,                 // [6]   centerOffsetX
		22,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		80,                // [9]   topRowY
		140,               // [10]  middleRowLabelY
		190,               // [11]  middleRowValueY
		140,               // [12]  heartRateIconY
		140,               // [13]  heartRateIconHRZY
		20,                // [14]  heartRateIconWidth
		28,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		2,                 // [17]  heartRateIconHRZXOffset
		190,               // [18]  heartRateTextY
		249,               // [19]  bottomRowUpperTextY
		292,               // [20]  bottomRowLowerTextY
		7,                 // [21]  bottomRowIconX
		258,               // [22]  bottomRowIconY
		338,               // [23]  batteryY
		0,                 // [24]  batteryX
		62,                // [25]  batteryWidth
		28,                // [26]  batteryHeight
		0,                 // [27]  timeFont                 Gfx.FONT_XTINY
		2,                 // [28]  topRowFont               Gfx.FONT_SMALL
		0,                 // [29]  heartRateFont            Gfx.FONT_XTINY
		1,                 // [30]  middleRowLabelFont       Gfx.FONT_TINY
		1,                 // [31]  middleRowValueFontShrunk Gfx.FONT_TINY
		4,                 // [32]  middleRowValueFont       Gfx.FONT_LARGE
		3,                 // [33]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
    false              // [35]  eightColourPalette
	];
}