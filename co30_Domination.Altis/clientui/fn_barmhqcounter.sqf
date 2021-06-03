// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_trig", "_num"];

private _vec = _trig getVariable "d_vec";

private _isbarormhq = _vec getVariable "d_isbarormhq";

private _txt = call {
	if (_isbarormhq == 0) exitWith {
		localize "STR_DOM_MISSIONSTRING_2081";
	};
	if (_isbarormhq == 1) exitWith {
		localize "STR_DOM_MISSIONSTRING_2082";
	};
	localize "STR_DOM_MISSIONSTRING_2083"
};

private _varname = format ["d_barmhqctrigbool_%1", _num];

__TRACE_2("","_vec","_varname")

private _do_del = false;

while {true} do {
	if (isNull _trig || {isNull _vec || {!(missionNamespace getVariable _varname)}}) exitWith {};
	
	private _disp = uiNamespace getVariable "d_RscBarMHQTake";
	if (isNil "_disp" || {isNull _disp}) then {
		"d_RscBarMHQTake" cutRsc ["d_RscBarMHQTake", "PLAIN"];
		_disp = uiNamespace getVariable "d_RscBarMHQTake";
		(_disp displayCtrl 3900) ctrlSetText _txt;
	};

	private _ttk = _vec getVariable "d_timetotake";
	private _taket = _vec getVariable "d_taketime";
	private _lin = round (linearConversion [0, _ttk, _taket, 0, 24, true]);
	__TRACE_3("","_ttk","_taket","_lin")
	(_disp displayCtrl 50) ctrlSetText format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _lin];
	
	if (_taket >= _ttk) exitWith {
		_do_del = true;
	};
	
	sleep 1;
};

if (_do_del && {!isNull _trig}) then {
	deleteVehicle _trig;
};

sleep 1;

"d_RscBarMHQTake" cutText ["", "PLAIN"];
