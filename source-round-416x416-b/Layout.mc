import Toybox.Lang;

/* 
 * 416 x 416 FONT GROUP B
 * DEVICES:
 * - Forerunner 265
 */

function getLayout() as Array {
	return [
		52, 126, 252, 364, // [0-3] lines
		7,                 // [4]   stepGoalProgressOffsetX
		6,                 // [5]   stepGoalProgressHeight
		12,                // [6]   centerOffsetX
		28,                // [7]   clockY
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
		208,               // [18]  heartRateTextY
		286,               // [19]  bottomRowUpperTextY
		330,               // [20]  bottomRowLowerTextY
		35,                // [21]  bottomRowIconX
		270,               // [22]  bottomRowIconY
		390,               // [23]  batteryY
		0,                 // [24]  batteryX
		65,                // [25]  batteryWidth
		28,                // [26]  batteryHeight
		1,                 // [27]  timeFont                 Gfx.FONT_TINY
		1,                 // [28]  topRowFont               Gfx.FONT_TINY
		1,                 // [29]  heartRateFont            Gfx.FONT_TINY
		0,                 // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		2,                 // [31]  middleRowValueFontShrunk Gfx.FONT_TINY
		4,                 // [32]  middleRowValueFont       Gfx.FONT_LARGE
		1,                 // [33]  bottomRowFont            Gfx.FONT_TINY
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
		false              // [35]  eightColourPalette
	];
}