//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// cause a unit to play a gesture
params ["_unit", "_gesture"];
if (!isServer) exitWith {};
_unit playMoveNow _gesture;
