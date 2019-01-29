// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_engtrigfnc.sqf"
#include "..\..\x_setup.sqf"

if (alive player && {!(player getVariable ["d_has_sfunc_aid", false]) && {(player call d_fnc_hastoolkit) && {call d_fnc_sfunc}}}) then {
	player setVariable ["d_has_sfunc_aid", true];
	
	__TRACE("has sfunc")
	
	if (!d_eng_can_repfuel && {!(player distance2D D_TR7 < 21 || {player distance2D D_TR8 < 21})}) exitWith {
		hintSilent (localize "STR_DOM_MISSIONSTRING_324");
	};
	
	private _exitit = false;
	if (d_with_ranked || {d_database_found}) then {
		if (score player < d_ranked_a # 0) exitWith {
			[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_325", score player, d_ranked_a # 0];
			_exitit = true;
		};
		if (time >= d_last_base_repair) then {d_last_base_repair = -1};
	};
	if (_exitit) exitWith {};
	
#ifndef __TT__
	if ((d_with_ranked || {d_database_found}) && {player inArea d_base_array && {d_last_base_repair != -1}}) exitWith {
#else
	if ((d_with_ranked || {d_database_found}) && {d_last_base_repair != -1 && {player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}}}) exitWith {
#endif
		[playerSide, "HQ"] sideChat (format [localize "STR_DOM_MISSIONSTRING_326", round (time - d_last_base_repair)]);
	};

#ifndef __TT__
	if ((d_with_ranked || {d_database_found}) && {player inArea d_base_array}) then {d_last_base_repair = time + 300};
#else
	if ((d_with_ranked || {d_database_found}) && {player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}}) then {d_last_base_repair = time + 300};
#endif
	
	d_orig_sfunc_obj = d_objectID2;
	
	private _rep_count = if (d_orig_sfunc_obj isKindOf "Air") then {
		0.05
	} else {
		if (d_orig_sfunc_obj isKindOf "Tank") then {
			0.1
		} else {
			0.2
		};
	};
	private _reptime = ceil (((damage d_orig_sfunc_obj) / _rep_count) max ((1 - (fuel d_orig_sfunc_obj)) / _rep_count));
	
	__TRACE_2("","_rep_count","_reptime")
	
	d_et_dam_sub = damage d_orig_sfunc_obj / 25;
	d_et_fuel_add = (1 - fuel d_orig_sfunc_obj) / 25;
	
	d_actionID2 = [
		/* 0 object */						d_orig_sfunc_obj,
		/* 1 action title */				format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1510"],
		/* 2 idle icon */					"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
		/* 3 progress icon */				"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_reviveMedic_ca.paa",
		/* 4 condition to show */			"isNull objectParent player && {alive _this}",
		/* 5 condition for action */		"isNull objectParent player && {alive _this}",
		/* 6 code executed on start */		{
			hintSilent format [localize "STR_DOM_MISSIONSTRING_327", fuel d_orig_sfunc_obj, damage d_orig_sfunc_obj];
			systemChat format [localize "STR_DOM_MISSIONSTRING_328", [typeOf d_orig_sfunc_obj, "CfgVehicles"] call d_fnc_GetDisplayName];
		},
		/* 7 code executed per tick */		{
			__TRACE_1("tick","_this select 4")
			hintSilent format [localize "STR_DOM_MISSIONSTRING_327", fuel d_orig_sfunc_obj, damage d_orig_sfunc_obj];
			//systemChat format [localize "STR_DOM_MISSIONSTRING_328", [typeOf d_orig_sfunc_obj, "CfgVehicles"] call d_fnc_GetDisplayName];
			private _damage = damage d_orig_sfunc_obj;
			if (_damage > 0) then {
				_damage = _damage - d_et_dam_sub;
				d_orig_sfunc_obj setDamage _damage;
			};
			private _fuel = fuel d_orig_sfunc_obj;
			if (_fuel < 1) then {
				_fuel = _fuel + d_et_fuel_add;
				[d_orig_sfunc_obj, _fuel] remoteExecCall ["setFuel", d_orig_sfunc_obj];
			};
		},
		/* 8 code executed on completion */	{
			d_orig_sfunc_obj setDamage 0;
			[d_orig_sfunc_obj, 1] remoteExecCall ["setFuel", d_orig_sfunc_obj];
			hintSilent format [localize "STR_DOM_MISSIONSTRING_327", fuel d_orig_sfunc_obj, damage d_orig_sfunc_obj];
			systemChat format [localize "STR_DOM_MISSIONSTRING_334", [typeOf d_orig_sfunc_obj, "CfgVehicles"] call d_fnc_GetDisplayName];
			if (d_with_ranked || {d_database_found}) then {
				private _addscore = if (d_orig_sfunc_obj isKindOf "Air") then {
					(d_ranked_a # 1) # 0
				} else {
					if (d_orig_sfunc_obj isKindOf "Tank") then {
						(d_ranked_a # 1) # 1
					} else {
						if (d_orig_sfunc_obj isKindOf "Car") then {
							(d_ranked_a # 1) # 2
						} else {
							(d_ranked_a # 1) # 3
						};
					};
				};
				if (_addscore > 0) then {
					[player, _addscore] remoteExecCall ["addScore", 2];
					[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_333", _addscore];
				};
			};
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[d_orig_sfunc_obj],
		/* 11 action duration */			_reptime,
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd;					
} else {
	if (player getVariable ["d_has_sfunc_aid", false] && {!(call d_fnc_sfunc)}) then {
		__TRACE("sfunc removed")
		if (d_actionID2 != -9999) then {
			[d_orig_sfunc_obj, d_actionID2] call bis_fnc_holdActionRemove;
			d_actionID2 = -9999;
		};
		player setVariable ["d_has_sfunc_aid", false];
	};
};