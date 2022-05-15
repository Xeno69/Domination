//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_target", "_caller", "_wtype"];

__TRACE_1("","_this")

private _callero = [player, objectFromNetId _caller] select isMultiplayer;
private _side = side (group _callero);

#ifndef __TT__
if (!isServer || {!d_cas_available}) exitWith {};
d_cas_available = false;
publicVariable "d_cas_available";
#else
if (!isServer || {_side == blufor && {!d_cas_available_w}}) exitWith {};
if (_side == opfor && {!d_cas_available_e}) exitWith {};

if (_side == blufor) then {
	d_cas_available_w = false;
	publicVariable "d_cas_available_w";
} else {
	if (_side == opfor) then {
		d_cas_available_e = false;
		publicVariable "d_cas_available_e";
	};
};
#endif

if (d_with_ranked || {d_database_found}) then {
	_callero addScore -(d_ranked_a # 22);
};

#ifndef __TT__
private _planeClass = d_cas_plane;
#else
private _planeClass = d_cas_plane select (_side == opfor);
#endif
__TRACE_1("","_planeClass")

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
#ifndef __TT__
	d_cas_available = true;
	publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true;
		publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true;
		publicVariable "d_cas_available_w";
	};
#endif
	false
};

remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];

#ifdef __TT__
private _topicside = ["HQ_W", "HQ_E"] select (_side == opfor);
private _logic = [d_hq_logic_blufor2, d_hq_logic_opfor2] select (_side == opfor);
private _logic1 = [d_hq_logic_blufor1, d_hq_logic_opfor1] select  (_side == opfor);
private _channel = "SIDE";
#else
private _topicside = d_kb_topic_side;
private _logic = d_kb_logic2;
private _logic1 = d_kb_logic1;
private _channel = d_kbtel_chan;
#endif

if (isNil "_callero" || {isNull _callero}) then {_callero = _logic};
_logic1 kbTell [_callero, _topicside, "CASOnTheWay", _channel];
sleep 1;
_logic1 kbTell [_logic, _topicside, "CASUnavailable", _channel];

private "_bomb";
private _altitude = 500;
if (_wtype == 0) then {
	_bomb = "Bomb_04_F";
	sleep (2 max random 5);
};
if (_wtype == 1) then {
	_bomb = "M_Scalpel_AT"; // todo
	sleep 1;
};

#ifdef __VN__
// default bomb type for SOG
if (_wtype == 0) then {
	_bomb = "vn_bomb_500_mk82_he_ammo";
	sleep (2 max random 5);
};
if (_wtype == 2) then {
	// napalm
	_bomb = "vn_bomb_500_blu1b_fb_ammo";
	sleep (2 max random 5);
};
if (_wtype == 3) then { 
	_bomb = "vn_bomb_15000_blu82_dc_ammo"; // todo
	sleep (2 max random 5);
};
#endif

private _callerpos = getPos _callero;

// fast CAS bomb, quickly drop the bomb, do not spawn a plane
[_target, _callerpos, _bomb, _altitude, _callero] call d_fnc_moduleCAS_guidedmissile;

[_side, _logic1, _logic, _topicside, _channel] spawn {
	scriptName "spawn_cas_available";
	params ["_side", "_logic1", "_logic", "_topicside", "_channel"];
	switch (d_arty_unlimited) do {
		case 1: {
			sleep (3);
		};
		case 2: {
			sleep (d_cas_available_time_low);
		};
		default {
			sleep d_cas_available_time;
		};
	};	

	d_cas_metadata = [];

#ifndef __TT__
	d_cas_available = true; publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true; publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true; publicVariable "d_cas_available_w";
	};
#endif
	remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];
	_logic1 kbTell [_logic, _topicside, "CASAvailable", _channel];
};
