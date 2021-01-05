// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initdbtop10dialog.sqf"
#include "..\x_setup.sqf"

disableSerialization;

#define CTRL(A) (_disp displayCtrl A)
#define __totscorecol [1, 1, 0, 1]

private _ctrl = (uiNamespace getVariable "D_DBTop10Dialog") displayCtrl 100;

private _colwidth = 0.9 / 14;

__TRACE_1("","_colwidth")
__TRACE_1("","safeZoneW")

private _start = 0.1;

private _row = ["Name", "Playtime", "Infkills", "Softveckills", "Armorkills", "Airkills", "Deaths", "Totalscore", "Radiotowerkills", "MT SM Kills", "Num played", "Camps captured", "Teamkills", "Revives", "Headshots"];

private _rowidx = _ctrl lnbAddRow _row;

for "_i" from 0 to count _row - 1 do {
	_ctrl lnbAddColumn (_start + (_i * _colwidth));
};

_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
_ctrl lnbAddRow [""];
{
	_rowidx = _ctrl lnbAddRow (_x apply {str _x});
	_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
	_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
} forEach d_top10_db_players;

_ctrl lnbAddRow [""];

if (!isNil "d_pl_db_mstart") then {
	_rowidx = _ctrl lnbAddRow (d_pl_db_mstart apply {str _x});
	_ctrl lnbSetText [[_rowidx, 7], score player];
	_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
	_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
};