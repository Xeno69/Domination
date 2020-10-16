// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_markercheck.sqf"
#include "..\x_setup.sqf"
if (!isServer) exitWith {};

params ["_uid"];

__TRACE_1("","_uid")

if (_uid isEqualTo "") exitWith {};

private _val = d_placed_objs_store getVariable _uid;
__TRACE_1("1","_val")
if (!isNil "_val") then {
	{
		__TRACE_1("","_x")
		deleteMarker (_x # 1);
		(_x # 1) remoteExecCall ["deleteMarkerLocal", 1];
		if (!isNull (_x # 0)) then {
			private _content = (_x # 0) getVariable ["d_objcont", []];
			__TRACE_1("","_content")
			if !(_content isEqualTo []) then {
				{deleteVehicle _x} forEach _content;
			};
			
			if ((_x # 0) isKindOf d_mash) then {
				private _cof = count d_mashes;
				d_mashes = d_mashes - [_x # 0];
				if (_cof != count d_mashes) then {
					publicVariable "d_mashes";
				};
			} else {
				if ((_x # 0) isKindOf (d_farp_classes # 0)) then {					
					private _cof = count d_farps;
					__TRACE_1("before","d_farps")
					d_farps = d_farps - [_x # 0];
					__TRACE_1("after","d_farps")
					if (_cof != count d_farps) then {
						publicVariable "d_farps";
					};
				};
			};
			deleteVehicle (_x # 0);
		};
	} forEach _val;
	d_placed_objs_store setVariable [_uid, nil];
};

_val = d_placed_objs_store2 getVariable _uid;
__TRACE_1("2","_val")
if (!isNil "_val") then {
	{
		if (unitIsUAV _x) then {
			private _v = _x;
			{_v deleteVehicleCrew _x} forEach (crew _v);
		};
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_store2 setVariable [_uid, nil];
};

_val = d_placed_objs_store3 getVariable _uid;
__TRACE_1("3","_val")
if (!isNil "_val") then {
	{
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_store3 setVariable [_uid, nil];
};

_val = d_placed_objs_store4 getVariable _uid;
__TRACE_1("4","_val")
if (!isNil "_val") then {
	{
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_store4 setVariable [_uid, nil];
};
