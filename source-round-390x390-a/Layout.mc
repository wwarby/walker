import Toybox.Lang;

/* 
 * 390 x 390 FONT GROUP A
 * DEVICES:
 * - Venu
 * - Venu Mercedes
 * - Approach S70 42mm
 * - epix 2 Pro 42mm
 * - MARQ 2
 * - MARQ Aviator
 * - Venu 3S
 * - Venu 4 (41mm)
 */

function getLayout() as Array {
	return [
		50, 120, 245, 340, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		5,                 // [5]   stepGoalProgressHeight
		20,                // [6]   centerOffsetX
		25,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		85,                // [9]   topRowY
		150,               // [10]  middleRowLabelY
		200,               // [11]  middleRowValueY
		150,               // [12]  heartRateIconY
		145,               // [13]  heartRateIconHRZY
		28,                // [14]  heartRateIconWidth
		40,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		3,                 // [17]  heartRateIconHRZXOffset
		204,               // [18]  heartRateTextY
		276,               // [19]  bottomRowUpperTextY
		310,               // [20]  bottomRowLowerTextY
		45,                // [21]  bottomRowIconX
		268,               // [22]  bottomRowIconY
		365,               // [23]  batteryY
		0,                 // [24]  batteryX
		65,                // [25]  batteryWidth
		28,                // [26]  batteryHeight
		1,                 // [27]  timeFont                 Gfx.FONT_TINY
		1,                 // [28]  topRowFont               Gfx.FONT_TINY
		1,                 // [29]  heartRateFont            Gfx.FONT_TINY
		0,                 // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		1,                 // [33]  bottomRowFont            Gfx.FONT_TINY
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
		false              // [35]  eightColourPalette
	];
}
