//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

params ["_obj"];
if (typeOf _obj == d_barracks_building || {typeOf _obj == d_vehicle_building || {typeOf _obj == d_illum_tower}}) exitWith {};
false