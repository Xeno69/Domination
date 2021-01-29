// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_showstatus.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

createDialog "d_StatusDialog";

d_commandingMenuIniting = false;

0 spawn {
	scriptName "spawn_waitforstatusdialogclose";
	waitUntil {!isNil "d_showstatus_dialog_open" && {!d_showstatus_dialog_open || {!d_player_canu}}};
	if (d_showstatus_dialog_open) then {closeDialog 0};
};