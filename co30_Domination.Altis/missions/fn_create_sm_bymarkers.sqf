// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_create_sm_bymarkers.sqf"
#include "..\x_setup.sqf"

// example, number must be unique (d_smm|uniqe number|), otherwise it will overwrite the previous entry
// d_smm|1|convoy|start
// d_smm|1|convoy|end
// d_smm|33|convoy|start
// d_smm|33|convoy|end
// d_smm|21|stealflag|flag|1|smarmor|1|2|1|1|400|true|sminf|1|2|300|false
// d_smm|21|stealflag|flag|2
// d_smm|21|stealflag|flag|3
// d_smm|21|stealflag|flag|4
// d_smm|21|stealflag|flag|5
// d_smm|21|stealflag|smarmor|1|2|1|1|400|true
// |1|2|1|1|400|true = 1 aa vehicle group| 2 tracked apc groups| 1 tank group| 1 vehicle per group| placed in 400m radius| do patrol
// d_smm|21|stealflag|sminf|1|2|300|false
// |1|2|300|false = 1 specops group| 2 normal inf groups| placed in 300m radius| do not patrol
// d_smm|8|tankdepot|tank|1
// d_smm|8|tankdepot|tank|2
// d_smm|8|tankdepot|tank|3
// d_smm|8|tankdepot|tank|4
// d_smm|8|tankdepot|tank|5
// d_smm|8|tankdepot|smarmor|1|2|1|1|400|true
// d_smm|8|tankdepot|sminf|1|2|300|true
// d_smm|23|arrest
// d_smm|24|artibase
// d_smm|8|deliver
// d_smm|41|evac|time|15
// |15 = number of minutes to wait before ai attack pilots
// d_smm|49|radiotower
// d_smm|50|radiotower|smarmor|1|2|1|1|400|true|sminf|1|2|300|false
// d_smm|77|prisoners
// d_smm|71|stealchopper
// d_smm|72|stealtank
// d_smm|73|stealplane
// d_smm|66|specops|radius|50
// d_smm|173|eliminateofficer
// d_smm|174|eliminategovmember
// d_smm|81|fuelstation
// d_smm|82|transformer
// d_smm|83|barracks
// d_smm|84|hangar
// d_smm|175|eliminatesniper
// d_smm|512|cargotruck
// d_smm|12|minesland
// d_smm|12|minesnaval
// d_smm|19|artycannon
// d_smm|667|dataterminal
// d_smm|668|device
// d_smm|669|sam
// d_smm|670|cache
// d_smm|671|trucks
// d_smm|701|gleak

private _dallsidemissions = [];

private _smtypes = ["convoy", "stealflag", "tankdepot", "arrest", "artibase", "deliver", "evac", "radiotower", "prisoners",
	"stealapc", "stealchopper", "stealtank", "stealplane", "specops", "eliminateofficer", "eliminategovmember", "fuelstation",
	"transformer", "barracks", "hangar", "eliminatesniper", "cargotruck", "minesland", "minesnaval", "dataterminal", "device",
	"sam", "cache", "trucks", "artycannon", "gleak", "farp"] apply {toLowerANSI _x};
private _subtypes = ["start", "end", "flag", "tank", "time", "radius"] apply {toLowerANSI _x};

private _infhelper_fnc = {
	params ["_fidx", "_marar", "_curmar"];
	["specops", parseNumber (_marar # (_fidx + 1)), "allmen", parseNumber (_marar # (_fidx + 2)), markerPos _curmar, parseNumber (_marar # (_fidx + 3)), _marar # (_fidx + 4) == "true"]
};

private _armorhelper_fnc = {
	params ["_fidx", "_marar", "_curmar"];
	["aa", parseNumber (_marar # (_fidx + 1)), "tracked_apc", parseNumber (_marar # (_fidx + 2)), "tank", parseNumber (_marar # (_fidx + 3)), markerPos _curmar, parseNumber (_marar # (_fidx + 4)), parseNumber (_marar # (_fidx + 5)), _marar # (_fidx + 6) == "true"]
};

#ifdef __DEBUG__
_eee = allMapMarkers select {_x select [0, 6] == "d_smm|"};
__TRACE_1("","_eee")
#endif

{
	__TRACE_1("","_x")
	private _curmar = _x;
	private _marar = _curmar splitString "|";
	__TRACE_1("","_marar")
	_marar params ["", "_idx" , "_smtype"];
	_smtype = toLowerANSI _smtype;
	__TRACE_1("","_smtype")
	
	if !(_smtype in _smtypes) exitWith {
		private _msg = format ["Error: Side mission type %1 does not exist!!!!", _smtype];
		diag_log _msg;
		player sideChat _msg;
	};
	
	private _subtype = "";
	private _subtypeidx = -1;
	for "_i" from 3 to (count _marar - 1) do {
		private _str = toLowerANSI (_marar # _i);
		if (_str in _subtypes) exitWith {
			_subtype = _str;
			_subtypeidx = _i;
		};
	};
	__TRACE_2("","_subtype","_subtypeidx")
	
	private _onesmar = d_sm_store getVariable _idx;
	
	if (isNil "_onesmar") then {
		_dallsidemissions pushBack ((parseNumber _idx) + 50000);
		private _smposis = if (_smtype == "convoy") then {
			[[], []]
		} else {
			[]
		};

		_onesmar = [parseNumber _idx, _smtype, _smposis, [], [], "", "", -4.5]; // array idx 2 = sm positions like convoy start/end or flags or tanks, etc; idx 3 = armor positions, idx 4 = inf positions, client only: idx 5 = d_cur_sm_txt, idx 7 = d_current_mission_resolved_text
	};
	
	if (isServer) then {
		private _fidx = _marar find "smarmor";
		if (_fidx != -1) then {
			if (_marar # (_fidx + 1) == "no") then {
				_onesmar set [3, false];
			} else {
				(_onesmar # 3) pushBack ([_fidx, _marar, _curmar] call _armorhelper_fnc);
			};
		};
		_fidx = _marar find "sminf";
		if (_fidx != -1) then {
			if (_marar # (_fidx + 1) == "no") then {
				_onesmar set [4, false];
			} else {
				(_onesmar # 4) pushBack ([_fidx, _marar, _curmar] call _infhelper_fnc);
			};
		};
	};
	
	call {
		if (_smtype == "convoy") exitWith {
			call {
				if (_subtype == "start") exitWith {
					(_onesmar # 2) set [0, markerPos _curmar];
					_onesmar set [7, markerDir _curmar];
					if (hasInterface) then {
						_onesmar set [5, "1801"]; // only the number of the STR_DOM_MISSIONSTRING, so 1801 means it will localize "STR_DOM_MISSIONSTRING_1801"
						_onesmar set [6, "753"];
					};
				};
				if (_subtype == "end") exitWith {
					(_onesmar # 2) set [1, markerPos _curmar];
				};
			};
		};
		
		if (_smtype == "stealflag") exitWith {
			call {
				if (_subtype == "flag") exitWith {
					(_onesmar # 2) pushBack (markerPos _curmar);
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "775"];
						_onesmar set [6, "776"];
					};
				};
			};
		};
		
		if (_smtype == "tankdepot") exitWith {
			call {
				if (_subtype == "tank") exitWith {
					(_onesmar # 2) pushBack [markerPos _curmar, markerDir _curmar];
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1810"];
						_onesmar set [6, "767"];
					};
				};
			};
		};
		
		if (_smtype == "arrest") exitWith {
			call {
				if (_subtype == "") exitWith {
					(_onesmar # 2) pushBack (markerPos _curmar);
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1800"];
						_onesmar set [6, "792"];
					};
				};
			};
		};
		
		if (_smtype == "artibase") exitWith {
			call {
				if (_subtype == "") exitWith {
					(_onesmar # 2) pushBack (markerPos _curmar);
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1448"];
						_onesmar set [6, "810"];
					};
				};
			};
		};
		
		if (_smtype == "deliver") exitWith {
			call {
				if (_subtype == "") exitWith {
					(_onesmar # 2) pushBack (markerPos "d_sm_loga");
					(_onesmar # 2) pushBack (markerPos _curmar);
					_onesmar set [7, markerDir _curmar];
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1664"];
						_onesmar set [6, "1665"];
					};
				};
			};
		};
		
		if (_smtype == "evac") exitWith {
			call {
				if ((_onesmar # 2) isEqualTo []) then {
					(_onesmar # 2) pushBack (markerPos _curmar);
					_onesmar set [7, markerDir _curmar];
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1803"];
						_onesmar set [6, "812"];
					};
				};
				if (_subtype == "time") then {
					if (isServer) then {
						_onesmar pushBack (parseNumber (_marar # (_subtypeidx + 1)));
					};
				};
			};
		};
		
		if (_smtype == "radiotower") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1815"];
						_onesmar set [6, "727"];
					};
				};
			};
		};
		
		if (_smtype == "prisoners") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1805"];
						_onesmar set [6, "789"];
					};
				};
			};
		};
		
		if (_smtype == "stealchopper") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1809"];
						_onesmar set [6, "796"];
					};
				};
			};
		};
		
		if (_smtype == "stealapc") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1819"];
						_onesmar set [6, "1551"];
					};
				};
			};
		};
		
		if (_smtype == "stealtank") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1808"];
						_onesmar set [6, "769"];
					};
				};
			};
		};
		
		if (_smtype == "stealplane") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1807"];
						_onesmar set [6, "750"];
					};
				};
			};
		};
		
		if (_smtype == "specops") exitWith {
			call {
				if ((_onesmar # 2) isEqualTo []) then {
					(_onesmar # 2) pushBack (markerPos _curmar);
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1806"];
						_onesmar set [6, "760"];
					};
				};
				if (_subtype == "radius") then {
					if (isServer) then {
						_onesmar pushBack (parseNumber (_marar # (_subtypeidx + 1)))
					};
				};
			};
		};
		
		if (_smtype == "eliminateofficer") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1813"];
						_onesmar set [6, "729"];
					};
				};
			};
		};
		
		if (_smtype == "eliminategovmember") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1817"];
						_onesmar set [6, "729"];
					};
				};
			};
		};
		
		if (_smtype == "eliminatesniper") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1814"];
						_onesmar set [6, "1545"];
					};
				};
			};
		};
		
		if (_smtype == "fuelstation") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "757"];
						_onesmar set [6, "758"];
					};
				};
			};
		};
		
		if (_smtype == "transformer") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1804"];
						_onesmar set [6, "741"];
					};
				};
			};
		};
		
		if (_smtype == "barracks") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "816"];
						_onesmar set [6, "817"];
					};
				};
			};
		};
		
		if (_smtype == "hangar") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "814"];
						_onesmar set [6, "815"];
					};
				};
			};
		};
		
		if (_smtype == "cargotruck") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "858"];
						_onesmar set [6, "787"];
					};
				};
			};
		};
		
		if (_smtype == "minesland") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1666a"];
						_onesmar set [6, "1667"];
					};
				};
			};
		};
		
		if (_smtype == "minesnaval") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1666"];
						_onesmar set [6, "1667"];
					};
				};
			};
		};
		
		if (_smtype == "artycannon") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1811"];
						_onesmar set [6, "731"];
					};
				};
			};
		};
		
		if (_smtype == "dataterminal") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1841"];
						_onesmar set [6, "1842"];
					};
				};
			};
		};
		
		if (_smtype == "device") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1844"];
						_onesmar set [6, "1845"];
					};
				};
			};
		};
		
		if (_smtype == "sam") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1846"];
						_onesmar set [6, "1847"];
					};
				};
			};
		};
		
		if (_smtype == "cache") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "1849"];
						_onesmar set [6, "1850"];
					};
				};
			};
		};
		
		if (_smtype == "trucks") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
						_onesmar set [7, markerDir _curmar];
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "49"];
						_onesmar set [6, "50"];
					};
				};
			};
		};
		
		if (_smtype == "gleak") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "2010"];
						_onesmar set [6, "2011"];
					};
				};
			};
		};
		
		if (_smtype == "farp") exitWith {
			call {
				if (_subtype == "") exitWith {
					if ((_onesmar # 2) isEqualTo []) then {
						(_onesmar # 2) pushBack (markerPos _curmar);
					};
					if (hasInterface && {_onesmar # 5 == ""}) then {
						_onesmar set [5, "2029"];
						_onesmar set [6, "2030"];
					};
				};
			};
		};
	};
	
	__TRACE_1("","_onesmar");
	d_sm_store setVariable [_idx, _onesmar];
} forEach (allMapMarkers select {_x select [0, 6] == "d_smm|"});

if (isServer && {_dallsidemissions isNotEqualTo []}) then {
	d_sm_array append _dallsidemissions;
};