class D_AIRecruitDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_AIRecruitDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;call d_fnc_fillRecruit;d_airecruit_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_AIRecruitDialog', nil];d_airecruit_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1235)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class UnitsListBoxCaption: RscText {
			x = 0.08; y = 0.11;
			w = 0.2; h = 0.1;
			sizeEx = 0.029;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1237";
		};
		class UnitsListbox: RscListBox {
			idc = 1000;
			x = 0.08; y = 0.2;
			w = 0.4; h = 0.5;
			style = ST_LEFT;
			onMouseButtonDblClick = "call d_fnc_recruitbuttonaction";
		};
		class RecruitButton: RscButton {
			idc = 1010;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1238"; 
			action = "call d_fnc_recruitbuttonaction";
			x = 0.17; y = 0.72; w = 0.2;
		};
		
		class CurUnitsListBoxCaption: UnitsListBoxCaption {
			idc = 1030;
			x = 0.5;
			w = 0.3;
			text = "$STR_DOM_MISSIONSTRING_1239";
		};
		class CurUnitsListbox: RscListBox {
			idc = 1001;
			x = 0.5; y = 0.2;
			w = 0.4; h = 0.5;
			style = ST_LEFT;
			onMouseButtonDblClick = "call d_fnc_dismissbuttonaction";
		};
		
		class DismissButton: RecruitButton {
			idc = 1011;
			text = "$STR_DOM_MISSIONSTRING_1240";
			action = "call d_fnc_dismissbuttonaction";
			x = 0.59;
		};
		
		class DismissAllButton: RecruitButton {
			idc = 1012;
			text = "$STR_DOM_MISSIONSTRING_1241"; 
			action = "call d_fnc_dismissallbuttonaction";
			x = 0.34; y = 0.8;
		};
	};
};
