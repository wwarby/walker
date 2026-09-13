import Toybox.Lang;

/* 
 * 466 x 466 FONT GROUP A
 * DEVICES:
 * - fenix 9 Pro 51mm
 */

function getLayout() as Array {
	return [
		62, 142, 281, 404, // [0-3] lines
		5,                 // [4]   stepGoalProgressOffsetX
		6,                 // [5]   stepGoalProgressHeight
		14,                // [6]   centerOffsetX
		31,                // [7]   clockY
		0,                 // [8]   clockOffsetX
		101,               // [9]   topRowY
		172,               // [10]  middleRowLabelY
		229,               // [11]  middleRowValueY
		170,               // [12]  heartRateIconY
		158,               // [13]  heartRateIconHRZY
		29,                // [14]  heartRateIconWidth
		41,                // [15]  heartRateIconHRZWidth
		2,                 // [16]  heartRateIconXOffset
		3,                 // [17]  heartRateIconHRZXOffset
		224,               // [18]  heartRateTextY
		314,               // [19]  bottomRowUpperTextY
		367,               // [20]  bottomRowLowerTextY
		36,                // [21]  bottomRowIconX
		302,               // [22]  bottomRowIconY
		432,               // [23]  batteryY
		0,                 // [24]  batteryX
		67,                // [25]  batteryWidth
		29,                // [26]  batteryHeight
		1,                 // [27]  timeFont                 Gfx.FONT_TINY
		1,                 // [28]  topRowFont               Gfx.FONT_TINY
		1,                 // [29]  heartRateFont            Gfx.FONT_TINY
		0,                 // [30]  middleRowLabelFont       Gfx.FONT_XTINY
		3,                 // [31]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		3,                 // [32]  middleRowValueFont       Gfx.FONT_MEDIUM
		3,                 // [33]  bottomRowFont            Gfx.FONT_MEDIUM
		0,                 // [34]  batteryFont              Gfx.FONT_XTINY
		false              // [35]  eightColourPalette
	];
}