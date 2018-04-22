// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_heli_local_check.sqf"
#include "..\..\x_setup.sqf"

params ["_chopper", "_local"];

__TRACE_1("","_local")

if (!_local) exitWith {};

__TRACE_1("","_chopper")

private _lon = _chopper getVariable "d_mhq_lift_obj";
__TRACE_1("","_lon")
if (!isNil "_lon") then {
	private _lobj = _lon # 0;
	if (!isNil "_lobj" && {alive _lobj}) then {
		_lobj setVariable ["d_in_air", false, true];
#ifndef __TT__
		private _channel = d_kbtel_chan;
#else
		private _channel = "SIDE";
#endif
		d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "Dmr_available", ["1", "", _lon # 1, []], _channel];
	};
	if (alive _chopper) then {
		_chopper setVariable ["d_mhq_lift_obj", nil, true];
	};
};

private _ropes = _chopper getVariable "d_ropes";
__TRACE_1("","_ropes")
if (!isNil "_ropes") then {
	{ropeDestroy _x;false} count (_ropes select {!isNull _x});
};

private _attached = _chopper getVariable "d_attachedto_v";
__TRACE_1("","_attached")
if (!isNil "_attached") then {
	detach _attached;
	_chopper setVariable ["d_attachedto_v", nil, true];
};

if (alive _chopper) then {
	_chopper setVariable ["d_ropes", nil, true];
};

private _lobm = _chopper getVariable "d_lobm";
__TRACE_1("","_lobm")
if (!isNil "_lobm") then {
	_lobm remoteExecCall ["setMass"];
	if (alive _chopper) then {
		_chopper setVariable ["d_lobm", nil, true];
	};
};
