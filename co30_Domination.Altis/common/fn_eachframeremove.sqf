// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_eachframeremove.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_name"];

if (_name in (keys d_ef_hash)) exitWith {
	d_ef_hash deleteAt _name;

	if ((count d_ef_hash) isEqualTo 0) then {
		removeMissionEventHandler ["EachFrame", d_ef_running];
		d_ef_running = nil;
		d_ef_hash = nil;
	};
};

if (_name in (keys d_ef_n_hash)) exitWith {
	removeMissionEventHandler ["EachFrame", d_ef_n_hash get _name];
	d_ef_n_hash deleteAt _name;
	
	if ((count d_ef_n_hash) isEqualTo 0) then {
		d_ef_n_hash = nil;
	};
};

private "_todel";
{
	private _trig = _y;
	__TRACE_2("","_x","_trig")
	private _hm = _trig getVariable "d_trig_hm";
	_hm deleteAt _name;
	if (count _hm == 0) then {
		d_ef_trig_hash deleteAt _x;
		deleteVehicle _trig;
	};
} forEach d_ef_trig_hash;
