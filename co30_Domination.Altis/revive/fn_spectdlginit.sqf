// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spectdlginit.sqf"
#include "..\x_macros.sqf"

disableSerialization;

params ["_disp"];

_disp displayAddEventHandler ["KeyDown", {call xr_fnc_spectkeyeh}];

false
