// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_additional_mhqs = [];
d_additional_trans = [];
d_additional_wreck = [];
d_additional_lift = [];

#ifndef __TT__
{
	d_additional_mhqs pushBack _x;
} forEach (vehicles select {(str _x) find "d_mhq_add_" == 0});
__TRACE_1("","d_additional_mhqs")
{
	d_additional_lift pushBack _x;
} forEach (vehicles select {(str _x) find "d_lift_add_" == 0});
{
	d_additional_wreck pushBack _x;
} forEach (vehicles select {(str _x) find "d_wreck_add_" == 0});
{
	d_additional_trans pushBack _x;
} forEach (vehicles select {(str _x) find "d_trans_add_" == 0});

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
} forEach (vehicles select {(str _x) find "d_mhq_add_o_" == 0});
__TRACE_1("","d_additional_mhqs_o")
{
	d_additional_mhqs_b pushBack _x;
} forEach (vehicles select {(str _x) find "d_mhq_add_b_" == 0});
__TRACE_1("","d_additional_mhqs_b")

d_additional_lift_o = [];
d_additional_lift_b = [];
{
	d_additional_lift_o pushBack _x;
} forEach (vehicles select {(str _x) find "d_lift_add_o_" == 0});
{
	d_additional_lift_b pushBack _x;
} forEach (vehicles select {(str _x) find "d_lift_add_b_" == 0});

d_additional_wreck_o = [];
d_additional_wreck_b = [];
{
	d_additional_wreck_o pushBack _x;
} forEach (vehicles select {(str _x) find "d_wreck_add_o_" == 0});
{
	d_additional_wreck_b pushBack _x;
} forEach (vehicles select {(str _x) find "d_wreck_add_b_" == 0});

d_additional_trans_o = [];
d_additional_trans_b = [];
{
	d_additional_trans_o pushBack _x;
} forEach (vehicles select {(str _x) find "d_trans_add_o_" == 0});
{
	d_additional_trans_b pushBack _x;
} forEach (vehicles select {(str _x) find "d_trans_add_b_" == 0});

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