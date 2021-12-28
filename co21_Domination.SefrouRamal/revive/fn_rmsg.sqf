// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

if (_this # 1 != xr_name_player && {_this # 0 != xr_name_player}) then {
	systemChat format [localize "STR_DOM_MISSIONSTRING_913", _this # 1, _this # 0];
};
if (_this # 1 == xr_name_player) then {
	_this spawn {
		scriptName "spawn xr msg";
		sleep 2.7;
		systemChat (format [localize "STR_DOM_MISSIONSTRING_914", _this # 0]);
	};
};
