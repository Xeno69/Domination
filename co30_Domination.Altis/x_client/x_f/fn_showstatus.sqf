// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_showstatus.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

createDialog "d_StatusDialog";

d_commandingMenuIniting = false;

0 spawn {
	scriptName "spawn_waitforstatusdialogclose";
	waitUntil {!isNil "d_showstatus_dialog_open" && {!d_showstatus_dialog_open || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}}};
	if (d_showstatus_dialog_open) then {closeDialog 0};
};