import Toybox.Lang;

/* 
 * 240 x 240 FONT GROUP A
 * DEVICES:
 * - Approach D2 Charlie
 * - Approach D2 Delta
 * - Approach D2 Delta PX
 * - Approach D2 Delta S
 * - Approach Descent Mk1
 * - fenix 5
 * - fenix 5 Plus
 * - fenix 5X
 * - fenix 5X Plus
 * - Forerunner 645
 * - Forerunner 645 Music
 * - Forerunner 935
 */
 
function getLayout() as Array {
	return [
		30, 70, 145, 203, // [0-3] lines
		3,                // [4]   stepGoalProgressOffsetX
		8,                // [5]   centerOffsetX
		15,               // [6]   clockY
		0,                // [7]   clockOffsetX
		50,               // [8]   topRowY
		90,               // [9]   middleRowLabelY
		120,              // [10]  middleRowValueY
		87,               // [11]  heartRateIconY
		83,               // [12]  heartRateIconHRZY
		20,               // [13]  heartRateIconWidth
		28,               // [14]  heartRateIconHRZWidth
		2,                // [15]  heartRateIconXOffset
		2,                // [16]  heartRateIconHRZXOffset
		123,              // [17]  heartRateTextY
		160,              // [18]  bottomRowUpperTextY
		185,              // [19]  bottomRowLowerTextY
		23,               // [20]  bottomRowIconX
		157,              // [21]  bottomRowIconY
		220,              // [22]  batteryY
		0,                // [23]  batteryX
		49,               // [24]  batteryWidth
		22,               // [25]  batteryHeight
		0,                // [26]  timeFont                 Gfx.FONT_XTINY
		0,                // [27]  topRowFont               Gfx.FONT_XTINY
		0,                // [28]  heartRateFont            Gfx.FONT_XTINY
		0,                // [29]  middleRowLabelFont       Gfx.FONT_XTINY
		2,                // [30]  middleRowValueFontShrunk Gfx.FONT_SMALL
		5,                // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		0,                // [32]  bottomRowFont            Gfx.FONT_XTINY
		0,                // [33]  batteryFont              Gfx.FONT_XTINY
    false             // [34]  eightColourPalette
	];
}