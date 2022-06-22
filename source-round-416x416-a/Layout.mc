import Toybox.Lang;

/* 
 * 416 x 416 FONT GROUP A
 * DEVICES:
 * - Venu 2
 * - D2 Air X10
 * - epix Gen 2
 */

function getLayout() as Array {
	return [
		52, 126, 252, 364, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		20,                // [5]   centerOffsetX
		25,                // [6]   clockY
		0,                 // [7]   clockOffsetX
		90,                // [8]   topRowY
		155,               // [9]   middleRowLabelY
		206,               // [10]  middleRowValueY
		150,               // [11]  heartRateIconY
		145,               // [12]  heartRateIconHRZY
		28,                // [13]  heartRateIconWidth
		40,                // [14]  heartRateIconHRZWidth
		2,                 // [15]  heartRateIconXOffset
		3,                 // [16]  heartRateIconHRZXOffset
		204,               // [17]  heartRateTextY
		286,               // [18]  bottomRowUpperTextY
		330,               // [19]  bottomRowLowerTextY
		35,                // [20]  bottomRowIconX
		270,               // [21]  bottomRowIconY
		390,               // [22]  batteryY
		0,                 // [23]  batteryX
		65,                // [24]  batteryWidth
		28,                // [25]  batteryHeight
		1,                 // [26]  timeFont                 Gfx.FONT_TINY
		2,                 // [27]  topRowFont               Gfx.FONT_SMALL
		2,                 // [28]  heartRateFont            Gfx.FONT_SMALL
		0,                 // [29]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [30]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                 // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		3,                 // [32]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                 // [33]  batteryFont              Gfx.FONT_XTINY
		false              // [34]  eightColourPalette
	];
}