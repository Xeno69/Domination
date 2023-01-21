// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

sleep 1.012;

"d_dummy_marker" setMarkerPosLocal d_cur_tgt_pos;

if (!isNil "d_obj00_task") then {
	d_obj00_task = nil;
	["d_obj00", "Succeeded", false] call d_fnc_taskSetState;
};

if (isNil "d_current_seize") then {d_current_seize = ""};

if (d_current_seize != d_cur_tgt_name) then {
	private _tname = format ["d_obj%1", d_current_target_index + 2];
	[true, _tname, [format [localize "STR_DOM_MISSIONSTRING_202", d_cur_tgt_name], format [localize "STR_DOM_MISSIONSTRING_203", d_cur_tgt_name], format [localize "STR_DOM_MISSIONSTRING_203", d_cur_tgt_name]], d_cur_tgt_pos, false, 2, true, "Attack", false] call d_fnc_taskcreate;
	d_current_task = _tname;
	d_current_seize = d_cur_tgt_name;
};

playSound "d_IncomingChallenge2";

if (!d_still_in_intro && {!isStreamFriendlyUIEnabled}) then {
	hintSilent format [localize "STR_DOM_MISSIONSTRING_204", d_cur_tgt_name];
	hintSilent parseText format ["<t color='#ff0000' size='1.5' align='center'>%1</t>", format [localize "STR_DOM_MISSIONSTRING_204", d_cur_tgt_name]];
};

#ifndef __TT__
call d_fnc_cmakemtgmarker;
#endif

d_meh_markercreated = addMissionEventHandler ["MarkerCreated", {
	__TRACE_1("MarkerCreated EH","_this")
	if (_this # 3) then {
		if ((_this # 0) select [0, 13] == "_USER_DEFINED") then {
			if (markerPos (_this # 0) distance2D (_thisArgs # 0) < _thisArgs # 1) then {
				(_this # 0) remoteExecCall ["d_fnc_add_tomadel", 2];
			};
		};
	};
}, [d_cur_tgt_pos, d_mttarget_radius_patrol + 300]];
