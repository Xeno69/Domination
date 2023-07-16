// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (player getVariable ["d_isinaction", false]) exitWith {
	d_commandingMenuIniting = false;
};

if (player distance2D d_FLAG_BASE < 30) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_246");
	d_commandingMenuIniting = false;
};

if ((player call d_fnc_GetHeight) > 5) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_241");
	d_commandingMenuIniting = false;
};

if ((player getVariable "d_farp_pos") isNotEqualTo []) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_242");
	d_commandingMenuIniting = false;
};

if (((player nearEntities ["Truck_F", 20]) select {(_x getVariable ["d_vec_type", ""]) == "Engineer"}) isEqualTo []) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_243");
	d_commandingMenuIniting = false;
};

private _d_farp_pos = player modelToWorldVisual [0,8,0];
_d_farp_pos set [2,0];

if (surfaceIsWater _d_farp_pos) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_244");
	d_commandingMenuIniting = false;
};

if ((d_with_ranked || {d_database_found}) && {score player < (d_ranked_a # 20)}) exitWith {
	[1, format [localize "STR_DOM_MISSIONSTRING_245", score player, d_ranked_a # 20]] call d_fnc_sideorsyschat;
	d_commandingMenuIniting = false;
};

if ([_d_farp_pos, 5] call d_fnc_getslope > 0.2) exitWith {
   systemChat (localize "STR_DOM_MISSIONSTRING_246");
   d_commandingMenuIniting = false;
};

player setVariable ["d_isinaction", true];

if (d_with_ranked || {d_database_found}) then {[player, 10] remoteExecCall ["d_fnc_ascfc", 2]};

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 1;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!d_player_canu}};
d_commandingMenuIniting = false;
if (!d_player_canu) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_247");
	player setVariable ["d_isinaction", false];
};

d_farp_classes params ["_farptype"];

private _mapSize = getNumber(configFile>>"CfgVehicles">>_farptype>>"mapSize");

private _farp = createVehicle [_farptype, _d_farp_pos, [], 0, "NONE"];
_farp setDir (getDirVisual player);
_farp setPos _d_farp_pos;
[_farp, 0] call d_fnc_SetHeight;

private _farptrig = [
[_d_farp_pos # 0, _d_farp_pos # 1, 1.9],
[_mapSize, _mapSize, getDirVisual _farp, true, 2],
["ANY", "PRESENT", true],
["[thislist, thisTrigger] call d_fnc_tallservice", "0 = [thisTrigger getVariable 'd_list'] spawn d_fnc_reload", ""]
] call d_fnc_CreateTrigger;
_farptrig setTriggerInterval 1;

private _farpcont = [_farptrig];

_mapSize = _mapSize + 10;
private _farp_o_pos = [_d_farp_pos, _mapSize] call d_fnc_getranpointcircleouter;
_farp_o_pos set [2, 0];
private _farp_seco = createVehicle [d_farp_classes # 1, _farp_o_pos, [], 0, "NONE"];
_farp_seco setDir (random 360);
_farp_seco setPos _farp_o_pos;

_farpcont pushBack _farp_seco;

if (count d_farp_classes > 2) then {
	for "_i" from 2 to (count d_farp_classes - 1) do {
		_farp_o_pos = [_d_farp_pos, _mapSize] call d_fnc_getranpointcircleouter;
		_farp_o_pos set [2, 0];
		_farp_o = createVehicle [d_farp_classes # _i, _farp_o_pos, [], 0, "NONE"];
		_farp_o setDir (_farp_o getDir _farp_seco);
		_farp_o setPos _farp_o_pos;

		_farpcont pushBack _farp_o;
	};
};

_farp setVariable ["d_objcont", _farpcont, true];

_d_farp_pos = getPosATL _farp;
player setVariable ["d_farp_pos", _d_farp_pos];

player setVariable ["d_farp_obj", _farp];

d_farps pushBack _farp;
publicVariable "d_farps";

systemChat (localize "STR_DOM_MISSIONSTRING_248");
#ifndef __TT__
["a", d_player_uid, [_farp, "d_FARP " + (netId player), d_name_pl, player, d_player_side]] remoteExecCall ["d_fnc_p_o_ar", 2];
#else
private _mbegin = ["d_FARP_opf ", "d_FARP_blu "] select (d_player_side == blufor);
["a", d_player_uid, [_farp, _mbegin + (netId player), d_name_pl, player, d_player_side]] remoteExecCall ["d_fnc_p_o_ar", 2];
#endif
if (isMultiplayer) then {
	[_farp, player] remoteExecCall ["d_fnc_farp_e", d_player_side];
} else {
	[_farp, player] call d_fnc_farp_e;
};

_farp setVariable ["d_owner", player, true];

_farp_seco addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_249"], {
	call {
		private _farp = player getVariable ["d_farp_obj", objNull];
		if (isNull _farp) exitWith {};

		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!d_player_canu}};
		if (!d_player_canu) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_315")};

		d_farps = d_farps - [_farp];
		publicVariable "d_farps";

		private _farpcont = _farp getVariable ["d_objcont", []];
		if (_farpcont isNotEqualTo []) then {
			{deleteVehicle _x} forEach _farpcont;
		};
		deleteVehicle _farp;

		player setVariable ["d_farp_obj", objNull];

		systemChat (localize "STR_DOM_MISSIONSTRING_316");
		player setVariable ["d_farp_pos", []];
		["ar", d_player_uid, "d_FARP " + (netId player)] remoteExecCall ["d_fnc_p_o_ar", 2];
	};
}, -1, 1.5, true, true, "", "true", 10];

player setVariable ["d_isinaction", false];
