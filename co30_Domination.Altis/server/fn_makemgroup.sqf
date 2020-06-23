// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makemgroup.sqf"
#include "..\x_setup.sqf"

params ["_pos", "_unitliste", "_grp", ["_mchelper", true], ["_doreduce", false], ["_unitsPerGroup", -1]];

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

if (d_smallgrps == 0 && {_doreduce && {count _unitliste > 2}}) then {
	__TRACE("in doreduce")
	private _nump = count (allPlayers - entities "HeadlessClient_F");
	// 30-40 0.15
	// 20-30 0.2
	// 1-20 0.26
	private _factor = call {
		if (_nump > 29) exitWith {
			0.15
		};
		if (_nump > 19) exitWith {
			0.2
		};
		0.26
	};
	
	
	private _maxunits = 99;
	
	if (_unitsPerGroup > 0) then {
    	_maxunits = _unitsPerGroup;
    } else {
    	_maxunits = round (_factor * _nump) max (selectRandom [2, 3]);
    };
	
	__TRACE_3("","_nump","_factor","_maxunits")
	if (_maxunits < count _unitliste) then {
		private _tmpar =+ _unitliste;
		_unitliste = [_tmpar # 0];
		_tmpar deleteAt 0;
		while {count _unitliste < _maxunits} do {
			_unitliste pushBack (selectRandom _tmpar);
		};
	};
	__TRACE_1("after","_unitliste")
};

_ret resize (count _unitliste);

private _subskill = if (diag_fps > 29) then {
	(0.1 + (random 0.2))
} else {
	(0.12 + (random 0.04))
};

if (!_mchelper) then {
	private _nnpos = _pos findEmptyPosition [0, 30, _unitliste # 0];
	if !(_nnpos isEqualTo []) then {_pos = _nnpos};
};

private _nightorfog = call d_fnc_nightfograin;

{
	private _one_unit = _grp createUnit [_x, _pos, [], 10, "NONE"];
	//if (d_with_dynsim == 1) then {
	if (_mchelper) then {
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
	
#ifdef __GROUPDEBUG__
	// does not subtract if a unit dies!
	if (side _grp == d_side_enemy) then {
		d_infunitswithoutleader = d_infunitswithoutleader + 1;
	};
#endif
	private _bino = binocular _one_unit;
	__TRACE_1("","_bino")
	if !(_bino isEqualTo "") then {
		_one_unit removeWeapon _bino;
	};
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
#ifndef __TT__
if (d_ai_awareness_rad > 0 || {d_snp_aware > 0 || {d_ai_pursue_rad > 0 || {d_ai_aggressiveshoot > 0}}}) then {
	//advanced awareness
	if (["Sniper", groupId(_grp)] call BIS_fnc_inString) then {
		{
			[_x, d_side_player, 1400, d_ai_pursue_rad, d_ai_aggressiveshoot, d_ai_quickammo] spawn d_fnc_hallyg_dlegion_Snipe_awareness;
		} forEach units _grp;
	} else {
		{
			[_x, d_side_player, d_ai_awareness_rad, d_ai_pursue_rad, d_ai_aggressiveshoot, d_ai_quickammo] spawn d_fnc_hallyg_dlegion_Snipe_awareness;
		} forEach units _grp;
	}
};
_ret call d_fnc_addceo;
#endif
_ret
