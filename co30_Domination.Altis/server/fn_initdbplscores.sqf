// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initdbplscores.sqf"
#include "..\x_setup.sqf"

params ["_pl", "_ar"];
sleep 10;
if (isNull _pl) exitWith {
	diag_log ["DOM initdbplscores, _pl is null", "_pl", _pl, "_ar", _ar];
};
private _plsar = getPlayerScores _pl;
__TRACE_1("","_plsar")
if (_plsar isNotEqualTo [] && {_ar isNotEqualTo []}) then {
	_pl addPlayerScores [(_ar # 1) - (_plsar # 0), _ar # 2 - (_plsar # 1), _ar # 3 - (_plsar # 2), _ar # 4 - (_plsar # 3), _ar # 5 - (_plsar # 4)];
} else {
	diag_log ["DOM initdbplscores, _plsar or _ar empty", "_plsar", _plsar, "_pl", _pl, "_ar", _ar];
};
if (_ar isEqualTo []) exitWith {};
__TRACE_1("","getPlayerScores _pl")
__TRACE_1("","score _pl")
sleep 1;
__TRACE_1("1","getPlayerScores _pl")
__TRACE_1("1","score _pl")
__TRACE_2("Adding score","_pl","_ar")
if (_ar # 0 != score _pl) then {
	if (score _pl > 0) then {
		_pl addScore -(score _pl);
	};
	_pl addScore ((_ar # 0) - score _pl);
};
__TRACE_1("2","getPlayerScores _pl")
__TRACE_1("2","score _pl")