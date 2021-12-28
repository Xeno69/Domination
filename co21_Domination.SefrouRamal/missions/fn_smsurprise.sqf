// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

{
	if (random 100 > 30) then {
		private _pos = [d_x_sm_pos # 0, (random 300) max 200] call d_fnc_getranpointcircleouter;
		__TRACE_1("","_pos")
		
		if (_pos isNotEqualTo []) then {
#ifdef __DEBUG__
			[format ["d_x_y_z_%1", _pos], _pos, "ICON", "ColorBlack", [0.8, 0.8], "AI Pos", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
#endif
			private _newgroup = [d_side_enemy] call d_fnc_creategroup;
			
			private _units = [_pos, [_x, d_enemy_side_short] call d_fnc_getunitlistm, _newgroup, true, true] call d_fnc_makemgroup;
			_newgroup allowFleeing 0;
			
			private _wp = _newgroup addWaypoint [d_x_sm_pos # 0, 10];
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointSpeed "NORMAL";
			_wp setwaypointtype "MOVE";
			_wp setWaypointFormation selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","DIAMOND"];
			_wp setWaypointCombatMode "YELLOW";

			d_x_sm_rem_ar append _units;
			[_newgroup, 30] spawn {
				scriptName "spawn smsurprise";
				sleep (_this # 1);
				(_this # 0) call d_fnc_addgrp2hc;
				if (d_with_dynsim == 0) then {
					(_this # 0) enableDynamicSimulation true;
				};
			};
		};
	};
	sleep 1;
} forEach ["allmen", "specops"];