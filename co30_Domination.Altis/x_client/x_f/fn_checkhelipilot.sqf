// by Xeno
#define THIS_FILE "fn_checkhelipilot.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_listin"];
private _enterer = _listin # 2;
if (_enterer != player) exitWith {};

_listin params ["_vec"];
private _exit_it = false;

#ifdef __TT__
private _d_side = _vec getVariable "d_side";
if (!isNil "_d_side") then {
	if (d_player_side == blufor && {_d_side == opfor}) then {
		_exit_it = true;
		[localize "STR_DOM_MISSIONSTRING_173", "SIDE"] call d_fnc_HintChatMsg;
	} else {
		if (d_player_side == opfor && {_d_side == blufor}) then {
			_exit_it = true;
			[localize "STR_DOM_MISSIONSTRING_174", "SIDE"] call d_fnc_HintChatMsg;
		};
	};
};
#endif

if (!_exit_it && {_listin # 1 == "driver"}) then {
	if (d_pilots_only == 0 && {!(call d_fnc_isPilotCheck)}) exitWith {
		_exit_it = true;
	};
	if (param [1] == 0) then {
		if (d_chophud_on) then {
			player setVariable ["d_hud_id", _vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_176"], {_this call d_fnc_sethud},0,-1,false]];
		} else {
			player setVariable ["d_hud_id", _vec addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_177"], {_this call d_fnc_sethud},1,-1,false]];
		};
		
		[_vec] spawn d_fnc_helilift;
	};
};

if (_exit_it) then {
	_enterer action ["getOut", _vec];
};