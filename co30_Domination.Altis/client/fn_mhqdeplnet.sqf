// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_mhq", "_isdeployed"];

if (local _mhq) then {
	_mhq lock _isdeployed;
};
private _name = _mhq getVariable "d_vec_name";
__TRACE_3("","_mhq","_isdeployed","_name")
if (isNil "_name") exitWith {};
#ifdef __TT__
private _vside = _mhq getVariable "d_side";
if (isNil "_vside" || {d_player_side != _vside}) exitWith {};
#endif
if (_isdeployed && {!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}}) then {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_647", _name];
} else {
	if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_648", _name];
	};
};