// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_create_vecx.sqf"
#include "..\x_setup.sqf"

if (!alive player || {player getVariable ["xr_pluncon", false] ||{player getVariable ["ace_isunconscious", false]}}) exitWith {};

disableSerialization;
private _idx = lbCurSel ((uiNamespace getVariable "d_VecDialog") displayCtrl 44449);
closeDialog 0;
if (_idx < 0) exitWith {};

if (time < d_mhqvec_create_cooldown_time) exitWith {
	systemChat format [localize "STR_DOM_MISSIONSTRING_1823", round (d_mhqvec_create_cooldown_time - time)];
};

[0, 0, 0, [d_create_bike # _idx, 0, true]] spawn d_fnc_bike;