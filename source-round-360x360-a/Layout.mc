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
		5,                 // [5]   stepGoalProgressHeight
		20,                // [6]   centerOffsetX
		25,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		78,                // [9]   topRowY
		142,               // [10]  middleRowLabelY
		185,               // [11]  middleRowValueY
		140,               // [12]  heartRateIconY
		132,               // [13]  heartRateIconHRZY
		28,                // [14]  heartRateIconWidth
		40,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		3,                 // [17]  heartRateIconHRZXOffset
		190,               // [18]  heartRateTextY
		250,               // [19]  bottomRowUpperTextY
		290,               // [20]  bottomRowLowerTextY
		40,                // [21]  bottomRowIconX
		240,               // [22]  bottomRowIconY
		337,               // [23]  batteryY
		0,                 // [24]  batteryX
		65,                // [25]  batteryWidth
		28,                // [26]  batteryHeight
		1,                 // [27]  timeFont                 Gfx.FONT_TINY
		1,                 // [28]  topRowFont               Gfx.FONT_TINY
		1,                 // [29]  heartRateFont            Gfx.FONT_TINY
		0,                 // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		2,                 // [33]  bottomRowFont            Gfx.FONT_SMALL
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
		false              // [35]  eightColourPalette
	];
}