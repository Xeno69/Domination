// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

//__TRACE("joingr")
if (player getVariable "xr_isleader") then {
	[group player, player] remoteExecCall ["d_fnc_selectLeader", 2];
};
player setVariable ["xr_isleader", false];