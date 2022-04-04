class D_MarkArtilleryDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_MarkArtilleryDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;call d_fnc_initMarkArtyDlg;d_markarti_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_MarkArtilleryDialog', nil];d_markarti_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE;
		COMMON_BACKGROUND_TILES;
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1524);
	};
	class controls {
		class SalvosText: RscText {
			idc = 11009;
			x = 0.68; y = 0.425;
			w = 0.3; h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.03;
			text = "$STR_DOM_MISSIONSTRING_1243";
		};
		class FireSeriesCombo:RscUIComboBox {
			idc = 889;
			x = 0.685; y = 0.5;
			w = 0.288; h = 0.035;
			sizeEx = 0.032;
		};		
		class ArtyTypeCombo:FireSeriesCombo {
			idc = 888;
			y = 0.185;
			onLBSelChanged = "[_this] call d_fnc_artytypeselchanged2";
		};
		class ETA_text: SalvosText {
			idc = 900;
			text = "$STR_DOM_MISSIONSTRING_1458";
			x = 0.68; y = 0.6;
		};
		class ArtyRequestButton: RscButton {
			idc = 890;
			style = 2;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1244b";
			action = "call d_fnc_firearty2;closeDialog 0";
			x = 0.68; y = 0.7; w = 0.3;
		};
		class Ordnance: RscText {
			x = 0.68; y = 0.11;
			w = 0.3; h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.03;
			text = "$STR_DOM_MISSIONSTRING_1245";
		};
		class Map: D_RscMapControl {
			idc = 11111;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.03; y = 0.07;
			w = 0.62; h = 0.85;
			showCountourInterval = false;
		};
		__CANCELCLOSEB(-1);
	};
};
