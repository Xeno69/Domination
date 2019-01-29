// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_engtrig1fnc.sqf"
#include "..\..\x_setup.sqf"

if (player getVariable ["d_has_ffunc_aid", -9999] == -9999 && {player call d_fnc_hastoolkit && {call d_fnc_ffunc}}) then {
	player setVariable ["d_has_ffunc_aid", player addAction [format ["<t color='#7F7F7F'>%1</t>", localize "STR_DOM_MISSIONSTRING_1408"], {_this call d_fnc_unflipVehicle}, [d_objectID1], -1, false]];
} else {
	if (player getVariable ["d_has_ffunc_aid", -9999] != -9999 && {!(call d_fnc_ffunc)}) then {
		player removeAction (player getVariable "d_has_ffunc_aid");
		player setVariable ["d_has_ffunc_aid", -9999];
	};
};