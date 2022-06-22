import Toybox.Lang;

/* 
 * 360 x 360 FONT GROUP A
 * DEVICES:
 * - Venu 2S
 */

function getLayout() as Array {
	return [
		46, 114, 225, 314, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		20,                // [5]   centerOffsetX
		25,                // [6]   clockY
		0,                 // [7]   clockOffsetX
		78,                // [8]   topRowY
		142,               // [9]   middleRowLabelY
		185,               // [10]  middleRowValueY
		140,               // [11]  heartRateIconY
		132,               // [12]  heartRateIconHRZY
		28,                // [13]  heartRateIconWidth
		40,                // [14]  heartRateIconHRZWidth
		2,                 // [15]  heartRateIconXOffset
		3,                 // [16]  heartRateIconHRZXOffset
		190,               // [17]  heartRateTextY
		250,               // [18]  bottomRowUpperTextY
		290,               // [19]  bottomRowLowerTextY
		40,                // [20]  bottomRowIconX
		240,               // [21]  bottomRowIconY
		337,               // [22]  batteryY
		0,                 // [23]  batteryX
		65,                // [24]  batteryWidth
		28,                // [25]  batteryHeight
		1,                 // [26]  timeFont                 Gfx.FONT_TINY
		1,                 // [27]  topRowFont               Gfx.FONT_TINY
		1,                 // [28]  heartRateFont            Gfx.FONT_TINY
		0,                 // [29]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [30]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		2,                 // [32]  bottomRowFont            Gfx.FONT_SMALL
		0,                 // [33]  batteryFont              Gfx.FONT_XTINY
		false              // [34]  eightColourPalette
	];
}