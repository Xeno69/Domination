// by Xeno
#define THIS_FILE "kbinit.sqf"
#include "..\x_setup.sqf"

if (isServer) then {
	if (d_tt_ver || {d_own_side == "WEST"}) then {
		private _grpen = [blufor] call d_fnc_creategroup;
		d_hq_logic_blufor1 = _grpen createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_blufor1] joinSilent _grpen;
		if (d_with_ai) then {
			_grpen setVariable ["d_do_not_delete", true];
		};
		_grpen deleteGroupWhenEmpty true;
		d_hq_logic_blufor1 enableSimulationGlobal false;
		publicVariable "d_hq_logic_blufor1";
		d_hq_logic_blufor1 setVariable ["d_hq_logic_name", "d_hq_logic_blufor1"];
		d_hq_logic_blufor1 setVariable ["d_hq_logic_side", blufor];
		d_hq_logic_blufor1 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
		
		d_hq_logic_blufor2 = _grpen createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_blufor2] joinSilent _grpen;
		d_hq_logic_blufor2 addEventHandler ["handleDamage",{0}];
		d_hq_logic_blufor2 enableSimulationGlobal false;
		publicVariable "d_hq_logic_blufor2";
		d_hq_logic_blufor2 setVariable ["d_hq_logic_name", "d_hq_logic_blufor2"];
		d_hq_logic_blufor2 setVariable ["d_hq_logic_side", blufor];
		d_hq_logic_blufor2 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
	};
	if (d_tt_ver || {d_own_side == "EAST"}) then {
		private _grpru = [opfor] call d_fnc_creategroup;
		d_hq_logic_opfor1 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_opfor1] joinSilent _grpru;
		if (d_with_ai) then {
			_grpru setVariable ["d_do_not_delete", true];
		};
		_grpru deleteGroupWhenEmpty true;
		d_hq_logic_opfor1 enableSimulationGlobal false;
		d_hq_logic_opfor1 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_opfor1";
		d_hq_logic_opfor1 setVariable ["d_hq_logic_name", "d_hq_logic_opfor1"];
		d_hq_logic_opfor1 setVariable ["d_hq_logic_side", opfor];
		d_hq_logic_opfor1 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
		
		d_hq_logic_opfor2 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_opfor2] joinSilent _grpru;
		d_hq_logic_opfor2 enableSimulationGlobal false;
		d_hq_logic_opfor2 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_opfor2";
		d_hq_logic_opfor2 setVariable ["d_hq_logic_name", "d_hq_logic_opfor2"];
		d_hq_logic_opfor2 setVariable ["d_hq_logic_side", opfor];
		d_hq_logic_opfor2 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
	};
	if (d_own_side == "GUER" || {d_ifa3lite}) then {
		private _grpru = [independent] call d_fnc_creategroup;
		d_hq_logic_guer1 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_guer1] joinSilent _grpru;
		if (d_with_ai) then {
			_grpru setVariable ["d_do_not_delete", true];
		};
		_grpru deleteGroupWhenEmpty true;
		d_hq_logic_guer1 enableSimulationGlobal false;
		d_hq_logic_guer1 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_guer1";
		d_hq_logic_guer1 setVariable ["d_hq_logic_name", "d_hq_logic_guer1"];
		d_hq_logic_guer1 setVariable ["d_hq_logic_side", independent];
		d_hq_logic_guer1 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
		
		d_hq_logic_guer2 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_guer2] joinSilent _grpru;
		d_hq_logic_guer2 enableSimulationGlobal false;
		d_hq_logic_guer2 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_guer2";
		d_hq_logic_guer2 setVariable ["d_hq_logic_name", "d_hq_logic_guer2"];
		d_hq_logic_guer2 setVariable ["d_hq_logic_side", independent];
		d_hq_logic_guer2 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
	};
};

private _kbscript = "x_bikb\domkba3.bikb";

if (d_tt_ver || {d_own_side == "EAST"}) then {
	d_hq_logic_opfor1 kbAddTopic["HQ_E",_kbscript];
	d_hq_logic_opfor1 kbAddTopic["HQ_ART_E",_kbscript];
	call {
		if (d_rhs) exitWith {
			d_hq_logic_opfor1 setIdentity "RDHQ_OP1";
		};
		if (d_gmcwg) exitWith {
			d_hq_logic_opfor1 setIdentity "GMDHQ_OP1";
		};
		d_hq_logic_opfor1 setIdentity "DHQ_OP1";
	};
	d_hq_logic_opfor1 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_opfor1 setGroupIdGlobal ["HQ"];
	};
	call {
		if (d_rhs) exitWith {
			d_hq_logic_opfor1 setVariable ["d_kddata", [["HQ_E", "HQ_ART_E"], "RDHQ_OP1", "HQ"]];
		};
		if (d_gmcwg) exitWith {
			d_hq_logic_opfor1 setVariable ["d_kddata", [["HQ_E", "HQ_ART_E"], "GMDHQ_OP1", "HQ"]];
		};
		d_hq_logic_opfor1 setVariable ["d_kddata", [["HQ_E", "HQ_ART_E"], "DHQ_OP1", "HQ"]];
	};
	d_hq_logic_opfor2 kbAddTopic["HQ_E",_kbscript];
	call {
		if (d_rhs) exitWith {
			d_hq_logic_opfor2 setIdentity "RDHQ_OP2";
		};
		if (d_gmcwg) exitWith {
			d_hq_logic_opfor2 setIdentity "GMDHQ_OP2";
		};
		d_hq_logic_opfor2 setIdentity "DHQ_OP2";
	};
	d_hq_logic_opfor2 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_opfor2 setGroupIdGlobal ["Papa Bear"];
	};
	call {
		if (d_rhs) exitWith {
			d_hq_logic_opfor2 setVariable ["d_kddata", [["HQ_E"], "RDHQ_OP2", "Papa Bear"]];
		};
		if (d_gmcwg) exitWith {
			d_hq_logic_opfor2 setVariable ["d_kddata", [["HQ_E"], "GMDHQ_OP2", "Papa Bear"]];
		};
		d_hq_logic_opfor2 setVariable ["d_kddata", [["HQ_E"], "DHQ_OP2", "Papa Bear"]];
	};
};

if (d_tt_ver || {d_own_side == "WEST"}) then {
	d_hq_logic_blufor1 kbAddTopic["HQ_W",_kbscript];
	d_hq_logic_blufor1 kbAddTopic["HQ_ART_W",_kbscript];
	call {
		if (d_gmcwg) exitWith {
			d_hq_logic_blufor1 setIdentity "GMDHQ_BF1";
		};
		d_hq_logic_blufor1 setIdentity "DHQ_BF1";
	};
	d_hq_logic_blufor1 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_blufor1 setGroupIdGlobal ["Crossroad"];
	};
	call {
		if (d_gmcwg) exitWith {
			d_hq_logic_blufor1 setVariable ["d_kddata", [["HQ_W", "HQ_ART_W"], "GMDHQ_BF1", "Crossroad"]];
		};
		d_hq_logic_blufor1 setVariable ["d_kddata", [["HQ_W", "HQ_ART_W"], "DHQ_BF1", "Crossroad"]];
	};
	d_hq_logic_blufor2 kbAddTopic["HQ_W",_kbscript];
	call {
		if (d_gmcwg) exitWith {
			d_hq_logic_blufor2 setIdentity "GMDHQ_BF2";
		};
		d_hq_logic_blufor2 setIdentity "DHQ_BF2";
	};
	d_hq_logic_blufor2 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_blufor2 setGroupIdGlobal ["Papa Bear"];
	};
	call {
		if (d_gmcwg) exitWith {
			d_hq_logic_blufor2 setVariable ["d_kddata", [["HQ_W"], "GMDHQ_BF2", "Papa Bear"]];
		};
		d_hq_logic_blufor2 setVariable ["d_kddata", [["HQ_W"], "DHQ_BF2", "Papa Bear"]];
	};
};

if (d_own_side == "GUER" || {d_ifa3lite}) then {
	d_hq_logic_guer1 kbAddTopic["HQ_I",_kbscript];
	d_hq_logic_guer1 kbAddTopic["HQ_ART_I",_kbscript];
	d_hq_logic_guer1 setIdentity "DHQ_IN1";
	d_hq_logic_guer1 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_guer1 setGroupIdGlobal ["Crossroad"];
	};
	d_hq_logic_guer1 setVariable ["d_kddata", [["HQ_I", "HQ_ART_I"], "DHQ_IN1", "Crossroad"]];

	d_hq_logic_guer2 kbAddTopic["HQ_I",_kbscript];
	d_hq_logic_guer2 setIdentity "DHQ_IN2";
	d_hq_logic_guer2 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_guer2 setGroupIdGlobal ["Papa Bear"];
	};
	d_hq_logic_guer2 setVariable ["d_kddata", [["HQ_I"], "DHQ_IN2", "Papa Bear"]];
};

#ifndef __TT__
d_kb_logic1 = switch (d_own_side) do {
	case "WEST": {d_hq_logic_blufor1};
	case "EAST": {d_hq_logic_opfor1};
	case "GUER": {d_hq_logic_guer1};
};
d_kb_logic2 = switch (d_own_side) do {
	case "WEST": {d_hq_logic_blufor2};
	case "EAST": {d_hq_logic_opfor2};
	case "GUER": {d_hq_logic_guer2};
};
d_kb_topic_side = switch (d_own_side) do {
	case "WEST": {"HQ_W"};
	case "EAST": {"HQ_E"};
	case "GUER": {"HQ_I"};
};
d_kb_topic_side_arti = switch (d_own_side) do {
	case "WEST": {"HQ_ART_W"};
	case "EAST": {"HQ_ART_E"};
	case "GUER": {"HQ_ART_I"};
};
#endif

if (hasInterface) then {
	sleep 1;
	if (isMultiplayer) then {
		waitUntil {sleep 0.220;!isNil "d_still_in_intro"};
		waitUntil {sleep 0.220;!d_still_in_intro};
	};
	private _pside = side (group player);
	switch (_pside) do {
		case blufor: {player kbAddTopic["HQ_W", _kbscript]};
		case opfor: {player kbAddTopic["HQ_E", _kbscript]};
		case independent: {player kbAddTopic["HQ_I", _kbscript]};
	};
	_strp = str player;
	player kbAddTopic["PL" + _strp, _kbscript];
#ifndef __TT__
	d_kb_logic1 kbAddTopic["PL" + _strp, _kbscript];
#else
	private _ll = switch (_pside) do {
		case blufor: {d_hq_logic_blufor1};
		case opfor: {d_hq_logic_opfor1};
		case independent: {d_hq_logic_guer1};
	};
	_ll kbAddTopic["PL" + _strp, _kbscript];
#endif
	if (d_no_ai) then {
		if (_strp in d_can_use_artillery || {_strp in d_can_mark_artillery}) then {
			switch (_pside) do {
				case blufor: {player kbAddTopic["HQ_ART_W", _kbscript]};
				case opfor: {player kbAddTopic["HQ_ART_E", _kbscript]};
				case independent: {player kbAddTopic["HQ_ART_I", _kbscript]};
			};
		};
	} else {
		switch (_pside) do {
			case blufor: {player kbAddTopic["HQ_ART_W", _kbscript]};
			case opfor: {player kbAddTopic["HQ_ART_E", _kbscript]};
			case independent: {player kbAddTopic["HQ_ART_I", _kbscript]};
		};
	};
};
