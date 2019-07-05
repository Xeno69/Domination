// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_adminspectate.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (isMultiplayer && {!d_pisadminp}) exitWith {d_commandingMenuIniting = false};

if !(["IsInitialized"] call BIS_fnc_EGSpectator) then {
	xr_phd_invulnerable = true;
	player setVariable ["AllowAi", false];
	d_spect_viewdistance = viewDistance;
	["Initialize", [player, [], !isMultiplayer, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
	d_rscspect_on = true;
	0 spawn {
		scriptName "spawn_adminspectate";
		sleep 2;
		d_spect_disp_handler = (["GetDisplay"] call BIS_fnc_EGSpectator) displayAddEventHandler ["KeyDown", {_this call d_fnc_egspectkeyeh}];
	};
	"d_adminspecttxt" cutText [localize "STR_DOM_MISSIONSTRING_1511", "PLAIN"];
} else {
	["Terminate"] call BIS_fnc_EGSpectator;
	xr_phd_invulnerable = false;
	d_commandingMenuIniting = false;
	d_rscspect_on = false;
	if (!isNil "d_spect_viewdistance") then {
		if (d_spect_viewdistance != viewDistance) then {
			setViewDistance d_spect_viewdistance;
		};
		d_spect_viewdistance = nil;
	};
};
