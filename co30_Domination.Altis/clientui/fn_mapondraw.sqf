// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mapondraw.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_map", "_type"]; // _type = 0 normal map control, 1 = GPS, 2 = custom map resources

_map = _map select 0;

__TRACE_1("","d_show_player_marker")

private _drawdist = d_island_x_max * (ctrlMapScale _map) + 200;
private _mapmid = _map ctrlMapScreenToWorld [0.5, 0.5];

private _fnc_gmi = d_fnc_getmapicon;

if !(d_show_player_marker isEqualTo 0) then {
	private _drawn_v = [];
	private ["_v", "_inv", "_dodraw", "_text", "_crw", "_nmt", "_nt", "_ccrwm1", "_isc", "_vc", "_res"];
	private _w_ai = d_with_ai;
	private _fnc_ispl = d_fnc_isplayer;
	private _s_pl_ma = d_show_player_marker;
	private _fnc_GDN = d_fnc_GetDisplayName;
	private _fnc_ghpn = d_fnc_gethpname;
	{
		_v = vehicle _x;
		if (_v distance2D _mapmid < _drawdist) then {
			_inv = !isNull objectParent _x;
			__TRACE_2("","_v","_inv")
			
			_dodraw = [true, _x isEqualTo (crew _v # 0)] select _inv;
			if (_w_ai && {_inv && {!_dodraw && {!(_v getVariable ["d_v_drawn", false]) && {!((crew _v # 0) call _fnc_ispl)}}}}) then {
				_v setVariable ["d_v_drawn", true];
				_drawn_v pushBack _v;
				_dodraw = true;
			};
			
			__TRACE_1("","_drawn_v")
			__TRACE_1("","_dodraw")
			
			if (_dodraw) then {
				_text = if !(_type isEqualTo 1) then {
					if (!_inv) then {
						if (_s_pl_ma isEqualTo 1) then {
							[_x] call _fnc_ghpn;
						} else {
							if (_s_pl_ma isEqualTo 2) then {
								""
							} else {
								if (_s_pl_ma isEqualTo 3) then {
									format [d_mark_loc280, 9 - round(9 * damage _x)]
								} else {
									""
								};
							};
						};
					} else {
						if (player distance2D _v < 3000) then {
							_vc = _v getVariable "d_vma_c";
							if (isNil "_vc" || {_vc > 7}) then {
								_nmt = _v getVariable "d_ma_text";
								__TRACE_1("","_nmt")
								if (isNil "_nmt") then {
									_nmt = [typeOf _v, "CfgVehicles"] call _fnc_GDN;
									_v setVariable ["d_ma_text", _nmt];
								};
								_nt = [_nmt, ": "];
								_crw = crew _v;
								_ccrwm1 = count _crw - 1;
								{
									if (alive _x) then {
										_nt pushBack (_x call _fnc_gpln);
										if (_forEachIndex < _ccrwm1) then {
											_nt pushBack ", ";
										};
									};
								} forEach _crw;
								_v setVariable ["d_vma_c", 0];
								__TRACE_1("","_nt")
								_res = (_nt joinString "");
								_v setVariable ["d_mac_text", _res];
								_res
							} else {
								_v setVariable ["d_vma_c", _vc + 1];
								_v getVariable "d_mac_text";
							};
						} else {
							private _nmt = _v getVariable "d_ma_text";
							if (isNil "_nmt") then {
								_nmt = [typeOf _v, "CfgVehicles"] call _fnc_GDN;
								_v setVariable ["d_ma_text", _nmt];
							};
							_nmt
						};
					};
				} else {
					""
				};
				
				_isc = [_v, _x] call _fnc_gmi;
				
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
	} forEach (d_allplayers select {!isNull _x && {!(_x getVariable ["xr_pluncon", false]) && {isNil {_x getVariable "xr_plno3dd"}}}});
	
	if !(_drawn_v isEqualTo []) then {
		{
			_x setVariable ["d_v_drawn", nil];
		} forEach _drawn_v;
	};
	
	if (_w_ai) then {
		private ["_isc", "_text"];
		{
			if (_x distance2D _mapmid < _drawdist) then {
				_isc = [_x, _x] call _fnc_gmi;
				
				_text = if !(_type isEqualTo 1) then {
					if (_s_pl_ma == 1) then {
						_ut = str _x; _ut select [count _ut - 1]
					} else {
						if (_s_pl_ma == 2) then {
							""
						} else {
							if (_s_pl_ma == 3) then {
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
			};
		} forEach ((units (group player)) select {alive _x && {!(_x call _fnc_ispl) && {isNull (objectParent _x)}}});
	};
};

__TRACE_1("","d_marker_vecs")

private _rdel = false;
private ["_isc", "_mt"];
{
	if (!isNull _x) then {
		if (_x distance2D _mapmid < _drawdist) then {
			if (isNil {_x getVariable "d_mvs_not"}) then {
				_isc = [_x, objNull, true] call _fnc_gmi;
				__TRACE_1("","_isc")
				_mt = call {
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
			if (!isNil {_x getVariable "d_mvs_not"}) then {
				_x setVariable ["d_mvs_not", nil];
			};
		};
	} else {
		_rdel = true;
	};
} forEach d_marker_vecs;

if (_rdel) then {
	d_marker_vecs = d_marker_vecs - [objNull];
};
