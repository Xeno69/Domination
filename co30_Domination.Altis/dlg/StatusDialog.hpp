class D_StatusDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['D_StatusDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;(_this select 0) call d_fnc_statusdialoginit;d_showstatus_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_StatusDialog', nil];d_showstatus_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BGN($STR_DOM_MISSIONSTRING_1318)
	};
	class controls {
		class TeamStatusButton: RscButton {
			idc = 11009;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1301";
			action = "closeDialog 0;uiNamespace setVariable ['d_dyxn_gr_disp', findDisplay 46 createDisplay 'RscDisplayDynamicGroups'];0 spawn d_fnc_grouplead";
			x = "0.71 * safezoneW + safezoneX";
			y = "0.61 * safezoneH + safezoneY";
			//w = "0.3 * safezoneW";
			w = 0.3;
		};
		class FixHeadBugButton: TeamStatusButton {
			idc = -1;
			text = "$STR_DOM_MISSIONSTRING_1303"; 
			action = "closeDialog 0;player spawn d_fnc_FixHeadBug";
			y = "0.67 * safezoneH + safezoneY";
		};
		class AdminButton: TeamStatusButton {
			idc = 123123;
			text = "$STR_DOM_MISSIONSTRING_1305";
			action = "closeDialog 0;call d_fnc_admindialog";
			y = "0.73 * safezoneH + safezoneY";
		};
		class SaveDBButton: TeamStatusButton {
			idc = 123124;
			text = "$STR_DOM_MISSIONSTRING_1754";
			action = "closeDialog 0;createDialog 'D_DBSaveDialog'";
			y = "0.79* safezoneH + safezoneY";
		};
		class DBTop10Button: TeamStatusButton {
			idc = 123125;
			text = "$STR_DOM_MISSIONSTRING_1757";
			action = "closeDialog 0;createDialog 'D_DBTop10Dialog'";
			y = "0.85 * safezoneH + safezoneY";
		};
		__CANCELCLOSEB3(-1)
		class ShowSideButton: RscLinkButtonBase {
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.07 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.031;
			style = ST_LEFT;
			text = "$STR_DOM_MISSIONSTRING_1306";
			action = "[0] call d_fnc_showsidemain_d";
			shadow = 0;
		};
		class ShowMainButton: RscLinkButtonBase {
			x = "0.71 * safezoneW + safezoneX";
			y = "0.09 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			style = ST_LEFT;
			sizeEx = 0.032;
			text = "$STR_DOM_MISSIONSTRING_1307";
			action = "[1] call d_fnc_showsidemain_d";
			shadow = 0;
		};
		class SideMissionTxt: RscText2 {
			idc = 11002;
			style = ST_MULTI;
			sizeEx = 0.028;
			lineSpacing = 1;
			colorBackground[] = __GUI_BCG_RGB;
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.11 * safezoneH + safezoneY";
			w = "0.28 * safezoneW";
			h = "0.15 * safezoneH";
			text = "";
			shadow = 0;
		};
		class SecondaryCaption: RscText2 {
			x = "0.0203532 * safezoneW + safezoneX";
			y = "0.28 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.031;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1308";
			shadow = 0;
		};
		class SecondaryTxt: SideMissionTxt {
			idc = 11007;
			y = "0.32 * safezoneH + safezoneY";
			w = "0.28 * safezoneW";
			h = "0.11 * safezoneH";
		};
		class IntelCaption: SecondaryCaption {
			idc = 11019;
			y = "0.45 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1309";
		};
		class IntelTxt: SideMissionTxt {
			idc = 11018;
			y = "0.49 * safezoneH + safezoneY";
			h = "0.09 * safezoneH";
		};
		class MainTargetNumber: RscText2 {
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
		class MainTarget: RscText2 {
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
		class TTNPointsCaption : RscText2 {
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
		class TTGamePoints : RscText2 {
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
		class HintCaption: RscText2 {
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
		class RankCaption: RscText2 {
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
		class RankString: RscText2 {
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
		class ScoreP: RscText2 {
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
		class CampsCaption: RscText2 {
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
		class CampsNumber: RscText2 {
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
	class BarracksCaption: RscText2 {
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
		class BarrackNumber: RscText2 {
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
		class RLivesCaption: RscText2 {
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
		class RLivesNumber: RscText2 {
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
		class SettingsCaption: RscText2 {
			idc = -1;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.07 * safezoneH + safezoneY";
			w = "0.543806 * safezoneW";
			h = "0.04 * safezoneH";
			sizeEx = 0.031;
			style = ST_LEFT;
			text = "$STR_DOM_MISSIONSTRING_1302";
		};
		class ViewDistanceCaption: RscText2 {
			idc = 1999;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.1 * safezoneH + safezoneY";
			w = "0.15 * safezoneW";
			h = "0.03 * safezoneH";
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_1285";
		};
		class VD_Slider: RscXSliderH {
			idc = 1000;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.13 * safezoneH + safezoneY";
			w = "0.2 * safezoneW";
			h = "0.02 * safezoneH";
			onSliderPosChanged = "_this call d_fnc_vdsliderchanged";
		};
		class GraslayerCaption: ViewDistanceCaption {
			idc = 1998;
			y = "0.18 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1287";
		};
		class GraslayerCombo: RscUIComboBox {
			idc = 1001;
			x = "0.35 * safezoneW + safezoneX";
			y = "0.21 * safezoneH + safezoneY";
			w = "0.2 * safezoneW";
			h = "0.02 * safezoneH";
			sizeEx = 0.028;
			onLBSelChanged = "[_this] call d_fnc_glselchanged";
		};
		class PlayermarkerCaption: ViewDistanceCaption {
			idc = 1501;
			y = "0.26 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1289";
		};
		class PlayermarkerCombo: GraslayerCombo {
			idc = 1002;
			y = "0.29 * safezoneH + safezoneY";
			onLBSelChanged = "[_this] call d_fnc_pmselchanged"; 
		};
		class PlayernamesCaption: ViewDistanceCaption {
			idc = 1601;
			y = "0.34 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1291";
		};
		class PlayernamesCombo: PlayermarkerCombo {
			idc = 1602;
			y = "0.37 * safezoneH + safezoneY";
			onLBSelChanged = "[_this] call d_fnc_pnselchanged"; 
		};
#ifndef __TT__
		class AutoVDCaption: ViewDistanceCaption {
			idc = 1609;
			y = "0.42 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1964";
		};
		class AutoVDCheckBox: RscCheckBox {
			idc = 1610;
			x = "0.48 * safezoneW + safezoneX";
			y = "0.424 * safezoneH + safezoneY";
			w = "0.02 * safezoneW";
			h = "0.025 * safezoneH";
		};
#endif
		class EarplugsUserCaption: ViewDistanceCaption {
			idc = 3301;
			y = "0.47 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_2012";
		};
		class EarplugsUserCombo: PlayermarkerCombo {
			idc = 3302;
			y = "0.5 * safezoneH + safezoneY";
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
		class PointsCaption: RscText2 {
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
			y = "0.665 * safezoneH + safezoneY";
			text = "$STR_DOM_MISSIONSTRING_1295";
		};
		class CorporalPic: D_RscPicture {
			x = "0.35 * safezoneW + safezoneX";
			y = "0.705 * safezoneH + safezoneY";
			w = "0.025 * safezoneW";
			h = "0.025 * safezoneH";
			text = __EVAL(getText(configfile>>"CfgRanks">>"1">>"texture"));
			sizeEx = 256;
			colorText[] = {1, 1, 1, 1};
		};
		class CorporalString: RscText2 {
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
			y = "0.735 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"2">>"texture"));
		};
		class SergeantString: CorporalString {
			y = "0.7 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"2">>"displayName"));
		};
		class SergeantPoints: CorporalPoints {
			idc = 2002;
			y = "0.7 * safezoneH + safezoneY";
			text = "";
		};
		class LieutenantPic: CorporalPic {
			y = "0.765 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"3">>"texture"));
		};
		class LieutenantString: CorporalString {
			y = "0.73 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"3">>"displayName"));
		};
		class LieutenantPoints: CorporalPoints {
			idc = 2003;
			y = "0.73 * safezoneH + safezoneY";
			text = "";
		};
		class CaptainPic: CorporalPic {
			y = "0.795 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"4">>"texture"));
		};
		class CaptainString: CorporalString {
			y = "0.76 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"4">>"displayName"));
		};
		class CaptainPoints: CorporalPoints {
			idc = 2004;
			y = "0.76 * safezoneH + safezoneY";
			text = "";
		};
		class MajorPic: CorporalPic {
			y = "0.825 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"5">>"texture"));
		};
		class MajorString: CorporalString {
			y = "0.79 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"5">>"displayName"));
		};
		class MajorPoints: CorporalPoints {
			idc = 2005;
			y = "0.79 * safezoneH + safezoneY";
			text = "";
		};
		class ColonelPic: CorporalPic {
			y = "0.855 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"6">>"texture"));
		};
		class ColonelString: CorporalString {
			y = "0.82 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"6">>"displayName"));
		};
		class ColonelPoints: CorporalPoints {
			idc = 2006;
			y = "0.82 * safezoneH + safezoneY";
			text = "";
		};
		class GeneralPic: CorporalPic {
			y = "0.885 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"7">>"texture"));
		};
		class GeneralString: CorporalString {
			y = "0.85 * safezoneH + safezoneY";
			text = __EVAL(getText(configfile>>"CfgRanks">>"7">>"displayName"));
		};
		class GeneralPoints: CorporalPoints {
			idc = 2007;
			y = "0.85 * safezoneH + safezoneY";
			text = "";
		};
	};
};
