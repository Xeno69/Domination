// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

private _cheml = _this;

__TRACE_1("","_cheml")

private _clight = _cheml createVehicle [0, 0, 0];

__TRACE_1("","_clight")
_clight attachTo [player, [0, -0.03, 0.07], "LeftShoulder"]; 
player setVariable ["d_p_clattached", _cheml];
player setVariable ["d_p_clattachedobj", _clight];
player removeMagazine _cheml;
d_commandingMenuIniting = false;