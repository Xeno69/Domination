// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gmcwgextrac.sqf"
#include "..\x_setup.sqf"

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