// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_park_player.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

params ["_dosleep"];
__TRACE_1("park_player","_dosleep")
player setVariable ["xr_isdead", true];
xr_phd_invulnerable = true;
if (_dosleep) then {
	private _etime = time + (player getVariable "xr_presptime") - 1.3;
	__TRACE_1("killedeh spawn","_etime")
	waitUntil {time >= _etime};
	__TRACE("park_player, black out")
	"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_931", "BLACK OUT", 1];
	waitUntil {alive player};
};
//player setPos (markerPos "xr_playerparkmarker");
player setVehiclePosition [markerPos "xr_playerparkmarker", [], 0, "NONE"]; // CAN_COLLIDE ?
player remoteExecCall ["hideObjectGlobal", 2];
[false] spawn xr_fnc_spectating;
__TRACE("park_player, black in")
"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_931", "BLACK IN", 1];