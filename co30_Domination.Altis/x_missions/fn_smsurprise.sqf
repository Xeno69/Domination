// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_smsurprise.sqf"
#include "..\x_setup.sqf"

private _pos = [d_x_sm_pos # 0, 200] call d_fnc_getranpointcircleouter;
__TRACE_1("","_pos")
if (_pos isEqualTo []) exitWith {};

#ifdef __DEBUG__
["aaabvbbbb", _pos, "ICON", "ColorBlack", [0.8,0.8], "AI Pos", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif

{
	if (random 100 > 50) then {
		private _newgroup = [d_side_enemy] call d_fnc_creategroup;
		
		private _units = [_pos, [_x, d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] call d_fnc_makemgroup;
		_newgroup deleteGroupWhenEmpty true;
		_newgroup allowFleeing 0;
		
		private _wp = _newgroup addWaypoint [d_x_sm_pos # 0, 10];
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointSpeed "NORMAL";
		_wp setwaypointtype "MOVE";
		_wp setWaypointFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"];
		_wp setWaypointCombatMode "YELLOW";

		if (d_with_dynsim == 0) then {
			_newgroup spawn {
				sleep 15;
				_this enableDynamicSimulation true;
			};
		};
		
		d_x_sm_rem_ar append _units;
		sleep 1;
	};
} forEach ["allmen", "specops"];