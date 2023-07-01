// by Xeno
//#include "..\x_setup.sqf"

params ["_disp"];

if (!d_pisadminp) then {
	(_disp displayCtrl 123123) ctrlShow false;
	(_disp displayCtrl 123124) ctrlShow false;
} else {
	if (!d_database_found) then {
		(_disp displayCtrl 123124) ctrlShow false;
	};
};
if (!d_database_found) then {
	(_disp displayCtrl 123125) ctrlShow false;
};

if (d_with_bis_dynamicgroups == 1) then {
	(_disp displayCtrl 11009) ctrlShow false;
};

if (d_MissionType == 1) then {
	//sidemissions are off
	(_disp displayCtrl 123126) ctrlShow false;
	(_disp displayCtrl 11002) ctrlShow false;
};

if (d_MissionType == 2) then {
	//maintargets are off
	(_disp displayCtrl 11090) ctrlShow false;
	(_disp displayCtrl 11007) ctrlShow false;
};

if (!d_with_ranked && {!d_database_found}) then {
	//ranked is off
	(_disp displayCtrl 12009) ctrlShow false;
	(_disp displayCtrl 12010) ctrlShow false;
	(_disp displayCtrl 11014) ctrlShow false;
	(_disp displayCtrl 3403) ctrlShow false;
	(_disp displayCtrl 3404) ctrlShow false;
	(_disp displayCtrl 3405) ctrlShow false;
	(_disp displayCtrl 3406) ctrlShow false;
	(_disp displayCtrl 2001) ctrlShow false;
	(_disp displayCtrl 3407) ctrlShow false;
	(_disp displayCtrl 3408) ctrlShow false;
	(_disp displayCtrl 2002) ctrlShow false;
	(_disp displayCtrl 3409) ctrlShow false;
	(_disp displayCtrl 3410) ctrlShow false;
	(_disp displayCtrl 2003) ctrlShow false;
	(_disp displayCtrl 3411) ctrlShow false;
	(_disp displayCtrl 3412) ctrlShow false;
	(_disp displayCtrl 2004) ctrlShow false;
	(_disp displayCtrl 3413) ctrlShow false;
	(_disp displayCtrl 3414) ctrlShow false;
	(_disp displayCtrl 2005) ctrlShow false;
	(_disp displayCtrl 3415) ctrlShow false;
	(_disp displayCtrl 3416) ctrlShow false;
	(_disp displayCtrl 2006) ctrlShow false;
	(_disp displayCtrl 3417) ctrlShow false;
	(_disp displayCtrl 3418) ctrlShow false;
	(_disp displayCtrl 2007) ctrlShow false;
};

if (!d_database_found) then {
	for "_i" from 6000 to 6008 do {
	(_disp displayCtrl _i) ctrlShow false;
	};
} else {
	private _p_distar = player getVariable "d_p_distar";
	if (isNil "_p_distar") exitWith {};
	(_disp displayCtrl 6002) ctrlSetText str(round (_p_distar # 0));
	(_disp displayCtrl 6004) ctrlSetText str(round (_p_distar # 1));
	(_disp displayCtrl 6006) ctrlSetText str(round (_p_distar # 2));
	(_disp displayCtrl 6008) ctrlSetText str(round (_p_distar # 3));
	
	(_disp displayCtrl 6002) ctrlSetText str(((_p_distar # 0)/1000) toFixed 2);
	(_disp displayCtrl 6004) ctrlSetText str(((_p_distar # 1)/1000) toFixed 2);
	(_disp displayCtrl 6006) ctrlSetText str(((_p_distar # 2)/1000) toFixed 2);
	(_disp displayCtrl 6008) ctrlSetText str(((_p_distar # 3)/1000) toFixed 2);
};

private _tgt_ar = [];

private _cur_tgt_name = if (d_current_target_index != -1) then {
	d_cur_tgt_name
} else {
	localize "STR_DOM_MISSIONSTRING_539"
};

if (isNil "_cur_tgt_name") then {_cur_tgt_name = ""};

if (d_tt_ver) then {
	_ctrl = _disp displayCtrl 11011;
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

	_ctrl = _disp displayCtrl 11012;
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
};

private _s = call {
	if (d_all_sm_res) exitWith {localize "STR_DOM_MISSIONSTRING_522"};
	if (d_cur_sm_idx == -1) exitWith {localize "STR_DOM_MISSIONSTRING_712"};
	format ["%1     #%2", d_cur_sm_txt, d_cur_sm_idx]
};

(_disp displayCtrl 11002) ctrlSetText _s;

if (d_WithRevive == 1) then {
	(_disp displayCtrl 30000) ctrlShow false;
	(_disp displayCtrl 30001) ctrlShow false;
} else {
	private _xltxt = if (xr_max_lives == -1) then {
		localize "STR_DOM_MISSIONSTRING_1010"
	} else {
		str (player getVariable "xr_lives")
	};
	(_disp displayCtrl 30001) ctrlSetText _xltxt;
};

if (!d_tt_ver) then {
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
	(_disp displayCtrl 11018) ctrlSetText _intels;
} else {
	(_disp displayCtrl 11019) ctrlShow false;
	(_disp displayCtrl 11018) ctrlShow false;
};

(_disp displayCtrl 11003) ctrlSetText _cur_tgt_name;

(_disp displayCtrl 11006) ctrlSetText format ["%1/%2", count d_resolved_targets + 1, d_MainTargets];

(_disp displayCtrl 11233) ctrlSetText str(score player);

private "_ctrl";
_ctrl = _disp displayCtrl 11278;
if (!d_tt_ver) then {
	_ctrl ctrlSetText format ["%1/%2", d_campscaptured, d_numcamps];
} else {
	if (d_player_side == blufor) then {
		_ctrl ctrlSetText format ["%1/%2", d_campscaptured_w, d_numcamps];
	} else {
		_ctrl ctrlSetText format ["%1/%2", d_campscaptured_e, d_numcamps];
	};
};

if (d_tt_ver) then {
	_ctrl = _disp displayCtrl 11279;
	_ctrl ctrlSetText format ["%1/%2", d_num_barracks_objs, d_num_barracks_tt];
};

_ctrl = _disp displayCtrl 11009;
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
			if (!d_tt_ver) then {
				format [localize "STR_DOM_MISSIONSTRING_557", _cur_tgt_name]
			} else {
				format [localize "STR_DOM_MISSIONSTRING_558", _cur_tgt_name]
			};
		};
		case 4: {
			if (!d_tt_ver) then {
				format [localize "STR_DOM_MISSIONSTRING_559", _cur_tgt_name]
			} else {
				format [localize "STR_DOM_MISSIONSTRING_560", _cur_tgt_name]
			};
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
	_s = format ["*** %1", _s];
};

private _s2 = "";
{
	_s2 = composeText [_s2, (format ["!!! %1", _x]), '\n'];
} forEach d_mt_event_messages_array;

_s_all = composeText [_s, _s2];

_s_all = str _s_all;

(_disp displayCtrl 11007) ctrlSetText _s_all;

(_disp displayCtrl 12010) ctrlSetText ((player call d_fnc_GetRankPic) # 0);
(_disp displayCtrl 11014) ctrlSetText (player call d_fnc_GetRankString);

(_disp displayCtrl 12016) ctrlSetText serverName;


if (d_disable_viewdistance) then {
	(_disp displayCtrl 1000) ctrlEnable false;
	(_disp displayCtrl 1999) ctrlSetText [localize "STR_DOM_MISSIONSTRING_358", round viewDistance];
	(_disp displayCtrl 3500) ctrlEnable false;
	(_disp displayCtrl 3333) ctrlSetText [localize "STR_DOM_MISSIONSTRING_358V", round viewDistance];
	(_disp displayCtrl 3501) ctrlEnable false;
	(_disp displayCtrl 1999) ctrlSetText [localize "STR_DOM_MISSIONSTRING_358A", round viewDistance];
} else {
	(_disp displayCtrl 1000) sliderSetRange [200, d_MaxViewDistance];
	if (!d_isvdreduced) then {
		(_disp displayCtrl 1000) sliderSetPosition viewDistance;
		(_disp displayCtrl 1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", round viewDistance];
	} else {
		(_disp displayCtrl 1000) sliderSetPosition d_curviewdistance;
		(_disp displayCtrl 1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", round d_curviewdistance];
	};
	(_disp displayCtrl 3500) sliderSetRange [200, d_MaxViewDistance];
	(_disp displayCtrl 3500) sliderSetPosition d_ViewDistanceVec;
	(_disp displayCtrl 3333) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358V", round d_ViewDistanceVec];
	(_disp displayCtrl 3501) sliderSetRange [200, d_MaxViewDistance];
	(_disp displayCtrl 3501) sliderSetPosition d_ViewDistanceAir;
	(_disp displayCtrl 3334) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358A", round d_ViewDistanceAir];
};

private _ctrl = _disp displayCtrl 1001;

private _glindex = -1;
{
	private _index = _ctrl lbAdd _x;
	if (d_graslayer_index == _index) then {_glindex = _index};
} forEach [localize "STR_DOM_MISSIONSTRING_359", localize "STR_DOM_MISSIONSTRING_360", localize "STR_DOM_MISSIONSTRING_361", localize "STR_DOM_MISSIONSTRING_400", localize "STR_DOM_MISSIONSTRING_400_VERYHIGH"];

_ctrl lbSetCurSel _glindex;
if (d_Terraindetail == 1) then {
	_ctrl ctrlEnable false;
	(_disp displayCtrl 1998) ctrlSetText (localize "STR_DOM_MISSIONSTRING_362");
	(_disp displayCtrl 1996) ctrlSetText "";
};

_ctrl = _disp displayCtrl 1002;
{_ctrl lbAdd _x} forEach [localize "STR_DOM_MISSIONSTRING_363", localize "STR_DOM_MISSIONSTRING_364", localize "STR_DOM_MISSIONSTRING_365", localize "STR_DOM_MISSIONSTRING_367"];
_ctrl lbSetCurSel d_show_player_marker;

d_pnsel_first = true;
_ctrl = _disp displayCtrl 1602;
{_ctrl lbAdd _x} forEach [localize "STR_DOM_MISSIONSTRING_363a", localize "STR_DOM_MISSIONSTRING_364", localize "STR_DOM_MISSIONSTRING_367"];
_ctrl lbSetCurSel d_show_player_namesx;

(_disp displayCtrl 2001) ctrlSetText str(d_points_needed # 0);
(_disp displayCtrl 2002) ctrlSetText str(d_points_needed # 1);
(_disp displayCtrl 2003) ctrlSetText str(d_points_needed # 2);
(_disp displayCtrl 2004) ctrlSetText str(d_points_needed # 3);
(_disp displayCtrl 2005) ctrlSetText str(d_points_needed # 4);
(_disp displayCtrl 2006) ctrlSetText str(d_points_needed # 5);
(_disp displayCtrl 2007) ctrlSetText str(d_points_needed # 6);

if (!d_tt_ver) then {
	if (d_AutoViewdistanceChangeDefault == 1) then {
		(_disp displayCtrl 1610) cbSetChecked d_maintarget_auto_vd;
		(_disp displayCtrl 1610) ctrlAddEventHandler ["CheckedChanged", {
			d_maintarget_auto_vd = !d_maintarget_auto_vd;
			if (d_maintarget_auto_vd) then {
				systemChat (localize "STR_DOM_MISSIONSTRING_1965");
			} else {
				systemChat (localize "STR_DOM_MISSIONSTRING_1966");
			};
			profileNamespace setVariable ["dom_maintarget_auto_vd", d_maintarget_auto_vd];
		}];
	} else {
		(_disp displayCtrl 1609) ctrlShow false;
		(_disp displayCtrl 1610) ctrlShow false;
	};
};

(_disp displayCtrl 1613) cbSetChecked d_VD_Combi_use_InfVD;
if (d_VD_Combi_use_InfVD) then {
	(_disp displayCtrl 3500) ctrlEnable false;
	(_disp displayCtrl 3501) ctrlEnable false;
};
(_disp displayCtrl 1613) ctrlAddEventHandler ["CheckedChanged", {
	d_VD_Combi_use_InfVD = (_this # 1) == 1;
	if (d_VD_Combi_use_InfVD) then {
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3500) sliderSetPosition d_curviewdistance;
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3501) sliderSetPosition d_curviewdistance;
		d_ViewDistanceAir = d_curviewdistance;
		d_ViewDistanceVec = d_curviewdistance;
		profileNamespace setVariable ["dom_viewdistanceair", d_ViewDistanceAir];
		profileNamespace setVariable ["dom_viewdistancevec", d_ViewDistanceVec];
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3500) ctrlEnable false;
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3501) ctrlEnable false;
		if (!isNull objectParent player) then {
			private _vp = vehicle player;
			if (_vp isKindOf "Car" || {_vp isKindOf "Tank" || {_vp isKindOf "Motorcycle" || {_vp isKindOf "Ship" || {_vp isKindOf "Helicopter" || {_vp isKindOf "Plane"}}}}}) then {
				if (d_isvdreduced) then {
					d_isvdreduced = false;
				};
				setViewDistance d_curviewdistance;
				setObjectViewDistance d_curviewdistance + 100;
			};
		};
	} else {
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3500) ctrlEnable true;
		((uiNamespace getVariable "D_StatusDialog") displayCtrl 3501) ctrlEnable true;
	};
	profileNamespace setVariable ["dom_vd_combi_use_infvd", d_VD_Combi_use_InfVD];
}];	

for "_i" from 1 to 20 do {
	private _usera = (str (actionKeysNamesArray format ["User%1", _i])) splitString "[,]";
	private _endstr = (localize format ["str_usract_user_%1", _i]);
	if (_usera isNotEqualTo []) then {
		_endstr = _endstr + " " + (_usera joinString ",");
	};
	(_disp displayCtrl 3302) lbAdd _endstr;
	(_disp displayCtrl 3402) lbAdd _endstr;
};
(_disp displayCtrl 3302) lbSetCurSel d_earplugs_userakey;
(_disp displayCtrl 3402) lbSetCurSel d_3dmarker_userakey;
