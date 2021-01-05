class D_DBTop10Dialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['D_DBTop10Dialog', _this select 0];[_this select 0] call bis_fnc_guiEffectTiles;call d_fnc_initdbtop10dialog;d_dbtop10_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_DBTop10Dialog', nil];d_dbtop10_dialog_open = false; d_dbtop10_dialog_open = nil";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		__DDIALOG_BG2($STR_DOM_MISSIONSTRING_1756)
	};
	class controls {
		__CANCELCLOSEB2(-1)
		
		class Top10LNListbox: RscListNBox {
			idc = 100;
			x = safezoneX; y = safezoneY + (1 / 25) + 0.02; w = safeZoneW; h = safeZoneH - 0.1;
			drawSideArrows = 1;
			idcRight = 147;
			idcLeft = 146;
			sizeEx = 0.028;
		};
	};
};
