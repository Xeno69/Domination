// by Xeno
#include "..\x_setup.sqf"
if (!hasInterface) exitWith {};

#define __vaeh _vec addEventHandler
#define __vreh _vec removeEventHandler

params ["_vec"];
private _eindex = -1;
private _egoindex = -1;
while {d_player_in_vec && {d_player_canu}} do {
	if (player == currentPilot _vec) then {
		if (_egoindex == -1) then {
			_egoindex = __vaeh ["getOut", {call d_fnc_getOutEHPoints}];
			{
				_x setVariable ["d_TRANS_START", getPosASL _vec];
			} forEach ((crew _vec) select {_x != player && {isPlayer _x}});
		};
		if (_eindex == -1) then {
			_eindex = __vaeh ["getIn", {if (isPlayer [_this # 2]) then {(_this # 2) setVariable ["d_TRANS_START", getPosASL (_this # 0)]}}];
		};
	};
	if (player != currentPilot _vec) then {
		if (_eindex != -1) then {
			__vreh ["getIn",_eindex];
			_eindex = -1;
		};
		if (_egoindex != -1) then {
			__vreh ["getOut",_egoindex];
			_egoindex = -1;
		};
	};
	sleep 0.512;
};
if (_eindex != -1) then {
	__vreh ["getIn",_eindex];
};
if (_egoindex != -1) then {
	__vreh ["getOut",_egoindex];
};
