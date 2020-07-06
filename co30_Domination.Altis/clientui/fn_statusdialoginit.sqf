// by Xeno
#define THIS_FILE "fn_statusdialoginit.sqf"
#include "..\x_setup.sqf"
#define __ctrl(vctrl) _ctrl = _disp displayCtrl vctrl
#define __ctrl2(ectrl) (_disp displayCtrl ectrl)

params ["_disp"];

if (!d_pisadminp) then {
	__ctrl2(123123) ctrlShow false;
	__ctrl2(123124) ctrlShow false;
	if (!d_database_found) then {
		__ctrl2(123125) ctrlShow false;
	};
} else {
	if (!d_database_found) then {
		__ctrl2(123124) ctrlShow false;
		__ctrl2(123125) ctrlShow false;
	};
};

if (d_with_bis_dynamicgroups == 1) then {
	__ctrl2(11009) ctrlShow false;
};

if (d_MissionType == 1) then {
	//sidemissions are off
	__ctrl2(123126) ctrlShow false;
	__ctrl2(11002) ctrlShow false;
};

if (d_MissionType == 2) then {
	//maintargets are off
	__ctrl2(11090) ctrlShow false;
	__ctrl2(11007) ctrlShow false;
};

if (!d_with_ranked) then {
	//ranked is off
	__ctrl2(12009) ctrlShow false;
	__ctrl2(12010) ctrlShow false;
	__ctrl2(11014) ctrlShow false;
	__ctrl2(3403) ctrlShow false;
	__ctrl2(3404) ctrlShow false;
	__ctrl2(3405) ctrlShow false;
	__ctrl2(3406) ctrlShow false;
	__ctrl2(2001) ctrlShow false;
	__ctrl2(3407) ctrlShow false;
	__ctrl2(3408) ctrlShow false;
	__ctrl2(2002) ctrlShow false;
	__ctrl2(3409) ctrlShow false;
	__ctrl2(3410) ctrlShow false;
	__ctrl2(2003) ctrlShow false;
	__ctrl2(3411) ctrlShow false;
	__ctrl2(3412) ctrlShow false;
	__ctrl2(2004) ctrlShow false;
	__ctrl2(3413) ctrlShow false;
	__ctrl2(3414) ctrlShow false;
	__ctrl2(2005) ctrlShow false;
	__ctrl2(3415) ctrlShow false;
	__ctrl2(3416) ctrlShow false;
	__ctrl2(2006) ctrlShow false;
	__ctrl2(3417) ctrlShow false;
	__ctrl2(3418) ctrlShow false;
	__ctrl2(2007) ctrlShow false;
};


private _tgt_ar = [];

private _cur_tgt_name = if (d_current_target_index != -1) then {
	d_cur_tgt_name
} else {
	localize "STR_DOM_MISSIONSTRING_539"
};

if (isNil "_cur_tgt_name") then {_cur_tgt_name = ""};

#ifdef __TT__
__ctrl(11011);
d_points_array params ["_points_blufor", "_points_opfor", "_kill_points_blufor", "_kill_points_opfor"];
private _color = if (_points_blufor > _points_opfor) then {
	[0,0.6,1,1]
} else {
	if (_points_opfor > _points_blufor) then {
		[1,0.39,0.28,1]
	} else {
		[0,1,0,1]
	};
};
_ctrl ctrlSetTextColor _color;
_ctrl ctrlSetText format ["%1: %2", _points_blufor, _points_opfor];

__ctrl(11012);
_color = if (_kill_points_blufor > _kill_points_opfor) then {
	[0,0.6,1,1]
} else {
	if (_kill_points_opfor > _kill_points_blufor) then {
		[1,0.39,0.28,1]
	} else {
		[0,1,0,1]
	};
};
_ctrl ctrlSetTextColor _color;
_ctrl ctrlSetText format ["%1 : %2", _kill_points_blufor, _kill_points_opfor];
#endif

private _s = call {
	if (d_all_sm_res) exitWith {localize "STR_DOM_MISSIONSTRING_522"};
	if (d_cur_sm_idx == -1) exitWith {localize "STR_DOM_MISSIONSTRING_712"};
	format ["%1     #%2", d_cur_sm_txt, d_cur_sm_idx]
};

__ctrl2(11002) ctrlSetText _s;

if (d_WithRevive == 1) then {
	__ctrl2(30000) ctrlShow false;
	__ctrl2(30001) ctrlShow false;
} else {
	__ctrl2(30001) ctrlSetText str (player getVariable "xr_lives");
};

#ifndef __TT__
private _intels = "";
{
	if (_x == 1) then {
		_tmp = switch (_forEachIndex) do {
			case 0: {localize "STR_DOM_MISSIONSTRING_542"};
			case 1: {localize "STR_DOM_MISSIONSTRING_543"};
			case 2: {localize "STR_DOM_MISSIONSTRING_544"};
			case 3: {localize "STR_DOM_MISSIONSTRING_545"};
			case 4: {localize "STR_DOM_MISSIONSTRING_546"};
			case 5: {localize "STR_DOM_MISSIONSTRING_547"};
			case 6: {localize "STR_DOM_MISSIONSTRING_541"};
		};
		_intels = _intels + _tmp + "\n";
	};
} forEach d_searchintel;
if (_intels == "") then {
	_intels = localize "STR_DOM_MISSIONSTRING_548";
};
__ctrl2(11018) ctrlSetText _intels;
#else
__ctrl2(11019) ctrlShow false;
__ctrl2(11018) ctrlShow false;
#endif

__ctrl2(11003) ctrlSetText _cur_tgt_name;

__ctrl2(11006) ctrlSetText format ["%1/%2", count d_resolved_targets + 1, d_MainTargets];

__ctrl2(11233) ctrlSetText str(score player);

private "_ctrl";
__ctrl(11278);
#ifndef __TT__
_ctrl ctrlSetText format ["%1/%2", d_campscaptured, d_numcamps];
#else
if (d_player_side == blufor) then {
	_ctrl ctrlSetText format ["%1/%2", d_campscaptured_w, d_numcamps];
} else {
	_ctrl ctrlSetText format ["%1/%2", d_campscaptured_e, d_numcamps];
};
#endif

#ifdef __TT__
__ctrl(11279);
_ctrl ctrlSetText format ["%1/%2", d_num_barracks_objs, d_num_barracks_tt];
#endif

__ctrl(11009);
_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_552");

_s = "";
if (d_current_target_index != -1) then {
	_s = switch (d_sec_kind) do {
		case 1: {
			format [localize "STR_DOM_MISSIONSTRING_554", _cur_tgt_name]
		};
		case 2: {
			format [localize "STR_DOM_MISSIONSTRING_556", _cur_tgt_name]
		};
		case 3: {
#ifndef __TT__
			format [localize "STR_DOM_MISSIONSTRING_557", _cur_tgt_name]
#else
			format [localize "STR_DOM_MISSIONSTRING_558", _cur_tgt_name]
#endif
		};
		case 4: {
#ifndef __TT__
			format [localize "STR_DOM_MISSIONSTRING_559", _cur_tgt_name]
#else
			format [localize "STR_DOM_MISSIONSTRING_560", _cur_tgt_name]
#endif
		};
		case 5: {
			format [localize "STR_DOM_MISSIONSTRING_561", _cur_tgt_name]
		};
		case 6: {
			format [localize "STR_DOM_MISSIONSTRING_562", _cur_tgt_name]
		};
		case 7: {
			format [localize "STR_DOM_MISSIONSTRING_563", _cur_tgt_name]
		};
		case 8: {
			format [localize "STR_DOM_MISSIONSTRING_565", _cur_tgt_name]
		};
		case 9: {
			format [localize "STR_DOM_MISSIONSTRING_566", _cur_tgt_name]
		};
		case 10: {
			format [localize "STR_DOM_MISSIONSTRING_567", _cur_tgt_name]
		};
		default {
			localize "STR_DOM_MISSIONSTRING_568"
		};
	};
} else {
	_s = localize "STR_DOM_MISSIONSTRING_568";
};

__ctrl2(11007) ctrlSetText _s;

__ctrl2(12010) ctrlSetText ((player call d_fnc_GetRankPic) # 0);
__ctrl2(11014) ctrlSetText (player call d_fnc_GetRankString);

__ctrl2(12016) ctrlSetText serverName;



if (d_disable_viewdistance) then {
	__ctrl2(1000) ctrlEnable false;
	__ctrl2(1999) ctrlSetText (localize "STR_DOM_MISSIONSTRING_357");
	__ctrl2(1997) ctrlSetText "";
} else {
	__ctrl2(1000) sliderSetRange [200, d_MaxViewDistance];
	if (!d_isvdreduced) then {
		__ctrl2(1000) sliderSetPosition viewDistance;
		__ctrl2(1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", round viewDistance];
	} else {
		__ctrl2(1000) sliderSetPosition d_curviewdistance;
		__ctrl2(1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", round d_curviewdistance];
	};
};

private _ctrl = __ctrl2(1001);

private _glindex = -1;
{
	private _index = _ctrl lbAdd _x;
	if (d_graslayer_index == _index) then {_glindex = _index};
} forEach [localize "STR_DOM_MISSIONSTRING_359", localize "STR_DOM_MISSIONSTRING_360", localize "STR_DOM_MISSIONSTRING_361"];

_ctrl lbSetCurSel _glindex;
if (d_Terraindetail == 1) then {
	_ctrl ctrlEnable false;
	__ctrl2(1998) ctrlSetText (localize "STR_DOM_MISSIONSTRING_362");
	__ctrl2(1996) ctrlSetText "";
};

_ctrl = __ctrl2(1002);
{_ctrl lbAdd _x} forEach [localize "STR_DOM_MISSIONSTRING_363", localize "STR_DOM_MISSIONSTRING_364", localize "STR_DOM_MISSIONSTRING_365", localize "STR_DOM_MISSIONSTRING_367"];
_ctrl lbSetCurSel d_show_player_marker;

d_pnsel_first = true;
_ctrl = __ctrl2(1602);
{_ctrl lbAdd _x} forEach [localize "STR_DOM_MISSIONSTRING_363a", localize "STR_DOM_MISSIONSTRING_364", localize "STR_DOM_MISSIONSTRING_367"];
_ctrl lbSetCurSel d_show_player_namesx;

__ctrl2(2001) ctrlSetText str(d_points_needed # 0);
__ctrl2(2002) ctrlSetText str(d_points_needed # 1);
__ctrl2(2003) ctrlSetText str(d_points_needed # 2);
__ctrl2(2004) ctrlSetText str(d_points_needed # 3);
__ctrl2(2005) ctrlSetText str(d_points_needed # 4);
__ctrl2(2006) ctrlSetText str(d_points_needed # 5);
__ctrl2(2007) ctrlSetText str(d_points_needed # 6);

#ifndef __TT__
__ctrl2(1610) cbSetChecked d_maintarget_auto_vd;
__ctrl2(1610) ctrlAddEventHandler ["CheckedChanged", {
	d_maintarget_auto_vd = !d_maintarget_auto_vd;
	if (d_maintarget_auto_vd) then {
		systemChat (localize "STR_DOM_MISSIONSTRING_1965");
	} else {
		systemChat (localize "STR_DOM_MISSIONSTRING_1966");
	};
}];
#endif

for "_i" from 1 to 20 do {
	private _usera = (str (actionKeysNamesArray format ["User%1", _i])) splitString "[,]";
	private _endstr = (localize format ["str_usract_user_%1", _i]);
	if !(_usera isEqualTo []) then {
		_endstr = _endstr + " " + (_usera joinString ",");
	};
	__ctrl2(3302) lbAdd _endstr;
	__ctrl2(3402) lbAdd _endstr;
};
__ctrl2(3302) lbSetCurSel d_earplugs_userakey;
__ctrl2(3402) lbSetCurSel d_3dmarker_userakey;
