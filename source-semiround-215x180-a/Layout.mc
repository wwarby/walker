import Toybox.Lang;

/* 
 * 215 x 180 FONT GROUP A
 * DEVICES:
 * - Forerunner 230
 * - Forerunner 235
 * - Forerunner 630
 * - Forerunner 735xt
 */

function getLayout() as Array {
	return [
		30, 64, 128, 0, // [0-3] lines
		7,              // [4]   stepGoalProgressOffsetX
		3,              // [5]   stepGoalProgressHeight
		7,              // [6]   centerOffsetX
		15,             // [7]   clockY
		-30,            // [8]   clockOffsetX
		47,             // [9]   topRowY
		80,             // [10]  middleRowLabelY
		105,            // [11]  middleRowValueY
		76,             // [12]  heartRateIconY
		73,             // [13]  heartRateIconHRZY
		18,             // [14]  heartRateIconWidth
		24,             // [15]  heartRateIconHRZWidth
		2,              // [16]  heartRateIconXOffset
		0,              // [17]  heartRateIconHRZXOffset
		107,            // [18]  heartRateTextY
		143,            // [19]  bottomRowUpperTextY
		163,            // [20]  bottomRowLowerTextY
		29,             // [21]  bottomRowIconX
		138,            // [22]  bottomRowIconY
		15,             // [23]  batteryY
		30,             // [24]  batteryX
		40,             // [25]  batteryWidth
		18,             // [26]  batteryHeight
		3,              // [27]  timeFont                 Gfx.FONT_MEDIUM
		3,              // [28]  topRowFont               Gfx.FONT_MEDIUM
		3,              // [29]  heartRateFont            Gfx.FONT_MEDIUM
		3,              // [30]  middleRowLabelFont       Gfx.FONT_MEDIUM
		5,              // [31]  middleRowValueFontShrunk Gfx.FONT_NUMBER_MILD
		5,              // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		3,              // [33]  bottomRowFont            Gfx.FONT_XTINY
		3,              // [34]  batteryFont              Gfx.FONT_XTINY
		false           // [35]  eightColourPalette
	];
}
