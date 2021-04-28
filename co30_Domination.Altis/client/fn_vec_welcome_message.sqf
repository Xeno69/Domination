// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _vtype = _this # 1;

private _vec_msg1 = if (_vtype == "MHQ") then {
	localize "STR_DOM_MISSIONSTRING_628"
} else {
	if (_vtype == "Engineer") then {
		localize "STR_DOM_MISSIONSTRING_629"
	} else {
		""
	};
};
private _struct_text = composeText[parseText("<t color='#f0a7ff31' size='1'>" + format [localize "STR_DOM_MISSIONSTRING_627", d_name_pl] + "</t>"), lineBreak,lineBreak,_vec_msg1];
private _endtime = time + 8;
hintSilent _struct_text;
while {!isNull objectParent player && {d_player_canu && {time < _endtime}}} do {
	sleep 1;
	hintSilent _struct_text;
};
if (_vtype == "MHQ" && {d_player_canu && {!isNull objectParent player}}) then {
	hintSilent composeText[parseText("<t color='#f0a7ff31' size='1.5'>" + (localize "STR_DOM_MISSIONSTRING_659") + "</t>"), lineBreak, lineBreak, localize "STR_DOM_MISSIONSTRING_1968"];
} else {
	hintSilent "";
};