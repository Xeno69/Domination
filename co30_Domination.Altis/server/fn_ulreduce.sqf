// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ulreduce.sqf"
#include "..\x_setup.sqf"

params ["_unitliste", "_unitsPerGroup"];

if (count _unitliste > 2) then {
	private _nump = count (allPlayers - entities "HeadlessClient_F");
	// 30-40 0.15
	// 20-30 0.2
	// 1-20 0.26
	private _factor = call {
		if (_nump > 29) exitWith {
			0.15
		};
		if (_nump > 19) exitWith {
			0.2
		};
		0.26
	};
	
	private _maxunits = 99;
	
	if (_unitsPerGroup > 0) then {
    	_maxunits = _unitsPerGroup;
    } else {
    	_maxunits = round (_factor * _nump) max (selectRandom [2, 3]);
    };
	
	__TRACE_3("","_nump","_factor","_maxunits")
	if (_maxunits < count _unitliste) then {
		private _tmpar =+ _unitliste;
		_unitliste = [_tmpar # 0];
		_tmpar deleteAt 0;
		while {count _unitliste < _maxunits} do {
			_unitliste pushBack (selectRandom _tmpar);
		};
	};
	__TRACE_1("after","_unitliste")
};

_unitliste
