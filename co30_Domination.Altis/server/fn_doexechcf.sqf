// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_doexechcf.sqf"
#include "..\x_setup.sqf"

params ["_type"];

if (_type == 0) then {
	0 spawn d_fnc_clearsidemission;
} else {
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
	} forEach d_mt_barracks_obj_ar;
	d_mt_barracks_obj_ar = [];
	if (!isNil "d_bara_trig_ar") then {
		{
			deleteVehicle _x;
		} forEach (d_bara_trig_ar select {!isNull _x});
		d_bara_trig_ar = [];
	};
	if (!isNull d_mt_mobile_hq_obj) then {
		d_mt_mobile_hq_obj spawn {
			scriptName "spawn doexechcf2";
			sleep (60 + random 60);
			_this setDamage 0;
			deleteVehicle _this;
		};
	};
	(_this select 1) execFSM "fsms\fn_DeleteUnits.fsm";
};