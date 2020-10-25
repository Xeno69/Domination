// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createmarkerglobal.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

// create a global marker, returns created marker
// parameters: marker name, marker pos/object), marker shape, marker color, marker size;(optional) marker text, marker dir, marker type, marker brush
// example: ["my marker",  position player, "hd_dot", "ColorBlue", [0.5,0.5]] call d_fnc_CreateMarkerGlobal;
params ["_m_name", "_m_pos", "_m_shape", "_m_col", ["_m_size", [1, 1]], ["_m_text", ""], ["_m_dir", 0], ["_m_type", ""], ["_m_brush", ""], ["_m_alpha", 1]];

if (isNil "_m_pos") exitWith {
	diag_log ["Domination Error: Could not create marker global, _m_pos is nil. Marker name: ", _m_name];
	_m_name
};

if (_m_pos isEqualType [] && {_m_pos isEqualTo []}) exitWith {
	diag_log ["Domination Error: Could not create marker global, position array _m_pos empty. Marker name: ", _m_name];
	_m_name
};

if (_m_pos isEqualType objNull && {isNull _m_pos}) exitWith {
	diag_log ["Domination Error: Could not create marker global, object _m_pos is null. Marker name: ", _m_name, " _m_pos object name: ", _m_pos];
	_m_name
};

if (_m_shape isEqualTo "") exitWith {
	diag_log ["Domination Error: Could not create marker global, marker shape not defined. Marker name: ", _m_name];
	_m_name
};

if (_m_col isEqualTo "") exitWith {
	diag_log ["Domination Error: Could not create marker global, marker color not defined. Marker name: ", _m_name];
	_m_name
};

private _ma = createMarker [_m_name, _m_pos];
_ma setMarkerShapeLocal _m_shape;
_ma setMarkerColorLocal _m_col;
_ma setMarkerSizeLocal _m_size;
if !(_m_text isEqualTo "") then {_ma setMarkerTextLocal _m_text};
if !(_m_dir isEqualTo 0) then {_ma setMarkerDirLocal _m_dir};
if !(_m_type isEqualTo "") then {_ma setMarkerTypeLocal _m_type};
if !(_m_brush isEqualTo "") then {_ma setMarkerBrushLocal _m_brush};
_ma setMarkerAlpha _m_alpha;
_ma