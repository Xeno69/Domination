// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_obj"];
_obj removeAllEventHandlers "killed";
private _trig = _obj getVariable "d_bar_trig";
if (!isNil "_trig") then {
	deleteVehicle _trig;
};
private _mt_done = _obj getVariable ["d_mt_done", false];
__TRACE_1("","_mt_done")
if (!_mt_done) then {
	d_num_barracks_objs = d_num_barracks_objs - 1;
	d_groups_respawn_time_add = d_groups_respawn_time_add + 30 + (random 10);
	private _numob = {alive _x} count d_mt_barracks_obj_ar;
	if (_numob != d_num_barracks_objs) then {
		d_num_barracks_objs = _numob;
	};
	publicVariable "d_num_barracks_objs";
	__TRACE_1("","d_num_barracks_objs")
};
if (d_num_barracks_objs == 0) then {
	if (!_mt_done) then {
		d_mt_barracks_down = true;
#ifndef __TT__
		[51] call d_fnc_DoKBMsg;
#else
		[57] call d_fnc_DoKBMsg;
#endif
	};
} else {
	if (!_mt_done) then {
#ifndef __TT__
		[55, d_num_barracks_objs] call d_fnc_DoKBMsg;
#else
		[58, d_num_barracks_objs] call d_fnc_DoKBMsg;
#endif
	};
};
d_mt_barracks_obj_ar = d_mt_barracks_obj_ar - [_obj, objNull];
__TRACE_1("","d_mt_barracks_obj_ar")

if (!_mt_done) then {
	private _killer = _this # 2;
	if (isNull _killer) then {
		if (!d_with_ace) then {
			_killer = _obj getVariable ["d_last_damager", _killer];
		} else {
			_killer = _obj getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};
	if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
		[_killer, 1] call d_fnc_addScore;
#ifdef __TT__
		[d_tt_points # 2, _killer, false] call d_fnc_AddPoints;
		if (side (group _killer) == blufor) then {
			[59, "WEST"] call d_fnc_DoKBMsg
		} else {
			if (side (group _killer) == opfor) then {
				[59, "EAST"] call d_fnc_DoKBMsg
			};
		};
#endif
	};
};

if (!d_vn && {(typeOf _obj) == d_barracks_building}) then {
	_obj spawn {
		scriptName "spawn checkmtrestkilled0 1";
		private _epos = _this getVariable "d_v_pos";
		private _edir = getDir _this;
		private _vup = vectorUp _this;
		deleteVehicle _this;
		private _obj = createVehicle ["Land_Slum_House02_ruins_F", _epos, [], 0, "NONE"];
		_obj setDir _edir;
		_obj setPos _epos;
		_obj setVectorUp _vup;
		sleep (10 + random 10);
		_obj setDamage 0;
		deleteVehicle _obj;
	};
} else {
	_obj spawn {
		scriptName "spawn checkmtrestkilled0 2";
		sleep (10 + random 10);
		_this setDamage 0;
		deleteVehicle _this;
	};
};