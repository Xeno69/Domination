//#define __DEBUG__
#define THIS_FILE "fn_civilianmodule.sqf"
#include "..\x_setup.sqf"

params ["_trg_center"];

private _civModuleSetVars = {
	_this setVariable ["#capacity",5];
	_this setVariable ["#usebuilding",true];
	_this setVariable ["#terminal",false];
	//_m1 setVariable ["#type",5];
};

if (isNil "d_cur_tgt_civ_modules_presencesafespot") then {
	d_cur_tgt_civ_modules_presencesafespot = [];
};

if (isNil "d_cur_tgt_civ_modules_presenceunit") then {
	d_cur_tgt_civ_modules_presenceunit = [];
};

//create civilian module
private _placeCivilianSpotsAndUnits = {
	//_randomPos = [[[_trg_center, 200]],[]] call BIS_fnc_randomPos;
	_ms1 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,125] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms1 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms1;
	__TRACE_1("","_ms1")
	
	_ms2 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,125] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms2 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms2;
	__TRACE_1("","_ms2")
	
	_ms3 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,125] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms3 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms3;
	__TRACE_1("","_ms3")
	
	_ms4 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,125] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms4 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms4;
	__TRACE_1("","_ms4")
	
	_ms5 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,200] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms5 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms5;
	__TRACE_1("","_ms5")
	
	_ms6 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,200] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms6 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms6;
	__TRACE_1("","_ms6")
	
	_ms7 = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", position nearestBuilding ([[[_trg_center, [0,200] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	_ms7 call _civModuleSetVars;
	d_cur_tgt_civ_modules_presencesafespot pushBack _ms7;
	__TRACE_1("","_ms7")

	_mu1 = _grp createUnit ["ModuleCivilianPresenceUnit_F", position nearestBuilding ([[[_trg_center, [0,50] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	d_cur_tgt_civ_modules_presenceunit pushBack _mu1;
	__TRACE_1("","_mu1")
	
	_mu2 = _grp createUnit ["ModuleCivilianPresenceUnit_F", position nearestBuilding ([[[_trg_center, [0,50] call d_fnc_GetRandomRangeInt]],[]] call BIS_fnc_randomPos), [], 0, "NONE"];
	d_cur_tgt_civ_modules_presenceunit pushBack _mu2;
	__TRACE_1("","_mu2")
};

#ifdef __DEBUG__
diag_log [diag_frameno, diag_ticktime, time, "placing civilians"];

_target_name = d_target_names select d_current_target_index;
_marker_name = format ["d_target_%1", d_current_target_index];
#endif

__TRACE_1("","_this")
__TRACE_1("","d_current_target_index")
__TRACE_1("","_target_name")
__TRACE_1("","_marker_name")

if (isNil "d_cur_tgt_civ_units") then {
	d_cur_tgt_civ_units = [];
};
if (isNil "d_cur_tgt_civ_modules_presence") then {
	d_cur_tgt_civ_modules_presence = [];
};

for "_i" from 0 to d_civ_groupcount do {
#ifdef __DEBUG__
	diag_log [diag_frameno, diag_ticktime, time, format ["civilian for loop, group count _i: %1", _i]];
#endif
	_grp = createGroup civilian;
	
	__TRACE("Placing a civilian module...")
	call _placeCivilianSpotsAndUnits;
	
	private _m = _grp createUnit ["ModuleCivilianPresence_F", [0,0,0], [], 0, "NONE"];
	
	d_cur_tgt_civ_modules_presence pushBack _m;
	
	//_m setVariable ["#debug", true]; // Debug mode on
	 
	_m setVariable ["#area", [_trg_center, 1000, 1000, 0, true, -1]];  // Fixed! this gets passed to https://community.bistudio.com/wiki/inAreaArray 
	_m setVariable ["#useagents", true];
	_m setVariable ["#usepanicmode", false];
	_m setVariable ["#unitcount", d_civ_unitcount];
	_m setVariable ["#onCreated", {
		d_cur_tgt_civ_units pushBack _this;
		_this addEventHandler ["Killed", {
			_this call d_fnc_civmodulekilleh;
		}];
	}];
};