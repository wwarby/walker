import Toybox.Lang;

/* 
 * 454 x 454 FONT GROUP A
 * DEVICES:
 * - Approach S70 47mm
 * - epix 2 Pro 51mm
 */

function getLayout() as Array {
	return [
		60, 138, 274, 394, // [0-3] lines
		5,                 // [4]   stepGoalProgressOffsetX
		6,                 // [5]   stepGoalProgressHeight
		20,                // [6]   centerOffsetX
		30,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		98,                // [9]   topRowY
		168,               // [10]  middleRowLabelY
		223,               // [11]  middleRowValueY
		166,               // [12]  heartRateIconY
		154,               // [13]  heartRateIconHRZY
		28,                // [14]  heartRateIconWidth
		40,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		3,                 // [17]  heartRateIconHRZXOffset
		218,               // [18]  heartRateTextY
		306,               // [19]  bottomRowUpperTextY
		358,               // [20]  bottomRowLowerTextY
		35,                // [21]  bottomRowIconX
		294,               // [22]  bottomRowIconY
		421,               // [23]  batteryY
		0,                 // [24]  batteryX
		65,                // [25]  batteryWidth
		28,                // [26]  batteryHeight
		1,                 // [27]  timeFont                 Gfx.FONT_TINY
		2,                 // [28]  topRowFont               Gfx.FONT_SMALL
		2,                 // [29]  heartRateFont            Gfx.FONT_SMALL
		0,                 // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [32]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		3,                 // [33]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
		false              // [35]  eightColourPalette
	];
}