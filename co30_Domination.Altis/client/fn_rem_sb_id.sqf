// by Xeno
#define THIS_FILE "fn_rem_sb_id.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (!isNil "d_searchbody" && {!isNil {d_searchbody getVariable "d_search_id"}}) then {
	[d_searchbody, d_searchbody getVariable "d_search_id"] call bis_fnc_holdActionRemove;
	d_searchbody setVariable ["d_search_id", nil];
};