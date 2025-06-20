// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","d_pl_mt_score_hash")

if (count d_pl_mt_score_hash == 0) exitWith {
	__TRACE("count d_pl_mt_score_hash is 0")
	d_pl_mt_score_hash = nil;
};

private _alllist = [];

{
	__TRACE_2("","_x","_y")
	if (!isNull (_y # 1)) then {
#ifdef __DEBUG__
		private _score = score (_y # 1);
		__TRACE_1("","_score")
#endif
		_alllist pushBack [score (_y # 1) - (_y # 0), _y # 2];
	} else {
		if ((_y # 3) != -11211) then {
			_alllist pushBack [_y # 3, _y # 2];
		};
	};
} forEach d_pl_mt_score_hash;

d_pl_mt_score_hash = nil;

//_alllist = [[50, "Peter"], [120, "Alex"], [75, "Heinz"], [3, "Pullover"], [843, "Loooooooooooooooongname"], [22, "Maria Hilf"], [120, "Alex"], [-10, "Murat"], [22, "Nutzlos"], [-500, "lololo"], [43, "Honka"]];

if (count _alllist == 0) exitWith {
	__TRACE("count _alllist is 0")
};

__TRACE_1("before sort","_alllist")

_alllist sort false;

__TRACE_1("after sort","_alllist")

if (count _alllist > 10) then {
	_alllist resize 10;
};

__TRACE_1("after resize","_alllist")

_alllist remoteExecCall ["d_fnc_showmtbest", [0, -2] select isDedicated];
