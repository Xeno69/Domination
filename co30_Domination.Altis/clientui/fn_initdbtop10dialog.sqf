// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

#define __totscorecol [1, 1, 0, 1]

private _ctrl = (uiNamespace getVariable "D_DBTop10Dialog") displayCtrl 100;

private _start = 0.001;

private _row = ["Name", "Playtime", "Infkills", "Softveckills", "Armorkills", "Airkills", "Deaths", "Totalscore", "Radiotowerkills", "MT SM Kills", "Num played", "Camps captured", "Teamkills", "Revives", "Headshots", "Rounds fired"];

private _colwidth = 0.98 / (count _row);

__TRACE_1("","_colwidth")

for "_i" from 0 to count _row - 1 do {
	_ctrl lnbAddColumn (_start + (_i * _colwidth));
};

private _rowidx = _ctrl lnbAddRow _row;

_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];

_ctrl lnbAddRow [""];
if (!isNil "d_top10_db_players") then {
	{
		__TRACE_1("","_x")
		_rowidx = _ctrl lnbAddRow (_x apply {if (_x isEqualType "") then {_x} else {str _x}});
		_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
		_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
	} forEach d_top10_db_players;
} else {
	_rowidx = _ctrl lnbAddRow [localize "STR_DOM_MISSIONSTRING_2093"];
};

_ctrl lnbAddRow [""];

if (!isNil "d_pl_db_mstart") then {
	__TRACE_1("","d_pl_db_mstart")
	_rowidx = _ctrl lnbAddRow (d_pl_db_mstart apply {if (_x isEqualType "") then {_x} else {str _x}});
	_ctrl lnbSetText [[_rowidx, 7], str (score player)];
	_ctrl lnbSetText [[_rowidx, 15], str d_p_rounds];
	_ctrl lnbSetColor [[_rowidx, 0], __totscorecol];
	_ctrl lnbSetColor [[_rowidx, 7], __totscorecol];
};
