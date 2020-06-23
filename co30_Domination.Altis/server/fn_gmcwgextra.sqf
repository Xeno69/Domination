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
		private _ne = nearEntities [["Air", "Car", "Tank"], 7];		
		if (_ne isEqualTo []) then {
			private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
			_vec setDir (markerDir _x);
			d_additional_mhqs pushBack _vec;
		};
	} forEach (allMapMarkers select {_x select [0, 17] == "d_cup_chopper_mhq"});

	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _ne = nearEntities [["Air", "Car", "Tank"], 7];		
		if (_ne isEqualTo []) then {
			private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
			_vec setDir (markerDir _x);
			d_additional_trans pushBack _vec;
		};
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_trans"});
};
if (isClass(configFile>>"CfgVehicles">>"CUP_B_CH53E_VIV_GER")) then {
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _ne = nearEntities [["Air", "Car", "Tank"], 7];		
		if (_ne isEqualTo []) then {
			private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
			_vec setDir (markerDir _x);
			d_additional_wreck pushBack _vec;
		};
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_wreck"});

	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _ne = nearEntities [["Air", "Car", "Tank"], 7];		
		if (_ne isEqualTo []) then {
			private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
			_vec setDir (markerDir _x);
			d_additional_lift pushBack _vec;
		};
	} forEach (allMapMarkers select {_x select [0, 18] == "d_cup_chopper_lift"});
};
#endif
#ifndef __TT__
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
#else
d_additional_mhqs_o = [];
d_additional_mhqs_b = [];
{
	d_additional_mhqs_o pushBack _x;
} forEach (vehicles select {(str _x) select [0, 12] isEqualTo "d_mhq_add_o_"});
__TRACE_1("","d_additional_mhqs_o")
{
	d_additional_mhqs_b pushBack _x;
} forEach (vehicles select {(str _x) select [0, 12] isEqualTo "d_mhq_add_b_"});
__TRACE_1("","d_additional_mhqs_b")

d_additional_lift_o = [];
d_additional_lift_b = [];
{
	d_additional_lift_o pushBack _x;
} forEach (vehicles select {(str _x) select [0, 13] isEqualTo "d_lift_add_o_"});
{
	d_additional_lift_b pushBack _x;
} forEach (vehicles select {(str _x) select [0, 13] isEqualTo "d_lift_add_b_"});

d_additional_wreck_o = [];
d_additional_wreck_b = [];
{
	d_additional_wreck_o pushBack _x;
} forEach (vehicles select {(str _x) select [0, 14] isEqualTo "d_wreck_add_o_"});
{
	d_additional_wreck_b pushBack _x;
} forEach (vehicles select {(str _x) select [0, 14] isEqualTo "d_wreck_add_b_"});

d_additional_trans_o = [];
d_additional_trans_b = [];
{
	d_additional_trans_o pushBack _x;
} forEach (vehicles select {(str _x) select [0, 14] isEqualTo "d_trans_add_o_"});
{
	d_additional_trans_b pushBack _x;
} forEach (vehicles select {(str _x) select [0, 14] isEqualTo "d_trans_add_b_"});

if (d_additional_mhqs_o isEqualTo []) then {
	d_additional_mhqs_o = nil;
} else {
	publicVariable "d_additional_mhqs_o";
};
if (d_additional_mhqs_b isEqualTo []) then {
	d_additional_mhqs_b = nil;
} else {
	publicVariable "d_additional_mhqs_b";
};

if (d_additional_lift_o isEqualTo []) then {
	d_additional_lift_o = nil;
} else {
	publicVariable "d_additional_lift_o";
};
if (d_additional_lift_b isEqualTo []) then {
	d_additional_lift_b = nil;
} else {
	publicVariable "d_additional_lift_b";
};

if (d_additional_trans_o isEqualTo []) then {
	d_additional_trans_o = nil;
} else {
	publicVariable "d_additional_trans_o";
};
if (d_additional_trans_b isEqualTo []) then {
	d_additional_trans_b = nil;
} else {
	publicVariable "d_additional_trans_b";
};

if (d_additional_wreck_b isEqualTo []) then {
	d_additional_wreck_b = nil;
} else {
	publicVariable "d_additional_wreck_o";
};
if (d_additional_wreck_b isEqualTo []) then {
	d_additional_wreck_b = nil;
} else {
	publicVariable "d_additional_wreck_b";
};
#endif