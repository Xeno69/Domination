class D_ParajumpDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "[_this select 0] call bis_fnc_guiEffectTiles;d_parajump_dialog_open = true";
	onUnLoad = "d_parajump_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BGN($STR_DOM_MISSIONSTRING_1266)
	};
	class controls {
		__CANCELCLOSEB3(-1)
		class Map: D_RscMapControl {
			idc = -1;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.12 * safezoneH + safezoneY";
			w = "0.96 * safezoneW";
			h = "0.78 * safezoneH";
			showCountourInterval = false;
			onMouseButtonClick = "_pp = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];if ([_pp, _this select 0] call d_fnc_checkpjumppos) then {d_global_jump_pos = _pp;closeDialog 0;};";
		};
		class ParaMapText: RscText2 {
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.07 * safezoneH + safezoneY";
			w = 0.7;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1267";
		};
		class ParaMapText2: ParaMapText {
			y = "0.89 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1269";
		};
		class ParaMapText3: ParaMapText {
			y = "0.911 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1271";
		};
		class ParaMapText4: ParaMapText2 {
			idc = 1000;
			x = "0.48 * safezoneW + safezoneX";
			text = "";
		};
	};
};
