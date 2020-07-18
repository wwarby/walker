(:base) function getLayout() {
	return [
		30, 70, 145, 203, // lines
		3,   // stepGoalProgressOffsetX
		8,   // centerOffsetX
		15,  // clockY
		0,   // clockOffsetX
		50,  // topRowY
		90,  // middleRowLabelY
		120, // middleRowValueY
		87,  // heartRateIconY
		83,  // heartRateIconHRZY
		20,  // heartRateIconWidth
		28,  // heartRateIconHRZWidth
		2,   // heartRateIconXOffset
		2,   // heartRateIconHRZXOffset
		123, // heartRateTextY
		160, // bottomRowUpperTextY
		185, // bottomRowLowerTextY
		23,  // bottomRowIconX
		157, // bottomRowIconY
		220, // batteryY
		0,   // batteryX
		49,  // batteryWidth
		22   // batteryHeight
	];
}

(:base) var timeFont = 0 /* Gfx.FONT_XTINY */;
(:base) var topRowFont = 0 /* Gfx.FONT_XTINY */;
(:base) var heartRateFont = 0 /* Gfx.FONT_XTINY */;
(:base) var middleRowLabelFont = 0 /* Gfx.FONT_XTINY */;
(:base) var middleRowValueFontShrunk = 2 /* Gfx.FONT_SMALL */;
(:base) var middleRowValueFont = 5 /* Gfx.FONT_NUMBER_MILD */;
(:base) var bottomRowFont = 0 /* Gfx.FONT_XTINY */;
(:base) var batteryFont = 0 /* Gfx.FONT_XTINY */;