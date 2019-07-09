//#define __DEBUG__
#define THIS_FILE "fn_sidedeliver.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_spos","_epos","_sdir","_edir"];

private _hangar = createVehicle ["Land_TentHangar_V1_F", _spos, [], 0, "NONE"];
_hangar setDir _sdir;
_hangar setPos _spos;
d_x_sm_vec_rem_ar pushBack _hangar;
_spos = _hangar ModelToWorld [0,0,0];
private _vec = createVehicle [selectRandom d_sm_deliver_truck, _spos, [], 0, "NONE"];
_vec setDir (direction _hangar);
_vec setPos _spos;
_vec setDamage 0;
[_vec, "d_sidekill"] call d_fnc_setekmode;
clearWeaponCargoGlobal _vec;
clearMagazineCargoGlobal _vec;
clearBackpackCargoGlobal _vec;
clearItemCargoGlobal _vec;
_vec addItemCargoGlobal ["ToolKit",1];
_vec addItemCargoGlobal ["FirstAidKit",3];
_vec setVariable ["d_liftit", true, true];
d_x_sm_vec_rem_ar pushBack _vec;

_vec addEventhandler ["getIn", {
	params ["_vec", "_role", "_unit"];
	if (!(_unit call d_fnc_isplayer) && {_role == "driver"}) then {
		_unit action ["getOut", _vec];
	};
}];

_vec addEventHandler ["SeatSwitched", {
	params ["_vec", "_unit1", "_unit2"];
	if (!(_unit1 call d_fnc_isplayer) && {(assignedVehicleRole _unit1) # 0 == "driver"}) then {
		_unit1 action ["getOut", _vec];
	} else {
		if (!(_unit2 call d_fnc_isplayer) && {(assignedVehicleRole _unit2) # 0 == "driver"}) then {
			_unit2 action ["getOut", _vec];
		};
	};
}];

private _hangar2 = createVehicle ["Land_TentHangar_V1_F", _epos, [], 0, "NONE"];
_hangar2 setDir _edir;
_hangar2 setPos _epos;
d_x_sm_vec_rem_ar pushBack _hangar2;

private _arrow = switch (d_own_side) do {
   case "WEST": {"Sign_Arrow_Large_Blue_F"};
   case "EAST": {"Sign_Arrow_Large_F"};
   case "GUER": {"Sign_Arrow_Large_F"};
};
private _arrowhead = _arrow createVehicle [0,0,0];
_arrowhead setPos [_epos # 0, _epos # 1, 15];
d_x_sm_vec_rem_ar pushBack _arrowhead;

sleep 2.123;
["specops", (floor (random 4) min 2), "allmen", (floor (random 5)) min 3, [_epos, 100] call d_fnc_getranpointcircleouter, 200, true] spawn d_fnc_CreateInf;
sleep 2.123;
[selectRandom ["wheeled_apc", "jeep_gl", "jeep_mg"], 1, selectRandom ["tank", "tracked_apc"], 1, "aa", 1, [_epos, 150] call d_fnc_getranpointcircleouter, 1, 250, true] spawn d_fnc_CreateArmor;

sleep 10.213;

private _reached_base = false;

private _markern = format ["d_smvecposc_%1", _vec];

[_markern, [0, 0, 0], "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_1584" , 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
	
while {alive _vec && {!_reached_base && {!d_sm_resolved}}} do {
	if ((call d_fnc_PlayersNumber) > 0) then {
		_markern setMarkerPos (getPosWorld _vec);
	};
	if (_vec distance2D _epos < 30) then {_reached_base = true;};
	sleep 5.2134;
};

if (!d_sm_resolved) then {
	if (alive _vec && {_reached_base}) then {
		d_sm_winner = 2;
	} else {
		d_sm_winner = -1200;
	};
};

deleteMarker _markern;

d_sm_resolved = true;

sleep 2.123;

if (!isNull _vec && {alive _vec}) then {
	if !((crew _vec) isEqualTo []) then {
		{moveOut _x} forEach (crew _vec);
	};
	[_vec, true] call d_fnc_l_v;
	[_vec, false] remoteExecCall ["engineOn", _vec];
};
