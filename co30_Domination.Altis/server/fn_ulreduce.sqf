// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_unitliste", "_unitsPerGroup"];

if (count _unitliste > 2) then {
	private _nump = count ((allPlayers - entities "HeadlessClient_F") select {!(_x isKindOf "VirtualMan_F")}) min 40;
	
	private "_maxunits";
	
	if (_unitsPerGroup > 0) then {
		_maxunits = _unitsPerGroup;
	} else {
		_maxunits = round (linearConversion [1, 40, _nump, 3, 7, true]);
		if (_maxunits == 3) then {
			_maxunits = selectRandom [3, 4];
		} else {
			if (_maxunits == 7) then {
				_maxunits = selectRandom [6, 7];
			};
		};
	};
	
	__TRACE_2("","_nump","_maxunits")
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
