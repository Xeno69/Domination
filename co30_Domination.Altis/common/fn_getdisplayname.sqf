// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getdisplayname.sqf"
#include "..\x_setup.sqf"

// get displayname of an object
// parameters: type of object (string), what "CfgVehicles", "CfgWeapons", "CfgMagazines"
// example: _dispname = ["I_Plane_Fighter_03_AA_F", "CfgVehicles"] call d_fnc_GetDisplayName;
params ["_obj_name", "_obj_kind"];
if !(_obj_name isEqualType "") then {_obj_name = typeOf _obj_name};
getText (configFile>>_obj_kind>>_obj_name>>"displayName")
