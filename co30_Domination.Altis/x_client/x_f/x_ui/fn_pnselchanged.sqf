// by Xeno
#define THIS_FILE "fn_pnselchanged.sqf"
#include "..\..\..\x_setup.sqf"

disableSerialization;

if (d_pnsel_first) exitWith {
	d_pnsel_first = false;
};

private _selIdx = (param [0]) param [1];
if (_selIdx == -1) exitWith {};

if (d_show_player_namesx != _selIdx) then {
	d_show_player_namesx = _selIdx;
	switch (d_show_player_namesx) do {
		case 0: {
			if (d_show_pname_hud) then {
				d_show_pname_hud = false;
				if (d_phudraw3d != -1) then {
					removeMissionEventHandler ["Draw3D", d_phudraw3d];
					d_phudraw3d = -1;
				};
				["itemAdd", ["dom_player_hud2", {call d_fnc_player_name_huddo2}, 0]] call bis_fnc_loop;
			};
			systemChat (localize "STR_DOM_MISSIONSTRING_887");
		};
		case 1: {
			if (!d_show_pname_hud) then {
				d_show_pname_hud = true;
				if (d_phudraw3d != -1) then {
					removeMissionEventHandler ["Draw3D", d_phudraw3d];
					d_phudraw3d = -1;
				};
				d_phudraw3d = addMissionEventHandler ["Draw3D", {call d_fnc_player_name_huddo}];
			};
			systemChat (localize "STR_DOM_MISSIONSTRING_888");
		};
		case 2: {
			if (!d_show_pname_hud) then {
				d_show_pname_hud = true;
				if (d_phudraw3d != -1) then {
					removeMissionEventHandler ["Draw3D", d_phudraw3d];
					d_phudraw3d = -1;
				};
				d_phudraw3d = addMissionEventHandler ["Draw3D", {call d_fnc_player_name_huddo}];
			};
			systemChat (localize "STR_DOM_MISSIONSTRING_890");
		};
	};
};