// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initairtaxidialog.sqf"
#include "..\x_setup.sqf"

#define CTRL(A) (_disp displayCtrl A)

if (!hasInterface) exitWith {};

disableSerialization;

params ["_disp"];

private _ctrl = CTRL(1000);

if (isNil "d_change_taxi_tmp") then {
	{
		private _idx = _ctrl lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
		_ctrl lbSetData [_idx, _x];
		_ctrl lbSetPicture [_idx, getText(configFile>>"cfgVehicles">>_x>>"picture")];
		_ctrl lbSetPictureColor [_idx, [1,1,1,1]];
	} forEach d_taxi_aircrafts;

	_ctrl lbSetCurSel 0;
} else {
	_ctrl ctrlShow false;
	CTRL(44450) ctrlShow false;
	CTRL(11004) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1936");
	CTRL(11005) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1935");
	private _dest = player getVariable "d_can_change_taxi";
	private _text = if (_dest distance2D d_FLAG_BASE < 500) then {localize "STR_DOM_MISSIONSTRING_1251"} else {str _dest};
	CTRL(2000) ctrlSetText str _text;
};