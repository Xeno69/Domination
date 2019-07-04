#define THIS_FILE "fn_unflipVehicle.sqf"
#include "..\..\x_setup.sqf"

player removeAction (_this select 2);
(_this select 3) params ["_vec"];
private _hhe = createVehicle [d_HeliHEmpty, getPosATL _vec, [], 0, "NONE"];
_vec setPos (getPosATL _hhe);
deleteVehicle _hhe;
