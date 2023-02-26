// by Xeno
#include "..\x_setup.sqf"

params ["_unit", "_pos", "_vec"];

if (d_ai_no_statics && {_pos == "gunner" && {_vec isKindOf "StaticWeapon"}}) exitWith {
	_unit action ["getOut", _vec];
};

private _out = false;

if (d_ai_alone_in_vehicle == 1) then {
	if (_pos == "driver" && {!(_vec isKindOf "ParachuteBase") && {!(_vec isKindOf "StaticWeapon") && {(crew _vec) findIf {_x call d_fnc_isplayer} == -1}}}) then {
		_unit action ["getOut", _vec];
		hintSilent (localize "STR_DOM_MISSIONSTRING_1852");
		_out = true;
	};
};

if (_out) exitWith {};

if (d_sm_mt_protection > 0) then {
	_unit setVariable ["d_anticas_id_ai", _unit addEventHandler ["firedMan", {
		if ((_this # 6) isKindOf "MissileBase" || {(_this # 6) isKindOf "BombCore" || {(_this # 6) isKindOf "RocketCore"}}) then {
			_this spawn d_fnc_anticas;
		};
	}]];
};
