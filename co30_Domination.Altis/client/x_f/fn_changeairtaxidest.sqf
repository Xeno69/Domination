// by Xeno
#define THIS_FILE "fn_changeairtaxidest.sqf"
#include "..\..\x_setup.sqf"

d_x_do_call_taxi = false;

d_x_airtaximarker = "d_air_taxi_" + str player;
[d_x_airtaximarker, player getVariable "d_can_change_taxi", "ICON", "ColorBlue", [0.8,0.8], localize "STR_DOM_MISSIONSTRING_1882", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;

d_change_taxi_tmp = true;
createDialog "D_AirTaxiDialog";
waitUntil {!isNil "d_airdtaxi_dialog_open" && {d_x_do_call_taxi || {!d_airdtaxi_dialog_open || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}}}};

private _destination = markerPos d_x_airtaximarker;

if (!isNil "d_AISPAWN" && {_destination distance2D d_FLAG_BASE < 100}) then {_destination = getPos d_AISPAWN};

_destination set [2, 0];

player sideChat (localize "STR_DOM_MISSIONSTRING_1937");

[_destination] remoteExec ["d_fnc_airtaxi_dest", 2];

player setVariable ["d_can_change_taxi", _destination];

deleteMarkerLocal d_x_airtaximarker;