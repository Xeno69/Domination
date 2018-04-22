// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mapondraw.sqf"
#include "..\..\..\x_setup.sqf"

__TRACE_1("","_this")

//if (!isNil "d_is_sat_on") exitWith {};

params ["_map", "_type"]; // _type = 0 normal map control, 1 = GPS, 2 = custom map resources

//if (_type isEqualTo 0 && {!visibleMap} || {_type isEqualTo 1 && {!visibleGPS}}) exitWith {};

_map = _map param [0];

__TRACE_1("","d_show_player_marker")

if !(d_show_player_marker isEqualTo 0) then {
	private _drawn_v = [];
	{
		private _ap = missionNamespace getVariable _x;
		if (!isNil "_ap" && {!isNull _ap && {!(_ap getVariable ["xr_pluncon", false]) && {isNil {_ap getVariable "xr_plno3dd"}}}}) then {
			private _v = vehicle _ap;
			//private _inv = !(_v isEqualTo _ap);
			private _inv = !isNull objectParent _ap;
			__TRACE_2("","_v","_inv")
			
			private _dodraw = [true, _ap isEqualTo (crew _v # 0)] select _inv;
			if (d_with_ai && {_inv && {!_dodraw && {!(_v getVariable ["d_v_drawn", false]) && {!isPlayer (crew _v # 0)}}}}) then {
				_v setVariable ["d_v_drawn", true];
				_drawn_v pushBack _v;
				_dodraw = true;
			};
			
			__TRACE_1("","_drawn_v")
			__TRACE_1("","_dodraw")
			
			if (_dodraw) then {
				private _text = if !(_type isEqualTo 1) then {
					if (!_inv) then {
						if (d_show_player_marker isEqualTo 1) then {
							[_ap] call d_fnc_gethpname;
						} else {
							if (d_show_player_marker isEqualTo 2) then {
								""
							} else {
								if (d_show_player_marker isEqualTo 3) then {
									format [d_mark_loc280, 9 - round(9 * damage _ap)]
								} else {
									""
								};
							};
						};
					} else {
						//if (player distance2D _v < 3500) then {
							private _crw = crew _v;
							private _nmt = _v getVariable "d_ma_text";
							__TRACE_1("","_nmt")
							if (isNil "_nmt") then {
								_nmt = [typeOf _v, "CfgVehicles"] call d_fnc_GetDisplayName;
								_v setVariable ["d_ma_text", _nmt];
							};
							private _nt = [_nmt, ": "];
							private _ccrwm1 = count _crw - 1;
							{
								if (alive _x) then {
									_nt pushBack (_x call d_fnc_getplayername);
									if (_forEachIndex < _ccrwm1) then {
										_nt pushBack ", ";
									};
								};
							} forEach _crw;
							__TRACE_1("","_nt")
							(_nt joinString "")
						/*} else {
							private _nmt = _v getVariable "d_ma_text";
							if (isNil "_nmt") then {
								_nmt = [typeOf _v, "CfgVehicles"] call d_fnc_GetDisplayName;
								_v setVariable ["d_ma_text", _nmt];
							};
							_nmt
						};*/
					};
				} else {
					""
				};
				
				private _isc = [_v, _ap] call d_fnc_getmapicon;
				
				__TRACE_1("","_isc")
				
				_map drawIcon [
					_isc # 0,
					_isc # 2,
					visiblePositionASL _v,
					_isc # 1,
					_isc # 1,
					getDirVisual _v,
					_text,
					1,
					0.05,
					"puristaMedium", // ROBOTO?
					"right"
				];
				
				if (_inv && {!isNil {_v getVariable "d_ism_vec"}}) then {
					_v setVariable ["d_mvs_not", true];
				};
			};
		};
		false
	} count d_player_entities;
	
	if !(_drawn_v isEqualTo []) then {
		{
			_x setVariable ["d_v_drawn", nil];
			false
		} count _drawn_v;
	};
	
	if (d_with_ai) then {
		{
			private _isc = [_x, _x] call d_fnc_getmapicon;
			
			private _text = if !(_type isEqualTo 1) then {
				if (d_show_player_marker == 1) then {
					_ut = str _x; _ut select [count _ut - 1]
				} else {
					if (d_show_player_marker == 2) then {
						""
					} else {
						if (d_show_player_marker == 3) then {
							format [d_mark_loc280, 9 - round(9 * damage _x)]
						} else {
							""
						};
					};
				};
			} else {
				""
			};
			
			_map drawIcon [
				_isc # 0,
				_isc # 2,
				visiblePositionASL _x,
				_isc # 1,
				_isc # 1,
				getDirVisual _x,
				_text,
				1,
				0.05,
				"puristaMedium", // ROBOTO?
				"right"
			];
			false
		} count ((units (group player)) select {alive _x && {!isPlayer _x && {isNull (objectParent _x)}}});
	};
};

__TRACE_1("","d_marker_vecs")

private _rem = [];
{
	if (!isNull _x) then {
		if (isNil {_x getVariable "d_mvs_not"}) then {
			private _isc = [_x, objNull, true] call d_fnc_getmapicon;
			private _mt = call {
				if (_x getVariable ["d_MHQ_Deployed", false]) exitWith {
					format [d_mark_loc261, _x getVariable "d_ma_text"];
				};
				if (alive _x) exitWith {
					_x getVariable "d_ma_text"
				};
				format [d_mark_loc1825, _x getVariable "d_ma_text"];
			};
			_map drawIcon [
				_isc # 0,
				_isc # 2,
				visiblePositionASL _x,
				_isc # 1,
				_isc # 1,
				getDirVisual _x,
				_mt,
				1,
				0.05,
				"puristaMedium",
				"right"
			];
		} else {
			_x setVariable ["d_mvs_not", nil];
		};
	} else {
		_rem pushBack _x;
	};
	false
} count d_marker_vecs;

if !(_rem isEqualTo []) then {
	__TRACE_1("","_rem")
	_rem pushBack objNull;
	d_marker_vecs = d_marker_vecs - _rem;
};
