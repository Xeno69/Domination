// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_uid", "_id"];

__TRACE_1("","_this")

if (_uid isEqualTo "") exitWith {};

private _val = d_placed_objs_hash getOrDefault [_uid, []];
if (_val isNotEqualTo []) then {
	__TRACE_1("1","_val")
	{
		__TRACE_1("","_x")
		deleteMarker (_x # 1);
		(_x # 1) remoteExecCall ["deleteMarkerLocal", [0, -2] select isDedicated];
		if (!isNull (_x # 0)) then {
			private _content = (_x # 0) getVariable ["d_objcont", []];
			__TRACE_1("","_content")
			if (_content isNotEqualTo []) then {
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
	d_placed_objs_hash deleteAt _uid;
};

_val = d_placed_objs_hash2 getOrDefault [_uid, []];
if (_val isNotEqualTo []) then {
	__TRACE_1("2","_val")
	{
		if (unitIsUAV _x) then {
			deleteVehicleCrew _x;
		};
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_hash2 deleteAt _uid;
};

_val = d_placed_objs_hash3 getOrDefault [_uid, []];
if (_val isNotEqualTo []) then {
	__TRACE_1("3","_val")
	{
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_hash3 deleteAt _uid;
};

_val = d_placed_objs_hash4 getOrDefault [_uid, []];
if (_val isNotEqualTo []) then {
	__TRACE_1("4","_val")
	{
		deleteVehicle _x;
	} forEach (_val select {!isNull _x});
	d_placed_objs_hash4 deleteAt _uid;
};

private _searchfor = "_USER_DEFINED #" + _id + "/";
__TRACE_1("","_searchfor")
{
	deleteMarker _x;
	sleep 0.01;
} forEach (allMapMarkers select {_x find _searchfor > -1});
