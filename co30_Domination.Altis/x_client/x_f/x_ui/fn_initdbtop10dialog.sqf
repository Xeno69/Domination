// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_initdbtop10dialog.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

#define CTRL(A) (_disp displayCtrl A)

private _ctrl = (uiNamespace getVariable "D_DBTop10Dialog") displayCtrl 100;

_ctrl lnbAddColumn 0.1;
_ctrl lnbAddColumn 0.17;
_ctrl lnbAddColumn 0.24;
_ctrl lnbAddColumn 0.31;
_ctrl lnbAddColumn 0.38;
_ctrl lnbAddColumn 0.45;
_ctrl lnbAddColumn 0.52;
_ctrl lnbAddColumn 0.59;
_ctrl lnbAddColumn 0.67;
_ctrl lnbAddColumn 0.74;
_ctrl lnbAddColumn 0.81;
_ctrl lnbAddColumn 0.88;

_ctrl lnbAddRow ["Name", "Playtime", "Infkills", "Softveckills", "Armorkills", "Airkills", "Deaths", "Totalscore", "Radiotowerkills", "MT SM Kills", "Num played", "Camps captured", "Teamkills"];
_ctrl lnbAddRow [""];
//_ctrl ctrlSetTooltip "Name|Playtime|Infkills|Softveckills|Armorkills|Airkills|Deaths|Totalscore|Radiotowerkills|Main Target Sidemission Kills|Number played on server|Camps captured|Teamkills";
{
	_ctrl lnbAddRow (_x apply {str _x});
	false
} count d_top10_db_players;

_ctrl lnbAddRow [""];

if (!isNil "d_pl_db_mstart") then {
	_ctrl lnbAddRow (d_pl_db_mstart apply {str _x});
};