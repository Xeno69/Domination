// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gettargetbonus.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

private _cur_tar_obj = missionNamespace getVariable format ["d_target_%1", d_current_target_index];

sleep 1.012;

#ifndef __TT__
private _vectypetouse = "";

if (!isNil "_cur_tar_obj" && {!isNull _cur_tar_obj}) then {
	private _vectypesv = _cur_tar_obj getVariable "d_bonusvec";
	if (!isNil "_vectypesv") then {
		_vectypetouse = _vectypesv;
	};
};
if (_vectypetouse == "") then {
	_vectypetouse = selectRandom d_mt_bonus_vehicle_array;
};
private _vec = createVehicle [_vectypetouse, d_bonus_create_pos, [], 0, "NONE"];
if (d_database_found) then {
	d_bonus_vecs_db pushBack _vec;
};
if (unitIsUAV _vec) then {
	private _uavgrp = createVehicleCrew _vec;
	_vec allowCrewInImmobile true;
	if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
	_uavgrp deleteGroupWhenEmpty true;
	[_vec, 7] call d_fnc_setekmode;
} else {
	if (d_with_dynsim == 0) then {
		[_vec, 10] spawn d_fnc_enabledynsim;
	};
};
_vec setVariable ["d_isspecialvec", true, true];
private _endpos = [];
private _dir = 0;
if (_vec isKindOf "Air") then {
	_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
	_dir = (d_bonus_air_positions # d_bap_counter) # 1;
	d_bap_counter = d_bap_counter + 1;
	if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
} else {
	_endpos = (d_bonus_vec_positions # d_bvp_counter) # 0;
	_dir = (d_bonus_vec_positions # d_bvp_counter) # 1;
	d_bvp_counter = d_bvp_counter + 1;
	if (d_bvp_counter > (count d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
	_vec setVariable ["d_liftit", true, true];
};
_vec setDir _dir;
_vec setVehiclePosition [_endpos, [], 0, "NONE"];
[_vec, 11] call d_fnc_setekmode;
if (d_with_ranked) then {
	clearWeaponCargoGlobal _vec;
};
#else
private _vectypetouse_w = "";
private _vectypetouse_e = "";
private _vectypetouse_w_temp = "";
private _vectypetouse_e_temp = "";

if (!isNil "_cur_tar_obj" && {!isNull _cur_tar_obj}) then {
	private _vectypesv = _cur_tar_obj getVariable "d_bonusvec_w";
	if (!isNil "_vectypesv") then {
		_vectypetouse_w_temp = _vectypesv;
	};
	private _vectypesv = _cur_tar_obj getVariable "d_bonusvec_e";
	if (!isNil "_vectypesv") then {
		_vectypetouse_e_temp = _vectypesv;
	};
};

if (_vectypetouse_w_temp == "") then {
	_vectypetouse_w_temp = selectRandom (d_mt_bonus_vehicle_array # 0);
};
if (_vectypetouse_e_temp == "") then {
	_vectypetouse_e_temp = selectRandom (d_mt_bonus_vehicle_array # 1);
};

private _vec = objNull;
private _vec2 = objNull;
private ["_d_bonus_air_positions", "_d_bonus_air_positions2", "_d_bvp_counter", "_d_bvp_counter2", "_d_bap_counter", "_d_bap_counter2", "_d_bonus_vec_positions", "_d_bonus_vec_positions2"];

if (d_mt_winner == 1) then {
	_vectypetouse_w = _vectypetouse_w_temp;
	_vec = createVehicle [_vectypetouse_w, d_bonus_create_pos_w, [], 0, "NONE"];
	if (d_database_found) then {
		d_bonus_vecs_db_w pushBack _vec;
	};
	_vec setVariable ["D_VEC_SIDE", 2];
	_vec setVariable ["d_isspecialvec", true, true];
	_d_bonus_air_positions = d_bonus_air_positions_w;
	_d_bap_counter = d_bap_counter_w;
	_d_bonus_vec_positions = d_bonus_vec_positions_w;
	_d_bvp_counter = d_bvp_counter_w;
} else {
	if (d_mt_winner == 2) then {
		_vectypetouse_e = _vectypetouse_e_temp;
		_vec = createVehicle [_vectypetouse_e, d_bonus_create_pos_e, [], 0, "NONE"];
		if (d_database_found) then {
			d_bonus_vecs_db_e pushBack _vec;
		};
		_vec setVariable ["D_VEC_SIDE", 1];
		_vec setVariable ["d_isspecialvec", true, true];
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bap_counter = d_bap_counter_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
	} else {
		_vectypetouse_w = _vectypetouse_w_temp;
		_vectypetouse_e = _vectypetouse_e_temp;
		_vec = createVehicle [_vectypetouse_w, d_bonus_create_pos_w, [], 0, "NONE"];
		if (d_database_found) then {
			d_bonus_vecs_db_w pushBack _vec;
		};
		_vec2 = createVehicle [_vectypetouse_e, d_bonus_create_pos_e, [], 0, "NONE"];
		if (d_database_found) then {
			d_bonus_vecs_db_e pushBack _vec;
		};
		_vec setVariable ["D_VEC_SIDE", 2];
		_vec2 setVariable ["D_VEC_SIDE", 1];
		_vec setVariable ["d_isspecialvec", true, true];
		_vec2 setVariable ["d_isspecialvec", true, true];
		_d_bonus_air_positions = d_bonus_air_positions_w;
		_d_bonus_air_positions2 = d_bonus_air_positions_e;
		_d_bap_counter = d_bap_counter_w;
		_d_bap_counter2 = d_bap_counter_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_w;
		_d_bonus_vec_positions2 = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_w;
		_d_bvp_counter2 = d_bvp_counter_e;
	};
};

private _endpos = [];
private _dir = 0;
if (_vec isKindOf "Air") then {
	_endpos = (_d_bonus_air_positions # _d_bap_counter) # 0;
	_dir = (_d_bonus_air_positions # _d_bap_counter) # 1;
	switch (d_mt_winner) do {
		case 1: {
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count d_bonus_air_positions_w - 1)) then {d_bap_counter_w = 0};
		};
		case 2: {
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count d_bonus_air_positions_e - 1)) then {d_bap_counter_e = 0};
		};
		case 3: {
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count d_bonus_air_positions_w - 1)) then {d_bap_counter_w = 0};
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count d_bonus_air_positions_e - 1)) then {d_bap_counter_e = 0};
		};
	};
} else {
	_endpos = (_d_bonus_vec_positions # _d_bvp_counter) # 0;
	_dir = (_d_bonus_vec_positions # _d_bvp_counter) # 1;
	switch (d_mt_winner) do {
		case 1: {
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count d_bonus_vec_positions_w - 1)) then {d_bvp_counter_w = 0};
		};
		case 2: {
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count d_bonus_vec_positions_e - 1)) then {d_bvp_counter_e = 0};
		};
		case 3: {
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count d_bonus_vec_positions_w - 1)) then {d_bvp_counter_w = 0};
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count d_bonus_vec_positions_e - 1)) then {d_bvp_counter_e = 0};
		};
	};
	_vec setVariable ["d_liftit", true, true];
	
};

if (!isNull _vec2) then {
	if (_vec2 isKindOf "Air") then {
		_endpos2 = (_d_bonus_air_positions2 # _d_bap_counter2) # 0;
		_dir2 = (_d_bonus_air_positions2 # _d_bap_counter2) # 1;
	} else {
		_endpos2 = (_d_bonus_vec_positions2 # _d_bvp_counter2) # 0;
		_dir2 = (_d_bonus_vec_positions2 # _d_bvp_counter2) # 1;
		_vec2 setVariable ["d_liftit", true, true];
	};
};

_vec setVehiclePosition [_endpos, [], 0, "NONE"];
_vec setDir _dir;
_vec setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
[_vec, 11] call d_fnc_setekmode;
if (d_with_ranked) then {
	clearWeaponCargoGlobal _vec;
};
if (unitIsUAV _vec) then {
	private _uavgrp = createVehicleCrew _vec;
	_vec allowCrewInImmobile true;
	if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
	_uavgrp deleteGroupWhenEmpty true;
	[_vec, 7] call d_fnc_setekmode;
} else {
	if (d_with_dynsim == 0) then {
		[_vec, 10] spawn d_fnc_enabledynsim;
	};
};
if (!isNull _vec2) then {
	_vec2 setDir _dir2;
	_vec2 setVehiclePosition [_endpos2, [], 0, "NONE"];
	_vec2 setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
	[_vec2, 11] call d_fnc_setekmode;
	if (d_with_ranked) then {
		clearWeaponCargoGlobal _vec2;
	};
	if (unitIsUAV _vec2) then {
		private _uavgrp = createVehicleCrew _vec2;
		_vec2 allowCrewInImmobile true;
		if (isClass (configFile>>"CfgVehicles">>_vec_type>>"Components">>"TransportPylonsComponent")) then {
			_vec2 remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
		};
		_uavgrp deleteGroupWhenEmpty true;
		[_vec2, 7] call d_fnc_setekmode;
	} else {
		if (d_with_dynsim == 0) then {
			[_vec2, 10] spawn d_fnc_enabledynsim;
		};
	};
};
#endif

_vec addEventHandler ["getIn", {_this call d_fnc_sgetinvec}];

_vec addEventHandler ["getOut", {_this call d_fnc_sgetoutvec}];
#ifdef __TT__
if (!isNull _vec2) then {
		_vec2 addEventHandler ["getIn", {_this call d_fnc_sgetinvec}];

	_vec2 addEventHandler ["getOut", {_this call d_fnc_sgetoutvec}];
};
#endif

call d_fnc_targetclearm;

#ifndef __TT__
_vectypetouse remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
#else
[_vectypetouse_w,_vectypetouse_e] remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
#endif

