// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getbymarkersm.sqf"
#include "..\x_setup.sqf"

params ["_cur_sm_idx"];

private _sm_ar = d_sm_store getVariable (str (_cur_sm_idx - 50000));
__TRACE_1("","_sm_ar")
if (isNil "_sm_ar") then {
	diag_log format ["Side mission idx %1 not found!!!!", _cur_sm_idx];
};

if (tolower (_sm_ar # 1) != "tankdepot") then {
	d_x_sm_pos = _sm_ar # 2;
} else {
	d_x_sm_pos = (_sm_ar # 2) # 0;
};
d_x_sm_type = _sm_ar # 1;
__TRACE_1("","d_x_sm_pos")
__TRACE_1("","d_x_sm_type")

if (hasInterface) then {
	d_cur_sm_txt = localize ("STR_DOM_MISSIONSTRING_" + (_sm_ar # 5));
	d_current_mission_resolved_text = localize ("STR_DOM_MISSIONSTRING_" + (_sm_ar # 6));
	__TRACE_1("","d_cur_sm_txt")
	__TRACE_1("","d_current_mission_resolved_text")
};

if !(isServer) exitWith {};

private _boolorarrayfnc = {
	if (_this isEqualType false) then {
		_this
	} else {
		if (_this isEqualType []) then {
			_this isEqualTo []
		} else {
			false
		};
	};
};

switch (tolower (_sm_ar # 1)) do {
	case "convoy": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_x_sm_pos # 1, _sm_ar # 7] spawn d_fnc_sideconvoy;
		};
	};
	case "stealflag": { // creates armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos] spawn d_fnc_sideflag;
		};
	};
	case "tankdepot": { // creates armor and inf in common file
		if (isServer) then {
			private _posis = [];
			private _dirs = [];
			{
				_posis pushBack (_x # 0);
				_dirs pushBack (_x # 1);
			} forEach (_sm_ar # 2);
			[_posis, _dirs] spawn d_fnc_sidetanks;
		};
	};
	case "arrest": { // does create armor and inf in common file if param 1 and 2 are set to true
		if (isServer) then {
			[objNull, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidearrest;
		};
	};
	case "artibase": { // creates armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos # 0] spawn d_fnc_sidearti;
		};
	};
	case "deliver": { // creates armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos # 0, d_x_sm_pos # 1, markerDir "d_sm_loga", _sm_ar # 7] spawn d_fnc_sidedeliver;
		};
	};
	case "evac": { // no need to create armor and inf
		if (isServer) then {
			private _time = if (count _sm_ar > 8) then {
				_sm_ar # 8
			} else {
				15
			};
			[d_x_sm_pos, time + ((_time * 60) + random 60)] spawn d_fnc_sideevac;
		};
	};
	case "radiotower": { // does NOT create armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos # 0, d_illum_tower, _sm_ar # 7, true, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "prisoners": { // creates armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos] spawn d_fnc_sideprisoners;
		};
	};
	case "stealchopper": { // does NOT create armor and inf in common file
		if (isServer) then {
			[objNull, d_x_sm_pos # 0, _sm_ar # 7, d_sm_chopper, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidesteal;
		};
	};
	case "stealtank": { // does NOT create armor and inf in common file
		if (isServer) then {
			[objNull, d_x_sm_pos # 0, _sm_ar # 7, d_sm_tank, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidesteal;
		};
	};
	case "stealapc": { // does NOT create armor and inf in common file
		if (isServer) then {
			[objNull, d_x_sm_pos # 0, _sm_ar # 7, d_sm_apc, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidesteal;
		};
	};
	case "stealplane": { // does NOT create armor and inf in common file
		if (isServer) then {
			[objNull, d_x_sm_pos # 0, _sm_ar # 7, d_sm_plane, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidesteal;
		};
	};
	case "specops": { // no need to create armor and inf
		if (isServer) then {
			private _radius = if (count _sm_ar > 8) then {
				_sm_ar # 8
			} else {
				150
			};
			[d_x_sm_pos # 0, _radius] spawn d_fnc_sidespecops;
		};
	};
	case "eliminateofficer": {
		if (isServer) then {
			[d_x_sm_pos # 0, _sm_ar # 7, d_soldier_officer, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideelimofficer;
		};
	};
	case "eliminategovmember": {
		if (isServer) then {
			[d_x_sm_pos # 0, _sm_ar # 7, d_soldier_officer, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideelimofficer;
		};
	};
	case "eliminatesniper": {
		if (isServer) then {
			[d_x_sm_pos # 0, _sm_ar # 7, d_sniper, true, false, false, true] spawn d_fnc_sideelimofficer;
		};
	};
	case "fuelstation": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_fuel_station, _sm_ar # 7, true, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "transformer": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_sm_land_transformer, _sm_ar # 7, true, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "barracks": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_sm_barracks, _sm_ar # 7, true, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "hangar": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_sm_hangar, _sm_ar # 7, true, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "cargotruck": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_sm_cargo, _sm_ar # 7, false, true, true, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "minesland": { // does NOT create armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos # 0, "land", (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidemines;
		};
	};
	case "minesnaval": { // does NOT create armor and inf in common file
		if (isServer) then {
			[d_x_sm_pos # 0, "naval", (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidemines;
		};
	};
	case "artycannon": {
		if (isServer) then {
			[d_x_sm_pos # 0, d_sm_arty, _sm_ar # 7, false, true, true, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "dataterminal": {
		if (isServer) then {
			[d_x_sm_pos # 0, _sm_ar # 7, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidetransferdata;
		};
	};
	case "device": {
		if (isServer) then {
			[d_x_sm_pos # 0, "Land_Device_assembled_F", _sm_ar # 7, false, false, true, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobject;
		};
	};
	case "sam": {
		if (isServer) then {
			private _samtypes = 
#ifdef __OWN_SIDE_OPFOR__
			["B_SAM_System_03_F", "B_Radar_System_01_F"];
#endif
#ifdef __OWN_SIDE_BLUFOR__
			["O_SAM_System_04_F", "O_Radar_System_02_F"];
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
			["B_SAM_System_03_F", "B_Radar_System_01_F"];
#endif
			[d_x_sm_pos # 0, random 360, _samtypes, false, false, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sideobjects;
		};
	};
	case "cache": {
		if (isServer) then {
			[d_x_sm_pos # 0, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc] spawn d_fnc_sidecache;
		};
	};
	case "trucks": {
		if (isServer) then {
			[d_x_sm_pos # 0, _sm_ar # 7, [d_sm_ammotrucktype, d_sm_fueltrucktype, d_sm_cargotrucktype], false, true, (_sm_ar # 3) call _boolorarrayfnc, (_sm_ar # 4) call _boolorarrayfnc, true, true] spawn d_fnc_sideobjects;
		};
	};
};

if (isServer && {tolower (_sm_ar # 1) != "convoy"}) then {
	if ((_sm_ar # 3) isEqualType [] && {!((_sm_ar # 3) isEqualTo [])}) then {
		(_sm_ar # 3) spawn {
			scriptName "spawn_getbymarkersmarmor";
			__TRACE("Creating armor")
			{
				_x spawn d_fnc_CreateArmor;
				sleep 1.03;
			} forEach _this;
		};
	};
	if ((_sm_ar # 4) isEqualType [] && {!((_sm_ar # 4) isEqualTo [])}) then {
		(_sm_ar # 4) spawn {
			scriptName "spawn_getbymarkersminf";
			__TRACE("Creating inf")
			{
				_x spawn d_fnc_CreateInf;
				sleep 1.03;
			} forEach _this;
		};
	};
};
