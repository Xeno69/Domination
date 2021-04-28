// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// get displayname of an object
// parameters: type of object (string), what "CfgVehicles", "CfgWeapons", "CfgMagazines"
// example: _dispname = ["I_Plane_Fighter_03_AA_F", "CfgVehicles"] call d_fnc_GetDisplayName;
params ["_obj_name", "_obj_kind"];
if (_obj_name isEqualType "") exitWith {
	getText (configFile>>_obj_kind>>_obj_name>>"displayName");
};
if (_obj_name isEqualType configNull) exitWith {
	getText (_obj_name>>"displayName");
};
getText (configOf _obj_name>>"displayName")
