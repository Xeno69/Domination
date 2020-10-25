// by Xeno
#define THIS_FILE "fn_getinmanai.sqf"
#include "..\x_setup.sqf"

params ["_unit", "_pos", "_vec"];

if (d_ai_no_statics && {_pos == "gunner" && {_vec isKindOf "StaticWeapon"}}) exitWith {
	_unit action ["getOut", _vec];
};

if (d_ai_alone_in_vehicle == 1) then {
	if (_pos == "driver" && {!(_vec isKindOf "ParachuteBase") && {!(_vec isKindOf "StaticWeapon") && {(crew _vec) findIf {_x call d_fnc_isplayer} == -1}}}) then {
		_unit action ["getOut", _vec];
		hintSilent (localize "STR_DOM_MISSIONSTRING_1852");
	};
};
