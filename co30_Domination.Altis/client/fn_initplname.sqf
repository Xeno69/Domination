// by Xeno
#define THIS_FILE "fn_initplname.sqf"
#include "..\x_setup.sqf"

waitUntil {time > 0 && {player == player}};
sleep (6 + random 2);
private _np = player getVariable ["d_plname", ""];
if (_np isEqualTo "" || {_np isEqualTo "Error: No unit"}) then {
	_np = profileName splitString """'" joinString "";
	if (_np isEqualTo "Error: No unit") then {
		_np = (name player) splitString """'" joinString "";
	};
	player setVariable ["d_plname", _np, true];
};
__TRACE_1("","_np")
d_name_pl = _np;