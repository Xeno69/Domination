// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

d_last_bonus_vec = "";

d_sm_triggervb = [
	[0, 0, 0],
	[0, 0, 0, false, 0],
	["NONE", "PRESENT", true],
	[
		"d_sm_resolved && {d_cur_sm_idx != -1}",
		"call d_fnc_SideMissionResolved",
		""
	]
] call d_fnc_createtriggerlocal;

if (d_with_ai) then {0 spawn d_fnc_delaiserv};

if (d_MissionType in [0,2]) then {
	0 spawn {
		scriptName "spawn_serversetup_startsm";
#ifndef __SMDEBUG__
		sleep 20;
		if (d_MissionType != 2) then {
			private _num_p = call d_fnc_PlayersNumber;
			private _waittime = 200 + random 10;
			if (_num_p > 0) then {
				private _fidx = d_time_until_next_sidemission findIf {_num_p <= _x # 0};
				if (_fidx > -1) then {
					_waittime = ((d_time_until_next_sidemission # _fidx # 1) max 20) + random 10;
				};
			};
			sleep _waittime;
		} else {
			sleep 15;
		};
#else
		sleep 10;
#endif
		0 spawn d_fnc_getsidemission;
	};
};

#ifdef __TT__
0 spawn d_fnc_sendttpoints;
#endif

private _applyfnc = {
	__TRACE_1("","_this")
	if (_this isKindOf "Plane") exitWith {
		__TRACE("Plane")
		[_this, d_sm_vec_weighting # 0]
	};
	if (_this isKindOf "Helicopter") exitWith {
		__TRACE("Helicopter")
		[_this, d_sm_vec_weighting # 1]
	};
	if (_this isKindOf "Tank") exitWith {
		__TRACE("Tank")
		[_this, d_sm_vec_weighting # 2]
	};
	__TRACE("Another")
	[_this, d_sm_vec_weighting # 3]
};

#ifndef __TT__
d_sm_bonus_vehicle_array = flatten (d_sm_bonus_vehicle_array apply {_x call _applyfnc});
d_sm_bonus_vehicle_array_cur =+ d_sm_bonus_vehicle_array;

private _bpos =+ d_base_array # 0;
_bpos set [2, 1.9];
[_bpos, [d_base_array # 1, d_base_array # 2, d_base_array # 3, true, 2], [d_enemy_side, "PRESENT", true], ["'Man' countType thislist > 0 || {'Tank' countType thislist > 0 || {'Car' countType thislist > 0}}", "d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'BaseUnderAtack',d_kbtel_chan]", ""]] call d_fnc_createtriggerlocal;
#else
__TRACE_1("","d_sm_bonus_vehicle_array")
d_sm_bonus_vehicle_array set [0, flatten ((d_sm_bonus_vehicle_array # 0) apply {_x call _applyfnc})];
d_sm_bonus_vehicle_array set [1, flatten ((d_sm_bonus_vehicle_array # 1) apply {_x call _applyfnc})];
d_sm_bonus_vehicle_array_o =+ d_sm_bonus_vehicle_array # 1;
d_sm_bonus_vehicle_array_b =+ d_sm_bonus_vehicle_array # 0;
#endif

if (d_MissionType == 2) then {
	0 spawn {
		scriptName "spawn setupserver2";
		while {true} do {
			sleep 9;
			if (d_all_sm_res) exitWith {
				sleep 10;
				d_the_end = true; publicVariable "d_the_end";
				0 spawn d_fnc_DomEnd;
			};
		};
	};
};

0 spawn d_fnc_cleanerfnc;

diag_log "Internal D Version: 4.60";

private _av_check_fnc = {
	_this addEventHandler ["handleDamage", {call d_fnc_pshootatarti;0}];
	_this lockDriver true;
	_this lock 2;
	
	if (!isNull (driver _this)) then {
		_this deleteVehicleCrew (driver _this);
		_this lockDriver true;
		_this lock 2;
	};
	
	{
		_x addEventHandler ["handleDamage", {0}];
		_x setCaptive true;
	} forEach (crew _this);
	
	_this setPos [getPosASL _this # 0, getPosASL _this # 1, 0.5];
	_this addEventhandler ["fired", {call d_fnc_casfired}];
	_this addEventhandler ["fired", {call d_fnc_arifired}];
	[_this, 2] spawn d_fnc_disglobalsim;
};

private _fnc_artvec = {
	params ["_num", "_name", ["_side", sideUnknown]];
	private _retar = vehicles select {(str _x) select [0, _num] == _name};
	if (_retar isNotEqualTo []) then {
		{
			_x call _av_check_fnc;
			if (_side isNotEqualTo sideUnknown) then {
				_x setVariable ["d_fside", _side];
			};
		} forEach _retar;
	};
	_retar
};

#ifndef __TT__
d_arty_vecs = [10, "d_artyvec_"] call _fnc_artvec;
#else
d_arty_vecsb = [11, "d_artyvecb_", blufor] call _fnc_artvec;
d_arty_vecso = [11, "d_artyveco_", opfor] call _fnc_artvec;
#endif

{
	[_x, 300, false] spawn d_fnc_vehirespawn;
} forEach (vehicles select {(str _x) select [0, 10] == "d_add_vec_"});

if (d_with_ranked) then {
	0 spawn {
		scriptName "spawn clearWeaponCargo global";
		sleep 10;
		{
			clearWeaponCargoGlobal _x;
			sleep 0.2;
		} forEach vehicles;
	};
};

#ifndef __IFA3LITE__
0 spawn d_fnc_scheck_uav;
#endif

0 spawn {
	scriptname "spawn sendfpssetupserver";
	sleep 10;
	["dom_sendfps", {
		diag_fps remoteExecCall ["d_fnc_dfps", [0, -2] select isDedicated];
	}, 3] call d_fnc_eachframeadd;
};
