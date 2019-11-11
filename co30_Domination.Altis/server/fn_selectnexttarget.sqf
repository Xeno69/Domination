// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_selectnexttarget.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","d_mttargets_ar")

if (count d_mttargets_ar > 1) then {
	d_next_sels_ar = [];
	
	private _howmany = 4;
	
	if (d_with_targetselect_count == -1) then {
		_howmany = 999;
	} else {
		_howmany = d_with_targetselect_count;
	};
		
	if (count d_mttargets_ar < 4) then {
		_howmany = count d_mttargets_ar;
	};
	
	__TRACE_1("","_howmany")
	
	_tmpar =+ d_mttargets_ar;
	
	for "_i" from 1 to _howmany do {
		private _idx = -1;
		private _curdist = 99999999;
		{
			_dist = (_x # 4) distance2D d_cur_tar_obj;
			if (_dist < _curdist) then {
				_idx = _forEachIndex;
				_curdist = _dist;
			};
		} forEach _tmpar;
		if (_idx != -1) then {
			d_next_sels_ar pushBack (_tmpar # _idx # 4);
			_tmpar deleteAt _idx;
		};
	};

	publicVariable "d_next_sels_ar";
	
	__TRACE_1("","d_next_sels_ar")
	
	private _markers = [];
	{
		_ma = [format ["d_sel_mar_%1", _x], _x, "ICON", "ColorYellow", [1.5, 1.5], "", 0, "hd_objective"] call d_fnc_CreateMarkerGlobal;
		_x setVariable ["d_sel_mar", _ma, true];
		_markers pushBack _ma;
	} forEach d_next_sels_ar;
	
	0 remoteExecCall ["d_fnc_clienttargetsel", [0, -2] select isDedicated];
	
	sleep 30;

	1 remoteExecCall ["d_fnc_clienttargetsel", [0, -2] select isDedicated];
	
	{
		deleteMarker _x;
	} forEach _markers;
	
	sleep 2;
	
	private _highest = 0;
	private _idx = -1;
	{
		private _cou = _x getVariable ["d_selectionsmt", 0];
		__TRACE_2("","_x","_cou")
		if (_cou > _highest) then {
			_idx = _forEachIndex;
			_highest = _cou;
		};
	} forEach d_next_sels_ar;
	
	__TRACE_2("","_idx","_highest")
	
	private _was_selected = false;
	if (_idx != -1) then {
		d_cur_tar_obj = d_next_sels_ar # _idx;
		_was_selected = true;
	} else {
		d_cur_tar_obj = selectRandom d_next_sels_ar;
	};
	
	__TRACE_1("","d_cur_tar_obj")
	
	{
		_x setVariable ["d_selectionsmt", nil, true];
		_x setVariable ["d_sel_mar", nil, true];
	} forEach d_next_sels_ar;
	
	d_next_sels_ar = nil;
	publicVariable "d_next_sels_ar";

	_idx = d_mttargets_ar findIf {(_x # 4) == d_cur_tar_obj};
	__TRACE_1("","_idx")
	
	d_maintargets_list = [d_mttargets_ar # _idx # 3];
	
	if (_was_selected) then {
		[format [localize "STR_DOM_MISSIONSTRING_1957", d_mttargets_ar # _idx # 1], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	} else {
		[localize "STR_DOM_MISSIONSTRING_1958", "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
	};
	
	d_mttargets_ar deleteAt _idx;
	
	{
		d_maintargets_list pushBack (_x # 3);
	} forEach d_mttargets_ar;
	
	__TRACE_1("","d_maintargets_list")
} else {
	d_cur_tar_obj = d_mttargets_ar # 0 # 4;
	d_maintargets_list = [d_mttargets_ar # 0 # 3];
	d_mttargets_ar deleteAt 0;
};
