// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

//__TRACE("joingr")
if (player getVariable "xr_isleader") then {
	private _grpl = group player;
	[_grpl, player] remoteExecCall ["xr_fnc_selleader", _grpl];
};
player setVariable ["xr_isleader", false];