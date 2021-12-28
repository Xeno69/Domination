// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (!isNull objectParent player) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_274")
};

params ["_vec"];
private _arg = _this # 3;

if (_arg == 0 && {_vec call d_fnc_isVecLocked}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_275")};

if (_arg == 1 && {!(_vec call d_fnc_isVecLocked)}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_276")};

if (_arg == 1 && {_vec getVariable ["d_MHQ_Deployed", false]}) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_277");
};

if (_arg == 0 && {(crew _vec) isNotEqualTo []}) then {{_x action ["getOut", vehicle _x]} forEach ((crew _vec) - [player])};

if (_arg == 0) then {
	[_vec, true] remoteExecCall ["d_fnc_l_v", 2];
	 systemChat (localize "STR_DOM_MISSIONSTRING_278");
} else {
	[_vec, false] remoteExecCall ["d_fnc_l_v", 2];
	systemChat (localize "STR_DOM_MISSIONSTRING_279");
};

d_adm_currentvec = objNull;
_vec removeAction (_this # 2);
d_admin_idd =  -9999;
