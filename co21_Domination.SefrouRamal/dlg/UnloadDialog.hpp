class D_UnloadDialog {
	idd = -1;
	movingEnable = 1;
	onLoad="uiNamespace setVariable ['D_UnloadDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;d_unload_dialog_open = true;call d_fnc_fillunload";
	onUnLoad="uiNamespace setVariable ['D_UnloadDialog', nil];d_unload_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1319)
	};
	class controls {
		class SelectButton: RscButton {
			idc = -1;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1320"; 
			action = "call d_fnc_unloadsetcargo";
			x = 0.36;
			y = 0.80;
			w = 0.3;
		};
		__CANCELCLOSEB(-1)
		class Unloadlistbox: RscListBox {
			idc = 101115;
			x = 0.3;
			y = 0.2;
			w = 0.4;
			h = 0.5;
			sizeEx = 0.037;
			rowHeight = 0.06;
			style = ST_LEFT;
		};
		class UnloadCaption: RscText {
			x = 0.37;
			y = 0.08;
			w = 0.4;
			h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1321";
		};
	};
};
