class D_VecDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['D_VecDialog', param [0]];[param [0]] call bis_fnc_guiEffectTiles;call d_fnc_initvecdialog;d_vec_dialog_open = true";
	onUnLoad = "uiNamespace setVariable ['D_VecDialog', nil];d_vec_dialog_open = false";
	effectTilesAlpha = 0.15;
	class controlsBackground {
		COMMON_BACKGROUND_VIGNETTE
		COMMON_BACKGROUND_TILES
		__DDIALOG_BG($STR_DOM_MISSIONSTRING_1322)
	};
	class controls {
		__CANCELCLOSEB(-1)
		class VecPicture: D_RscPicture {
			idc = 44444;
			x=0.36; y=0.11; w=0.15; h=0.1;
			text="";
			sizeEx = 256;
		};
		class VecDialogCaption2: RscText2 {
			idc = 44445;
			x = 0.55;
			y = 0.15;
			w = 0.25;
			text = "Chopper 1";
		};
		class AmmoBoxCaption: VecDialogCaption2 {
			idc = 44454;
			x = 0.24;
			y = 0.25;
			text = "$STR_DOM_MISSIONSTRING_1323";
		};
		class BoxPicture: D_RscPicture {
			idc = 44446;
			x=0.23; y=0.3; w=0.17; h=0.17;
			text="";
			sizeEx = 256;
		};
		class BoxPicture2: D_RscPicture {
			idc = 44447;
			x=0.25; y=0.325; w=0.12; h=0.12;
			text="";
			sizeEx = 256;
		};
		class DropAmmoButton: RscButton {
			idc = 44448;
			style = 0;
			colorBackgroundActive[] = {1,1,1,0.1};
			text = "$STR_DOM_MISSIONSTRING_1324"; 
			action = "closeDialog 0;[vehicle player, player] call d_fnc_dropammoboxdx";
			x = 0.20;
			y = 0.47;
			w = 0.23;
		};
		class LoadAmmoButton: DropAmmoButton {
			idc = 44452;
			text = "$STR_DOM_MISSIONSTRING_1325"; 
			action = "closeDialog 0;[vehicle player, player] call d_fnc_loaddroppedx";
			y = 0.53;
		};
		class CreateVecCaption: VecDialogCaption2 {
			idc = 44450;
			x = 0.50;
			y = 0.25;
			text = "$STR_DOM_MISSIONSTRING_1326";
		};
		class CreateListbox: RscListBox {
			idc = 44449;
			x = 0.50;
			y = 0.31;
			w = 0.275;
			h = 0.26;
			sizeEx = 0.037;
			rowHeight = 0.06;
			style = ST_LEFT;
			borderSize = 1;
		};
		class CreateVecButton: DropAmmoButton {
			idc = 44451;
			style = 2;
			text = "$STR_DOM_MISSIONSTRING_1326"; 
			action = "call d_fnc_create_vecx";
			x = 0.52;
			y = 0.59;
		};
		class TeleportButton: DropAmmoButton {
			idc = 44453;
			text = "$STR_DOM_MISSIONSTRING_1250"; 
			action = "closeDialog 0;call d_fnc_teleportx";
			y = 0.59;
		};
		class SATViewButton: DropAmmoButton {
			idc = 44459;
			text = "$STR_DOM_MISSIONSTRING_1327"; 
			action = "closeDialog 0;createDialog 'D_FakeUAVDialog'";
			y = 0.65;
		};
		class UAVButton: DropAmmoButton {
			idc = 44460;
			text = "$STR_DOM_MISSIONSTRING_1327a"; 
			action = "closeDialog 0;call d_fnc_makeuav";
			y = 0.71;
		};
		class DeployMHQ: DropAmmoButton {
			idc = 44462;
			style = 2;
			text = "$STR_DOM_MISSIONSTRING_1328"; 
			action = "closeDialog 0;call d_fnc_deploy_mhq";
			x = 0.37;
			y = 0.8;
		};
	};
};
