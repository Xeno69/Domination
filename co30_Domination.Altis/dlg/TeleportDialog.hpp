class d_TeleportDialog {
	idd = -1;
	movingEnable = false;
	onLoad="uiNamespace setVariable ['d_TeleportDialog', _this select 0];d_teleport_dialog_open = true;d_teleport_off = false;[_this select 0, 0] call d_fnc_teleportdialoginit";
	onUnLoad="uiNamespace setVariable ['d_TeleportDialog', nil];d_x_loop_end = true;d_teleport_dialog_open = false;d_teleport_off = nil;";
	class controlsBackground {
		class bg1: RscBG {
			x = SafeZoneXAbs;
			y = SafeZoneY;
			w = SafeZoneWAbs;
			h = SafeZoneH;
			idc = 100101;
			colorBackground[] = {0, 0, 0, 0.98};
		};
		class Map: D_RscMapControl {
			idc = 900;
			x = "13.1 *(((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW -((safezoneW / safezoneH) min 1.2))/2)";
			y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "25.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "18.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorGrid[] = {0,0,0,0};
			colorGridMap[] = {0,0,0,0};
		};
	};
	class controls {
		class Title: RscText {
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			idc = 100111;
			text = "$STR_DOM_MISSIONSTRING_1254";
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "38 * (	((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ListBackground: RscText {
			colorBackground[] = {0,0,0,0.7};
			idc = 1001;
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "21.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class List: RscListBox {
			idc = 1500;
			x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "21.0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			onLBSelChanged = "[_this, 0] call d_fnc_update_telerespsel";
		};
		class respawn: RscButton {
			idc = 100102;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1250"; 
			action = "[0] call d_fnc_beam_tele";
			x = "27 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "23.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			default = true;
		};
		class cancelb: respawn {
			idc = 100103;
			text = "$STR_DOM_MISSIONSTRING_1229"; 
			action = "CloseDialog 0";
			x = "1 *(((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "23.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "12 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			default = false;
		};
		
		class LogTxt: RscText {
			idc = 11002;
			style = ST_MULTI;
			sizeEx = 0.028;
			lineSpacing = 1;
			colorBackground[] = {0,0,0,0};
			x = "13.1 *(((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW -((safezoneW / safezoneH) min 1.2))/2)";
			y = "20.05 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "25.9 * (((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2.95 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "";
			shadow = 0;
		};
		class Tdestination: RscText {
			idc = 100110;
			x = "14 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
			y = "23.2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = 0.3;
			h = 0.032;
			sizeEx = 0.032;
			text = "";
			colorText[] = {1,1,0,1};
		};
		class dtext: Tdestination {
			x = "SafeZoneX + SafeZoneW - 0.2";
			y = "SafeZoneY + SafeZoneH - 0.09";
			h = 0.1;
			sizeEx = 0.03921;
			colorText[] = {1, 1, 1, 1};
			text = __DOM_NVER_STR__;
		};
		class Helptext: Tdestination {
			idc = 11003;
			x = 0.31;
			y = 0.082;
			w = 0.7;
			h = 0.032;
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1990";
			shadow = 1;
			colorText[] = {1,1,1,1};
		};
		class Helptext2: Helptext {
			idc = 11004;
			y = 0.76;
			text = "$STR_DOM_MISSIONSTRING_1991";
		};
	};
};
