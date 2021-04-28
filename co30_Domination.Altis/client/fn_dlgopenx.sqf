// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (dialog) then {closeDialog 0};

d_beam_target = "";
d_tele_dialog = 0; // 0 = respawn, 1 = teleport

disableSerialization;

xr_respawn_available = true;

createDialog "d_TeleportDialog";

#define __CTRL(A) ((uiNamespace getVariable "d_TeleportDialog") displayCtrl A)
__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_298");
__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_299");

d_x_loop_end = false;

0 spawn d_fnc_dlgopenxwait;
