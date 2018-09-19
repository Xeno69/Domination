class xr_SpectDlg {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['XR_SpectDlg', _this select 0];if (!isNil 'xr_mouse_end') then {xr_mouse_end = nil};d_teleport_off = false;[_this select 0, 1] call d_fnc_teleportdialoginit";
	onUnload = "uiNamespace setVariable ['XR_SpectDlg', nil];d_x_loop_end = true;xr_mouse_end = true;d_teleport_off = nil;";
	class controlsBackground {
		class Caption: RscText {
			idc = 9998;
			style = 1;
			x = SafeZoneX + SafeZoneW - 0.35;
			y = SafeZoneY + 0.13;
			w = 0.34;
			h = 0.04;
			size = 0.032;
			sizeEx = 0.032;
			shadow = 0;
			colorText[] = {0, 1, 1, 1};
			colorBackground[] = {0, 0, 0, 0};
			text = "$STR_DOM_MISSIONSTRING_1725";
		};
		class Text: d_RscStructuredText {
			idc = 9999;
			style = "1 + 16";
			text = "";
			x = SafeZoneX + SafeZoneW - 0.35;
			y = SafeZoneY + 0.17;
			w = 0.34;
			h = 0.6;
			colorText[] = {0,1,1,1};
			colorBackground[] = {0, 0, 0, 0};
			size = 0.032;
			sizeEx = 0.032;
			shadow = 0;
			class Attributes {
				font = DEFAULTFONT;
				color = "#ffffff";
				align = "center";
				shadow = 0;
			};
		};
		class Help: RscText {
			x = SafeZoneX + SafeZoneW - 0.37;
			y = SafeZoneY + SafeZoneH - 0.17;
			w = 0.34;
			h = 0.04;
			size = 0.028;
			sizeEx = 0.028;
			shadow = 0;
			colorText[] = {1, 1, 1, 0.6};
			text = "$STR_DOM_MISSIONSTRING_1728";
		};
		class Help2: Help {
			y = SafeZoneY + SafeZoneH - 0.14;
			text = "$STR_DOM_MISSIONSTRING_1729";
		};
		class MouseMovement: xr_mouseHandler {
			idc = 1212;
		};
	};
	class controls {
		class BorderTop {
			idc = -1;
			x = SafeZoneXAbs; y = SafeZoneY;
			w = SafeZoneWAbs; h = 0.1;
			type = CT_STATIC;
			style = ST_CENTER;
			font = "RobotoCondensed";
			sizeEx = 0.04;
			colorText[] = { 1, 1, 1, 1 };
			colorBackground[] = {0,0,0,1};
			text = "";
		};
		class BorderBot: BorderTop {
			y = SafeZoneY + SafeZoneH - 0.1;
		};
		class FollowingCaption: RscText {
			idc = -1;
			x = "SafeZoneX + 0.05";
			y = "SafeZoneY + 0.022";
			w = 0.5;
			h = 0.04;
			sizeEx = 0.042;
			shadow = 0;
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1330";
		};
		class FollowingText: FollowingCaption {
			idc = 1010;
			x = "SafeZoneX + 0.18";
			text = "";
		};
		class SpectatingCaption: FollowingCaption {
			idc = -1;
			x = "SafeZoneX + (SafeZoneW / 2) - 0.05";
			y = "SafeZoneY + 0.02";
			colorText[] = {1, 0, 0, 1};
			text = "$STR_DOM_MISSIONSTRING_1331";
		};
		class TimerTextCap: FollowingCaption {
			idc = 1020;
			x = 0.3;
			y = "SafeZoneY + SafeZoneH - 0.062";
			w = 0.1;
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1011";
		};
		class TimerText: TimerTextCap {
			idc = 1005;
			x = 0.393;
			text = "";
		};
		class RespawnTextCap: TimerTextCap {
			idc = 1021;
			x = 0.6;
			w = 0.25;
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1332";
		};
		class RespawnText: RespawnTextCap {
			idc = 1006;
			x = 0.78;
			text = "$STR_DOM_MISSIONSTRING_1007";
		};
		class NoRespawnTextCap: RespawnTextCap {
			idc = 1022;
			y = "SafeZoneY + SafeZoneH - 0.17";
			w = 0.3;
			h = 0.1;
			text = "";
		};
		class LeftPanel: RscListBox {
			idc = 1000;
			x = 0;
			y = 0;
			w = 1;
			h = 1;
			sizeEx = 0.04;
			text = "";
			colorText[] = {1,1,1,1};
			colorSelect[] = {1,1,1,0.9};
			onLBSelChanged = "_this call xr_fnc_targetsslbchange";
		};
		class MapButton: RscButton {
			idc = 1002;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1333"; 
			action = "if (ctrlShown ((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1000)) then {ctrlShow [1000, false];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1003) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1334');};if (ctrlShown ((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 3000)) then {ctrlShow [3000, false];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1002) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1333');d_x_loop_end = true;} else {ctrlShow [3000, true];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1002) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1333a'); call xr_fnc_updaterlb}";
			x = "SafeZoneX + SafeZoneW - 0.33";
			y = "SafeZoneY + SafeZoneH - 0.063";
			w = 0.3;
		};
		class ShowPlayersButton: MapButton {
			idc = 1003;
			text = "$STR_DOM_MISSIONSTRING_1334"; 
			action = "if (ctrlShown ((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 3000)) then {ctrlShow [3000, false];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1002) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1333');};if (ctrlShown ((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1000)) then {ctrlShow [1000, false];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1003) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1334')} else {ctrlShow [1000, true];((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1003) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1334a')}";
			x = "SafeZoneX + 0.03";
		};
		class NVGButton: MapButton {
			idc = 1004;
			text = "$STR_DOM_MISSIONSTRING_1335"; 
			action = "if (!xr_camnvgon) then {camUseNVG true; xr_camnvgon = true;((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1004) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1335a')} else {camUseNVG false; xr_camnvgon = false;((uiNamespace getVariable 'XR_SpectDlg') displayCtrl 1004) ctrlSetText (localize 'STR_DOM_MISSIONSTRING_1335')}";
			x = "SafeZoneX + 0.35";
		};
		
		class RCGroup: RscControlsGroupNoScrollbars {
			idc = 3000;
			x = 0;
			y = 0;
			w = 1.1;
			h = 1.1;
			class controls {
				class Map: D_RscMapControl {
					idc = 900;
					x = 0.30;
					y = 0.044;
					w = 0.7;
					h = 0.8;
					colorGrid[] = {0,0,0,0};
					colorGridMap[] = {0,0,0,0};
				};
				class Title: RscText {
					colorBackground[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.69])","(profileNamespace getVariable ['GUI_BCG_RGB_G',0.75])","(profileNamespace getVariable ['GUI_BCG_RGB_B',0.5])","(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"};
					idc = 100111;
					text = "$STR_DOM_MISSIONSTRING_299";
					x = 0;
					y = 0;
					w = 1;
					h = 0.04;
				};
				class PPosButton: RscLinkButtonBase {
					idc = -1;
					x = 1 - 0.31;
					y = 0;
					w = 0.3;
					h = 0.038;
					text = "$STR_DOM_MISSIONSTRING_1532"; 
					action = "call xr_fnc_showppos";
					SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};
				class List: RscListBox {
					idc = 1500;
					x = 0;
					y = 0.044;
					w = 0.3;
					h = 0.91;
					sizeEx = "2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					onLBSelChanged = "[_this, 1] call d_fnc_update_telerespsel";
				};
				class respawn: RscButton {
					idc = 100102;
					colorBackgroundActive[] = {1,1,1,0.1};
					text = "$STR_DOM_MISSIONSTRING_298"; 
					action = "call xr_fnc_closeSpectControls;0 spawn xr_fnc_buttonclickrespawn";
					x = 1 - 0.3;
					y = 1 - 0.045;
					w = 0.3;
					h = 0.04;
					default = true;
				};
				class LogTxt: RscText2 {
					idc = 11002;
					style = ST_MULTI;
					sizeEx = 0.028;
					lineSpacing = 1;
					colorBackground[] = {0,0,0,0.3};
					x = 0.30;
					y = 0.845;
					w = 0.7;
					h = 0.108;
					text = "";
					shadow = 0;
				};
				class Tdestination: RscText {
					idc = 100110;
					x = 0.01;
					y = 1 - 0.044;
					w = 0.4;
					h = 0.032;
					sizeEx = 0.032;
					text = "";
					colorText[] = {1,1,0,1};
				};
			};
		};
	};
};
