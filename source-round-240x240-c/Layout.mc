/* 
 * 240 x 240 FONT GROUP C
 * DEVICES:
 * - fenix 6S
 * - fenix 6S Pro
 * - MARQ Adventurer
 * - MARQ Athlete
 * - MARQ Aviator
 * - MARQ Captain
 * - MARQ Commander
 * - MARQ Driver
 * - MARQ Expedition
 * - MARQ Golfer
 */

function getLayout() {
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
		40,               // [24]  batteryWidth
		18,               // [25]  batteryHeight
		1,                // [26]  timeFont                 Gfx.FONT_TINY
		1,                // [27]  topRowFont               Gfx.FONT_TINY
		1,                // [28]  heartRateFont            Gfx.FONT_TINY
		1,                // [29]  middleRowLabelFont       Gfx.FONT_TINY
		3,                // [30]  middleRowValueFontShrunk Gfx.FONT_MEDIUM
		5,                // [31]  middleRowValueFont       Gfx.FONT_NUMBER_MILD
		2,                // [32]  bottomRowFont            Gfx.FONT_SMALL
		0                 // [33]  batteryFont              Gfx.FONT_XTINY
	];
}