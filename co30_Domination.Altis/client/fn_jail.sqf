// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_jail.sqf"
#include "..\x_setup.sqf"

d_goto_jail = true;

if (!alive player) then {
	waitUntil {alive player};
};

cutText ["You are beeing transfered to jail because of too much teamkilling!!!", "BLACK", 0];

if (vehicle player != player) then {
	moveOut player;
};

player allowDamage false;

params ["_numtk", ["_isjip", 0]];

private _secs = [_numtk * 60, _isjip] select (_isjip > 0);
player setVariable ["d_jailar", [serverTime, _secs], true];

private _laodout =+ getUnitLoadout player;
player setUnitLoadout (configFile >> "EmptyLoadout");

if (isNil "d_jailpos") then {
	d_jailpos = [d_FLAG_BASE, 800, 10000, 3, 0, 0.3] call d_fnc_findsafepos;
};

private _soundspawn = 0 spawn {
	while {true} do {
		playSound "d_war";
		sleep 3.78;
	};
};

private _disresbspawn = 0 spawn {
	waitUntil {!isNull (findDisplay 49)};
	((findDisplay 49) displayCtrl 1010) ctrlEnable false;
};

private _jailcoords = [
	["Land_PillboxWall_01_3m_F",[-0.203125,-1.66772,0],0,1,0,[],"","",true,false], 
	["Land_PillboxBunker_01_big_F",[3.55261,3.76831,0],0,1,0,[],"","",true,false], 
	["UGV_02_Wheel_F",[6.56763,4.93701,-0.000999928],359.999,1,0,[],"","",true,false]
];

private _jailobjects = [d_jailpos, random 360, _jailcoords, 0, true] call d_fnc_objectsMapper;
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

player setPos _pmovepos;

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

cutText ["You are beeing transfered back to base!!!", "BLACK OUT", 0];

sleep 2;

terminate _soundspawn;
terminate _disresbspawn;

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

{
	deleteVehicle _x;
} forEach _jailobjects;

sleep 8;
if (isNil "d_goto_jail") then {
	"d_jail" cutText ["", "PLAIN"];
};
