// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gmcwgextra.sqf"
#include "..\x_setup.sqf"

d_additional_mhqs = [];
d_additional_trans = [];
d_additional_wreck = [];
d_additional_lift = [];

#ifdef __GMCWG__
if (isClass(configFile>>"CfgVehicles">>"CUP_B_UH1D_GER_KSK")) then {
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_mhqs pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 17] == "d_cup_chopper_mhq"});

	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_trans pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_trans"});
};
if (isClass(configFile>>"CfgVehicles">>"CUP_B_CH53E_VIV_GER")) then {
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_wreck pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_wreck"});

	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_lift pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 18] == "d_cup_chopper_lift"});
};
#endif
{
	d_additional_mhqs pushBack _x;
} forEach (vehicles select {(str _x) select [0, 10] isEqualTo "d_mhq_add_"});
__TRACE_1("","d_additional_mhqs")
{
	d_additional_lift pushBack _x;
} forEach (vehicles select {(str _x) select [0, 11] isEqualTo "d_lift_add_"});
{
	d_additional_wreck pushBack _x;
} forEach (vehicles select {(str _x) select [0, 12] isEqualTo "d_wreck_add_"});
{
	d_additional_trans pushBack _x;
} forEach (vehicles select {(str _x) select [0, 12] isEqualTo "d_trans_add_"});

if (d_additional_mhqs isEqualTo []) then {
	d_additional_mhqs = nil;
} else {
	publicVariable "d_additional_mhqs";
};

if (d_additional_lift isEqualTo []) then {
	d_additional_lift = nil;
} else {
	publicVariable "d_additional_lift";
};

if (d_additional_trans isEqualTo []) then {
	d_additional_trans = nil;
} else {
	publicVariable "d_additional_trans";
};

if (d_additional_wreck isEqualTo []) then {
	d_additional_wreck = nil;
} else {
	publicVariable "d_additional_wreck";
};