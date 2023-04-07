// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_idx", "_mt_barracks_obj_ar", "_bara_trig_ar", "_mt_mobile_hq_obj", "_mines_created", "_mtunits"];

{
	if (!isNull _x) then {
		private _trig = _x getVariable "d_bar_trig";
		if (!isNil "_trig") then {
			deleteVehicle _trig;
		};
		_x spawn {
			scriptName "spawn dellstuff";
			sleep (60 + random 60);
			_this setDamage 0;
			deleteVehicle _this;
		};
	};
	sleep 0.1;
} forEach _mt_barracks_obj_ar;

{
	deleteVehicle _x;
} forEach (_bara_trig_ar select {!isNull _x});

if (!isNil "_mt_mobile_hq_obj" && {!isNull _mt_mobile_hq_obj}) then {
	_mt_mobile_hq_obj spawn {
		scriptName "spawn doexechcf2";
		sleep (60 + random 60);
		_this setDamage 0;
		deleteVehicle _this;
	};
};

private _old_units_trigger = [(d_target_names # _idx) # 0, [500, 500, 0, false], [d_enemy_side, "PRESENT", false], ["this", "", ""]] call d_fnc_createtriggerlocal;

{deleteVehicle _x; sleep 0.1} forEach _mines_created;

sleep 90;

__TRACE("90 secs sleep over")

if (!isNil "d_delempty_run") then {
	__TRACE("Waiting for d_delempty_run")
	waitUntil {sleep 1; isNil "d_delempty_run"};
};

d_delstuff_run = true;

__TRACE_1("","list _old_units_trigger")

{
	if !(_x isKindOf "CAManBase") then {
		if ((crew _x) findIf {_x call d_fnc_isplayer} == -1) then {
			_x call d_fnc_DelVecAndCrew;
		} else {
			_x call d_fnc_dpcpbv;
		};
	} else {
		if !(_x call d_fnc_isplayer) then {deleteVehicle _x};
	};
	sleep 0.1;
} forEach ((list _old_units_trigger) unitsBelowHeight 20);

deleteVehicle _old_units_trigger;

_mtunits = _mtunits - [objNull];
sleep 0.1;
__TRACE_1("","_mtunits")
if (d_ai_persistent_corpses != 0) then {
	{
		_x setDamage 1;
		sleep 0.01;
	} forEach _mtunits;
} else {
	{
		deleteVehicle _x;
		sleep 0.1;
	} forEach _mtunits;
};

d_delstuff_run = nil;

__TRACE("Done")
