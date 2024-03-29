import Toybox.Lang;

/* 
 * 416 x 416 FONT GROUP A
 * DEVICES:
 * - Venu 2
 * - D2 Air X10
 * - epix 2
 * - epix 2 Pro 47mm
 */

function getLayout() as Array {
	return [
		52, 126, 252, 364, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		6,                 // [5]   stepGoalProgressHeight
		20,                // [6]   centerOffsetX
		25,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		90,                // [9]   topRowY
		155,               // [10]  middleRowLabelY
		206,               // [11]  middleRowValueY
		150,               // [12]  heartRateIconY
		145,               // [13]  heartRateIconHRZY
		28,                // [14]  heartRateIconWidth
		40,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		3,                 // [17]  heartRateIconHRZXOffset
		204,               // [18]  heartRateTextY
		286,               // [19]  bottomRowUpperTextY
		330,               // [20]  bottomRowLowerTextY
		35,                // [21]  bottomRowIconX
		270,               // [22]  bottomRowIconY
		390,               // [23]  batteryY
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