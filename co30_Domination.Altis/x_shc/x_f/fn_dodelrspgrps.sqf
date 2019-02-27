// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_dodelrspgrps.sqf"
#include "..\..\x_setup.sqf"

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