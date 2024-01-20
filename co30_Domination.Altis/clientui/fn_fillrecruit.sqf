// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;
private _dspx = uiNamespace getVariable "d_AIRecruitDialog";
private _ctrl = _dspx displayCtrl 1000;
lbClear _ctrl;

private ["_ipic", "_pic", "_idx"];
{
	_ipic = getText (configFile>>"cfgVehicles">>_x>>"icon");
	//__TRACE_2("","_x","_ipic")
	_pic = [getText(configFile>>"CfgVehicleIcons">>_ipic), "#(argb,8,8,3)color(1,1,1,0)"] select (_ipic == "");
	//__TRACE_1("","_pic")
	_idx = _ctrl lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
	_ctrl lbSetPicture [_idx, _pic];
	_ctrl lbSetColor [_idx, [1, 1, 0, 0.8]];
} forEach d_UnitsToRecruit;

_ctrl lbSetCurSel 0;

d_current_ai_units = (units player) select {!(isPlayer _x) && {alive _x}};
d_current_ai_num = count d_current_ai_units;

private _max_ai = [round linearConversion [0, 20, 21 - count d_allplayers, 0, d_max_ai, true], d_max_ai] select !d_ai_dyn_recruit;

(_dspx displayCtrl 1030) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_693", d_current_ai_num, _max_ai];

_ctrl = _dspx displayCtrl 1001;
lbClear _ctrl;
private ["_tt", "_pic", "_idx"];
{
	_tt = typeOf _x;
	_ipic = getText (configFile>>"cfgVehicles">>_tt>>"icon");
	//__TRACE_2("","_tt","_ipic")
	_pic = [getText(configFile>>"CfgVehicleIcons">>_ipic), "#(argb,8,8,3)color(1,1,1,0)"] select (_ipic == "");
	//__TRACE_1("","_pic")
	_idx = _ctrl lbAdd ([_tt, "CfgVehicles"] call d_fnc_GetDisplayName);
	_ctrl lbSetPicture [_idx, _pic];
	_ctrl lbSetColor [_idx, [1, 1, 0, 0.8]];
} forEach d_current_ai_units;

if (d_current_ai_units isNotEqualTo []) then {
	_ctrl lbSetCurSel 0;
};

if (d_current_ai_num == 0) then {
	(_dspx displayCtrl 1011) ctrlShow false;
	(_dspx displayCtrl 1012) ctrlShow false;
};
if (d_current_ai_num == d_max_ai) then {
	(_dspx displayCtrl 1010) ctrlShow false;
};