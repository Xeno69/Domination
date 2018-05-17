// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vec_welcome_message.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

private _vtype = _this select 1;

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
while {!isNull objectParent player && {alive player && {time < _endtime && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}}} do {
	sleep 1;
	hintSilent _struct_text;
};
if (_vtype == "MHQ" && {alive player && {!isNull objectParent player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false])}}}}) then {
	hintSilent composeText[parseText("<t color='#f0a7ff31' size='1.5'>" + (localize "STR_DOM_MISSIONSTRING_659") + "</t>"), lineBreak,lineBreak,"Dont' forget to deploy the MHQ"];
} else {
	hintSilent "";
};