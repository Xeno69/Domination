class D_DomLabel {
	idd=-1;
	movingEnable=0;
	duration=9.1;
	fadeout = 1;
	name="D_DomLabel";
	sizeEx = 256;
	onLoad = "uiNamespace setVariable ['D_DomLabel', _this select 0]";
	class controls {
		class DPicture: D_RscPicture {
			idc = 50;
			x=0.23; y=0.4; w=0.6; h=0.7;
			text="pics\domination.paa";
			sizeEx = 256;
			colorText[] = {1, 1, 1, 1};
		};
	};
};
class d_DomThree {
	idd=-1;
	movingEnable=0;
	duration=9.5;
	fadeout = 1;
	name="d_DomThree";
	sizeEx = 256;
	onLoad = "uiNamespace setVariable ['d_DomThree', _this select 0]";
	class controls {
		class Picture: D_RscPicture {
			idc=50;
			x=2; y=0.35; w=0.15; h=0.15;
			text="pics\dthree.paa";
			sizeEx = 256;
		};
	};
};
class d_Xlabel {
	idd=-1;
	movingEnable=0;
	fadein = 2;
	fadeout = 2;
	duration=14;
	name="d_Xlabel";
	sizeEx = 256;
	class controls {
		class Picture: D_RscPicture {
			x = "SafeZoneX + SafeZoneW - 0.153";
			y = "SafeZoneY + SafeZoneH - 0.15";
			w = 0.16; h = 0.16;
			text="pics\Xlabel.paa";
			sizeEx = 256;
		};
	};
};
class d_Lightning1 {
	idd = -1;
	movingEnable = 0;
	duration = 0.6;
	fadein = 0.2;
	fadeout = 1.3;
	name = "d_Lightning1";
	class controls {
		class Lightning_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = DEFAULTFONT;
			sizeEx = 0.023;
			x = 0.6;y = 0.3;w = 0.3;h = 0.3;
			text = "a3\data_f\blesk_b_ca.paa";
		};
	};
};
class d_Eyeflare {
	idd = -1;
	movingEnable = 0;
	duration = 0.4;
	fadein = 0.1;
	fadeout = 1.1;
	name = "d_Eyeflare";
	class controls {
		class Eyeflare_BG {
			idc=-1;
			type = 0;
			style = 48;
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 0.8};
			font = DEFAULTFONT;
			sizeEx = 0.023;
			x = 0.74;y = 0.3;w = 0.15;h = 0.15;
			text = "a3\data_f\eyeflare_ca.paa";
		};
	};
};
class d_ArmaLogo {
	idd=-1;
	movingEnable=0;
	duration=9;
	name="d_ArmaLogo";
	fadein = 1;
	fadeout = 1;
	sizeEx = 256;
	class controls {
		class Picture: D_RscPicture {
			idc = 50;
			x=0.3;y=0.07;w=0.4;h=0.38;
			text= "\A3\ui_f\data\Logos\arma3_expansion_ca.paa";
			sizeEx = 48;
		};
	};
};
class d_vec_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 1;
	duration = 1e+011;
	name="d_vec_hud";
	onLoad = "uiNamespace setVariable ['d_vec_hud', _this select 0]";
	onUnLoad = "uiNamespace setVariable ['d_vec_hud', nil]";
	class controls {
		class vehicle_hud_name {
			type = 0;
			idc = 64432;
			style = 0;
			x = "SafeZoneX + SafeZoneW - 0.163";
			y = "SafeZoneY + SafeZoneH - 0.3";
			w = 0.2;h = 0.2;
			font = DEFAULTFONT;
			sizeEx = 0.028;
			colorBackground[]={0,0,0,0};
			colorText[] = {1.0, 1.0, 1.0, 0.9};
			text = "";
			shadow = 2;
		};
		class vehicle_hud_speed: vehicle_hud_name {
			idc = 64433;
			y = "SafeZoneY + SafeZoneH - 0.27";
		};
		class vehicle_hud_fuel: vehicle_hud_name {
			idc = 64434;
			y = "SafeZoneY + SafeZoneH - 0.24";
		};
		class vehicle_hud_damage: vehicle_hud_name {
			idc = 64435;
			y = "SafeZoneY + SafeZoneH - 0.21";
		};
		class vehicle_hud_direction: vehicle_hud_name {
			idc = 64436;
			y = "SafeZoneY + SafeZoneH - 0.18";
		};
	};
};
class d_chopper_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 1;
	duration = 1e+011;
	name="d_chopper_hud";
	onLoad="uiNamespace setVariable ['d_chopper_hud', _this select 0]";
	onUnLoad="uiNamespace setVariable ['d_chopper_hud', nil]";
	
	class controls {
		class Text: d_RscStructuredText {
			idc = 9999;
			style = "1 + 16";
			text = "";
			x = 0.2;
			y = 0.2;
			w = 0.6;
			h = 0.6;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0, 0, 0, 0};
			size = 0.032;
			sizeEx = 0.032;
			shadow = 2;
			class Attributes {
				font = DEFAULTFONT;
				color = "#ffffff";
				align = "center";
				shadow = 2;
			};
		};
	};
};
class d_chopper_lift_hud {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 0;
	duration = 1e+011;
	name="d_chopper_lift_hud";
	onLoad="uiNamespace setVariable ['d_chopper_lift_hud', _this select 0]";
	onUnLoad="uiNamespace setVariable ['d_chopper_lift_hud', nil]";
	class controls {
		class hud_background {
			idc = 64437;
			type = 0;
			colorText[] = {1, 1, 1, 1};
			font = DEFAULTFONT;
			colorBackground[] = {0, 0.3, 0, 0.1};
			text = "";
			style = 128;
			sizeEx = 0.015;
			x = 0.3;y = 0.4;w = 0.42;h = 0.4;
		};
		class hud_type {
			type = 0;
			idc = 64438;
			style = 0;
			x = 0.31;y = 0.76;w = 0.42;h = 0.03;
			font = DEFAULTFONT;
			sizeEx = 0.03;
			colorBackground[]={0,0,0,0};
			text = "";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class hud_icon: hud_type {
			idc = 64439;
			style = 48;
			x = 0.62;y = 0.723;w = 0.083;h = 0.07;
		};
		class hud_edge: hud_type {
			idc = 64440;
			x = 0.1;
			y = "SafeZoneY + 0.02";
			w = 0.42;
		};
		class hud_dist: hud_type {
			idc = 64441;
			x = 0.31;y = 0.405;w = 0.27;
			colorText[] = {1,1,1,1};
		};
		class hud_height: hud_type {
			idc = 64442;
			x = 0.6;y = 0.37;w = 0.2;h = 0.1;
			colorText[] = {1,1,1,1};
		};
		class hud_back: hud_type {
			idc = 64443;
			style = 48;
			x = 0.45;y = 0.6;w = 0.1;h = 0.1;
		};
		class hud_forward: hud_type {
			idc = 64444;
			style = 48;
			x = 0.45;y = 0.5;w = 0.1;h = 0.1;
		};
		class hud_left: hud_type {
			idc = 64445;
			style = 48;
			x = 0.4;y = 0.55;w = 0.1;h = 0.1;
		};
		class hud_right: hud_type {
			idc = 64446;
			style = 48;
			x = 0.5;y = 0.55;w = 0.1;h = 0.1;
		};
		class hud_middle: hud_type {
			idc = 64447;
			style = 48;
			x = 0.45;y = 0.55;w = 0.1;h = 0.1;
		};
		class hud_icon2: hud_type {
			idc = 64448;
			style = 48;
			x = 0.458;y = 0.56;w = 0.083;h = 0.07;
		};
	};
};
class d_chopper_lift_hud2 {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 0;
	duration = 1e+011;
	name="d_chopper_lift_hud2";
	onLoad="uiNamespace setVariable ['d_chopper_lift_hud2', _this select 0]";
	onUnLoad="uiNamespace setVariable ['d_chopper_lift_hud2', nil]";
	class controls {
		class hud_type {
			type = 0;
			idc = 61422;
			style = 0;
			x = 0.1;
			y = "SafeZoneY + 0.02";
			w = 0.42;h = 0.032;
			font = DEFAULTFONT;
			sizeEx = 0.032;
			colorText[] = {1,1,1,1};
			colorBackground[]={0,0,0,0};
			text = "";
			shadow = 0;
		};
	};
};
class d_ProgressBar {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "d_ProgressBar";
	onLoad = "uiNamespace setVariable ['d_ProgressBar', _this select 0]; ((_this select 0) displayCtrl 3800) progressSetPosition 0";
	onUnLoad = "uiNamespace setVariable ['d_ProgressBar', nil]";
	controlsBackground[] = {};
	class controls {
		class ProgressBarBackground: RscText2 {
			style = 128;
			idc = 3600;
			x = 0.3;
			y = "((SafeZoneH + SafeZoneY) - (1 + 0.165)) * -1";
			w = 0.4;
			h = 0.06;
			colorBackground[] = {0,0,0,0.5};
		};
		class ProgressBar: RscText2 {
			style = 128;
			idc = 3800;
			x = 0.31;
			y = "((SafeZoneH + SafeZoneY) - (1 + 0.175)) * -1";
			w = 0;
			h = 0.04;
			colorBackground[] = {0.543, 0.5742, 0.4102, 0.8};
		};
		class Progress_Label: RscText2 {
			idc = 3900;
			style = 2;
			text = "$STR_DOM_MISSIONSTRING_1272";
			x = 0.31;
			w = 0.38;
			y = "((SafeZoneH + SafeZoneY) - (1 + 0.175)) * -1";
			sizeEx = 0.035;
			colorBackground[] = {1,1,1,0};
			colorText[] = {1, 1, 1, 1};
		};
	};
};
class d_ProgressBar2 {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "d_ProgressBar2";
	onLoad = "uiNamespace setVariable ['d_ProgressBar2', _this select 0]; ((_this select 0) displayCtrl 3800) progressSetPosition 0";
	onUnLoad = "uiNamespace setVariable ['d_ProgressBar2', nil]";
	controlsBackground[] = {};
	class controls {
		class ProgressBar: RscText2 {
			style = 128;
			idc = 3800;
			x = 0.3;
			y = "SafeZoneH + SafeZoneY - 0.175";
			w = 0;
			h = 0.04;
			colorBackground[] = {0.543, 0.5742, 0.4102, 0.8};
		};
		class Progress_Label: RscText2 {
			idc = 3900;
			style = 2;
			text = "$STR_DOM_MISSIONSTRING_1939";
			x = 0.3;
			w = 0.4;
			y = "SafeZoneH + SafeZoneY - 0.175";
			sizeEx = 0.035;
			colorBackground[] = {1,1,1,0};
			colorText[] = {1, 1, 1, 0.8};
		};
	};
};
class d_ProgressBar3 {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "d_ProgressBar3";
	onLoad = "uiNamespace setVariable ['d_ProgressBar3', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['d_ProgressBar3', nil]";
	controlsBackground[] = {};
	class controls {
		class ProgressBar: RscText2 {
			style = 128;
			idc = 3800;
			x = 0.3;
			y = "SafeZoneH + SafeZoneY - 0.2";
			w = 0;
			h = 0.04;
			colorBackground[] = {0, 0, 0, 0.8};
		};
		class Progress_Label: RscText2 {
			idc = 3900;
			style = 2;
			text = "$STR_DOM_MISSIONSTRING_1954";
			x = 0.3;
			w = 0.4;
			y = "SafeZoneH + SafeZoneY - 0.2";
			sizeEx = 0.035;
			colorBackground[] = {1,1,1,0};
			colorText[] = {1, 1, 1, 0.8};
		};
	};
};

class d_showPlayerNameRsc {
	idd = -1;
	movingEnable = 1;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0.3;
	name = "d_PlayerNameRSC";
	onLoad ="uiNamespace setVariable ['d_showPlayerNameRsc', _this select 0]";
	onUnload = "uiNamespace setVariable ['d_showPlayerNameRsc', nil]";
	class controls {
		class DisplayPlayerName: d_RscStructuredText {
			idc = 1000;
			colorBackground[] = {0,0,0,0.0};
			colorText[] = { 0, 0, 0, 0 };
			font =DEFAULTFONT;
			size = 0.03;
			sizeEx = 0.012;
			x = SafeZoneX + (SafeZoneW/2) - 0.15;
			y = SafeZoneY + (SafeZoneH/2) + 0.15;
			w = 0.4;
			h = 0.15*2;
			shadow = 0;
			class Attributes {
				font = DEFAULTFONT;
				color = "#e0d8a6";
				align = "center";
				shadow = 0;
			};
		};
	};
};

class d_rscDynamicText {
	idd = -1;
	movingEnable = 1;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name = "d_rscDynamicText";
	onload = "uinamespace setvariable ['d_rscDynamicText',_this select 0];";
	onUnload = "uinamespace setvariable ['d_rscDynamicText',nil];";
	class controls {
		class Text: d_RscStructuredText {
			idc = 9999;
			style = "1 + 16";
			text = "";
			x = 0;
			y = 0.45;
			w = 1;
			h = 10000;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			size = "(0.05 / 1.17647) * safezoneH";
			sizeEx = 0.4;
			class Attributes {
				font = "RobotoCondensed";
				color = "#ffffff";
				align = "center";
				shadow = 0;
				valign = "top";
			};
		};
	};
};

class d_rscCrewText {
	idd = -1;
	movingEnable = 1;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name = "d_rscCrewText";
	onload = "uinamespace setvariable ['d_rscCrewText',_this select 0]";
	onUnload = "uinamespace setvariable ['d_rscCrewText',nil]";
	class controls {
		class Text: d_RscStructuredText {
			idc = 9999;
			style = "1 + 16";
			text = "";
			x = SafeZoneX + SafeZoneW - 0.35;
			//y = 0.7;
			y = SafeZoneY + SafeZoneH - 0.4;
			w = 0.34;
			h = 0.4;
			colorText[] = {1,1,1,1};
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
	};
};

class d_RscText {
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.8784,0.8471,0.651,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 2;
	font = DEFAULTFONT;
	SizeEx = 0.03921;
};

class d_fpsresource {
	idd=-1;
	movingEnable=0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name="d_fpsresource";
	onLoad = "uiNamespace setVariable ['d_fpsresource', _this select 0]";
	onUnLoad = "uiNamespace setVariable ['d_fpsresource', nil]";
	class controls {
		class server_cap: RscText2 {
			idc=-1;
			style="16+512";
			lineSpacing=0.95;
			text="Server FPS:";
			x = "SafeZoneX + 0.001";
			y = "SafeZoneY + SafeZoneH - 0.057";
			w=0.3;h=0.1;
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,0.45};
			size=0.026;
			sizeEx = 0.026;
		};
		class client_cap: server_cap {
			text="Client FPS:";
			y = "SafeZoneY + SafeZoneH - 0.03";
		};
		class server_out: server_cap {
			idc = 50;
			text="";
			x = "SafeZoneX + 0.1";
		};
		class client_out: client_cap {
			idc = 51;
			text="";
			x = "SafeZoneX + 0.1";
		};
	};
};

class d_cam_rose {
	idd=-1;
	movingEnable = true;
	fadein = 0;
	fadeout = 0;
	duration = 1e+011;
	name="d_cam_rose";
	onLoad = "uiNamespace setVariable ['d_cam_rose', _this select 0]";
	onUnLoad = "uiNamespace setVariable ['d_cam_rose', nil]";
	class controls {
		class CHAR_N {
			type = 0;
			idc = 64432;
			style = 0;
			x = "SafeZoneX + SafeZoneW - 0.3";
			y = "SafeZoneY + SafeZoneH - 0.5";
			w = 0.2;
			h = 0.2;
			font = DEFAULTFONT;
			sizeEx = 0.032;
			colorText[] = {1, 1, 1, 1};
			colorBackground[]={0,0,0,0};
			text = "N";
		};
		class CHAR_E: CHAR_N {
			idc = 64433;
			x = "SafeZoneX + SafeZoneW - 0.1";
			y = "SafeZoneY + SafeZoneH - 0.3";
			text = "E";
		};
		class CHAR_S: CHAR_N {
			idc = 64434;
			x = "SafeZoneX + SafeZoneW - 0.3";
			y = "SafeZoneY + SafeZoneH - 0.1";
			text = "S";
		};
		class CHAR_W: CHAR_N {
			idc = 64435;
			x = "SafeZoneX + SafeZoneW - 0.5";
			y = "SafeZoneY + SafeZoneH - 0.3";
			text = "W";
		};
	};
};

class d_sat_timode {
	idd=-1;
	movingEnable=0;
	duration = 1e+011;
	fadein = 0;
	fadeout = 0;
	name="d_sat_timode";
	onLoad = "uiNamespace setVariable ['d_sat_timode', _this select 0]";
	onUnLoad = "uiNamespace setVariable ['d_sat_timode', nil]";
	class controls {
		class ti_caption: RscText2 {
			idc=-1;
			style="16+512";
			lineSpacing=0.95;
			text="TI Mode:";
			x = "SafeZoneX + SafeZoneW - 0.2";
			y = "SafeZoneY + (SafeZoneH / 2)";
			w=0.3;
			h=0.1;
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,0.45};
			size = 0.04;
			sizeEx = 0.04;
			shadow = 2;
		};
		class ti_text: ti_caption {
			idc = 50;
			text="WHOT";
			y = "SafeZoneY + (SafeZoneH / 2) + 0.05";
		};
	};
};

class d_RscSupportL {
	idd = -1;
	movingEnable = 0;
	duration = 1e+011;
	fadeout = 1;
	name = "d_RscSupportL";
	sizeEx = 256;
	onLoad = "uiNamespace setVariable ['d_RscSupportL', _this select 0];call d_fnc_updatesupportrsc";
	onUnLoad = "uiNamespace setVariable ['d_RscSupportL', nil]";
	class controls {
		class Arty: D_RscPicture {
			idc = 50;
			x = SafeZoneX; y = 0.35; w = 0.05; h = 0.05;
			text = "\A3\ui_f\data\gui\cfg\CommunicationMenu\artillery_ca.paa";
			sizeEx = 256;
		};
		class Drop: Arty {
			idc = 51;
			y = 0.42;
			text = "\A3\ui_f\data\gui\cfg\CommunicationMenu\supplydrop_ca.paa";
		};
		class Air: Arty {
			idc = 52;
			y = 0.49;
			text = "\A3\ui_f\data\gui\cfg\CommunicationMenu\cas_ca.paa";
		};
	};
};

class d_RscPIP {
	idd = -1;
	duration = 1e+011;
	fadein = 0;
	onLoad = "uinamespace setvariable ['d_RscPIP', _this select 0];";
	onUnload = "uinamespace setvariable ['d_RscPIP', nil];";
	class controlsBackground {
		class PIP: D_RscPicture {
			IDC = 2300;
			x = "(safezoneX + safezoneW - 6.5 * (((safezoneW / safezoneH) min 1.2) / 32)) + (0.5 * 0.67 * (((safezoneW / safezoneH) min 1.2) / 32))";
			y = "(9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))) + (0.5 * 	0.67 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 20))";
			w = "(6 * (((safezoneW / safezoneH) min 1.2) / 32)) - (2 * 	0.5 * 0.67 * (((safezoneW / safezoneH) min 1.2) / 32))";
			h = "((6 * (((safezoneW / safezoneH) min 1.2) / 32))) - (2 * 0.5 * 0.67 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 20))";
		};
	};
};
