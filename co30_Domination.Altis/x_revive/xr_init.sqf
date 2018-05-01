// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_revive\xr_init.sqf"
#include "..\x_macros.sqf"

if (isDedicated) exitWith {};

if (didJIP) then {
	waitUntil {!isNull player};
};
waitUntil {player == player};

player setVariable ["xr_lives", xr_max_lives];
player setVariable ["xr_is_dragging", false];
player setVariable ["xr_presptime", -1];
player setVariable ["xr_pluncon", false, true];
player setVariable ["xr_pisinaction", false];
player setVariable ["xr_dragged", false, true];
player setVariable ["xr_isdead", false];

xr_uncon_units = [];
xr_death_pos = [];

private _grpl = group player;
xr_side_pl = [playerSide, side _grpl] select (!isNull _grpl);

xr_strpl = str player;
xr_strpldead = xr_strpl + "_xr_dead";

player addEventHandler ["killed", {_this call xr_fnc_killedEH}];

player addEventHandler ["respawn", {_this call xr_fnc_respawneh}];

xr_name_player = player call d_fnc_getplayername;

xr_announce_ar = [];
xr_announce_unit_ar = [];

player addEventHandler ["handleDamage", {_this call xr_fnc_ClientHD}];

if (d_only_medics_canrevive != 0) then {
	xr_pl_can_revive = true;
} else {
	xr_pl_can_revive = player getUnitTrait "Medic";
};

{
	if (alive _x && {_x getVariable ["xr_pluncon", false]}) then {
		_x spawn {
			sleep 1;
			if (alive _this && {_this getVariable ["xr_pluncon", false]}) then {
				_this call xr_fnc_addActions;
			};
		};
		xr_uncon_units pushBackUnique _x;
	} else {
		_x setVariable ["xr_ReviveAction", -9999];
		_x setVariable ["xr_DragAction", -9999];
	};
	false
} count ((allPlayers - entities "HeadlessClient_F") select {d_player_side getFriend side (group _x) >= 0.6});

addMissionEventHandler ["Draw3D", {
	if (alive player && {!(xr_uncon_units isEqualTo [])}) then {
		private _cam2world = positionCameraToWorld [0,0,0];
		{
			private _dist = _cam2world distance _x;
			if (_dist < 400) then {
				drawIcon3D ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", [1,0,0,1 - (_dist / 200)], (getPosATLVisual _x) vectorAdd [0, 0, 1 + (_dist * 0.04)], 1, 1, 0, "(Uncon) " + (_x call d_fnc_getplayername), 1, 0.032 - (_dist / 9000), "RobotoCondensed"];
			};
			false
		} count xr_uncon_units;
	};
}];

if (xr_selfheals > 0) then {
	player setVariable ["xr_numheals", xr_selfheals];
	player setVariable ["xr_selfh_ac_id", player addAction ["<t color='#FF0000'>Self Heal</t>", {_this call xr_fnc_selfheal}, [], -1, false, false, "", "alive _target &&  {!(_target getVariable 'xr_pluncon') && {!(_target getVariable 'xr_pisinaction') && {damage _target >= xr_selfheals_minmaxdam # 0 && {damage _target <= xr_selfheals_minmaxdam # 1 && {_target getVariable 'xr_numheals' > 0}}}}}"]];
};
