class D_AirTaxiDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_AirTaxiDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;d_airdtaxi_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_AirTaxiDialog', nil];d_airdtaxi_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_535)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class CallCasButton: RscButton {
			idc = 11004;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1884";
			action = "d_x_do_call_taxi = true;closeDialog 0";
			x = 0.68; y = 0.32; w = 0.3;
		};
		class AirTaxiMapText: RscText2 {
			x = 0.02; y = 0.02;
			w = 0.5; h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1883";
		};
		class Map: D_RscMapControl {
			idc = 11111;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.02; y = 0.115;
			w = 0.61; h = 0.8;
			showCountourInterval = false;
			onMouseButtonClick = "if (ctrlShown ((uiNamespace getVariable 'D_AirTaxiDialog') displayCtrl 11111)) then {_pp = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];d_x_airtaximarker setMarkerPosLocal _pp}";
		};
	};
};
