// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_doexechcf.sqf"
#include "..\x_setup.sqf"

params ["_type", "_idx", "_mt_barracks_obj_ar", "_bara_trig_ar", "_mt_mobile_hq_obj"];

_mt_barracks_obj_ar =+ _mt_barracks_obj_ar;
_bara_trig_ar =+ _bara_trig_ar;

{
	if (!isNull _x) then {
		private _trig = _x getVariable "d_bar_trig";
		if (!isNil "_trig") then {
			deleteVehicle _trig;
		};
		_x spawn {
			scriptName "spawn doexechcf1";
			sleep (60 + random 60);
			_this setDamage 0;
			deleteVehicle _this;
		};
	};
} forEach _mt_barracks_obj_ar;

{
	deleteVehicle _x;
} forEach (_bara_trig_ar select {!isNull _x});

if (!isNull _mt_mobile_hq_obj) then {
	_mt_mobile_hq_obj spawn {
		scriptName "spawn doexechcf2";
		sleep (60 + random 60);
		_this setDamage 0;
		deleteVehicle _this;
	};
};
_idx execFSM "fsms\fn_DeleteUnits.fsm";
