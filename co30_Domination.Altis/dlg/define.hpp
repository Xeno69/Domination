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

#define __DOM_NVER_STR__ "Domination! 4"

import ScrollBar;
import RscText;
import RscFrame;
import RscButton;
import RscListBox;
import RscPicture;
import RscVignette;
import RscPictureKeepAspect;
import RscShortcutButton;
import RscCombo;
import RscXSliderH;
import RscControlsGroup;
import RscControlsGroupNoScrollbars;
import RscStructuredText;
import RscXListBox;
import RscProgress;
import RscListNBox;
import RscIGUIListNBox;
import RscEdit;
import RscCheckBox;
import RscMapControl;

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

class RscNavButton:RscButton {
	w = 0.1; h = 0.04;
	x = 0.90;
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
class D_RscMapControl: RscMapControl {
	idc = -1;
	onDraw = "[_this, 2] call d_fnc_mapondraw";
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

#define __DDIALOG_BG(loc_str) \
	class BackGroundCaption: RscText { \
		x = 0; y = 0; \
		w = 1; h = 1 / 25; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText { \
		x = 0.02; y = 0; \
		w = 0.4; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText { \
		colorBackground[] = {0, 0, 0, 0.7}; \
		x = 0; \
		y = (1 / 25) + 0.005; \
		w = 1; \
		h = 1 - (2 / 25) - 0.01; \
	}; \
	class DomVer: RscText { \
		x = 0.02; y = 1 - 0.04; \
		w = 0.25; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = __DOM_NVER_STR__; \
	};

#define __DDIALOG_BGN(loc_str) \
	class BackGroundCaption: RscText { \
		x = "0.0124502 * safezoneW + safezoneX"; y = "0.02 * safezoneH + safezoneY"; \
		w = "0.965724 * safezoneW"; h = "0.04 * safezoneH"; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText { \
		x = "0.0405779 * safezoneW + safezoneX"; y = "0.02 * safezoneH + safezoneY"; \
		w = "0.543806 * safezoneW"; h = "0.04 * safezoneH"; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText { \
		colorBackground[] = {0, 0, 0, 0.7}; \
		x = "0.0124502 * safezoneW + safezoneX"; \
		y = "0.07 * safezoneH + safezoneY"; \
		w = "0.9751 * safezoneW"; \
		h = "0.89 * safezoneH"; \
	}; \
	class DomVer: RscText { \
		x = "0.0780818 * safezoneW + safezoneX"; y = "0.96 * safezoneH + safezoneY"; \
		w = "0.346911 * safezoneW"; h = "0.04 * safezoneH"; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = __DOM_NVER_STR__; \
	};
	
#define __DDIALOG_BG2(loc_str) \
	class BackGroundCaption: RscText { \
		x = safezoneX; y = safezoneY; \
		w = safezoneW; h = 1 / 25; \
		colorBackground[] = __GUI_BCG_RGB; \
	}; \
	class MainCaption: RscText { \
		x = safezoneX + 0.02; y = safezoneY; \
		w = 0.4; h = 0.04; \
		sizeEx = 0.04; \
		colorBackground[] = {1, 1, 1, 0}; \
		colorText[] = {1, 1, 1, 1}; \
		text = #loc_str; \
	}; \
	class BackGroundMain: RscText { \
		colorBackground[] = {0, 0, 0, 0.9}; \
		x = safezoneX; \
		y = safeZoneY + (1 / 25); \
		w = safezoneW; \
		h = safezoneH - 0.01; \
	}; \
	class DomVer: RscText { \
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

class d_RscStructuredText: RscStructuredText {
	colorText[] = {0.8784,0.8471,0.651,1};
	class Attributes {
		font = DEFAULTFONT;
		color = "#e0d8a6";
		align = "center";
		shadow = 1;
	};
	text = "";
	size = 0.03921;
	shadow = 2;
};
