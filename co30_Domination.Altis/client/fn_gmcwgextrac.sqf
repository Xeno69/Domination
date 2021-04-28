// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifndef __TT__
if (!isNil "d_additional_mhqs") then {
	{
		private _num = 3 + _forEachIndex;
		d_p_vecs pushBack ["D_MRR" + str (_num), _num - 1, "d_mobilerespawn" + str (_num), "b_hq", "ColorYellow", str _num, "MHQ " + str (_num)];
		d_mob_respawns pushBack ["D_MRR" + str (_num), "MHQ " + str (_num)];
	} forEach d_additional_mhqs;
};
if (!isNil "d_additional_wreck") then {
	{
		private _num = 10 + _forEachIndex;
		d_choppers pushBack ["D_HR" + str (_num), 1, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", "W", localize "STR_DOM_MISSIONSTRING_10"];
	} forEach d_additional_wreck;
};
if (!isNil "d_additional_lift") then {
	{
		private _num = 30 + _forEachIndex;
		d_choppers pushBack ["D_HR" + str (_num), 0, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", str (_forEachIndex  + 1), "Lift " + str (_forEachIndex  + 1)];
	} forEach d_additional_lift;
};
if (!isNil "d_additional_trans") then {
	{
		private _num = 40 + _forEachIndex;
		d_choppers pushBack ["D_HR"  + str (_num), 2, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", str (40 + _forEachIndex), ""];
	} forEach d_additional_trans;
};
#else
if (!isNil "d_additional_mhqs_o") then {
	{
		private _num = 3 + _forEachIndex;
		d_p_vecs_opfor pushBack ["D_MRR" + str (_num), _num - 1, "d_mobilerespawn" + str (_num), "b_hq", "ColorYellow", str _num, "MHQ " + str (_num)];
		d_mob_respawns_opfor pushBack ["D_MRR" + str (_num), "MHQ " + str (_num)];
	} forEach d_additional_mhqs_o;
};
if (!isNil "d_additional_mhqs_b") then {
	{
		private _num = 3 + _forEachIndex;
		d_p_vecs_blufor pushBack ["D_MRR" + str (_num), _num - 1, "d_mobilerespawn" + str (_num), "b_hq", "ColorYellow", str _num, "MHQ " + str (_num)];
		d_mob_respawns_blufor pushBack ["D_MRR" + str (_num), "MHQ " + str (_num)];
	} forEach d_additional_mhqs_b;
};
if (!isNil "d_additional_wreck_o") then {
	{
		private _num = 10 + _forEachIndex;
		d_choppers_opfor pushBack ["D_HR" + str (_num), 1, "d_chopper" + str (_num), 4000 + _num, "n_air", "ColorWhite", "W", localize "STR_DOM_MISSIONSTRING_10"];
	} forEach d_additional_wreck_o;
};
if (!isNil "d_additional_wreck_b") then {
	{
		private _num = 10 + _forEachIndex;
		d_choppers_blufor pushBack ["D_HR" + str (_num), 1, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", "W", localize "STR_DOM_MISSIONSTRING_10"];
	} forEach d_additional_wreck_b;
};
if (!isNil "d_additional_lift_o") then {
	{
		private _num = 30 + _forEachIndex;
		d_choppers_opfor pushBack ["D_HR" + str (_num), 0, "d_chopper" + str (_num), 4000 + _num, "n_air", "ColorWhite", str (_forEachIndex  + 1), "Lift " + str (_forEachIndex  + 1)];
	} forEach d_additional_lift_o;
};
if (!isNil "d_additional_lift_b") then {
	{
		private _num = 30 + _forEachIndex;
		d_choppers_blufor pushBack ["D_HR" + str (_num), 0, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", str (_forEachIndex  + 1), "Lift " + str (_forEachIndex  + 1)];
	} forEach d_additional_lift_b;
};
if (!isNil "d_choppers_opfor") then {
	{
		private _num = 40 + _forEachIndex;
		d_choppers pushBack ["D_HR"  + str (_num), 2, "d_chopper" + str (_num), 4000 + _num, "n_air", "ColorWhite", str (40 + _forEachIndex), ""];
	} forEach d_additional_trans_o;
};
if (!isNil "d_additional_trans_b") then {
	{
		private _num = 40 + _forEachIndex;
		d_choppers_blufor pushBack ["D_HR"  + str (_num), 2, "d_chopper" + str (_num), 3000 + _num, "n_air", "ColorWhite", str (40 + _forEachIndex), ""];
	} forEach d_additional_trans_b;
};
#endif