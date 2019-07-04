// by Xeno
#define THIS_FILE "fn_sideboats.sqf"
#include "..\..\x_setup.sqf"

if !(isServer) exitWith {};

params ["_posi_array", "_dirs"];

private _boats_ar = [];
private _boatt =
#ifdef __OWN_SIDE_BLUFOR__
	"O_Boat_Transport_01_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
	"B_Boat_Transport_01_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"O_Boat_Transport_01_F";
#endif
for "_ii" from 0 to 3 do {
	private _boat = createVehicle [_boatt, _posi_array # _ii, [], 0, "NONE"];
	_boat setDir (_dirs # _ii);
	_boat setPos (_posi_array # _ii);
	d_x_sm_vec_rem_ar pushBack _boat;
	_boat lock true;
	_boats_ar pushBack _boat;
	sleep 0.512;
};

for "_i" from 4 to 7 do {
	["specops", 1, "allmen", 1, _posi_array # _i, 100, true] spawn d_fnc_CreateInf;
	sleep 2.333;
};

_dirs = nil;
_posi_array = nil;

sleep 15.321;

private _num_t = count _boats_ar;

while {true} do {
	if ({damage _x >= 0.9 || {!alive _x}} count _boats_ar == _num_t) exitWith {};
	sleep 5.321;
	__TRACE_1("","_boats_ar")
	#ifdef __DEBUG__
	{
		__TRACE_3("","_x","damage _x","alive _x")
	} forEach _boats_ar;
	#endif
	if (d_sm_resolved) exitWith {};
};

if (!d_sm_resolved) then {
	d_sm_winner = 2;
};
d_sm_resolved = true;
