class D_PylonLoadoutDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_PylonLoadoutDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;_this call d_fnc_initpylonloadoutdialog;d_pylonloadout_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_PylonLoadoutDialog', nil]; d_pylondialog_ctrls = nil;d_pylonloadout_dialog_open = false; if (unitIsUAV d_pylon_vec) then {d_pylon_vec setVariable ['d_pylon_blocked', nil, true]}";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1857)
		class AircraftPicture: D_RscPicture {
			idc = 1000;
			x = 0.15;
			y = 0.15;
			w = 0.65;
			h = 0.65;
			colorText[] = {1,1,1,1};
			text = "";
			sizeEx = 256;
		};
	};
	class controls {
		__CANCELCLOSEB(-1)
		class PresetCaption: RscText {
			x = 0.05; y = 0.035;
			w = 0.2; h = 0.1;
			sizeEx = 0.036;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_1860";
		};
		class Presets: RscUIComboBox {
			idc = 1001;
			x = 0.05;
			y = 0.11;
			w = 0.2;
			h = 0.032;
			sizeEx = 0.032;
			onLBSelChanged = "_this call d_fnc_pylonloadoutpresetschanged";
		};
		class MirrorCheckbox: RscCheckBox {
			idc = 1002;
			x = 0.8;
			y = 0.11;
			w = 0.04;
			h = 0.04;
			onCheckedChanged = "_this call d_fnc_pylonloadoutdialogcbselchanged";
		};
		class MirrorCaption: RscText {
			x = 0.84; y = 0.08;
			w = 0.2; h = 0.1;
			sizeEx = 0.036;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_1859";
		};
		class ApplyButton: RscButton {
			idc = -1;
			style = 2;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1858"; 
			action = "call d_fnc_pylonapply;closeDialog 0";
			x = 0.77; y = 0.87; w = 0.2;
		};
	};
};
