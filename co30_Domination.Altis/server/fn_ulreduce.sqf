// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ulreduce.sqf"
#include "..\x_setup.sqf"

params ["_unitliste", "_unitsPerGroup"];

if (count _unitliste > 2) then {
	private _nump = count (allPlayers - entities "HeadlessClient_F") min 40;
	
	private "_maxunits";
	
	if (_unitsPerGroup > 0) then {
    	_maxunits = _unitsPerGroup;
    } else {
		_maxunits = round (linearConversion [1, 40, _nump, 2, 6, true]);
		if (_maxunits == 2) then {
			_maxunits = selectRandom [2, 3];
		} else {
			if (_maxunits == 6) then {
				_maxunits = selectRandom [5, 6];
			};
		};
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
