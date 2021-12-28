// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _disp = uiNamespace getVariable "d_TransferScoreDialog";

private _idx = lbCurSel (_disp displayCtrl 1001);

if (_idx == -1) exitWith {
	closeDialog 0;
};

private _playern = (_disp displayCtrl 1001) lbText _idx;
private _netid = (_disp displayCtrl 1001) lbData _idx;

closeDialog 0;

private _result = [format [localize "STR_DOM_MISSIONSTRING_1877", d_transscore, _playern], localize "STR_DOM_MISSIONSTRING_1878", true, true] call BIS_fnc_guiMessage;

if (_result) then {
	[player, _netid, d_transscore] remoteExecCall ["d_fnc_giveplayerscore", 2];
};