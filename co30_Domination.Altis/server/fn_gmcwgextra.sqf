// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gmcwgextra.sqf"
#include "..\x_setup.sqf"

if (isClass(configFile>>"CfgVehicles">>"CUP_B_UH1D_GER_KSK")) then {
	d_additional_mhqs = [];
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_mhqs pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 17] == "d_cup_chopper_mhq"});
	
	if (d_additional_mhqs isEqualTo []) then {
		d_additional_mhqs = nil;
	} else {
		publicVariable "d_additional_mhqs";
	};
	
	d_additional_trans = [];
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_UH1D_GER_KSK", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_trans pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_trans"});
	
	if (d_additional_trans isEqualTo []) then {
		d_additional_trans = nil;
	} else {
		publicVariable "d_additional_trans";
	};
};
if (isClass(configFile>>"CfgVehicles">>"CUP_B_CH53E_VIV_GER")) then {
	d_additional_wreck = [];
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_wreck pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 19] == "d_cup_chopper_wreck"});
	
	if (d_additional_wreck isEqualTo []) then {
		d_additional_wreck = nil;
	} else {
		publicVariable "d_additional_wreck";
	};
	
	d_additional_lift = [];
	{
		private _pos = markerPos _x;
		_pos set [2, 0];
		private _vec = createVehicle ["CUP_B_CH53E_VIV_GER", _pos, [], 0, "NONE"];
		_vec setDir (markerDir _x);
		d_additional_lift pushBack _vec;
	} forEach (allMapMarkers select {_x select [0, 18] == "d_cup_chopper_lift"});
	
	if (d_additional_lift isEqualTo []) then {
		d_additional_lift = nil;
	} else {
		publicVariable "d_additional_lift";
	};
};