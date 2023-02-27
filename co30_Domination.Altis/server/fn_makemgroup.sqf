// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params [
	["_pos", ""],
	["_unitliste", ""],
	["_grp", ""],
	["_mchelper", true],					// man create helper function for positioning
	["_doreduce", false],					// allows the caller to disable d_smallgrps
	["_unitsPerGroupMax", -1],					// allows the caller to specify max unit count
	["_noAIAwareness", false]		// if true do not add this unit to the AI awareness loop (d_cur_tgt_enemy_units) (only used when AI awareness parameters are enabled)
];

if (isNil "_unitliste") exitWith {
	diag_log ["Attention, _unitlist (param 2) is nil, returning []", "_pos", _pos, "_grp", _grp];
	[]
};

if (_unitliste isEqualTo []) exitWith {
	diag_log ["Attention, _unitlist (param 2) is empty, returning []", "_pos", _pos, "_grp", _grp];
	[]
};

__TRACE_3("","_pos","_unitliste","_grp")
__TRACE_2("","_mchelper","_doreduce")

private _ret = [];

if ((d_smallgrps == 0 && {_doreduce}) || {_unitsPerGroupMax > 0}) then {
	_unitliste = [_unitliste, _unitsPerGroupMax] call d_fnc_ulreduce;
};

_ret resize (count _unitliste);

private _subskill = if (diag_fps < 29 && {d_skillfps == 0}) then {
	(0.12 + (random 0.04))
} else {
	//(0.1 + (random 0.2))
	switch (d_EnemySkill) do {
		case 0: {(0.1 + (random 0.05))};
		case 1: {(0.1 + (random 0.1))};
		case 2: {(0.1 + (random 0.2))};
		case 3: {(0.1 + (random 0.3))};
		case 4: {(0.1 + (random 0.4))};
	};
};

if (!_mchelper) then {
	private _nnpos = _pos findEmptyPosition [0, 30, _unitliste # 0];
	if (_nnpos isNotEqualTo []) then {_pos = _nnpos};
};

private _nightorfog = call d_fnc_nightfograin;

private _women_infantry = [];

#ifdef __OWN_SIDE_BLUFOR__
_women_infantry = [
	"WO_Soldier_lite_F",
	"WO_Soldier_F",
	"WO_Soldier_AR_F",
	"WO_officer_F",
	"WO_Soldier_SL_F",
	"WO_T_Soldier_AR_F",
	"WO_T_Soldier_F",
	"WO_T_Officer_F"
];
#endif

#ifdef __OWN_SIDE_OPFOR__
_women_infantry = [
	"WB_Soldier_lite_F",
	"WB_Soldier_F",
	"WB_Soldier_AR_F",
	"WB_officer_F",
	"WB_Soldier_SL_F",
	"WB_T_Soldier_AR_F",
	"WB_T_Soldier_F",
	"WB_T_Officer_F"
];
#endif

{
	private _one_unit = nil;
	if (_women_infantry isNotEqualTo [] && {d_enable_women_military == 1 && {random 100 > 95 && {(groupId _grp) find "Sniper" == -1}}}) then {
		// if women are enabled, chance unit is a woman, cannot be sniper because there is no sniper class for women
		_one_unit = _grp createUnit [selectRandom _women_infantry, _pos, [], 10, "NONE"];
	} else {
		_one_unit = _grp createUnit [_x, _pos, [], 10, "NONE"];
	};
	// TODO - prevent poison animation sometimes occurs "acinpknlmstpsraswrfldnon" see https://feedback.bistudio.com/T156969
	_one_unit allowDamage false;
	_one_unit setDamage 0;
	//if (d_with_dynsim == 1) then {
	if (_mchelper) then {
		//_one_unit setVehiclePosition [getPosWorld _one_unit, [], 0, "CAN_COLLIDE"];
		_one_unit spawn d_fnc_mchelper;
	};
	//};
#ifdef __TT__
	[_one_unit, 0] call d_fnc_setekmode;
#endif
	if (d_with_ai && {d_with_ranked}) then {
		[_one_unit, 4] call d_fnc_setekmode;
	};
	_one_unit setUnitAbility ((d_skill_array # 0) + (random (d_skill_array # 1)));
	_one_unit setSkill ["aimingAccuracy", _subskill];
	_one_unit setSkill ["spotTime", _subskill];
	_ret set [_forEachIndex, _one_unit];
	_one_unit call d_fnc_removenvgoggles_fak;
	[_one_unit, _nightorfog, true] call d_fnc_changeskill;
	//_one_unit enableStamina false;
	//_one_unit enableFatigue false;
	_one_unit disableAI "RADIOPROTOCOL";	
	
	if (d_ai_persistent_corpses == 0) then {
		removeFromRemainsCollector [_one_unit];
	};

#ifdef __GROUPDEBUG__
	// does not subtract if a unit dies!
	if (side _grp == d_side_enemy) then {
		d_infunitswithoutleader = d_infunitswithoutleader + 1;
	};
#endif
	private _bino = binocular _one_unit;
	__TRACE_1("","_bino")
	if (_bino isNotEqualTo "") then {
		_one_unit removeWeapon _bino;
	};
	_one_unit setDamage 0;
	_one_unit allowDamage true;
} forEach _unitliste;
_ret joinSilent _grp;
#ifdef __TT__
if (d_with_ace) then {
	_grp setVariable ["d_ktypett", 1];
};
#endif
#ifdef __GROUPDEBUG__
if (side _grp == d_side_enemy) then {
	d_infunitswithoutleader = d_infunitswithoutleader - 1;
};
#endif
(leader _grp) setRank "SERGEANT";

if !(_noAIAwareness) then {
	d_cur_tgt_enemy_units append _ret;
};

#ifndef __TT__
_ret call d_fnc_addceo;
#endif
__TRACE_1("","_ret")
_ret
