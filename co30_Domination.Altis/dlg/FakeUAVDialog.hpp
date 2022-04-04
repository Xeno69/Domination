class D_FakeUAVDialog {
	idd = -1;
	movingEnable = true;
	onLoad = "uiNamespace setVariable ['D_FakeUAVDialog', _this select 0]";
	onUnLoad = "uiNamespace setVariable ['D_FakeUAVDialog', nil]";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE;
		COMMON_BACKGROUND_TILES;
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1513);
	};
	class controls {
		__CANCELCLOSEB(-1);
		class FakeMapText : RscText {
			x = 0.02; y = 0.02;
			w = 0.5; h = 0.1;
			colorBackground[] = {1, 1, 1, 0};
			colorText[] = {1, 1, 1, 1};
			text = "$STR_DOM_MISSIONSTRING_1514";
		};
		class Map : D_RscMapControl {
			idc = 11111;
			colorBackground[] = {0.9, 0.9, 0.9, 0.9};
			x = 0.02; y = 0.115;
			w = 0.96; h = 0.8;
			showCountourInterval = false;
			onMouseButtonClick = "closedialog 0; _this call d_fnc_satellitedo";
		};
	};
};
