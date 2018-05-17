// by Xeno
#define THIS_FILE "fn_getmtmission.sqf"
#include "..\..\x_setup.sqf"

#define __getPos \
_poss = [d_cur_tgt_pos, d_cur_target_radius] call d_fnc_GetRanPointCircleBig;\
while {_poss isEqualTo []} do {\
	_poss = [d_cur_tgt_pos, d_cur_target_radius] call d_fnc_GetRanPointCircleBig;\
	sleep 0.01;\
}

#define __specops \
_newgroup = [d_side_enemy] call d_fnc_creategroup;\
[_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] spawn d_fnc_makemgroup;\
sleep 1.0112;\
_newgroup deleteGroupWhenEmpty true; \
_newgroup allowFleeing 0;\
_newgroup setVariable ["d_defend", true]; \
[_newgroup, _poss] spawn d_fnc_taskDefend; \
if (d_with_dynsim == 0) then { \
	_newgroup spawn { \
		sleep 10; \
		_this enableDynamicSimulation true; \
	}; \
};

#define __vkilled(ktype) _vec addEventHandler [#killed, {_this pushBack #ktype; _this call d_fnc_MTSMTargetKilled}]

if !(call d_fnc_checkSHC) exitWith {};

private _wp_array = _this;

sleep 3.120;
private _poss = _wp_array select ((count _wp_array) call d_fnc_RandomFloor);

private _sec_kind = (floor (random 10)) + 1;

d_fixor_var = objNull;

switch (_sec_kind) do {
	case 1: {
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
		private _vec = _newgroup createUnit [d_soldier_officer, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_newgroup deleteGroupWhenEmpty true;
		_vec call d_fnc_removenvgoggles_fak;
		private _svec = sizeOf d_soldier_officer;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setPos _poss;
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		_vec disableAI "PATH";
		d_delinfsm  pushBack _vec;
		d_fixor_var = _vec;
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
		__vkilled(gov_dead);
		if (d_with_ai && {d_with_ranked}) then {
			_vec addEventHandler ["Killed", {
				[1, _this select 1] remoteExecCall ["d_fnc_addkillsai", 2];
				(_this select 0) removeAllEventHandlers "Killed";
			}];
		};
		removeFromRemainsCollector [_vec];
		[_vec] remoteExecCall ["d_fnc_addceo", 2];
		if (d_with_dynsim == 0) then {
			_vec enableDynamicSimulation true;
		};
#ifdef __TT__
		_vec addEventHandler ["Killed", {[[15, 3, 2, 1], _this # 1, _this # 0] remoteExecCall ["d_fnc_AddKills", 2]}];
#endif
		sleep 1.0112;
		__specops;
	};
	case 2: {
		__getPos;
		private _ctype = "Land_Radar_Small_F";
		private _vec = createVehicle [_ctype, _poss, [], 0, "NONE"];
		private _svec = sizeOf _ctype;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1) then {
			if (_poss distance2D _isFlat < 100) then {
				_isFlat set [2,0];
				_poss = _isFlat;
			};
		};
		_vec setPos _poss;
		_vec setVectorUp [0,0,1];
		__vkilled(radar_down);
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 3: {
		__getPos;
		private _vec = createVehicle [d_sm_ammotrucktype, _poss, [], 0, "NONE"];
		private _svec = sizeOf d_sm_ammotrucktype;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec lock true;
		_vec addEventHandler ["killed", {
			_this pushBack "ammo_down";
			_this call d_fnc_MTSMTargetKilled;
			_this call d_fnc_handleDeadVec;
		}];
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 4: {
		private _vec = createVehicle [d_sm_medtrucktype, _poss, [], 0, "NONE"];
		private _svec = sizeOf d_sm_medtrucktype;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec lock true;
		_vec addEventHandler ["killed", {
			_this pushBack "med_down";
			_this call d_fnc_MTSMTargetKilled;
			_this call d_fnc_handleDeadVec;
		}];
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 5: {
		__getPos;
		private _vec = createVehicle [d_enemy_hq, _poss, [], 0, "NONE"];
		private _svec = sizeOf d_enemy_hq;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec lock true;
		__vkilled(hq_down);
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 6: {
		__getPos;
		private _fact = "Land_dp_transformer_F";
		private _vec = createVehicle [_fact, _poss, [], 0, "NONE"];
		private _svec = sizeOf _fact;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec setVectorUp [0,0,1];
		__vkilled(light_down);
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 7: {
		__getPos;
		/*_fact = switch (d_enemy_side_short) do {
			case "E": {"Land_spp_Transformer_F"};
			case "W": {"Land_spp_Transformer_F"};
			case "G": {"Land_spp_Transformer_F"};
		};*/
		private _fact = "Land_Factory_Main_F";
		private _vec = createVehicle [_fact, _poss, [], 0, "NONE"];
		private _svec = sizeOf _fact;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec setVectorUp [0,0,1];
		__vkilled(heavy_down);
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 8: {
		__getPos;
		private _vec = createVehicle [d_air_radar, _poss, [], 0, "NONE"];
		private _svec = sizeOf d_air_radar;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setDir (floor random 360);
		_vec setPos _poss;
		_vec setVectorUp [0,0,1];
		__vkilled(airrad_down);
		d_fixor_var = _vec;
		d_mtmissionobj = _vec;
		sleep 1.0112;
		__specops;
	};
	case 9: {
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
		private _ctype = "C_man_polo_6_F";
		private _vec = _newgroup createUnit [_ctype, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_newgroup deleteGroupWhenEmpty true;
		_vec call d_fnc_removenvgoggles_fak;
		private _svec = sizeOf _ctype;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setPos _poss;
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		_vec disableAI "PATH";
		d_delinfsm  pushBack _vec;
		d_fixor_var = _vec;
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
		__vkilled(lopo_dead);
		if (d_with_ai && {d_with_ranked}) then {
			_vec addEventHandler ["Killed", {
				[1, _this select 1] remoteExecCall ["d_fnc_addkillsai", 2];
				(_this select 0) removeAllEventHandlers "Killed";
			}];
		};
		removeFromRemainsCollector [_vec];
		[_vec] remoteExecCall ["d_fnc_addceo", 2];
		if (d_with_dynsim == 0) then {
			_vec enableDynamicSimulation true;
		};
#ifdef __TT__
		_vec addEventHandler ["Killed", {[[15, 3, 2, 1], _this # 1, _this # 0] remoteExecCall ["d_fnc_AddKills", 2]}];
#endif
		sleep 1.0112;
		__specops;
	};
	case 10: {
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
		private _ctype = "C_man_1_3_F";
		private _vec = _newgroup createUnit [_ctype, _poss, [], 0, "NONE"];
		[_vec] joinSilent _newgroup;
		_newgroup deleteGroupWhenEmpty true;
		_vec call d_fnc_removenvgoggles_fak;
		private _svec = sizeOf _ctype;
		private _isFlat = (getPosATL _vec) isFlatEmpty [_svec / 2, -1, 0.7, _svec, 0, false, _vec]; // 150
		if (count _isFlat > 1 && {_poss distance2D _isFlat < 100}) then {
			_isFlat set [2,0];
			_poss = _isFlat;
		};
		_vec setPos _poss;
		_vec setRank "COLONEL";
		_vec setSkill 0.3;
		d_fixor_var = _vec;
		d_delinfsm  pushBack _vec;
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
			_vec addEventHandler ["Killed", {
				[1, _this select 1] remoteExecCall ["d_fnc_addkillsai", 2];
				(_this select 0) removeAllEventHandlers "Killed";
			}];
		};
		removeFromRemainsCollector [_vec];
		[_vec] remoteExecCall ["d_fnc_addceo", 2];
		if (d_with_dynsim == 0) then {
			_vec enableDynamicSimulation true;
		};
#ifdef __TT__
		_vec addEventHandler ["Killed", {[[15, 3, 2, 1], _this # 1, _this # 0] remoteExecCall ["d_fnc_AddKills", 2]}];
#endif
		sleep 1.0112;
		__specops;
	};
};

d_sec_kind = _sec_kind; publicVariable "d_sec_kind";
private _s = "";
if (d_current_target_index != -1) then {
	_s = (switch (_sec_kind) do {
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
			format [localize "STR_DOM_MISSIONSTRING_904", d_cur_tgt_name]
		};
	});
} else {
	_s = localize "STR_DOM_MISSIONSTRING_905";
};
#ifndef __TT__
[18, _s] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
[19, _s] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif

if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_fixor_var", d_fixor_var]] remoteExecCall ["setVariable", 2];
};