//#define __DEBUG__
//#define __DEBUG__
#define THIS_FILE "x_m145.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_145" call d_fnc_smmapos; //  destroy lost uav
d_x_sm_type = "normal"; // "convoy"

if (hasInterface) then {
	d_cur_sm_txt = localize "STR_DOM_SIDESTRING_1057";
	d_current_mission_resolved_text = localize "STR_DOM_SIDESTRING_1058";
};

if (call d_fnc_checkSHC) then {
	private _trigger = objNull;
	d_x_sm_pos params ["_poss"];
	private _exact_pos = [_poss, 300] call d_fnc_GetRanPointCircleOld;
	private _cm = createVehicle [selectRandom d_sm_uav, _exact_pos, [], 0, "NONE"];
	_cm allowDamage false;
	_cm setDir (random 360);
	_cm setPos _exact_pos;
	_cm spawn {
		scriptName "spawn_sm145";
		sleep 10; _this allowDamage true;
	};
	{_cm removeMagazineGlobal _x} forEach (magazines _cm);
    _cm call d_fnc_clearcargo;
	_cm lock true;
	_cm setVectorup [0,0,-1];
	_cm setDamage 0;
#ifdef __DEBUG__
    [format["uav_%1",_cm], _cm,"ICON","ColorBlack",[0.5,0.5],"uav",0,"mil_dot"] call d_fnc_CreateMarkerLocal;
#endif	
	d_x_sm_vec_rem_ar pushBack _cm;
	_cm addEventHandler ["killed", {
		_this call d_fnc_KilledSMTargetNormal;
		(_this select 0) spawn {
			scriptName "spawn_sm145_2";
			sleep 2; deleteVehicle _this;
		}
	}];
	_cm addMPEventHandler ["MPKilled", {
		if (isServer) then {
			if ((_this select 1) call d_fnc_isplayer) then {(_this select 1) addScore 5};
		};
	}];
	sleep 20;
	private _time_over = 3;
	private _enemy_created = false;
	d_fnc_cruise_m_enemy = false;
	private _endtime = time + 1200;
	while {true} do {
		if (isNull _cm || {!alive _cm} || {d_fnc_cruise_m_enemy}) exitWith {};
		if (_time_over > 0) then {
			if (_time_over == 3) then {
				if (_endtime - time <= 600) then {
					_time_over = 2;
					[29] remoteExecCall ["d_fnc_DoKBMsg", 2];
				};
			} else {
				if (_time_over == 2) then {
					if (_endtime - time <= 300) then {
						_time_over = 1;
						[31] remoteExecCall ["d_fnc_DoKBMsg", 2];
					};
				} else {
					if (_time_over == 1) then {
						if (_endtime - time <= 120) then {
							_time_over = 0;
							[33] remoteExecCall ["d_fnc_DoKBMsg", 2];
						};
					};
				};
			};
		} else {
			if (!_enemy_created) then {
				_trigger = [_exact_pos, [20,20,0,false], [d_fnc_enemy_side,"PRESENT",false], ["this","d_cruise_m_enemy = true",""]] call d_fnc_CreateTrigger;
				_enemy_created = true;
				_estart_pos = [_exact_pos,300] call d_fnc_GetRanPointCircleOuter;
				_unit_array = ["basic", d_fnc_enemy_side] call d_fnc_getunitlistm;
				_ran = [2,4] call d_fnc_GetRandomRangeInt;
				for "_i" from 1 to _ran do {
					_newgroup = [d_fnc_enemy_side] call d_fnc_creategroup;
					_units = [_estart_pos, _unit_array, _newgroup] call d_fnc_makemgroup;
					sleep 1.045;
					_leader = leader _newgroup;
					_leader setRank "LIEUTENANT";
					_newgroup allowFleeing 0;
					_newgroup deleteGroupWhenEmpty true;
					[_newgroup, _exact_pos] call d_fnc_AttackWP;
					d_fnc_x_sm_rem_ar append _units;
					{_x triggerDynamicSimulation true} forEach _units;
					sleep 1.012;
				};				
				_unit_array = nil;
			};
		};
		sleep 5.223;
		if (d_fnc_sm_resolved) exitWith {};
	};

	if (!isNull _trigger) then {deleteVehicle _trigger};

	if (d_fnc_cruise_m_enemy && {!isNull _cm}) then {
		_cm removeAllEventHandlers "killed";
		d_fnc_sm_winner = -878;
	};
	
	d_fnc_cruise_m_enemy = nil;
	
	if (!d_fnc_sm_resolved) then {
	   d_fnc_sm_resolved = true;
	};
};
