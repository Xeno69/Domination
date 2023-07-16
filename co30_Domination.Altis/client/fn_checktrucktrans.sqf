// by Xeno
#include "..\x_setup.sqf"

private _enterer = _this # 2;
if (_enterer != player) exitWith {};

private _do_msg = true;
#ifdef __TT__
private _d_side = (_this # 0) getVariable "d_side";
if (!isNil "_d_side") then {
	if (d_player_side == blufor && {_d_side == opfor}) then {
		_do_msg = false;
		[localize "STR_DOM_MISSIONSTRING_180", "SIDE"] call d_fnc_HintChatMsg;
	} else {
		if (d_player_side == opfor && {_d_side == blufor}) then {
			_do_msg = false;
			[localize "STR_DOM_MISSIONSTRING_181", "SIDE"] call d_fnc_HintChatMsg;
		};
	};
};
#endif

if (_do_msg) then {
	[1, localize "STR_DOM_MISSIONSTRING_182"] call d_fnc_sideorsyschat;
};
_enterer action ["getOut", _this # 0];

