// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tranfserscoremsgdialog.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

private _disp = uiNamespace getVariable "d_TransferScoreDialog";

#define CTRL(A) (_disp displayCtrl A)

private _idx = lbCurSel CTRL(1001);

if (_idx == -1) exitWith {
	closeDialog 0;
};

private _playern = CTRL(1001) lbText _idx;
private _netid = CTRL(1001) lbData _idx;

closeDialog 0;

private _result = [format [localize "STR_DOM_MISSIONSTRING_1877", d_transscore, _playern], localize "STR_DOM_MISSIONSTRING_1878", true, true] call BIS_fnc_guiMessage;

if (_result) then {
	[player, _netid, d_transscore] remoteExecCall ["d_fnc_giveplayerscore", 2];
};