// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_movecheck.sqf"
#include "..\x_setup.sqf"

private _opos = getPosWorld player;
private _m = 0;
private _lvm = 0;
private _avm = 0;
private _svm = 0;
private ["_dst", "_v"];

private _p_distar = _this;

__TRACE_1("","_p_distar")

player setVariable ["d_p_distar", _p_distar];

private _ntime = time + 30 + (random 30);
__TRACE_1("","_ntime")

while {true} do {
	sleep 0.2;
	isNil {
		if (speed player > 0) then {
			_dst = _opos distance2D (getPosWorld player);
			__TRACE_1("","_dst")
			if (isNull objectParent player) then {
				_m = _m + _dst;
			} else {
				_v = vehicle player;
				call {
					if (_v isKindOf "LandVehicle") exitWith {
						_lvm = _lvm + _dst;
					};
					if (_v isKindOf "Air") exitWith {
						_avm = _avm + _dst;
					};
					if (_v isKindOf "Ship") exitWith {
						_svm = _svm + _dst;
					};
				};
			};
		};
		_opos = getPosWorld player;
	};
	sleep 0.01;
	if (time > _ntime) then {
		_p_distar = [(_p_distar # 0) + _m, (_p_distar # 1) + _lvm, (_p_distar # 2) + _avm, (_p_distar # 3) + _svm];
		__TRACE_1("","_p_distar")
		if (_p_distar isNotEqualTo (player getVariable ["d_p_distar", []])) then {
			[player, _p_distar, d_p_rounds] remoteExecCall ["d_fnc_pdistar", 2];
			player setVariable ["d_p_distar", _p_distar];
		};
		_ntime = time + 30 + (random 30);
		__TRACE_1("","_ntime")
	};
};
