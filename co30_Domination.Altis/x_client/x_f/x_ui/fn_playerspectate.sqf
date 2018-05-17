// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerspectate.sqf"
#include "..\..\..\x_setup.sqf"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"

if (isDedicated) exitWith {};

if !(["IsInitialized"] call BIS_fnc_EGSpectator) then {
	xr_phd_invulnerable = true;
	player setVariable ["AllowAi", false];
	d_spect_viewdistance = viewDistance;
	["Initialize", [player, d_own_sides_o, !isMultiplayer, true, true, true, true, true, true, true]] call BIS_fnc_EGSpectator;
	d_rscspect_on = true;
	0 spawn {
		sleep 2;
		d_spect_disp_handler = (["GetDisplay"] call BIS_fnc_EGSpectator) displayAddEventHandler ["KeyDown", {
			if (_this select 1 == DIK_X) then {
				xr_phd_invulnerable = false;
				(["GetDisplay"] call BIS_fnc_EGSpectator) displayRemoveEventHandler ["KeyDown" ,d_spect_disp_handler];
				["Terminate"] call BIS_fnc_EGSpectator;
				d_commandingMenuIniting = false;
				d_rscspect_on = nil;
				if (!isNil "d_spect_viewdistance") then {
					if (d_spect_viewdistance != viewDistance) then {
						setViewDistance d_spect_viewdistance;
					};
					d_spect_viewdistance = nil;
				};
				"d_adminspecttxt" cutText ["", "PLAIN"];
				true
			} else {
				false
			};
		}];
	};
	"d_adminspecttxt" cutText [localize "STR_DOM_MISSIONSTRING_1511", "PLAIN"];
} else {
	["Terminate"] call BIS_fnc_EGSpectator;
	xr_phd_invulnerable = false;
	d_commandingMenuIniting = false;
	d_rscspect_on = nil;
	if (!isNil "d_spect_viewdistance") then {
		if (d_spect_viewdistance != viewDistance) then {
			setViewDistance d_spect_viewdistance;
		};
		d_spect_viewdistance = nil;
	};
};