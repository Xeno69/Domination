// by Xeno
//#include "..\x_setup.sqf"

disableSerialization;

if (d_pnsel_first) exitWith {
	d_pnsel_first = false;
};

private _selIdx = (_this # 0) # 1;
if (_selIdx == -1) exitWith {};

if (d_show_player_namesx != _selIdx) then {
	if (isStreamFriendlyUIEnabled || {d_force_isstreamfriendlyui == 1}) then {
		removeMissionEventHandler ["Draw3D", d_phudraw3d];
		["dom_fillname_huddo"] call d_fnc_eachframeremove;
		d_phudraw3d = -1;
	} else {
		d_show_player_namesx = _selIdx;
		switch (d_show_player_namesx) do {
			case 0: {
				if (d_show_pname_hud) then {
					d_show_pname_hud = false;
					if (d_phudraw3d != -1) then {
						removeMissionEventHandler ["Draw3D", d_phudraw3d];
						["dom_fillname_huddo"] call d_fnc_eachframeremove;
						d_phudraw3d = -1;
					};
					["dom_player_hud2", {call d_fnc_player_name_huddo2}] call d_fnc_eachframeadd;
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
					d_pl_name_huddo_ar = [];
					["dom_fillname_huddo", {call d_fnc_fillname_huddo}] call d_fnc_eachframeadd;
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
					d_pl_name_huddo_ar = [];
					 ["dom_fillname_huddo", {call d_fnc_fillname_huddo}] call d_fnc_eachframeadd;
					d_phudraw3d = addMissionEventHandler ["Draw3D", {call d_fnc_player_name_huddo}];
				};
				systemChat (localize "STR_DOM_MISSIONSTRING_890");
			};
		};
	};
};