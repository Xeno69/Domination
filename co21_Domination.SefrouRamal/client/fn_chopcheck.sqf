// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

private _enterer = _this # 2;
if (_enterer != player) exitWith {};

params ["_vec"];

private _exit_it = false;
call {
	if ((_this # 1) == "driver") exitWith {
		if !(getPlayerUID player in d_uids_def_choppers) then {
			_exit_it = true;
		};
	};
	if ([_vec, player] call d_fnc_iscopilot) exitWith {
		if !(getPlayerUID player in d_uids_def_choppers) then {
			_exit_it = true;
		};
	};
};

if (_exit_it) exitWith {
	_enterer action ["GetOut", _vec];
	[localize "STR_DOM_MISSIONSTRING_2055", "SIDE"] call d_fnc_HintChatMsg;
};
