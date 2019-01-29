// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmtrespawntarget.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_vec", "_type"]; // type 0 = barracks, 1 = vehicles

if (_type == 0) then {
	_vec addEventHandler ["killed", {
		params ["_obj"];
		_obj removeAllEventHandlers "killed";
		d_num_barracks_objs = d_num_barracks_objs - 1;
		if ({alive _x} count d_mt_barracks_obj_ar != d_num_barracks_objs) then {
			d_num_barracks_objs = {alive _x} count d_mt_barracks_obj_ar;
		};
		__TRACE_1("","d_num_barracks_objs")
		if (d_num_barracks_objs == 0) then {
			d_mt_barracks_down = true;
			if (!isServer) then {
				[missionNamespace, ["d_mt_barracks_down", true]] remoteExecCall ["setVariable", 2];
			};
			[51] remoteExecCall ["d_fnc_DoKBMsg", 2];
		} else {
			[55, d_num_barracks_objs] remoteExecCall ["d_fnc_DoKBMsg", 2];
		};
		d_mt_barracks_obj_ar = d_mt_barracks_obj_ar - [_obj, objNull];
		__TRACE_1("","d_mt_barracks_obj_ar")
		if (d_database_found) then {
			private _killer = _this select 2;
			if (isNull _killer) then {
				if (!d_with_ace) then {
					_killer = _obj getVariable ["d_last_damager", _killer];
				} else {
					_killer = _obj getVariable ["ace_medical_lastDamageSource", _killer];
				};
			};
			if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
				[_killer, 5] remoteExecCall ["addScore", 2];
			};
		};
		if (typeOf _obj isEqualTo "Land_BagBunker_Large_F") then {
			private _epos = _obj getVariable "d_v_pos";
			private _edir = getDir _obj;
			deleteVehicle _obj;
			_obj = createVehicle ["Land_Slum_House02_ruins_F", _epos, [], 0, "NONE"];
			_obj setDir _edir;
			_obj setPos _epos;
			_obj setVectorUp [0,0,1];
		};
		_obj spawn {
			sleep (10 + random 10);
			_this setDamage 0;
			deleteVehicle _this;
		};
	}];
} else {
	_vec addEventHandler ["killed", {
		d_mt_mobile_hq_down = true;
		if (!isServer) then {
			[missionNamespace, ["d_mt_mobile_hq_down", true]] remoteExecCall ["setVariable", 2];
		};
		[53] remoteExecCall ["d_fnc_DoKBMsg", 2];
		(_this select 0) spawn {
			sleep (60 + random 60);
			_this setDamage 0;
			deleteVehicle _this;
		};
		(_this select 0) removeAllEventHandlers "killed";
		if (d_database_found) then {
			private _killer = _this select 2;
			if (isNull _killer) then {
				if (!d_with_ace) then {
					_killer = (_this select 0) getVariable ["d_last_damager", _killer];
				} else {
					_killer = (_this select 0) getVariable ["ace_medical_lastDamageSource", _killer];
				};
			};
			if (!isNull _killer && {_killer call d_fnc_isplayer}) then {
				[_killer, 5] remoteExecCall ["addScore", 2];
			};
		};
	}];
};
_vec addEventHandler ["handleDamage", {_this call d_fnc_CheckMTShotHD}];