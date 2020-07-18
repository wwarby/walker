/* 
 * 215 x 180 FONT GROUP A
 * DEVICES:
 * - Forerunner 230
 * - Forerunner 235
 * - Forerunner 630
 * - Forerunner 735xt
 */

function getLayout() {
	return [
		30, 64, 128, 0, // [0-3] lines
		7,              // [4]   stepGoalProgressOffsetX
		7,              // [5]   centerOffsetX
		15,             // [6]   clockY
		-30,            // [7]   clockOffsetX
		47,             // [8]   topRowY
		80,             // [9]   middleRowLabelY
		105,            // [10]  middleRowValueY
		76,             // [11]  heartRateIconY
		73,             // [12]  heartRateIconHRZY
		18,             // [13]  heartRateIconWidth
		24,             // [14]  heartRateIconHRZWidth
		2,              // [15]  heartRateIconXOffset
		0,              // [16]  heartRateIconHRZXOffset
		107,            // [17]  heartRateTextY
		143,            // [18]  bottomRowUpperTextY
		163,            // [19]  bottomRowLowerTextY
		29,             // [20]  bottomRowIconX
		138,            // [21]  bottomRowIconY
		15,             // [22]  batteryY
		30,             // [23]  batteryX
		40,             // [24]  batteryWidth
		18,             // [25]  batteryHeight
		3,              // [26]  timeFont                 Gfx.FONT_MEDIUM
		3,              // [27]  topRowFont               Gfx.FONT_MEDIUM
		3,              // [28]  heartRateFont            Gfx.FONT_MEDIUM
		3,              // [29]  middleRowLabelFont       Gfx.FONT_MEDIUM
		5,              // [30]  middleRowValueFontShrunk Gfx.FONT_NUMBER_MILD
		5,              // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		3,              // [32]  bottomRowFont            Gfx.FONT_XTINY
		3               // [33]  batteryFont              Gfx.FONT_XTINY
	];
}
