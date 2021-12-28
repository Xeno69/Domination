class D_DBSaveDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['D_DBSaveDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;((_this select 0) displayCtrl 101) ctrlEnable false;call d_fnc_initdbsavedialog;d_dbsave_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_DBSaveDialog', nil];d_dbsave_dialog_open = false; d_dbsave_dialog_open = nil";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1746)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class SaveNameCaption: RscText {
			x = 0.08; y = 0.08;
			w = 0.7; h = 0.1;
			sizeEx = 0.064;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_1747";
		};
		class EditBox: RscEdit {
			idc = 100;
			x = 0.08; y = 0.2;
			w = 0.6; h = 0.1;
			sizeEx = 0.064;
			text = "";
			OnKeyDown = "if (ctrlText ((uiNamespace getVariable 'D_DBSaveDialog') displayCtrl 100) != '') then {((uiNamespace getVariable 'D_DBSaveDialog') displayCtrl 101) ctrlEnable true} else {((uiNamespace getVariable 'D_DBSaveDialog') displayCtrl 101) ctrlEnable false}";
			default = true;
		};
		class SaveButton: RscButton {
			idc = 101;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1748"; 
			action = "[ctrlText ((uiNamespace getVariable 'D_DBSaveDialog') displayCtrl 100), player] remoteExec ['d_fnc_saveprogress2db', 2];closeDialog 0";
			x = 1 - 0.28; y = 0.22; w = 0.2;
		};
		class SavedNamesCaption: RscText {
			x = 0.08; y = 0.32; w = 0.4; h = 0.07;
			text = "Saved games in database";
		};
		class SavedNames: RscListBox {
			idc = 102;
			x = 0.08; y = 0.4;
			w = 0.6; h = 0.5;
			onLBSelChanged = "_this call d_fnc_dbsave_lbchanged";
		};
	};
};
