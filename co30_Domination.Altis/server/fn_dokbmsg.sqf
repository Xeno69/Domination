// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

__TRACE_1("","owner d_kb_logic1");
__TRACE_1("","owner d_kb_logic2");

// some kb messages should always be played even if isStreamFriendlyUi is true 
private _always_dokbmsg = [
	61, // DangerMortarsNoText
	62 // DangerAirstrikeNoText
	];

if (isNil "d_kb_hash") exitWith {};

if (d_force_isstreamfriendlyui != 1 || {_num in _always_dokbmsg}) then {
	params ["_num", ["_val1", ""], ["_val2", ""]];
	[_val1, _val2] call (d_kb_hash get _num);
};