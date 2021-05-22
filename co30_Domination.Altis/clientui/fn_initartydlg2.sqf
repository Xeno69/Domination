// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

d_cur_art_marker_ar = [];
d_arti_did_fire = nil;

//d_arttmx|1|32Rnd_155mm_Mo_shells|1   // name, net id, name of shell, number rounds

{
	(_x splitString "|") params ["", "_netid_ar", "_type_ar", "_rounds_ar"];
	__TRACE_1("","_x")
	__TRACE_3("","_netid_ar","_type_ar","_rounds_ar")

	if (!isMultiplayer || {_netid_ar != ""}) then {
		if (!d_tt_ver) then {
			d_cur_art_marker_ar pushBack [_x, _netid_ar, _type_ar, parseNumber _rounds_ar];
		} else {
			private _obj = objectFromNetId _netid_ar;
			if (side (group _obj) == d_player_side) then {
				d_cur_art_marker_ar pushBack [_x, _netid_ar, _type_ar, parseNumber _rounds_ar];
			};
		};
	};
} forEach (allMapMarkers select {_x select [0, 9] == "d_arttmx|"});

__TRACE_1("","d_cur_art_marker_ar")

d_cur_artm_map_startpos = getPosWorld player;

private _disp = uiNamespace getVariable "d_ArtilleryDialog2";

private _ctrllb = _disp displayCtrl 1000;
lbClear _ctrllb;

if (d_cur_art_marker_ar isNotEqualTo []) then {
	{
		private _name = if (isMultiplayer) then {
			name (objectFromNetId  (_x # 1))
		} else {
			d_name_pl
		};
		private _lbAdd = _ctrllb lbAdd _name;	
		_ctrllb lbSetvalue [_lbAdd, _forEachIndex];	
		_ctrllb lbSetData [_lbAdd, _x # 0];
	} forEach d_cur_art_marker_ar;
	_ctrllb lbSetcursel 0;
} else {
	(_disp displayCtrl 1002) ctrlEnable false;
	_ctrllb lbAdd format ["<< %1 >>", localize "STR_DOM_MISSIONSTRING_1649"];
	_ctrllb ctrlEnable false;
};
