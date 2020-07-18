/* 
 * 390 x 390 FONT GROUP A
 * DEVICES:
 * - Venu
 * - Venu Mercedes
 */

function getLayout() {
	return [
		50, 120, 245, 340, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		20,                // [5]   centerOffsetX
		25,                // [6]   clockY
		0,                 // [7]   clockOffsetX
		85,                // [8]   topRowY
		150,               // [9]   middleRowLabelY
		200,               // [10]  middleRowValueY
		150,               // [11]  heartRateIconY
		145,               // [12]  heartRateIconHRZY
		28,                // [13]  heartRateIconWidth
		40,                // [14]  heartRateIconHRZWidth
		2,                 // [15]  heartRateIconXOffset
		3,                 // [16]  heartRateIconHRZXOffset
		204,               // [17]  heartRateTextY
		276,               // [18]  bottomRowUpperTextY
		310,               // [19]  bottomRowLowerTextY
		45,                // [20]  bottomRowIconX
		268,               // [21]  bottomRowIconY
		365,               // [22]  batteryY
		0,                 // [23]  batteryX
		65,                // [24]  batteryWidth
		28,                // [25]  batteryHeight
		1,                 // [26]  timeFont                 Gfx.FONT_TINY
		1,                 // [27]  topRowFont               Gfx.FONT_TINY
		1,                 // [28]  heartRateFont            Gfx.FONT_TINY
		0,                 // [29]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [30]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		1,                 // [32]  bottomRowFont            Gfx.FONT_TINY
		0                  // [33]  batteryFont              Gfx.FONT_XTINY
	];
}