// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_airtaxi_dest.sqf"
#include "..\x_setup.sqf"

if (isNil "d_airtaxi_driver" || {isNull d_airtaxi_driver}) exitWith {};

params ["_destination"];

private _nendpos = _destination findEmptyPosition [10, 200, d_airtaxi_driver getVariable "d_type"];
if !(_nendpos isEqualTo []) then {_nendpos = _destination};
if (!isNil {d_airtaxi_driver getVariable "d_isondestway"}) then {
	d_airtaxi_driver doMove _nendpos;
	(d_airtaxi_driver getVariable "d_hempty") setVehiclePosition [_nendpos, [], 0, "NONE"];
} else {
	d_airtaxi_driver setVariable ["d_newdest", _nendpos];
};

