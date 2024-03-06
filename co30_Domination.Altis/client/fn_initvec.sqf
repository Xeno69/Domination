// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
#define __vecmarker _vec setVariable ["d_ma_text", _car select 5]; \
_vec setVariable ["d_ma_type", getText (configFile >>"CfgMarkers">>(_car select 3)>>"icon")]; \
_vec setVariable ["d_ma_color", d_color_hash get (_car select 4)]; \
_vec setVariable ["d_icon_type", getText ((configOf _vec)>>"icon")]; \
_vec setVariable ["d_icon_size", 28];

#define __chopmarker _vec setVariable ["d_ma_text", _car select 6]; \
_vec setVariable ["d_ma_type", getText (configFile >>"CfgMarkers">>(_car select 4)>>"icon")]; \
_vec setVariable ["d_ma_color", d_color_hash get (_car select 5)]; \
_vec setVariable ["d_icon_type", getText ((configOf _vec)>>"icon")]; \
_vec setVariable ["d_icon_size", 28];

#define __chopset private _index = _car select 1;\
_vec setVariable ["d_choppertype", _index];\
_vec setVariable ["d_vec_type", "chopper"];\
call {\
	if (_index == 0) exitWith {_vec addEventHandler ["getin", {[_this,0] call d_fnc_checkhelipilot}]};\
	if (_index == 1) exitWith {_vec addEventHandler ["getin", {call d_fnc_checkhelipilot_wreck}]};\
	if (_index == 2) exitWith {_vec addEventHandler ["getin", {[_this,1] call d_fnc_checkhelipilot}]};\
};\
_vec addEventHandler ["getOut", {call d_fnc_checkhelipilotout}]

#define __vecname _vec setVariable ["d_vec_name", _car select 6]
#define __chopname _vec setVariable ["d_vec_name", _car select 7]
#define __pvecs private _fidx = d_p_vecs findIf {_x select 1 == _d_vec}; if (_fidx > -1) then {_car = d_p_vecs select _fidx}

#define __staticl \
_vec addAction[format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_256"], {_this spawn d_fnc_load_static}, _d_vec, -1, false, true, "","count (_target getVariable ['d_CARGO_AR', []]) < d_max_truck_cargo", 10];\
_vec addAction[format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_257"], {_this spawn d_fnc_unload_static}, _d_vec, -2, false, true, "","isNull objectParent player && {(_target getVariable ['d_CARGO_AR', []]) isNotEqualTo []}", 10]

#define __addchopm _vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_258"], {call d_fnc_vecdialog}, [], -1, false, true, "", "true", 8]

#ifdef __TT__
#define __sidew _vec setVariable ["d_side", blufor]
#define __sidee _vec setVariable ["d_side", opfor]
#define __checkenterer _vec addEventHandler ["getin", {call d_fnc_checkenterer}]
#define __pvecss(sname) private _fidx = d_p_vecs_##sname findIf {_x select 1 == _d_vec}; if (_fidx > -1) then {_car = d_p_vecs_##sname select _fidx}
#endif

if (!hasInterface) exitWith {};

d_marker_vecs = d_marker_vecs - [objNull];

private _vec = _this;

__TRACE_1("","_vec")

private _desm = _vec getVariable ["d_deserted_marker", ""];

if (_desm isNotEqualTo "" && {markerPos _desm isNotEqualTo [0,0,0]}) then {
	[_desm, _vec, "ICON", "ColorBlack", [1, 1], format [localize "STR_DOM_MISSIONSTRING_260", [_vec] call d_fnc_GetDisplayName], 0, "hd_dot"] call d_fnc_CreateMarkerLocal;
};

private _d_vec = _vec getVariable "d_vec";
if (isNil "_d_vec") exitWith {};

__TRACE_1("","_d_vec")

if (!isNil {_vec getVariable "d_vcheck"}) exitWith {};
_vec setVariable ["d_vcheck", true];

if (isNil {_vec getVariable "d_canloadbox"}) then {
	_vec setVariable ["d_canloadbox", toLowerANSI (typeOf _vec) in d_check_ammo_load_vecs];
};

if (_d_vec isEqualType []) exitWith {
	__TRACE_1("","_d_vec")
	private _p_side = [d_player_side, side (group player)] select (isNil "d_player_side");
	_d_vec params ["_ma_type", "_ma_text", "_ma_col", ["_vside", _p_side]];
	__TRACE_2("","_vside","d_player_side")
	if (_vside getFriend _p_side >= 0.6) then {
		__TRACE_1("","_ma_text")
		if (_ma_text isNotEqualTo "") then {
			_vec setVariable ["d_ma_text", _ma_text];
		} else {
			_vec setVariable ["d_ma_text", ""];
		};
		if (_ma_type isNotEqualTo "") then {
			_vec setVariable ["d_ma_type", getText (configFile >>"CfgMarkers">>_ma_type>>"icon")];
			_vec setVariable ["d_ism_vec", true];
		};
		_vec setVariable ["d_icon_type", getText ((configOf _vec)>>"icon")];
		if (_ma_col isNotEqualTo "") then {
			_vec setVariable ["d_ma_color", d_color_hash get _ma_col];
		};
		d_marker_vecs pushBack _vec;
		__TRACE_1("","d_marker_vecs")
	};
};

if (_d_vec < 100) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		_vec setVariable ["d_mhq_txt", "MHQ" +  (_car # 5)];
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
		d_mhq_3ddraw = d_mhq_3ddraw - [objNull];
		d_mhq_3ddraw pushBack _vec;
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
			d_mhq_3ddraw = d_mhq_3ddraw - [objNull];
			d_mhq_3ddraw pushBack _vec;
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (isNil {_vec getVariable "d_canloadbox"}) then {
		_vec setVariable ["d_canloadbox", true];
	};
	d_check_ammo_load_vecs pushBackUnique toLowerANSI (typeOf _vec);
#ifdef __TT__
	if (d_player_side == blufor) then {
#endif
	_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_262"], {call d_fnc_vecdialog}, _d_vec, -1, false, true, "", "alive _target", 7];
	if (d_with_bis_dynamicgroups == 0) then {
		_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_552"], {call d_fnc_showdynamicgroupsdialog}, _d_vec, -1, false, true, "", "alive _target", 7];
	};
	_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_304"], {0 call d_fnc_DomCommandingMenuExec}, _d_vec, -1, false, true, "", "alive _target", 7];
	player reveal _vec;
#ifdef __TT__
	} else {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec setVariable ["d_vec_type", "MHQ"];
#ifdef __TT__
	__sidew;
	_vec addEventHandler ["getin", {call d_fnc_checkdriver}];
#endif
	if (!isServer) then {
		_vec addEventHandler ["handleDamage", {call d_fnc_pshootatmhq}];
	};
	if (isMultiplayer && {_vec isKindOf "Air" && {d_uids_def_choppers isNotEqualTo []}}) then {
		_vec addEventhandler ["getIn", {call d_fnc_chopcheck}];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 200) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
			if (d_with_ace) then {
				_vec setVariable ["ace_medical_medicClass", 1];
			};
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __TT__
	__sidew;
	__checkenterer;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 300) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __TT__
	__sidew;
	__checkenterer;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 400) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (!d_no_ai || {player getUnitTrait "engineer"}) then {
		__staticl;
	} else {
		_vec addEventHandler ["getin", {call d_fnc_checktrucktrans}];
	};
	_vec setVariable ["d_vec_type", "Engineer"];
#ifdef __TT__
	__sidew;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 500) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __TT__
	__sidew;
	__checkenterer;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 600) exitWith {
	private _car = [];
#ifndef __TT__
	__pvecs;
#else
	__pvecss(blufor);
#endif
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
#endif
		__vecname;
	};
	if (!alive _vec) exitWith {};
#ifdef __TT__
	__sidew;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	_vec addEventHandler ["getin", {call d_fnc_checkdriver_wreck}];
	_vec setVariable ["d_s2fly", true];
};

#ifdef __TT__
if (_d_vec < 1100) exitWith {
	private _car = [];
	__pvecss(opfor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		_vec setVariable ["d_mhq_txt", "MHQ " +  (_car # 5)];
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
			d_mhq_3ddraw = d_mhq_3ddraw - [objNull];
			d_mhq_3ddraw pushBack _vec;
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (d_player_side == opfor) then {
		_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_262"], {call d_fnc_vecdialog}, _d_vec, -1, false, true, "", "alive _target", 7];
		if (d_with_bis_dynamicgroups == 0) then {
			_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_552"], {call d_fnc_showdynamicgroupsdialog}, _d_vec, -1, false, true, "", "alive _target", 7];
		};
		_vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_304"], {0 call d_fnc_DomCommandingMenuExec}, _d_vec, -1, false, true, "", "alive _target", 7];
		player reveal _vec;
	};
	_vec setVariable ["d_vec_type", "MHQ"];
	if (isNil {_vec getVariable "d_canloadbox"}) then {
		_vec setVariable ["d_canloadbox", true];
	};
	d_check_ammo_load_vecs pushBackUnique toLowerANSI (typeOf _vec);
	__sidee;
	_vec addEventHandler ["getin", {call d_fnc_checkdriver}];
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	if (!isServer) then {
		_vec addEventHandler ["handleDamage", {call d_fnc_pshootatmhq}];
	};
	if (isMultiplayer && {_vec isKindOf "Air" && {d_uids_def_choppers isNotEqualTo []}}) then {
		_vec addEventhandler ["getIn", {call d_fnc_chopcheck}];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 1200) exitWith {
	private _car = [];
	__pvecss(opfor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
			if (d_with_ace) then {
				_vec setVariable ["ace_medical_medicClass", 1];
			};
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	__sidee;
	__checkenterer;
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 1300) exitWith {
	private _car = [];
	__pvecss(opfor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	__sidee;
	__checkenterer;
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 1400) exitWith {
	private _car = [];
	__pvecss(opfor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	if (!d_no_ai || {player getUnitTrait "engineer"}) then {
		__staticl;
	} else {
		_vec addEventHandler ["getin", {call d_fnc_checktrucktrans}];
	};
	_vec setVariable ["d_vec_type", "Engineer"];
	__sidee;
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 1500) exitWith {
	private _car = [];
	__pvecss(opfor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	__sidee;
	__checkenterer;
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	_vec setVariable ["d_s2fly", true];
};

if (_d_vec < 1600) exitWith {
	private _car = [];
	__pvecss(blufor);
	if (_car isNotEqualTo []) then {
		missionNamespace setVariable [_car # 0, _vec];
		if (!alive _vec) exitWith {};
		__vecmarker;
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
		__vecname;
	};
	if (!alive _vec) exitWith {};
	__sidew;
	_vec addEventHandler ["getin", {call d_fnc_checkdriver_wreck}];
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	_vec setVariable ["d_s2fly", true];
};
#endif


if (_d_vec < 4000) exitWith {
	private _car = [];
#ifndef __TT__
	private _fidx = d_choppers findIf {_x # 3 == _d_vec}; if (_fidx > -1) then {_car = d_choppers # _fidx};
#else
	private _fidx = d_choppers_blufor findIf {_x # 3 == _d_vec}; if (_fidx > -1) then {_car = d_choppers_blufor # _fidx};
#endif
	__TRACE_1("","_car")
	if (_car isNotEqualTo []) then {
		if (!alive _vec) exitWith {};
		missionNamespace setVariable [_car # 0, _vec];
		__chopname;
		__chopmarker;
#ifndef __TT__
		d_marker_vecs pushBack _vec;
		_vec setVariable ["d_ism_vec", true];
#else
		if (d_player_side == blufor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
#endif
	};
	if (!alive _vec) exitWith {};
	__addchopm;
	__chopset;
#ifdef __TT__
	__sidew;
	if (d_player_side != blufor) then {
		_vec setVariable ["d_liftit", false];
	};
#endif
	if (isMultiplayer && {_vec isKindOf "Air" && {d_uids_def_choppers isNotEqualTo []}}) then {
		_vec addEventhandler ["getIn", {call d_fnc_chopcheck}];
	};
	_vec setVariable ["d_s2fly", true];
};

#ifdef __TT__
if (_d_vec < 5000) exitWith {
	private _car = [];
	private _fidx = d_choppers_opfor findIf {_x # 3 == _d_vec}; if (_fidx > -1) then {_car = d_choppers_opfor # _fidx};
	__TRACE_1("","_car")
	if (_car isNotEqualTo []) then {
		if (!alive _vec) exitWith {};
		missionNamespace setVariable [_car # 0, _vec];
		__chopname;
		__chopmarker;
		if (d_player_side == opfor) then {
			d_marker_vecs pushBack _vec;
			_vec setVariable ["d_ism_vec", true];
		};
	};
	if (!alive _vec) exitWith {};
	__addchopm;
	__chopset;
	__sidee;
	if (d_player_side != opfor) then {
		_vec setVariable ["d_liftit", false];
	};
	if (isMultiplayer && {_vec isKindOf "Air" && {d_uids_def_choppers isNotEqualTo []}}) then {
		_vec addEventhandler ["getIn", {call d_fnc_chopcheck}];
	};
	_vec setVariable ["d_s2fly", true];
};
#endif
