class D_StatusDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['D_StatusDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;(_this select 0) call d_fnc_statusdialoginit;d_showstatus_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_StatusDialog', nil];d_showstatus_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE;
		COMMON_BACKGROUND_TILES;
		__DDIALOG_BGN($STR_DOM_MISSIONSTRING_1318);
	};
	class controls {
		class TeamStatusButton: RscButton {
			idc = 11009;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1301";
			action = "closeDialog 0;uiNamespace setVariable ['d_dyxn_gr_disp', findDisplay 46 createDisplay 'd_RscDisplayDynamicGroups'];0 spawn d_fnc_grouplead";
			x = "0.71 * safezoneW + safezoneX";
			y = "0.61 * safezoneH + safezoneY";
			//w = "0.3 * safezoneW";
			w = 0.3;
		};
		class AdminButton: TeamStatusButton {
			idc = 123123;
			text = "$STR_DOM_MISSIONSTRING_1305";
			action = "closeDialog 0;call d_fnc_admindialog";
			y = "0.655 * safezoneH + safezoneY";
		};
		class SaveDBButton: TeamStatusButton {
			idc = 123124;
			text = "$STR_DOM_MISSIONSTRING_1754";
			action = "closeDialog 0;createDialog 'D_DBSaveDialog'";
			y = "0.7* safezoneH + safezoneY";
		};
		class DBTop10Button: TeamStatusButton {
			idc = 123125;
			text = "$STR_DOM_MISSIONSTRING_1757";
			action = "closeDialog 0;createDialog 'D_DBTop10Dialog'";
			y = "0.745 * safezoneH + safezoneY";
		};
		__CANCELCLOSEB3(-1);
		// top left title
		class ShowSideButton: RscLinkButtonBase {
			idc = 123126;
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.07 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.050;
			style = ST_LEFT;
			text = "$STR_DOM_MISSIONSTRING_1306"; // Side Mission:
			action = "[0] call d_fnc_showsidemain_d";
			shadow = 0;
		};
		// top right
		class ShowMainButton: RscLinkButtonBase {
			x = "0.71 * safezoneW + safezoneX";
			y = "0.09 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			style = ST_LEFT;
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1307"; // Main Target:
			action = "[1] call d_fnc_showsidemain_d";
			shadow = 0;
		};
		// top left box
		class SideMissionTxt: RscText {
			idc = 11002;
			style = ST_MULTI;
			sizeEx = 0.035;
			lineSpacing = 1;
			colorBackground[] = __GUI_BCG_RGB;
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.11 * safezoneH + safezoneY";
			w = "0.28 * safezoneW";
			h = "0.125 * safezoneH";
			text = "";
			shadow = 0;
		};
		// middle left (upper) title
		class SecondaryCaption: RscText {
			idc = 11090;
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.235 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.050;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1308"; // Secondary Main Target Mission:
			shadow = 0;
		};
		// middle left (upper) box
		class SecondaryTxt: SideMissionTxt {
			idc = 11007;
			y = "0.275 * safezoneH + safezoneY";
			w = "0.28 * safezoneW";
			h = "0.173 * safezoneH";
			sizeEx = 0.035;
		};
		// middle left (lower) title
		class IntelCaption: SecondaryCaption {
			idc = 11019;
			y = "0.45 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1309";
			sizeEx = 0.050;
		};
		// middle left (lower) box
		class IntelTxt: SideMissionTxt {
			idc = 11018;
			y = "0.49 * safezoneH + safezoneY";
			h = "0.09 * safezoneH";
			sizeEx = 0.035;
		};
		class MainTargetNumber: RscText {
			idc = 11006;
			x = "0.81 * safezoneW + safezoneX";
			y = "0.09 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.032;
			colorText[] = __GUI_TXT_RGB;
			colorBackground[] = {1, 1, 1, 0};
			text = "";
			shadow = 0;
		};
		class MainTarget: RscText {
			idc = 11003;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.15 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.032;
			colorText[] = __GUI_TXT_RGB;
			colorBackground[] = {1, 1, 1, 0};
			text = "";
			shadow = 0;
		};
#ifdef __TT__
		class TTNPointsCaption : RscText {
			x = "0.71 * safezoneW + safezoneX";
			y = "0.2 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.01 * safezoneH";
			sizeEx = 0.025;
			colorText[] = __GUI_TXT_RGB;
			colorBackground[] = {1, 1, 1, 0};
			text = "$STR_DOM_MISSIONSTRING_1311";
			shadow = 0;
		};
		class TTGamePoints : RscText {
			idc = 11011;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.23 * safezoneH + safezoneY";
			w = "0.27 * safezoneW";
			h = "0.01 * safezoneH";
			sizeEx = 0.025;
			colorText[] = __GUI_TXT_RGB;
			colorBackground[] = {1, 1, 1, 0};
			text = "";
			shadow = 0;
		};
		class TTKillsCaption : TTNPointsCaption {
			y = "0.27 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1312";
		};
		class TTKillPoints : TTGamePoints {
			idc = 11012;
			y = "0.3 * safezoneH + safezoneY";
			text = "";
		};
#endif
		// bottom left box (map display with no caption)
		class Map: D_RscMapControl {
			idc = 11010;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.6 * safezoneH + safezoneY";
			w = "0.28 * safezoneW";
			h = "0.33 * safezoneH";
			showCountourInterval = false;
		};
		class ServerInfoCaption: SecondaryCaption {
			y = "0.926 * safezoneH + safezoneY";
			w = "0.45 * safezoneW";
			text = "$STR_DOM_MISSIONSTRING_1583a";
		};
		class ServerInfoText: ServerInfoCaption {
			idc = 12016;
			x = "0.11 * safezoneW + safezoneX";
			text = "";
		};
		class HintCaption: RscText {
			idc = -1;
			x = "0.4 * safezoneW + safezoneX";
			y = "0.02 * safezoneH + safezoneY";
			w = "0.5 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.03;
			shadow = 1;
			style = ST_RIGHT;
			colorBackground[] = {0, 0, 0, 0};
			text = "$STR_DOM_MISSIONSTRING_1313";
		};
		class RankCaption: RscText {
			idc = 12009;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.34 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1314";
			shadow = 0;
		};
		class RankPicture: D_RscPicture {
			idc = 12010;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.415 * safezoneH + safezoneY";
			w = "0.02 * safezoneH";
			h = "0.02 * safezoneH";
			text="";
			sizeEx = 256;
			colorText[] = {1, 1, 1, 1};
		};
		class RankString: RscText {
			idc = 11014;
			x = "0.75 * safezoneW + safezoneX";
			y = "0.378 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = __GUI_TXT_RGB;
			sizeEx = 0.032;
			text = "";
			shadow = 0;
		};
		class ScoreCaption: RankCaption {
			y = "0.42 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1315";
		};
		class ScoreP: RscText {
			idc = 11233;
			x = "0.85 * safezoneW + safezoneX";
			y = "0.42 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = __GUI_TXT_RGB;
			sizeEx = 0.032;
			text = "0";
			shadow = 0;
		};
		class CampsCaption: RscText {
			x = "0.71 * safezoneW + safezoneX";
			y = "0.465 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1316";
			shadow = 0;
		};
		class CampsNumber: RscText {
			idc = 11278;
			x = "0.85 * safezoneW + safezoneX";
			y = "0.465 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = __GUI_TXT_RGB;
			sizeEx = 0.032;
			text = "";
			shadow = 0;
		};
#ifdef __TT__
		class BarracksCaption: RscText {
			x = "0.71 * safezoneW + safezoneX";
			y = "0.482 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1959";
			shadow = 0;
		};
		class BarrackNumber: RscText {
			idc = 11279;
			x = "0.85 * safezoneW + safezoneX";
			y = "0.482 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = __GUI_TXT_RGB;
			sizeEx = 0.032;
			text = "";
			shadow = 0;
		};
#endif
		class RLivesCaption: RscText {
			idc = 30000;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.51 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1317";
			shadow = 0;
		};
		class RLivesNumber: RscText {
			idc = 30001;
			x = "0.85 * safezoneW + safezoneX";
			y = "0.51 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = __GUI_TXT_RGB;
			sizeEx = 0.032;
			text = "0";
			shadow = 0;
		};
		class SettingsCaption: RscText {
			idc = -1;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.07 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.031;
			style = ST_LEFT;
			text = "$STR_DOM_MISSIONSTRING_1302";
		};
		class ViewDistanceCaption: RscText {
			idc = 1999;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.1 * safezoneH + safezoneY";
			w = "0.15 * safezoneW";
			h = "0.03 * safezoneH";
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_358";
		};
		class VD_Slider: RscXSliderH {
			idc = 1000;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.13 * safezoneH + safezoneY";
			w = "0.2 * safezoneW";
			h = "0.02 * safezoneH";
			onSliderPosChanged = "_this call d_fnc_vdsliderchanged";
		};
		
		class ViewDistanceVecCaption: ViewDistanceCaption {
			idc = 3333;
			y = "0.15 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_358V";
		};
		class VDVec_Slider: VD_Slider {
			idc = 3500;
			y = "0.18 * safezoneH + safezoneY";
			onSliderPosChanged = "_this call d_fnc_vdvecsliderchanged";
		};
		class ViewDistanceAirCaption: ViewDistanceCaption {
			idc = 3334;
			y = "0.20 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_358A";
		};
		class VDAir_Slider: VD_Slider {
			idc = 3501;
			y = "0.23 * safezoneH + safezoneY";
			onSliderPosChanged = "_this call d_fnc_vdairsliderchanged";
		};
		class VDCombiCaption: ViewDistanceCaption {
			idc = 1612;
			y = "0.254 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_2095";
		};
		class VDCombiCheckBox: RscCheckBox {
			idc = 1613;
			x = "0.5 * safezoneW + safezoneX";
			y = "0.258 * safezoneH + safezoneY";
			w = "0.02 * safezoneW";
			h = "0.025 * safezoneH";
		};
#ifndef __TT__
		class AutoVDCaption: ViewDistanceCaption {
			idc = 1609;
			y = "0.285 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1964";
		};
		class AutoVDCheckBox: RscCheckBox {
			idc = 1610;
			x = "0.5 * safezoneW + safezoneX";
			y = "0.289 * safezoneH + safezoneY";
			w = "0.02 * safezoneW";
			h = "0.025 * safezoneH";
		};
#endif
		class GraslayerCaption: ViewDistanceCaption {
			idc = 1998;
			y = "0.31 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1287";
		};
		class GraslayerCombo: RscUIComboBox {
			idc = 1001;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.34 * safezoneH + safezoneY";
			w = "0.2 * safezoneW";
			h = "0.02 * safezoneH";
			sizeEx = 0.028;
			onLBSelChanged = "[_this] call d_fnc_glselchanged";
		};
		class PlayermarkerCaption: ViewDistanceCaption {
			idc = 1501;
			y = "0.37 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1289";
		};
		class PlayermarkerCombo: GraslayerCombo {
			idc = 1002;
			y = "0.40 * safezoneH + safezoneY";
			onLBSelChanged = "[_this] call d_fnc_pmselchanged"; 
		};
		class PlayernamesCaption: ViewDistanceCaption {
			idc = 1601;
			y = "0.43 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1291";
		};
		class PlayernamesCombo: PlayermarkerCombo {
			idc = 1602;
			y = "0.46 * safezoneH + safezoneY";
			onLBSelChanged = "[_this] call d_fnc_pnselchanged"; 
		};
		class EarplugsUserCaption: ViewDistanceCaption {
			idc = 3301;
			y = "0.49 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_2012";
		};
		class EarplugsUserCombo: PlayermarkerCombo {
			idc = 3302;
			y = "0.52 * safezoneH + safezoneY";
			onLBSelChanged = "[_this, 0] call d_fnc_userkeyselchanged"; 
		};
		class ThreeDMarkerUserCaption: ViewDistanceCaption {
			idc = 3401;
			y = "0.55 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_2013";
		};
		class ThreeDMarkerUserCombo: EarplugsUserCombo {
			idc = 3402;
			y = "0.58 * safezoneH + safezoneY";
			onLBSelChanged = "[_this, 1] call d_fnc_userkeyselchanged";
		};
		class PointsCaption: RscText {
			idc = 3403;
			y = "0.635 * safezoneH + safezoneY";
			x = "0.35 * safezoneW + safezoneX";
			w = "0.25 * safezoneW";
			h = "0.025 * safezoneH";
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1294";
		};
		class PointsCaption2: PointsCaption {
			idc = 3404;
			y = "0.665 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1295";
		};
		class CorporalPic: D_RscPicture {
			idc = 3405;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.705 * safezoneH + safezoneY";
			w = "0.025 * safezoneW";
			h = "0.025 * safezoneH";
			text = __EVAL(getText(configfile>>"CfgRanks">>"1">>"texture"));
			sizeEx = 256;
			colorText[] = {1, 1, 1, 1};
		};
		class CorporalString: RscText {
			idc = 3406;
			x = "0.38 * safezoneW + safezoneX";
			y = "0.67 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = __EVAL(getText(configfile>>"CfgRanks">>"1">>"displayName"));
		};
		class CorporalPoints: CorporalString {
			idc = 2001;
			x = "0.47 * safezoneW + safezoneX";
			text = "";
		};
		class SergeantPic: CorporalPic {
			idc = 3407;
			y = "0.735 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"2">>"texture"));
		};
		class SergeantString: CorporalString {
			idc = 3408;
			y = "0.7 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"2">>"displayName"));
		};
		class SergeantPoints: CorporalPoints {
			idc = 2002;
			y = "0.7 * safezoneH + safezoneY";
			text = "";
		};
		class LieutenantPic: CorporalPic {
			idc = 3409;
			y = "0.765 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"3">>"texture"));
		};
		class LieutenantString: CorporalString {
			idc = 3410;
			y = "0.73 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"3">>"displayName"));
		};
		class LieutenantPoints: CorporalPoints {
			idc = 2003;
			y = "0.73 * safezoneH + safezoneY";
			text = "";
		};
		class CaptainPic: CorporalPic {
			idc = 3411;
			y = "0.795 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"4">>"texture"));
		};
		class CaptainString: CorporalString {
			idc = 3412;
			y = "0.76 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"4">>"displayName"));
		};
		class CaptainPoints: CorporalPoints {
			idc = 2004;
			y = "0.76 * safezoneH + safezoneY";
			text = "";
		};
		class MajorPic: CorporalPic {
			idc = 3413;
			y = "0.825 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"5">>"texture"));
		};
		class MajorString: CorporalString {
			idc = 3414;
			y = "0.79 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"5">>"displayName"));
		};
		class MajorPoints: CorporalPoints {
			idc = 2005;
			y = "0.79 * safezoneH + safezoneY";
			text = "";
		};
		class ColonelPic: CorporalPic {
			idc = 3415;
			y = "0.855 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"6">>"texture"));
		};
		class ColonelString: CorporalString {
			idc = 3416;
			y = "0.82 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"6">>"displayName"));
		};
		class ColonelPoints: CorporalPoints {
			idc = 2006;
			y = "0.82 * safezoneH + safezoneY";
			text = "";
		};
		class GeneralPic: CorporalPic {
			idc = 3417;
			y = "0.885 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"7">>"texture"));
		};
		class GeneralString: CorporalString {
			idc = 3418;
			y = "0.85 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"7">>"displayName"));
		};
		class GeneralPoints: CorporalPoints {
			idc = 2007;
			y = "0.85 * safezoneH + safezoneY";
			text = "";
		};
		class DistTraveled: RscText {
			idc = 6000;
			x = "0.71 * safezoneW + safezoneX";
			y = "0.78 * safezoneH + safezoneY";
			w = "0.25 * safezoneW";
			h = "0.1 * safezoneH";
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_2045";
			shadow = 0;
		};
		class ByFoot: DistTraveled {
			idc = 6001;
			text = "$STR_DOM_MISSIONSTRING_2046";
			y = "0.82 * safezoneH + safezoneY";
		};
		class ByFootVal: ByFoot {
			idc = 6002;
			text = "";
			x = "0.77 * safezoneW + safezoneX";
		};
		class ByLandvehicle: ByFoot {
			idc = 6003;
			text = "$STR_DOM_MISSIONSTRING_2047";
			y = "0.84 * safezoneH + safezoneY";
		};
		class ByLandvehicleVal: ByLandvehicle {
			idc = 6004;
			text = "";
			x = "0.77 * safezoneW + safezoneX";
		};
		class ByAir: ByFoot {
			idc = 6005;
			text = "$STR_DOM_MISSIONSTRING_2048";
			y = "0.86 * safezoneH + safezoneY";
		};
		class ByAirVal: ByAir {
			idc = 6006;
			text = "";
			x = "0.77 * safezoneW + safezoneX";
		};
		class ByShip: ByFoot {
			idc = 6007;
			text = "$STR_DOM_MISSIONSTRING_2049";
			y = "0.88 * safezoneH + safezoneY";
		};
		class ByShipVal: ByShip {
			idc = 6008;
			text = "";
			x = "0.77 * safezoneW + safezoneX";
		};
	};
};
