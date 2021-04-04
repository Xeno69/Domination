// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_jail.sqf"
#include "..\x_setup.sqf"

d_goto_jail = true;

private _enhmm = isClass (configFile>>"CfgPatches">>"BaBe_EM");

private "_keyeh";
if (_enhmm) then {
	d_usactckey = [];
	for "_i" from 1 to 20 do {
		d_usactckey append (actionKeys format ["User%1", _i]);
	};
	_keyeh = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		((_this # 1) in d_usactckey)
	}];
};

if (!alive player) then {
	waitUntil {sleep 0.3; alive player};
};

if (player getVariable "xr_pluncon") then {
	xr_u_doend_of = true;
	waitUntil {d_uncon_finally_over};
	d_uncon_finally_over = false;
};

cutText [localize "STR_DOM_MISSIONSTRING_1999", "BLACK", 0];

player allowDamage false;

if (vehicle player != player) then {
	moveOut player;
};

params ["_numtk", ["_isjip", 0]];

private _secs = [_numtk * 60, _isjip] select (_isjip > 0);
player setVariable ["d_jailar", [serverTime, _secs], true];

private _laodout =+ getUnitLoadout player;
player setUnitLoadout (configFile >> "EmptyLoadout");

private _jailpos = if (d_cur_tgt_pos isNotEqualTo []) then {
	[d_FLAG_BASE, 800, 10000, 3, 0, 0.3, 0, [[d_cur_tgt_pos, 1000, 1000, 0, false]]] call d_fnc_findsafepos
} else {
	[d_FLAG_BASE, 800, 10000, 3, 0, 0.3] call d_fnc_findsafepos
};

private _soundspawn = 0 spawn {
	scriptname "spawn jail1";
	while {true} do {
		playSound "d_war";
		sleep 3.78;
	};
};

private _disresbspawn = 0 spawn {
	scriptname "spawn jail2";
	waitUntil {!isNull (findDisplay 49)};
	((findDisplay 49) displayCtrl 1010) ctrlEnable false;
};

private _jailcoords = [
	["Land_PillboxWall_01_3m_F",[-0.203125,-1.66772,0],0,1,0,[],"","",true,false], 
	["Land_PillboxBunker_01_big_F",[3.55261,3.76831,0],0,1,0,[],"","",true,false], 
	["UGV_02_Wheel_F",[6.56763,4.93701,-0.000999928],359.999,1,0,[],"","",true,false]
];

private _jailobjects = [_jailpos, random 360, _jailcoords, 0, true] call d_fnc_objectsMapper;
__TRACE_1("","_jailobjects")
private _pmovepos = [];

private _todelete = -1;
{
	if (typeOf _x == "UGV_02_Wheel_F") then {
		_pmovepos = getPos _x;
		deleteVehicle _x;
		_todelete = _forEachIndex;
	} else {
		_x allowDamage false;
	};
} forEach _jailobjects;

if (_todelete != -1) then {
	_jailobjects deleteAt _todelete;
};

["aj", d_player_uid, _jailobjects] remoteExecCall ["d_fnc_p_o_ar", 2];

player setPos _pmovepos;

sleep 0.1;

private _movecheck_fnc = _pmovepos spawn {
	scriptname "spawn jail3";
	private _notfirst = false;
	while {true} do {
		if (player distance _this > 12) then {
			player setPos _pmovepos;
			if (!_notfirst) then {
				_notfirst = true;
				(getPlayerUID player) remoteExecCall ["d_fnc_incjail", 2];
				d_player_jescape = d_player_jescape + 1;
				if (d_player_jescape > 10) then {
					0 spawn {
						scriptname "spawn jail4";
						"d_jescape" cutText [format ["<t color='#ffffff' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_2043"], "PLAIN DOWN", -1, true, true];
						sleep 5;
						endMission "End2";
						forceEnd;
					};
				};
			};
		};
		sleep 1;
	};
};

sleep 2;
cutText ["", "BLACK IN", 2];
sleep 2;

private _t1 = format [localize "STR_DOM_MISSIONSTRING_1995", _numtk, _secs];
"d_jail2" cutText [format ["<t color='#ffffff' size='2'>%1</t>", _t1], "PLAIN DOWN", -1, true, true];

_t1 = localize "STR_DOM_MISSIONSTRING_1996";
private _t2 = format [localize "STR_DOM_MISSIONSTRING_1997", _secs];
"d_jail" cutText [format ["<t color='#ff0000' size='5'>%1<br/>%2</t>", _t1, _t2], "PLAIN", -1, true, true];
while {_secs > 0} do {
	_secs = _secs - 1;
	_t2 = format [localize "STR_DOM_MISSIONSTRING_1997", _secs];
	"d_jail" cutText [format ["<t color='#ff0000' size='5'>%1<br/>%2</t>", _t1, _t2], "PLAIN", -1, true, true];
	sleep 1;
};

"d_jail" cutText ["", "PLAIN"];
"d_jail2" cutText ["", "PLAIN DOWN"];

cutText [localize "STR_DOM_MISSIONSTRING_2000", "BLACK OUT", 0];

sleep 2;

terminate _soundspawn;
terminate _disresbspawn;
terminate _movecheck_fnc;

player setVariable ["d_jailar", nil, true];

player setUnitLoadout _laodout;

private "_respawn_pos";

if (!d_tt_ver) then {
	_respawn_pos = markerPos "base_spawn_1";
} else {
	_respawn_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
};
if (!d_carrier) then {
	_respawn_pos set [2, 0];
} else {
	_respawn_pos set [2, (getPosASL D_FLAG_BASE) # 2];
};
d_player_in_base = true;
if (surfaceIsWater _respawn_pos) then {
	__TRACE("is water")
	player setPosASL _respawn_pos;
} else {
	player setVehiclePosition [_respawn_pos, [], 2, "NONE"];
};
"d_jail" cutText [format ["<t color='#ff0000' size='5'>%1</t>", localize "STR_DOM_MISSIONSTRING_1998"], "PLAIN", -1, true, true];
d_goto_jail = nil;
player allowDamage true;

cutText ["", "BLACK IN", 0.2];

__TRACE("Deleting objects")
{
	deleteVehicle _x;
} forEach _jailobjects;
["ajr", d_player_uid] remoteExecCall ["d_fnc_p_o_ar", 2];

sleep 8;
if (isNil "d_goto_jail") then {
	"d_jail" cutText ["", "PLAIN"];
};

if (_enhmm) then {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", _keyeh];
};