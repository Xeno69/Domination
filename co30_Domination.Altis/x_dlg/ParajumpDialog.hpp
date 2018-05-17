class D_ParajumpDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "[_this select 0] call bis_fnc_guiEffectTiles;d_parajump_dialog_open = true";
	onUnLoad = "d_parajump_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1266)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class Map: D_RscMapControl {
			idc = -1;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.06;
			y = 0.14;
			w = 0.885;
			h = 0.7;
			showCountourInterval = false;
			onMouseButtonClick = "closeDialog 0;_pp = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];d_global_jump_pos = _pp";
		};
		class ParaMapText: RscText2 {
			x = 0.06;
			y = 0.05;
			w = 0.7;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1267";
		};
		class ArtiMapText2: ParaMapText {
			y = 0.83;
			text = "$STR_DOM_MISSIONSTRING_1269";
		};
		class ArtiMapText3: ParaMapText {
			y = 0.86;
			text = "$STR_DOM_MISSIONSTRING_1271";
		};
	};
};
