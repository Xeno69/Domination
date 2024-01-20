// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_2("EntityCreated","_this","typeOf _this")

params ["_ent"];
call {
	if (typeOf _ent == "#crater") exitWith {
		__TRACE("Is crater")
		d_cleaner_array pushBack _ent;
	};
	if (_ent isKindOf "Plane_Canopy_Base_F") exitWith {
		d_cleaner_array pushBack _ent;
	};
	if (_ent isKindOf "Ejection_Seat_Base_F") exitWith {
		d_cleaner_array pushBack _ent;
	};
};