// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (count d_pl_mt_score_hash == 0) exitWith {
	d_pl_mt_score_hash = nil;
};

private _alllist = [];
{
	if (!isNull (_y # 1)) then {
		_alllist pushBack [score (_y # 1) - (_y # 0), _y # 2];
	};
} forEach d_pl_mt_score_hash;

d_pl_mt_score_hash = nil;

//_alllist = [[50, objNull, "Peter"], [120, objNull, "Alex"], [75, objNull, "Heinz"], [3, objNull, "Pullover"], [843, objNull, "Loooooooooooooooongname"], [22, objNull, "Maria Hilf"], [120, objNull, "Alex"], [-10, objNull, "Murat"], [22, objNull, "Nutzlos"], [-500, objNull, "lololo"], [43, objNull, "Honka"]];

if (count _alllist == 0) exitWith {};

_alllist sort false;

if (count _alllist > 10) then {
	_alllist resize 10;
};

__TRACE_1("","_alllist")

_alllist remoteExecCall ["d_fnc_showmtbest", [0, -2] select isDedicated];
