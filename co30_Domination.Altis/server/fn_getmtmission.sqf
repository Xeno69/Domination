// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_wp_array", "_mtradius", "_trg_center"];

#define __getPos \
_poss = [d_cur_tgt_pos, d_cur_target_radius, 3, 0.3, 0, false, true] call d_fnc_GetRanPointCircleBig;\
if (d_tanoa) then {\
	_poss = [_poss] call d_fnc_tanoafix;\
};\
private _iccount = 0;\
while {_poss isEqualTo []} do {\
	_iccount = _iccount + 1;\
	_poss = [d_cur_tgt_pos, d_cur_target_radius, 3, 0.3, 0, false, true] call d_fnc_GetRanPointCircleBig;\
	if (d_tanoa) then {\
		_poss = [_poss] call d_fnc_tanoafix;\
	};\
	if (_iccount >= 50 && {_poss isNotEqualTo []}) exitWith {};\
};\
if (isNil "_poss" || {_poss isEqualTo []}) then {\
	_poss = [d_cur_tgt_pos, d_cur_target_radius] call d_fnc_getranpointcircle;\
};\
_poss set [2, 0];

#define __specops \
_newgroup = [d_side_enemy] call d_fnc_creategroup;\
private _specus = [_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup, true, true] call d_fnc_makemgroup;\
sleep 1.0112;\
_newgroup allowFleeing 0;\
_newgroup setVariable ["d_defend", true]; \
[_newgroup, _poss] spawn d_fnc_taskDefend; \
if (d_with_dynsim == 0) then { \
	[_newgroup, 10] spawn d_fnc_enabledynsim; \
}; \
d_delinfsm append _specus; \
if (d_mt_respawngroups == 0) then { \
	{ \
		[_x, 3] call d_fnc_setekmode; \
	} forEach (units _newgroup); \
	_newgroup setVariable ["d_respawninfo", ["specops", [], _trg_center, 0, "patrol2", d_side_enemy, 0, 0, 1, [_trg_center, _mtradius], false, []]]; \
};

#define __vkilled(ktype) _vec addEventHandler [#killed, {_this pushBack #ktype; call d_fnc_MTSMTargetKilled}];

if !(isServer) exitWith {};

sleep 1.120;
private _poss = _wp_array select ((count _wp_array) call d_fnc_RandomFloor);
if (d_tanoa) then {
	_poss = [_poss] call d_fnc_tanoafix;
	private _tcounter = 0;
	while {_poss isEqualTo []} do {
		_poss = _wp_array select ((count _wp_array) call d_fnc_RandomFloor);
		_poss = [_poss] call d_fnc_tanoafix;
		if (_tcounter >= 70 && {_poss isNotEqualTo []}) exitWith {};
		_tcounter = _tcounter + 1;
	};
};

private _sec_kind = call {
	if (d_spe) exitWith {
		selectRandom [1,2,3,4,6,7,8,9,10];
	};
	selectRandom [1,2,3,4,5,6,7,8,9,10];
};

d_fixor_var = objNull;

private _fnc_makefortress = {
	private _fortress = createVehicle [d_sm_fortress, _this, [], 0, "NONE"];
	_fortress setDir (random 360);
	private _res = [_fortress] call BIS_fnc_buildingPositions;
	__TRACE_1("","_res")
	if (_res isEqualTo []) then {
		deleteVehicle _fortress;
	} else {
		_res = selectRandom _res;
	};
	[_res, _fortress]
};

#ifdef __DEBUG__
_sec_kind = 8;
#endif

switch (_sec_kind) do {
	case 1: {
		private _forar = _poss call _fnc_makefortress;
		__TRACE_1("","_forar")
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
		private _vec = _newgroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_vec call d_fnc_removenvgoggles_fak;
		
		if ((_forar # 0) isEqualTo []) then {
			private _svec = 1;
			private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
			if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
				_isFlat set [2,0];
				_poss = _isFlat;
			};
			_vec setPos _poss;
		} else {
			_vec setPos (_forar # 0);
			d_mtmissionobjs pushBack (_forar # 1);
		};
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		_vec disableAI "PATH";

		d_delinfsm pushBack _vec;
		d_fixor_var = _vec;
		if ({_x == 1} count d_searchintel < count d_searchintel) then {
			d_intel_unit = _vec;
			d_searchbody = _vec; publicVariable "d_searchbody";
			remoteExecCall ["d_fnc_s_b_client", [0, -2] select isDedicated];
		} else {
			if (!isNull d_searchbody) then {
				d_searchbody = nil; publicVariable "d_searchbody";
			};
		};
		sleep 0.1;
		__vkilled(gov_dead);
		if (d_with_ai && {d_with_ranked}) then {
			[_vec, 4] call d_fnc_setekmode;
		};
		removeFromRemainsCollector [_vec];
		[_vec] call d_fnc_addceo;
		if (d_with_dynsim == 0) then {
			[_vec, 0] spawn d_fnc_enabledynsim;
		};
#ifdef __TT__
		[_vec, 0] call d_fnc_setekmode;
#endif
		sleep 1.0112;
		__specops;
	};
	case 2: {
		private _svec = 8;
		__getPos;
		private _vec = createVehicle [d_air_radar2, _poss, [], 0, "NONE"];
		_vec setDir (random 360);
		//_vec setPos _poss;
		//_vec setVectorUp [0,0,1];
		__vkilled(radar_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		sleep 1.0112;
		__specops;
	};
	case 3: {
		private _svec = 6;
		__getPos;
		private _vec = createVehicle [d_sm_ammotrucktype, _poss, [], 0, "NONE"];
		_vec call d_fnc_nodamoff;
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		_vec lock true;
		__vkilled(ammo_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		private _vec2 = createVehicle ["CamoNet_wdl_big_F", getPos _vec, [], 0, "NONE"];
		_vec2 setDir (getDir _vec);
		_vec2 setPos (getPos _vec);
		d_mtmissionobjs pushBack _vec2;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		addToRemainsCollector [_vec];
		sleep 1.0112;
		__specops;
	};
	case 4: {
		private _vec = createVehicle [d_sm_medtrucktype, _poss, [], 0, "NONE"];
		_vec call d_fnc_nodamoff;
		private _svec = 6;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		_vec lock true;
		__vkilled(med_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		private _vec2 = createVehicle ["CamoNet_wdl_big_F", getPos _vec, [], 0, "NONE"];
		_vec2 setDir (getDir _vec);
		_vec2 setPos (getPos _vec);
		d_mtmissionobjs pushBack _vec2;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		addToRemainsCollector [_vec];
		sleep 1.0112;
		__specops;
	};
	case 5: {
		private _svec = sizeOf d_enemy_hq;
		__getPos;
		private _vec = createVehicle [d_enemy_hq, _poss, [], 0, "NONE"];
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		_vec lock true;
		__vkilled(hq_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		sleep 1.0112;
		__specops;
	};
	case 6: {
		private _svec = 6;
		__getPos;
		private _vec = createVehicle ["Land_dp_transformer_F", _poss, [], 0, "NONE"];
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		//_vec setVectorUp [0,0,1];
		__vkilled(light_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		private _vec2 = createVehicle ["CamoNet_wdl_big_F", getPos _vec, [], 0, "NONE"];
		_vec2 setDir (getDir _vec);
		_vec2 setPos (getPos _vec);
		d_mtmissionobjs pushBack _vec2;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		sleep 1.0112;
		__specops;
	};
	case 7: {
		private _fact = "Land_IndustrialShed_01_F";
		private _svec = 15;
		__getPos;
		/*_fact = switch (d_enemy_side_short) do {
			case "E": {"Land_spp_Transformer_F"};
			case "W": {"Land_spp_Transformer_F"};
			case "G": {"Land_spp_Transformer_F"};
		};*/
		private _vec = createVehicle [_fact, _poss, [], 0, "NONE"];
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		//_vec setVectorUp [0,0,1];
		__vkilled(heavy_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		sleep 1.0112;
		__specops;
	};
	case 8: {
		private _svec = sizeOf d_air_radar;
		__getPos;
		private _vec = createVehicle [d_air_radar, _poss, [], 0, "NONE"];
		_vec setDir (floor random 360);
		//_vec setPos _poss;
		//_vec setVectorUp [0,0,1];
		__vkilled(airrad_down);
		if (d_MTTowerSatchelsOnly == 0) then {
			_vec addEventHandler ["handleDamage", {call d_fnc_checkmtshothd}];
		};
		d_fixor_var = _vec;
		d_mtmissionobjs pushBack _vec;
		if (d_with_dynsim == 0) then {
			[_vec, 5] spawn d_fnc_enabledynsim;
		};
		sleep 1.0112;
		__specops;
	};
	case 9: {
		private _forar = _poss call _fnc_makefortress;
		__TRACE_1("","_forar")
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
#ifndef __VN__
		private _ctype = "C_man_polo_6_F";
#else
		private _ctype = "vn_c_men_02";
#endif
		private _vec = _newgroup createUnit [_ctype, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_vec call d_fnc_removenvgoggles_fak;
		if ((_forar # 0) isEqualTo []) then {
			private _svec = 1;
			private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
			if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
				_isFlat set [2,0];
				_poss = _isFlat;
			};
			_vec setPos _poss;
		} else {
			_vec setPos (_forar # 0);
			d_mtmissionobjs pushBack (_forar # 1);
		};
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		_vec disableAI "PATH";
		d_delinfsm pushBack _vec;
		d_fixor_var = _vec;
#ifndef __VN__
		_vec addMagazines ["16Rnd_9x21_Mag", 2];
		_vec addWeapon "hgun_Rook40_F";
#else
		_vec addMagazines ["vn_hd_mag", 2];
		_vec addWeapon "vn_hd";
#endif
		if ({_x == 1} count d_searchintel < count d_searchintel) then {
			d_intel_unit = _vec;
			d_searchbody = _vec; publicVariable "d_searchbody";
			remoteExecCall ["d_fnc_s_b_client", [0, -2] select isDedicated];
		} else {
			if (!isNull d_searchbody) then {
				d_searchbody = objNull; publicVariable "d_searchbody";
			};
		};
		sleep 0.1;
		__vkilled(lopo_dead);
		if (d_with_ai && {d_with_ranked}) then {
			[_vec, 4] call d_fnc_setekmode;
		};
		removeFromRemainsCollector [_vec];
		[_vec] call d_fnc_addceo;
		if (d_with_dynsim == 0) then {
			[_vec, 0] spawn d_fnc_enabledynsim;
		};
#ifdef __TT__
		[_vec, 0] call d_fnc_setekmode;
#endif
		sleep 1.0112;
		__specops;
	};
	case 10: {
		private _forar = _poss call _fnc_makefortress;
		__TRACE_1("","_forar")
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
#ifndef __VN__
		private _ctype = "C_man_1_3_F";
#else
		private _ctype = "vn_c_men_03";
#endif
		private _vec = _newgroup createUnit [_ctype, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_vec call d_fnc_removenvgoggles_fak;
		if ((_forar # 0) isEqualTo []) then {
			private _svec = 1;
			private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
			if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
				_isFlat set [2,0];
				_poss = _isFlat;
			};
			_vec setPos _poss;
		} else {
			_vec setPos (_forar # 0);
			d_mtmissionobjs pushBack (_forar # 1);
		};
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		d_fixor_var = _vec;
		d_delinfsm pushBack _vec;
		_vec disableAI "PATH";
		_vec addMagazines ["16Rnd_9x21_Mag", 2];
		_vec addWeapon "hgun_Rook40_F";
		if ({_x == 1} count d_searchintel < count d_searchintel) then {
			d_intel_unit = _vec;
			d_searchbody = _vec; publicVariable "d_searchbody";
			remoteExecCall ["d_fnc_s_b_client", [0, -2] select isDedicated];
		} else {
			if (!isNull d_searchbody) then {
				d_searchbody = objNull; publicVariable "d_searchbody";
			};
		};
		sleep 0.1;
		__vkilled(dealer_dead);
		if (d_with_ai && {d_with_ranked}) then {
			[_vec, 4] call d_fnc_setekmode;
		};
		removeFromRemainsCollector [_vec];
		[_vec] call d_fnc_addceo;
		if (d_with_dynsim == 0) then {
			[_vec, 0] spawn d_fnc_enabledynsim;
		};
#ifdef __TT__
		[_vec, 0] call d_fnc_setekmode;
#endif
		sleep 1.0112;
		__specops;
	};
};

#ifdef __DEBUG__
[str d_fixor_var, d_fixor_var, "ICON", "ColorBlack", [0.5, 0.5], "Main target mission", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif

d_sec_kind = _sec_kind; publicVariable "d_sec_kind";
private _s = "";
if (d_current_target_index != -1) then {
	_s = switch (_sec_kind) do {
		case 1: {
			format [localize "STR_DOM_MISSIONSTRING_891", d_cur_tgt_name]
		};
		case 2: {
			format [localize "STR_DOM_MISSIONSTRING_893", d_cur_tgt_name]
		};
		case 3: {
			format [localize "STR_DOM_MISSIONSTRING_894", d_cur_tgt_name]
		};
		case 4: {
			format [localize "STR_DOM_MISSIONSTRING_896", d_cur_tgt_name]
		};
		case 5: {
			format [localize "STR_DOM_MISSIONSTRING_898", d_cur_tgt_name]
		};
		case 6: {
			format [localize "STR_DOM_MISSIONSTRING_899", d_cur_tgt_name]
		};
		case 7: {
			format [localize "STR_DOM_MISSIONSTRING_900", d_cur_tgt_name]
		};
		case 8: {
			format [localize "STR_DOM_MISSIONSTRING_902", d_cur_tgt_name]
		};
		case 9: {
			format [localize "STR_DOM_MISSIONSTRING_903", d_cur_tgt_name]
		};
		case 10: {
			format [localize "STR_DOM_MISSIONSTRING_567", d_cur_tgt_name]
		};
	};
} else {
	_s = localize "STR_DOM_MISSIONSTRING_905";
};
#ifndef __TT__
[18, _s] call d_fnc_DoKBMsg;
#else
[19, _s] call d_fnc_DoKBMsg;
#endif
