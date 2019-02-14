// by Xeno
#define THIS_FILE "fn_dodelrspgrps.sqf"
#include "..\..\x_setup.sqf"

if !(d_respawn_ai_groups isEqualTo []) then {
	0 spawn {
		scriptName "spawn_respawn_ai_groups";
		__TRACE_1("","d_respawn_ai_groups")
		{
			_x params ["_rgrp"];
			__TRACE_1("","_rgrp")
			if (!isNil "_rgrp" && {_rgrp isEqualType grpNull && {!isNull _rgrp}}) then {
				{
					if !(isNull objectParent _x)  then {
						private _v = vehicle _x;
						__TRACE_1("","_v")
						if (alive _v) then {_v setDamage 1};
					};
					if (alive _x) then {_x setDamage 1};
				} forEach ((units _rgrp) select {!isNil "_x" && {!isNull _x}});
			};
		} forEach (d_respawn_ai_groups select {_x isEqualType []});
	};
};

#ifndef __TT__
if (d_enemy_occupy_bldgs == 1) then {
	//garrisoned infantry cleanup
	{
		//diag_log [diag_frameno, diag_ticktime, time, format ["Deleting garrisoned infantry: %1", _x]];
		deleteVehicle _x;
	} forEach d_cur_tgt_garrisonedinfantry;
	d_cur_tgt_garrisonedinfantry = [];
};
#endif