// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_movecheck.sqf"
#include "..\x_setup.sqf"

player setVariable ["d_move_opos", getPosWorld player];

private ["_dst", "_v"];

__TRACE_1("","_this")

player setVariable ["d_p_distar", _this];
private _ar2 =+ _this;
player setVariable ["d_p_odistar", _ar2];

private _ntime = time + 30 + (random 30);
__TRACE_1("","_ntime")

while {true} do {
	sleep 0.2;
	isNil {
		if (isNil {player getVariable "d_move_stop"}) then {
			call d_fnc_updatemove;
		};
	};
	sleep 0.1;
	
	if (time > _ntime || {!d_player_canu}) then {
		if ((player getVariable "d_p_odistar") isNotEqualTo (player getVariable "d_p_distar")) then {
			_ar2 =+ (player getVariable "d_p_distar");
			[player, _ar2, d_p_rounds] remoteExecCall ["d_fnc_pdistar", 2];
			player setVariable ["d_p_odistar", _ar2];
		};
		_ntime = time + 30 + (random 30);
		__TRACE_1("","_ntime")
	};
	if (!d_player_canu || {!isNil {player getVariable "d_move_stop"}}) then {
		waitUntil {sleep 0.2; d_player_canu && {isNil {player getVariable "d_move_stop"}}};
		player setVariable ["d_move_opos", getPosWorld player];
		_ntime = time + 30 + (random 30);
	};
};
