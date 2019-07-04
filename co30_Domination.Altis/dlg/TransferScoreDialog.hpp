class d_TransferScoreDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['d_TransferScoreDialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;call d_fnc_inittransferscoredialog;d_transferscore_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['d_TransferScoreDialog', nil];d_transferscore_dialog_open = false;";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1872)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class SelectPlayerComboCaption: RscText2 {
			x = 0.08; y = 0.08;
			w = 0.2; h = 0.1;
			sizeEx = 0.032;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			text = "$STR_DOM_MISSIONSTRING_1220";
		};
		class UnitsCombo: RscUIComboBox {
			idc = 1001;
			x = 0.08; y = 0.16;
			w = 0.25; h = 0.04;
			sizeEx = 0.032;
		};
		class ExecTransferButton: RscButton {
			idc = 1007;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1873"; 
			action = "if (d_transscore > 0) then {0 spawn d_fnc_tranfserscoremsgdialog} else {closeDialog 0}";
			x = 0.7; y = 0.8; w = 0.2;
		};
		class AmmountSlider {
			idc = 1008; 
			type = CT_SLIDER; 
			style = 1024; 
			x = 0.45; 
			y = 0.4; 
			w = 0.38; 
			h = 0.03; 
			color[] = { 1, 1, 1, 1 }; 
			coloractive[] = { 1, 1, 1, 1 };
			onSliderPosChanged = "_this call d_fnc_tsdsliderposchanged";
		};
		class LeftText: SelectPlayerComboCaption {
			idc = 1020;
			style = ST_RIGHT;
			x = 0.40; y = 0.392; w = 0.05; h = 0.032;
			text = "";
		};
		class RightText: LeftText {
			idc = 1021;
			style = ST_LEFT;
			x = 0.83;
		};
		class CurrentScoreCaption: SelectPlayerComboCaption {
			x = 0.5;
			y = 0.16;
			sizeEx = 0.04;
			text = "$STR_DOM_MISSIONSTRING_1874";
		};
		class CurrentScoreText: CurrentScoreCaption {
			idc = 1009;
			x = 0.7;
			text = "";
		};
		class NewScoreCaption: CurrentScoreCaption {
			x = 0.5;
			y = 0.21;
			sizeEx = 0.04;
			text = "$STR_DOM_MISSIONSTRING_1875";
		};
		class NewScoreText: NewScoreCaption {
			idc = 1010;
			x = 0.7;
			text = "";
		};
		class TransferScoreCaption: CurrentScoreCaption {
			x = 0.5;
			y = 0.5;
			sizeEx = 0.04;
			text = "$STR_DOM_MISSIONSTRING_1876";
		};
		class TransferScoreText: TransferScoreCaption {
			idc = 1011;
			x = 0.7;
			text = "";
		};
	};
};
