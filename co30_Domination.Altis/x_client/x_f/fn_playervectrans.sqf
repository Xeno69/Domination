// by Xeno
#define THIS_FILE "fn_playervectrans.sqf"
#include "..\..\x_setup.sqf"
if (isDedicated) exitWith {};

#define __vaeh _vec addEventHandler
#define __vreh _vec removeEventHandler

private _vec = param [0];
private _eindex = -1;
private _egoindex = -1;
while {d_player_in_vec && {alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}} do {
	if (player == driver _vec) then {
		if (_egoindex == -1) then {
			_egoindex = __vaeh ["getOut", {_this call d_fnc_getOutEHPoints}];
			{
				_x setVariable ["d_TRANS_START", getPosASL _vec];
				false
			} count ((crew _vec) select {_x != player && {_x call d_fnc_isplayer}});
		};
		if (_eindex == -1) then {
			_eindex = __vaeh ["getIn", {if ((param [2]) call d_fnc_isplayer) then {(param [2]) setVariable ["d_TRANS_START", getPosASL (param [0])]}}];
		};
	};
	if (player != driver _vec) then {
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
