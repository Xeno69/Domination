// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initartydlg2.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

disableSerialization;

d_cur_art_marker_ar = [];
d_arti_did_fire = nil;

//d_arttmx|1|32Rnd_155mm_Mo_shells|1   // name, net id, name of shell, number rounds

{
	(_x splitString "|") params ["", "_netid_ar", "_type_ar", "_rounds_ar"];
	__TRACE_3("","_netid_ar","_type_ar","_rounds_ar")
	
	if (_netid_ar != "") then {
#ifdef __TT__
		private _obj = objectFromNetId _netid_ar;
		if (side (group _obj) == d_player_side) then {
#endif
		d_cur_art_marker_ar pushBack [_x, _netid_ar, _type_ar, parseNumber _rounds_ar];
#ifdef __TT__
		};
#endif
	};
} forEach (allMapMarkers select {_x select [0, 9] == "d_arttmx|"});

__TRACE_1("","d_cur_art_marker_ar")

d_cur_artm_map_startpos = getPosWorld player;

private _disp = uiNamespace getVariable "d_ArtilleryDialog2";

private _ctrllb = _disp displayCtrl 1000;
lbClear _ctrllb;

if !(d_cur_art_marker_ar isEqualTo []) then {
	{
		private _name = if (isMultiplayer) then {
			(objectFromNetId  (_x # 1)) call d_fnc_getplayername
		} else {
			d_name_pl
		};
		if (_name != "Error: No unit") then {
			private _lbAdd = _ctrllb lbAdd _name;
			_ctrllb lbSetvalue [_lbAdd, _forEachIndex];
			_ctrllb lbSetData [_lbAdd, _x # 0];
		};
	} forEach d_cur_art_marker_ar;
	_ctrllb lbSetcursel 0;
} else {
	(_disp displayCtrl 1002) ctrlEnable false;
	_ctrllb lbAdd format ["<< %1 >>", localize "STR_DOM_MISSIONSTRING_1649"];
	_ctrllb ctrlEnable false;
};
