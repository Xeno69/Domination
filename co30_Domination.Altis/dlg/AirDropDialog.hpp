class D_AirDropDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_AirDropDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;call d_fnc_initairdropdialog;d_airdrop_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_AirDropDialog', nil];d_airdrop_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE;
		COMMON_BACKGROUND_TILES;
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1228);
	};
	class controls {
		__CANCELCLOSEB(-1);
		class Drop3: RscButton {
			idc = 11004;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1230";
			action = "d_x_drop_type = (d_X_Drop_Array select 2) select 1;closeDialog 0";
			x = 0.68; y = 0.32; w = 0.3;
		};
		class Drop2: Drop3 {
			idc = 11003;
			text = "$STR_DOM_MISSIONSTRING_1231";
			action = "d_x_drop_type = (d_X_Drop_Array select 1) select 1;closeDialog 0";
			y = 0.26;
		};
		class Drop1: Drop3 {
			idc = 11002;
			text = "$STR_DOM_MISSIONSTRING_1232";
			action = "d_x_drop_type = (d_X_Drop_Array select 0) select 1;closeDialog 0";
			y = 0.20;
		};
		class Drop4: Drop3 {
			idc = 11008;
			text = "$STR_DOM_MISSIONSTRING_1232_AMMOTRUCK";
			action = "d_x_drop_type = (d_x_drop_array_custom_types select 0);closeDialog 0";
			y = 0.38;
		};
		class Drop5: Drop3 {
			idc = 11020;
			text = "$STR_DOM_MISSIONSTRING_1232_APC";
			action = "d_x_drop_type = (d_x_drop_array_custom_types select 1);closeDialog 0";
			y = 0.44;
		};
		class Drop6: Drop3 {
			idc = 11021;
			text = "$STR_DOM_MISSIONSTRING_1232_MRAP";
			action = "d_x_drop_type = (d_x_drop_array_custom_types select 2);closeDialog 0";
			y = 0.50;
		};
		class Drop7: Drop3 {
			idc = 11022;
			text = "$STR_DOM_MISSIONSTRING_1232_TANK";
			action = "d_x_drop_type = (d_x_drop_array_custom_types select 3);closeDialog 0";
			y = 0.56;
		};
		class DropMapText: RscText {
			x = 0.02; y = 0.02;
			w = 0.5; h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1234";
		};
		class DropText: DropMapText {
			x = 0.68;
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.03;
			text = "$STR_DOM_MISSIONSTRING_1233";
		};
		class Map: D_RscMapControl {
			idc = 11111;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.02; y = 0.115;
			w = 0.61; h = 0.8;
			showCountourInterval = false;
			onMouseButtonClick = "if (ctrlShown ((uiNamespace getVariable 'D_AirDropDialog') displayCtrl 11111)) then {_pp = (_this select 0) ctrlMapScreenToWorld [_this select 2, _this select 3];'d_drop_zone' setMarkerPosLocal _pp}";
		};
	};
};
