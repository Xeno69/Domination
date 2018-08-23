// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getbonus.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

d_sm_winner = _this select 0;
d_current_sm_bonus_vec = _this select 1;

__TRACE("Starting")

if (d_MissionType == 2 || {d_bonus_vec_type in [1, 3]}) exitWith {
	[d_sm_winner, ""] remoteExecCall ["d_fnc_sm_res_client", [0, -2] select isDedicated];
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionAccomplished",d_kbtel_chan];
#else
	if (d_sm_winner == 1) then {
		d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];
		d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionAccomplished","SIDE"];
	} else {
		d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionAccomplished","SIDE"];
		d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"];
	};
#endif

	if !(isServer && {!isDedicated}) then {d_sm_winner = 0};
};

#ifdef __TT__
switch (d_sm_winner) do {
	case 1: {
		d_points_opfor = d_points_opfor + (d_tt_points # 4);
		{
			_x addScore (d_tt_points # 4);
		} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x && {opfor getFriend side (group _x) >= 0.6}});
	};
	case 2: {
		d_points_blufor = d_points_blufor + (d_tt_points # 4);
		{
			_x addScore (d_tt_points # 4);
		} forEach ((allPlayers - entities "HeadlessClient_F") select {!isNull _x && {blufor getFriend side (group _x) >= 0.6}});
	};
};	
#endif

#ifndef __TT__
private _vec_type = "";
if (d_current_sm_bonus_vec == "") then {
	private _airval = 72;
	private _chance = 0;

	if (d_land_bonus_vecs == 0) then {
		_chance = _airval + 1;
	} else {
		if (d_air_bonus_vecs == 0) then {
			_chance = 0;
		} else {
			if (d_air_bonus_vecs > d_land_bonus_vecs) then {
				_airval = floor ((d_land_bonus_vecs / d_air_bonus_vecs) * 100);
			};
			_chance = floor (random 100);
		};
	};
	
	__TRACE_1("","_chance")

	private _btype = "";

	__TRACE_2("","d_land_bonus_vecs","d_air_bonus_vecs")
	while {_btype == ""} do {
		_vec_type = selectRandom d_sm_bonus_vehicle_array;
		__TRACE_1("","_vec_type")
		if (count d_sm_bonus_vehicle_array > 3 && {d_land_bonus_vecs > 2 && {d_air_bonus_vecs > 2}}) then {
			private _vecclass = getText(configFile>>"CfgVehicles">>_vec_type>>"vehicleClass");
			__TRACE_1("","_vecclass")
			if (_chance > _airval) then {
				if (_vecclass == "Air" && {d_last_bonus_vec != _vec_type}) then {_btype = _vec_type};
			} else {
				if (_vecclass != "Air" && {d_last_bonus_vec != _vec_type}) then {_btype = _vec_type};
			};
		} else {
			_btype = _vec_type;
		};
		sleep 0.01;
	};
} else {
	_vec_type = d_current_sm_bonus_vec;
	d_current_sm_bonus_vec = "";
};

__TRACE_1("","_vec_type")

d_last_bonus_vec = _vec_type;
#else
private _airval = 50;
private _chance = floor (random 100);

private _btype_e = "";
private _btype_w = "";
private ["_d_bonus_create_pos", "_vec_type", "_d_bonus_air_positions", "_d_bonus_vec_positions", "_d_bvp_counter", "_d_bap_counter", "_d_bonus_vec_positions2", "_d_bonus_create_pos2", "_vec_type2", "_d_bonus_air_positions2", "_d_bvp_counter2", "_d_bap_counter2"];

switch (d_sm_winner) do {
	case 1: {
		if (d_current_sm_bonus_vec # 1 == "") then {
			while {_btype_e == ""} do {
				private _vec_typex = selectRandom (d_sm_bonus_vehicle_array # 1);
				if (count d_sm_bonus_vehicle_array > 5) then {
					private _vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
					// 50 % chance for an Air vehicle now
					if (_chance > _airval) then {
						if (_vecclass == "AIR") then {_btype_e = _vec_typex};
					} else {
						if (_vecclass != "AIR") then {_btype_e = _vec_typex};
					};
				} else {
					_btype_e = _vec_typex;
				};
				sleep 0.01;
			};
		} else {
			_btype_e = d_current_sm_bonus_vec # 1;
		};
		_d_bonus_create_pos = d_bonus_create_pos_e;
		_vec_type = _btype_e;
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
		_d_bap_counter = d_bap_counter_e;
	};
	case 2: {
		if (d_current_sm_bonus_vec # 0 == "") then {
			while {_btype_w == ""} do {
				private _vec_typex = selectRandom (d_sm_bonus_vehicle_array # 0);
				if (count d_sm_bonus_vehicle_array > 5) then {
					private _vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
					// 50 % chance for an Air vehicle now
					if (_chance > _airval) then {
						if (_vecclass == "AIR") then {_btype_w = _vec_typex};
					} else {
						if (_vecclass != "AIR") then {_btype_w = _vec_typex};
					};
				} else {
					_btype_w = _vec_typex;
				};
				sleep 0.01;
			};
		} else {
			_btype_w = d_current_sm_bonus_vec # 0;
		};
		_d_bonus_create_pos = d_bonus_create_pos_w;
		_vec_type = _btype_w;
		_d_bonus_air_positions = d_bonus_air_positions_w;
		_d_bonus_vec_positions = d_bonus_vec_positions_w;
		_d_bvp_counter = d_bvp_counter_w;
		_d_bap_counter = d_bap_counter_w;
	};
	case 123: {
		if (d_current_sm_bonus_vec # 1 == "") then {
			while {_btype_e == ""} do {
				private _vec_typex = selectRandom (d_sm_bonus_vehicle_array # 1);
				if (count d_sm_bonus_vehicle_array > 5) then {
					private _vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
					// 50 % chance for an Air vehicle now
					if (_chance > _airval) then {
						if (_vecclass == "AIR") then {_btype_e = _vec_typex};
					} else {
						if (_vecclass != "AIR") then {_btype_e = _vec_typex};
					};
				} else {
					_btype_e = _vec_typex;
				};
				sleep 0.01;
			};
		} else {
			_btype_e = d_current_sm_bonus_vec # 1;
		};
		_d_bonus_create_pos = d_bonus_create_pos_e;
		_vec_type = _btype_e;
		_d_bonus_air_positions = d_bonus_air_positions_e;
		_d_bonus_vec_positions = d_bonus_vec_positions_e;
		_d_bvp_counter = d_bvp_counter_e;
		_d_bap_counter = d_bap_counter_e;
		
		if (d_current_sm_bonus_vec # 0 == "") then {
			while {_btype_w == ""} do {
				private _vec_typex = selectRandom (d_sm_bonus_vehicle_array # 0);
				if (count d_sm_bonus_vehicle_array > 5) then {
					private _vecclass = toUpper (getText(configFile >> "CfgVehicles" >> _vec_typex >> "vehicleClass"));
					// 50 % chance for an Air vehicle now
					if (_chance > _airval) then {
						if (_vecclass == "AIR") then {_btype_w = _vec_typex};
					} else {
						if (_vecclass != "AIR") then {_btype_w = _vec_typex};
					};
				} else {
					_btype_w = _vec_typex;
				};
				sleep 0.01;
			};
		} else {
			_btype_w = d_current_sm_bonus_vec # 0;
		};
		
		_d_bonus_create_pos2 = d_bonus_create_pos_w;
		_vec_type2 = _btype_w;
		_d_bonus_air_positions2 = d_bonus_air_positions_w;
		_d_bonus_vec_positions2 = d_bonus_vec_positions_w;
		_d_bvp_counter2 = d_bvp_counter_w;
		_d_bap_counter2 = d_bap_counter_w;
	};
};
__TRACE_3("","_d_bonus_create_pos","_vec_type","_d_bvp_counter")
d_current_sm_bonus_vec = ["",""];
#endif
sleep 1.012;

private _endpos = [];
private _dir = 0;
#ifndef __TT__
private _vec = createVehicle [_vec_type, d_bonus_create_pos, [], 0, "NONE"];
_vec allowDamage false;
if (d_database_found) then {
	d_bonus_vecs_db pushBack _vec;
};
if (unitIsUAV _vec) then {
	createVehicleCrew _vec;
	_vec allowCrewInImmobile true;
	if (isClass (configFile>>"CfgVehicles">>_vectypetouse>>"Components">>"TransportPylonsComponent")) then {
		_vec remoteExecCall ["d_fnc_addpylon_action", [0, -2] select isDedicated];
	};
};

__TRACE_1("","_vec")

if (_vec isKindOf "Air") then {
	if (d_bonus_air_positions_carrier isEqualTo []) then {
		_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
		_dir = (d_bonus_air_positions # d_bap_counter) # 1;
		d_bap_counter = d_bap_counter + 1;
		if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
	} else {
		if (getNumber(configFile >> "CfgVehicles" >> _vec_type >> "tailHook") != 1) then {
			_endpos = (d_bonus_air_positions # d_bap_counter) # 0;
			_dir = (d_bonus_air_positions # d_bap_counter) # 1;
			d_bap_counter = d_bap_counter + 1;
			if (d_bap_counter > (count d_bonus_air_positions - 1)) then {d_bap_counter = 0};
		} else {
			_endpos = (d_bonus_air_positions_carrier # d_bacp_counter) # 0;
			private _aslheight = d_the_carrier getVariable "d_asl_height";
			if (isNil "_aslheight") then {
				_aslheight = (getPosASL d_FLAG_BASE) # 2;
			};
			_endpos set [2, _aslheight];
			_dir = (d_bonus_air_positions_carrier # d_bacp_counter) # 1;
			_vec setVariable ["d_oncarrier", true];
			d_bacp_counter = d_bacp_counter + 1;
			if (d_bacp_counter > (count d_bonus_air_positions_carrier - 1)) then {d_bacp_counter = 0};
		};
	};
} else {
	_endpos = (d_bonus_vec_positions # d_bvp_counter) # 0;
	_dir = (d_bonus_vec_positions # d_bvp_counter) # 1;
	d_bvp_counter = d_bvp_counter + 1;
	if (d_bvp_counter > (count d_bonus_vec_positions - 1)) then {d_bvp_counter = 0};
	_vec setVariable ["d_liftit", true, true];
};

_vec setDir _dir;
if !(_vec getVariable ["d_oncarrier", false]) then {
	__TRACE_1("","_endpos")
	if (_vec_type isKindOf "VTOL_01_base_F" || {_vec_type isKindOf "VTOL_02_base_F"}) then {
		private _nendpos = _endpos findEmptyPosition [20, 100, _vec_type];
		if !(_nendpos isEqualTo []) then {_endpos = _nendpos};
	};
	_vec setVehiclePosition [_endpos, [], 0, "NONE"];
} else {
	_vec setPosASL _endpos;
	[_vec, _endpos] spawn {
		params ["_vec", "_cposc"];
		sleep 1;
		_vec setPosASL _cposc;
		_vec setDamage 0;
	};
};
_vec setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
_vec addMPEventHandler ["MPKilled", {if (isServer) then {_this # 0 setFuel 0;_this call d_fnc_bonusvecfnc}}];
_vec spawn {
	sleep 10;
	_this allowDamage true;
};
#else
private _vec2 = objNull;
private _endpos2 = [];
private _dir2 = 0;

private _vec = createVehicle [_vec_type, _d_bonus_create_pos, [], 0, "NONE"];
_vec allowDamage false;
if (d_database_found) then {
	d_bonus_vecs_db_e pushBack _vec;
};
if (d_sm_winner == 123) then {
	_vec2 = createVehicle [_vec_type2, _d_bonus_create_pos2, [], 0, "NONE"];
	_vec2 allowDamage false;
	if (d_database_found) then {
		d_bonus_vecs_db_w pushBack _vec2;
	};
};

if (_vec isKindOf "Air") then {
	_endpos = (_d_bonus_air_positions # _d_bap_counter) # 0;
	_dir = (_d_bonus_air_positions # _d_bap_counter) # 1;
	switch (d_sm_winner) do {
		case 1: {
			_vec setVariable ["D_VEC_SIDE", 1];
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count _d_bonus_air_positions - 1)) then {d_bap_counter_e = 0};
		};
		case 2: {
			_vec setVariable ["D_VEC_SIDE", 2];
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count _d_bonus_air_positions - 1)) then {d_bap_counter_w = 0};
		};
		case 123: {
			_vec setVariable ["D_VEC_SIDE", 1];
			_vec2 setVariable ["D_VEC_SIDE", 2];
			d_bap_counter_e = d_bap_counter_e + 1;
			if (d_bap_counter_e > (count _d_bonus_air_positions - 1)) then {d_bap_counter_e = 0};
			d_bap_counter_w = d_bap_counter_w + 1;
			if (d_bap_counter_w > (count _d_bonus_air_positions2 - 1)) then {d_bap_counter_w = 0};
		};
	};
} else {
	_endpos = (_d_bonus_vec_positions # _d_bvp_counter) # 0;
	_dir = (_d_bonus_vec_positions # _d_bvp_counter) # 1;
	switch (d_sm_winner) do {
		case 1: {
			_vec setVariable ["D_VEC_SIDE", 1];
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_e = 0};
		};
		case 2: {
			_vec setVariable ["D_VEC_SIDE", 2];
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_w = 0};
		};
		case 123: {
			_vec setVariable ["D_VEC_SIDE", 1];
			_vec2 setVariable ["D_VEC_SIDE", 2];
			d_bvp_counter_e = d_bvp_counter_e + 1;
			if (d_bvp_counter_e > (count _d_bonus_vec_positions - 1)) then {d_bvp_counter_e = 0};
			d_bvp_counter_w = d_bvp_counter_w + 1;
			if (d_bvp_counter_w > (count _d_bonus_vec_positions2 - 1)) then {d_bvp_counter_w = 0};
			_vec2 setVariable ["d_liftit", true, true];
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
	};
};

_vec setDir _dir;
if (_vec_type isKindOf "VTOL_01_base_F" || {_vec_type isKindOf "VTOL_02_base_F"}) then {
	private _nendpos = _endpos findEmptyPosition [20, 100, _vec_type];
	if !(_nendpos isEqualTo []) then {_endpos = _nendpos};
};
_vec setVehiclePosition [_endpos, [], 0, "NONE"];
_vec setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
_vec addMPEventHandler ["MPKilled", {if (isServer) then {_this # 0 setFuel 0;_this call d_fnc_bonusvecfnc}}];
_vec spawn {
	sleep 10;
	_this allowDamage true;
};
if (!isNull _vec2) then {
	_vec2 setDir _dir2;
	if (_vec_type2 isKindOf "VTOL_01_base_F" || {_vec_type2 isKindOf "VTOL_02_base_F"}) then {
		private _nendpos2 = _endpos2 findEmptyPosition [20, 100, _vec_type2];
		if !(_nendpos2 isEqualTo []) then {_endpos2 = _nendpos2};
	};
	_vec2 setVehiclePosition [_endpos2, [], 0, "NONE"];
	_vec2 setVariable ["d_WreckMaxRepair", d_WreckMaxRepair, true];
	_vec2 addMPEventHandler ["MPKilled", {if (isServer) then {_this # 0 setFuel 0;_this call d_fnc_bonusvecfnc}}];
	_vec2 spawn {
		sleep 10;
		_this allowDamage true;
	};
};
#endif

_vec addEventHandler ["getIn", {
	private _ma = (_this select 0) getVariable "d_abandoned_ma";
	if (!isNil "_ma") then {
		deleteMarker _ma;
		(_this select 0) setVariable ["d_abandoned_ma", nil];
	};
}];

_vec addEventHandler ["getOut", {
	params ["_vec"];
#ifndef __TT__
	if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vec distance2D d_FLAG_BASE > 800}}) then {
#else
	private _vside = _vec getVariable "D_VEC_SIDE";
	if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vside == 2 && {_vec distance2D d_WFLAG_BASE > 800} || {_vside == 1 && {_vec distance2D d_EFLAG_BASE > 800}}}}) then {
#endif
		_vec setVariable ["d_abandoned_ma", [format ["%1_ab%2", _vec, time], _vec, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_1566", [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal];
#ifdef __TT__
		if (_vside == 1) then {
			(_vec getVariable "d_abandoned_ma") remoteExecCall ["deleteMarkerLocal", west];
		} else {
			(_vec getVariable "d_abandoned_ma") remoteExecCall ["deleteMarkerLocal", east];
		};
#endif
	};
}];

if (_vec isKindOf "Air") then {
	_vec enableCopilot false;
};

#ifdef __TT__
if (!isNull _vec2) then {
	_vec2 addEventHandler ["getIn", {
		private _ma = (_this select 0) getVariable "d_abandoned_ma";
		if (!isNil "_ma") then {
			deleteMarker _ma;
			(_this select 0) setVariable ["d_abandoned_ma", nil];
		};
	}];

	_vec2 addEventHandler ["getOut", {
		params ["_vec"];
		private _vside = _vec getVariable "D_VEC_SIDE";
		if (alive _vec && {(crew _vec) findIf {alive _x} == -1 && {_vside == 2 && {_vec distance2D d_WFLAG_BASE > 800} || {_vside == 1 } && {_vec distance2D d_EFLAG_BASE > 800}}}) then {
			private _mname = format ["%1_ab%2", _vec, time];
			[_mname, _vec, "ICON", "ColorBlue", [1,1], format [localize "STR_DOM_MISSIONSTRING_1566", [typeOf _vec, "CfgVehicles"] call d_fnc_GetDisplayName], 0, "mil_triangle"] call d_fnc_CreateMarkerGlobal;
			_vec setVariable ["d_abandoned_ma", _mname];
			if (_vside == 1) then {
				_mname remoteExecCall ["deleteMarkerLocal", west];
			} else {
				_mname remoteExecCall ["deleteMarkerLocal", east];
			};
		};
	}];
};
if (_vec2 isKindOf "Air") then {
	_vec2 enableCopilot false;
};
#endif

__TRACE_1("Calling res client","d_sm_winner")
[d_sm_winner, _vec_type] remoteExecCall ["d_fnc_sm_res_client", [0, -2] select isDedicated];
#ifndef __TT__
d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionAccomplished",d_kbtel_chan];
#else
if (d_sm_winner == 1) then {
	d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];
	d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionAccomplished","SIDE"];
} else {
	if (d_sm_winner == 2) then {
		d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionAccomplished","SIDE"];
		d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"];
	} else {
		if (d_sm_winner == 123) then {
			d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionAccomplished","SIDE"];
			d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionAccomplished","SIDE"];
		} else {
			d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];
			d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"];
		};
	};
};
#endif

if !(isServer && {!isDedicated}) then {d_sm_winner = 0};