// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_initdbtop10dialog.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

#define CTRL(A) (_disp displayCtrl A)
#define __totscorecol [1, 1, 0, 1]

private _ctrl = (uiNamespace getVariable "D_DBTop10Dialog") displayCtrl 100;

_ctrl lnbAddColumn 0.1;
_ctrl lnbAddColumn 0.16;
_ctrl lnbAddColumn 0.22;
_ctrl lnbAddColumn 0.28;
_ctrl lnbAddColumn 0.34;
_ctrl lnbAddColumn 0.40;
_ctrl lnbAddColumn 0.46;
_ctrl lnbAddColumn 0.52;
_ctrl lnbAddColumn 0.58;
_ctrl lnbAddColumn 0.64;
_ctrl lnbAddColumn 0.70;
_ctrl lnbAddColumn 0.76;
_ctrl lnbAddColumn 0.82;

private _rowidx = _ctrl lnbAddRow ["Name", "Playtime", "Infkills", "Softveckills", "Armorkills", "Airkills", "Deaths", "Totalscore", "Radiotowerkills", "MT SM Kills", "Num played", "Camps captured", "Teamkills", "Revives"];
_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
_ctrl lnbAddRow [""];
{
	_rowidx = _ctrl lnbAddRow (_x apply {str _x});
	_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
	_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
	false
} count d_top10_db_players;

_ctrl lnbAddRow [""];

if (!isNil "d_pl_db_mstart") then {
	_rowidx = _ctrl lnbAddRow (d_pl_db_mstart apply {str _x});
	_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
	_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
};