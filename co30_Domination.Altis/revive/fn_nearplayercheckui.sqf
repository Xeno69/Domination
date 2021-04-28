// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

disableSerialization;
private _disp = uiNamespace getVariable "xr_SpectDlg";
#define __dspctrl(ctrlid) (_disp displayCtrl ctrlid)
if (xr_near_players isNotEqualTo []) then {
	private _s_p = [];
	{
		_s_p pushBack format ["%1<br/>", name _x];
	} forEach xr_near_players;
	__dspctrl(9999) ctrlSetStructuredText parseText format ["<t color='#00FFFF' size='1'><t align='right'>%1", _s_p joinString ""];
	__dspctrl(9999) ctrlCommit 0;
} else {
	__dspctrl(9999) ctrlSetStructuredText parseText format ["<t color='#00FFFF' size='1'><t align='right'>%1<br/>", localize "STR_DOM_MISSIONSTRING_405"];
	__dspctrl(9999) ctrlCommit 0;
};
