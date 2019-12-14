// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createsecondary.sqf"
#include "..\x_setup.sqf"

__TRACE("Create Secondary")

__TRACE_1("","_this")

params ["_wp_array", "_mtradius", "_trg_center"];

sleep 2.120;

private _mtmhandle = _this spawn d_fnc_getmtmission;

while {true} do {
	sleep 0.321;
	if (scriptDone _mtmhandle) exitWith {};
};

sleep 2.0123;

private _poss = [_trg_center, _mtradius, 3, 1, 0.3, 30, 0] call d_fnc_GetRanPointCircleBig;
private _iccount = 0;
while {_poss isEqualTo []} do {
	_iccount = _iccount + 1;
	_poss = [_trg_center, _mtradius, 3, 1, 0.3, 30, 0] call d_fnc_GetRanPointCircleBig;
	if (_iccount >= 50 && {!(_poss isEqualTo [])}) exitWith {};
};
if (isNil "_poss" || {_poss isEqualTo []}) then {
	_poss = [_trg_center, _mtradius] call d_fnc_getranpointcircle;
};
_poss set [2, 0];
private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
_vec setPos _poss;
_vec setVectorUp [0,0,1];
[_vec] call d_fnc_CheckMTHardTarget;
d_mt_radio_down = false;
["d_main_target_radiotower", _poss,"ICON","ColorBlack",[0.5,0.5],localize "STR_DOM_MISSIONSTRING_521",0,"mil_dot"] call d_fnc_CreateMarkerGlobal;

#ifndef __TT__
[9] call d_fnc_DoKBMsg;
#else
[10] call d_fnc_DoKBMsg;
#endif
sleep 1.0112;

["specops", [_poss], _trg_center, 0, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _mtradius]] call d_fnc_makegroup;

#ifndef __TT__
sleep 1;
[54] call d_fnc_DoKBMsg;
sleep 2.234;
#else
[56] call d_fnc_DoKBMsg;
sleep 2.234;
#endif

d_mt_spotted = false;
d_create_new_paras = false;
#ifndef __TT__
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {scriptName 'spawn createsecondary3';if (!d_create_new_paras) then {d_create_new_paras = true;if !(d_transport_chopper isEqualTo []) then {d_parahhandle = 0 spawn d_fnc_parahandler}};d_mt_spotted = true;[12] call d_fnc_DoKBMsg;0 spawn d_fnc_createambient;sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#else
d_f_check_trigger = ([d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["ANYPLAYER", d_enemy_side + " D", false], ["this", "0 = 0 spawn {scriptName 'spawn createsecondary4';if (!d_create_new_paras) then {d_create_new_paras = true;if !(d_transport_chopper isEqualTo []) then {d_parahhandle = 0 spawn d_fnc_parahandler}};d_mt_spotted = true;[13] call d_fnc_DoKBMsg;0 spawn d_fnc_createambient;sleep 5; deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal);
#endif

sleep 2.234;
#ifndef __TT__
private "_nrcamps";
if (d_enemy_max_camps_count != -1 ) then {
	//max camps is set, overwrite the random value
	_nrcamps = ceil random d_enemy_max_camps_count;
	if (_nrcamps == 0) then {
		_nrcamps = 1;
	};
} else {
	_nrcamps = (ceil random 5) max 3;
};
#else
private _nrcamps = (ceil random 6) max 4;
#endif

d_sum_camps = _nrcamps;

__TRACE_1("","_nrcamps")

private _sizecamp = sizeOf d_wcamp;
__TRACE_1("","_sizecamp")
private _dist_for_points = -1;

private _isFirstCamp = true;

private _parray = [_trg_center, d_cur_target_radius + 200, 4, 1, 0.3, _sizecamp - 2, 0] call d_fnc_GetRanPointCircleBigArray;

for "_i" from 1 to _nrcamps do {
	private _wf = objNull;
	private _poss =+ _trg_center;

	if (d_first_enemy_camp_near_target_center == 1 && {_isFirstCamp}) then {
		//try to place the first camp very close (10m) to the center of the target
		_poss set [2, 0];
		_wf = createVehicle [d_wcamp, _poss, [], 10, "NONE"];
		_wf allowDamage false;
		_wf setDir (_wf getDir _trg_center);
		_wf addEventHandler ["HandleDamage", {0}];
		sleep 0.3;
		_poss = getPosASL _wf;
		_isFirstCamp = false;
	} else {
		private _idx = floor random (count _parray);
		_poss = _parray select _idx;
		__TRACE_1("1","_poss")

		if !(d_currentcamps isEqualTo []) then {
			private _fidx = d_currentcamps findIf {_x distance2D _poss < 130};
			if (_fidx != -1) then {
				private _icounter = 0;
				while {_icounter < 50 || {_fidx != -1}} do {
					_idx = floor random (count _parray);
					_poss = _parray select _idx;
					_fidx = d_currentcamps findIf {_x distance2D _poss < 130};
					_icounter = _icounter + 1;
				};
			};
		};

		_poss set [2, 0];
		_wf = createVehicle [d_wcamp, _poss, [], 0, "NONE"];
		_wf allowDamage false;
		_wf setDir (_wf getDir _trg_center);
		_wf addEventHandler ["HandleDamage", {0}];
		sleep 0.3;
		__TRACE_1("1111","_wf")

		_parray deleteAt _idx;
	};

	__TRACE_1("5","_poss")
	if (d_with_ranked || {d_database_found}) then {
		if (_dist_for_points < _wf distance2D _trg_center) then {
			_dist_for_points = _wf distance2D _trg_center;
		};
		__TRACE_1("","_dist_for_points")
	};
	d_currentcamps pushBack _wf;
	_wf setVariable ["d_SIDE", d_enemy_side, true];
	_wf setVariable ["d_CAPTIME", 40 + (floor random 10), true];
	_wf setVariable ["d_CURCAPTIME", 0, true];
#ifndef __TT__
	_wf setVariable ["d_CURCAPTURER", d_own_side];
#else
	_wf setVariable ["d_CURCAPTURER", ""];
#endif
	_wf setVariable ["d_STALL", false, true];
	_wf setVariable ["d_TARGET_MID_POS", _trg_center];
	_fwfpos = getPosATL _wf;
	_fwfpos set [2, 4.3];
	__TRACE_1("","_fwfpos")
	private _flagPole = createVehicle [d_flag_pole, _fwfpos, [], 0, "NONE"];
	_flagPole setPos _fwfpos;
	_wf setVariable ["d_FLAG", _flagPole, true];
	private _maname = format ["d_camp_%1", _wf];
	__TRACE_2("","_i","_maname")
	[_maname, _poss, "ICON", "ColorBlack", [0.5, 0.5], str _i, 0, d_strongpointmarker] call d_fnc_CreateMarkerGlobal;
	_wf setVariable ["d_camp_mar", _maname];
	_flagPole setFlagTexture (call d_fnc_getenemyflagtex);

#ifndef __TT__
	[_wf, _flagPole] execFSM "fsms\fn_HandleCamps2.fsm";
#else
	[_wf, _flagPole] execFSM "fsms\fn_HandleCampsTT2.fsm";
#endif

	sleep 0.5;

	if (_wf distance2D _trg_center > d_cur_target_radius || {random 100 > 20}) then {
		["specops", [_poss], _trg_center, 0, "guard", d_enemy_side_short, 0, -1.111, 1, [_trg_center, _mtradius]] call d_fnc_makegroup;
	};
};

publicVariable "d_currentcamps";
remoteExecCall ["d_fnc_curcampsclient", [0, -2] select isDedicated];
d_numcamps = count d_currentcamps; publicVariable "d_numcamps";
d_campscaptured = 0; publicVariable "d_campscaptured";

if (d_with_ranked || {d_database_found}) then {
	d_dist_for_points = _dist_for_points + 10;
	publicVariable "d_dist_for_points";
};

#ifndef __TT__
[15, _nrcamps] call d_fnc_DoKBMsg;
#else
[16, _nrcamps] call d_fnc_DoKBMsg;
#endif

if (d_with_minefield == 0 && {random 100 > 70}) then {
	[_mtradius, _trg_center] call d_fnc_minefield;
};

sleep 5.213;
d_main_target_ready = true;
