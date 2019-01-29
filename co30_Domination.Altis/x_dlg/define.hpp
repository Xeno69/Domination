#define CT_STATIC			0
#define CT_BUTTON			1
#define CT_EDIT				2
#define CT_SLIDER			3
#define CT_COMBO			4
#define CT_LISTBOX			5
#define CT_TOOLBOX			6
#define CT_CHECKBOXES		7
#define CT_PROGRESS			8
#define CT_HTML				9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		11
#define CT_TREE				12
#define CT_STRUCTURED_TEXT	13 
#define CT_3DSTATIC			20
#define CT_3DACTIVETEXT		21
#define CT_3DLISTBOX		22
#define CT_3DHTML			23
#define CT_3DSLIDER			24
#define CT_3DEDIT			25
#define CT_OBJECT			80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER				99
#define ST_HPOS				0x0F
#define ST_LEFT				0
#define ST_RIGHT			1
#define ST_CENTER			2
#define ST_UP				3
#define ST_DOWN				4
#define ST_VCENTER			5
#define ST_TYPE				0xF0
#define ST_SINGLE			0
#define ST_MULTI			16
#define ST_TITLE_BAR		32
#define ST_PICTURE			48
#define ST_FRAME			64
#define ST_BACKGROUND		80
#define ST_GROUP_BOX		96
#define ST_GROUP_BOX2		112
#define ST_HUD_BACKGROUND	128
#define ST_TILE_PICTURE		144
#define ST_WITH_RECT		160
#define ST_LINE				176
#define ST_SHADOW			256
#define ST_NO_RECT			512
#define ST_KEEP_ASPECT_RATIO  0x800
#define ST_TITLE			ST_TITLE_BAR + ST_CENTER
#define FontHTML			"RobotoCondensed"
#define FontM				"RobotoCondensed"
#define Dlg_ROWS			36
#define Dlg_COLS			90
#define Dlg_CONTROLHGT		((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH		((100/Dlg_COLS)/100)
#define Dlg_TEXTHGT_MOD		0.9
#define Dlg_ROWSPACING_MOD	1.3
#define Dlg_ROWHGT			(Dlg_CONTROLHGT*Dlg_ROWSPACING_MOD)
#define Dlg_TEXTHGT			(Dlg_CONTROLHGT*Dlg_TEXTHGT_MOD)
#define UILEFT				0
#define UICOMBO				4
#define DEFAULTFONT			"RobotoCondensed"

#define __GUI_BCG_RGB {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"}
#define __GUI_TXT_RGB {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1}
#define __GUI_1_RGB {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1}

#define __DOM_NVER_STR__ "Domination! 3"

class ScrollBar {
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};
class RscText {
	idc = -1;
	type = CT_STATIC;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = DEFAULTFONT;
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	text = "";
};
class RscBG: RscText {
	idc = -1;
	type = CT_STATIC;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = DEFAULTFONT;
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	text = "";
};
class RscFrame {
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = DEFAULTFONT;
	sizeEx = 0.02;
	text = "";
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
};
class RscButton {
	idc = -1;
	type = CT_BUTTON;
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = DEFAULTFONT;
	sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {0, 0, 0, 0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0, 0, 0, 0};
	colorBorder[] = {0, 0, 0, 1};
	borderSize = 0.0;
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	default = false;
};
class RscNavButton:RscButton {
	w = 0.1; h = 0.04;
	x = 0.90;
};
class RscListBox {
	type = 5;
	style = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0.3};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	font = DEFAULTFONT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rowHeight = 0.03;
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 10;
	w = 0.275;
	h = 0.04;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	colorScrollbar[] = {0.95,0.95,0.95,1};
	shadow = 2;
	period = 1.2;
	default = false;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class ListScrollBar: ScrollBar {
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
	};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
};
class RscPicture {
	shadow = 0;
	colorText[] = {1,1,1,1};
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class RscVignette: RscPicture {
	type = CT_STATIC;
	style = ST_PICTURE;
	x = "safezoneXAbs";
	y = "safezoneY";
	w = "safezoneWAbs";
	h = "safezoneH";
	text = "\A3\ui_f\data\gui\rsccommon\rscvignette\vignette_gs.paa";
	colortext[] = {0,0,0,0.3};
	colorBackground[] = {0, 0, 0, 0};
	font = FontM;
	sizeEx = Dlg_TEXTHGT;
};
class RscPictureKeepAspect: RscPicture {
	style = "0x30 + 0x800";
};
class D_RscPicture: RscPicture {
	type = CT_STATIC;
	idc = -1;
	style = ST_PICTURE;
	x = 0.1; y = 0.1;
	w = 0.4; h = 0.2;
	sizeEx = Dlg_TEXTHGT;
	colorBackground[] = {0, 0, 0, 0};
	font = FontM;
	text = "";
};
class D_RscMapControl {
	type = 101;
	style = 48;
	font = DEFAULTFONT;
	sizeEx = 0.04;
	moveOnEdges = 1;
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "SafeZoneWAbs";
	h = "SafeZoneH - 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1.0;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	colorBackground[] = {0.969,0.957,0.949,1.0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0.0,0.0,0.0,0.0};
	colorRocks[] = {0.0,0.0,0.0,0.3};
	colorRocksBorder[] = {0.0,0.0,0.0,0.0};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorPowerLines[] = {0.1,0.1,0.1,1.0};
	colorRailWay[] = {0.8,0.2,0.0,1.0};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1.0,1.0,1.0,0.5};
	colorOutside[] = {0.0,0.0,0.0,1.0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorText[] = {0, 0, 0, 1};
	fontLabel = DEFAULTFONT;
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "RobotoCondensed";
	sizeExGrid = 0.02;
	fontUnits = "RobotoCondensed";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "EtelkaNarrowMediumPro";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = DEFAULTFONT;
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "RobotoCondensed";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	onDraw = "[_this, 2] call d_fnc_mapondraw";
	class LineMarker {
		lineWidthThin = 0.008;
		lineWidthThick = 0.014;
		lineDistanceMin = 3e-005;
		lineLengthMin = 5;
	};
	class Legend {
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = DEFAULTFONT;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
	};
	class Task {
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Waypoint {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0,0,0,1};
		size = 20;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class WaypointCompleted {
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0,0,0,1};
		size = 20;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class CustomMark {
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0,0,0,1};
	};
	class Command {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Bush {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock {
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1,0.1,0.1,0.8};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class busstop {
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class fuelstation {
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class hospital {
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class church {
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class lighthouse {
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class quay {
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class transmitter {
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class watertower {
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class Cross {
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Chapel {
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Bunker {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fortress {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fountain {
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Ruin {
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Stack {
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Tourism {
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ViewTower {
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ActiveMarker {
		color[] = {0,0,0,0};
		size = 1;
	};
};

class RscShortcutButton {
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	colorFocused[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = __GUI_1_RGB;
	colorBackgroundFocused[] = __GUI_1_RGB;
	colorBackground2[] = {1,1,1,1};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1.0};
	colorFocusedSecondary[] = {1,1,1,1.0};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = DEFAULTFONT;
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	textureNoShortcut = "";
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos {
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) -(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos {
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = DEFAULTFONT;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	action = "";
	class Attributes {
		font = DEFAULTFONT;
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage {
		font = DEFAULTFONT;
		color = "#E5E5E5";
		align = "left";
	};
};

class RscButtonBase: RscShortcutButton {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackground2[] = {1,1,1,0.5};
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	class Attributes {
		font = DEFAULTFONT;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos {
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};

class RscButtonBase2: RscButtonBase {
	colorBackground[] = __GUI_BCG_RGB;
	colorBackground2[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
};

class RscButtonMenu: RscShortcutButton {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	class Attributes {
		font = DEFAULTFONT;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos {
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
};

class RscLinkButtonBase {
	idc = -1;
	type = CT_BUTTON;
	style = ST_CENTER;
	default = false;
	font = DEFAULTFONT;
	sizeEx = 0.029;
	colorText[] = {1, 1, 1, 1};
	colorFocused[] = {1, 1, 1, 0};
	colorDisabled[] = {0, 0, 1, 0.7};
	colorBackground[] = {1, 1, 1, 0};
	colorBackgroundDisabled[] = {1, 1, 1, 0.5};
	colorBackgroundActive[] = {1, 1, 1, 0};
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = {1, 1, 1, 0};
	colorBorder[] = {1, 1, 1, 0};
	borderSize = 0;
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	x = 0.06; y = 0.11;
	w = 0.15; h = 0.1;
	text = "";
	action = "";
	shadow = 2;
};
class RscCombo {
	style = 16;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelect[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorScrollbar[] = {1,0,0,1};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {1,1,1,1};
	colorActive[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	font = DEFAULTFONT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	class ComboScrollBar: ScrollBar {
		color[] = {1,1,1,1};
	};

};
class RscUIComboBox: RscCombo {
	type = UICOMBO;
	idc = -1;
	sizeEx = 0.025;
	wholeHeight = 0.3;
	colorText[] = {1,1,1,1};
};
class RscUIComboBox2: RscUIComboBox {
		sizeEx = 0.03;
};
class RscText2 {
	type = CT_STATIC;
	idc = -1;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = DEFAULTFONT;
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	text = "";
};

class RscXSliderH {
	type = 43;
	idc = -1;
	style = "0x400	+ 0x10";
	shadow = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class RscControlsGroup {
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = 16;
	class VScrollbar: ScrollBar {
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar: ScrollBar {
		height = 0.028;
	};
	class Controls{};
};

class RscControlsGroupNoScrollbars: RscControlsGroup {
	class VScrollbar: VScrollbar {
		width = 0;
	};
	class HScrollbar: HScrollbar {
		height = 0;
	};
};

class xr_mouseHandler : RscControlsGroup {
	onMouseButtonDown = "['MouseButtonDown',_this] call xr_fnc_DlgEvents";
	onMouseButtonUp = "['MouseButtonUp',_this] call xr_fnc_DlgEvents";
	onMouseZChanged = "['MouseZChanged',_this] call xr_fnc_DlgEvents";
	idc = -1;
	type = 15;
	style = 0;
	x = SafeZoneX; y = SafeZoneY;
	w = SafeZoneW; h = SafeZoneH;
	colorBackground[] = {0, 0, 0, 0};
};

class RscStructuredText {
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	shadow = 1;
	class Attributes {
		font = DEFAULTFONT;
		color = "#ffffff";
		align = "left";
		shadow = 1;
	};
};

class RscXListBox {
	type = 42;
	style = "0x400 + 0x02 +	0x10";
	shadow = 2;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	w = 0.14706;
	h = 0.039216;
	colorSelect[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	font = DEFAULTFONT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	colorActive[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
};

class RscProgress {
	//style = 1;
	style = 0;
	type = CT_PROGRESS;
	x = 0.344;
	y = 0.619;
	w = 0.3137255;
	h = 0.0261438;
	shadow = 2;
	texture = "\A3\ui_f\data\GUI\RscCommon\RscProgress\progressbar_ca.paa";
	colorFrame[] = {0,0,0,0};
	colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
};

class RscListNBox {
	style = 16;
	shadow = 0;
	type = 102;
	font = DEFAULTFONT;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	color[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	period = 1.2;
	rowHeight = 0.04;
	maxHistoryDelay = 1;
	soundSelect[] = {"", 0.1, 1};
	class ListScrollBar: ScrollBar{};
	class ScrollBar: ScrollBar{};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
};

class RscIGUIListNBox: RscListNBox {
	idc = -1;
	style = "0 + 0x10";
	shadow = 2;
	color[] = {1,1,1,1};
	colorText[] = {1,1,1,0.75};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorSelect2[] = {0.95,0.95,0.95,1};
	colorSelectBackground[] = {1,1,1,1.0};
	colorSelectBackground2[] = {1,1,1,1.0};
	period = 0;
	colorBackground[] = {0,0,0,1};
	columns[] = {0.1,0.7,0.1,0.1};
	class ScrollBar: ScrollBar{};
};

#define __DDIALOG_BG(loc_str) \
	class BackGroundCaption: RscText2 { \
		x = 0; y = 0; \
		w = 1; h = 1 / 25; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText2 { \
		x = 0.02; y = 0; \
		w = 0.4; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText2 { \
		colorBackground[] = {0, 0, 0, 0.7}; \
		x = 0; \
		y = (1 / 25) + 0.005; \
		w = 1; \
		h = 1 - (2 / 25) - 0.01; \
	}; \
	class DomVer: RscText2 { \
		x = 0.02; y = 1 - 0.04; \
		w = 0.25; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = __DOM_NVER_STR__; \
	};

#define __DDIALOG_BGN(loc_str) \
	class BackGroundCaption: RscText2 { \
		x = "0.0124502 * safezoneW + safezoneX"; y = "0.02 * safezoneH + safezoneY"; \
		w = "0.965724 * safezoneW"; h = "0.04 * safezoneH"; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText2 { \
		x = "0.0405779 * safezoneW + safezoneX"; y = "0.02 * safezoneH + safezoneY"; \
		w = "0.543806 * safezoneW"; h = "0.04 * safezoneH"; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText2 { \
		colorBackground[] = {0, 0, 0, 0.7}; \
		x = "0.0124502 * safezoneW + safezoneX"; \
		y = "0.07 * safezoneH + safezoneY"; \
		w = "0.9751 * safezoneW"; \
		h = "0.89 * safezoneH"; \
	}; \
	class DomVer: RscText2 { \
		x = "0.0780818 * safezoneW + safezoneX"; y = "0.96 * safezoneH + safezoneY"; \
		w = "0.346911 * safezoneW"; h = "0.04 * safezoneH"; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = __DOM_NVER_STR__; \
	};
	
#define __DDIALOG_BG2(loc_str) \
	class BackGroundCaption: RscText2 { \
		x = safezoneX; y = safezoneY; \
		w = safezoneW; h = 1 / 25; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText2 { \
		x = safezoneX + 0.02; y = safezoneY; \
		w = 0.4; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText2 { \
		colorBackground[] = {0, 0, 0, 0.9}; \
		x = safezoneX; \
		y = safeZoneY + (1 / 25); \
		w = safezoneW; \
		h = safezoneH - 0.01; \
	}; \
	class DomVer: RscText2 { \
		x = safezoneX + 0.02; y = safeZoneY + safezoneH - 0.05; \
		w = 0.25; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = __DOM_NVER_STR__; \
	};
	
#define __CANCELCLOSEB(bidc) \
	class CancelCloseButton: RscButton { \
			idc = bidc; \
			style = "0x02+48"; \
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa"; \
			action = "closeDialog 0"; \
			x = 0.96; y = 0.003; w = 0.035; h = 0.035; \
			colorBackground[] = __GUI_BCG_RGB; \
			colorBackgroundActive[] = __GUI_BCG_RGB; \
		};
		
#define __CANCELCLOSEB2(bidc) \
	class CancelCloseButton: RscButton { \
			idc = bidc; \
			style = "0x02+48"; \
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa"; \
			action = "closeDialog 0"; \
			x = safezoneX + safezoneW - 0.04; y = safeZoneY + 0.003; w = 0.035; h = 0.035; \
			colorBackground[] = __GUI_BCG_RGB; \
			colorBackgroundActive[] = __GUI_BCG_RGB; \
		};
		
#define __CANCELCLOSEB3(bidc) \
	class CancelCloseButton: RscButton { \
			idc = bidc; \
			style = "0x02+48"; \
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa"; \
			action = "closeDialog 0"; \
			x = "0.959422 * safezoneW + safezoneX"; y = "0.02 * safezoneH + safezoneY"; w = "0.0281279 * safezoneW"; h = "0.04 * safezoneH"; \
			colorBackground[] = __GUI_BCG_RGB; \
			colorBackgroundActive[] = __GUI_BCG_RGB; \
		};

#define COMMON_BACKGROUND_VIGNETTE \
	class Vignette: RscVignette \
	{ \
		idc = 114998; \
	};

#define BCGTILE(posX,posY) \
	class Tile_##posX##_##posY##: RscText \
	{ \
		idc = 1150##posX####posY##; \
		x = (##posX## * 1/6) * safezoneW; \
		y = (##posY## * 1/6) * safezoneH; \
		w = 1/6 * safezoneW; \
		h = 1/6 * safezoneH; \
		colorBackground[] = {0,0,0,0.1}; \
	};
	
#define COMMON_BACKGROUND_TILES\
	class TileGroup: RscControlsGroupNoScrollbars\
	{\
		idc = 115099;\
		x = safezoneX;\
		y = safezoneY;\
		w = safezoneW;\
		h = safezoneH;\
		disableCustomColors = 1;\
		class Controls\
		{\
			class TileFrame: RscFrame\
			{\
				idc = 114999;\
				x = 0;\
				y = 0;\
				w = safezoneW;\
				h = safezoneH;\
				colortext[] = {0,0,0,1};\
			};\
			BCGTILE(0,0)\
			BCGTILE(0,1)\
			BCGTILE(0,2)\
			BCGTILE(0,3)\
			BCGTILE(0,4)\
			BCGTILE(0,5)\
			BCGTILE(1,0)\
			BCGTILE(1,1)\
			BCGTILE(1,2)\
			BCGTILE(1,3)\
			BCGTILE(1,4)\
			BCGTILE(1,5)\
			BCGTILE(2,0)\
			BCGTILE(2,1)\
			BCGTILE(2,2)\
			BCGTILE(2,3)\
			BCGTILE(2,4)\
			BCGTILE(2,5)\
			BCGTILE(3,0)\
			BCGTILE(3,1)\
			BCGTILE(3,2)\
			BCGTILE(3,3)\
			BCGTILE(3,4)\
			BCGTILE(3,5)\
			BCGTILE(4,0)\
			BCGTILE(4,1)\
			BCGTILE(4,2)\
			BCGTILE(4,3)\
			BCGTILE(4,4)\
			BCGTILE(4,5)\
			BCGTILE(5,0)\
			BCGTILE(5,1)\
			BCGTILE(5,2)\
			BCGTILE(5,3)\
			BCGTILE(5,4)\
			BCGTILE(5,5)\
		}\
	};

class d_RscStructuredText {
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {0.8784,0.8471,0.651,1};
	class Attributes {
		font = DEFAULTFONT;
		color = "#e0d8a6";
		align = "center";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = 0.03921;
	shadow = 2;
};

class RscEdit {
	deletable = 0;
	fade = 0;
	access = 0;
	type = 2;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", 1};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = "0x00 + 0x40";
	font = "RobotoCondensed";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	canModify = 1;
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.65};
};

class RscCheckBox {
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	idc = -1;
	type = 77;
	deletable = 0;
	style = 0;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureFocusedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureHoverUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	texturePressedUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
	textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
	textureDisabledUnchecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureUnchecked_ca.paa";
};