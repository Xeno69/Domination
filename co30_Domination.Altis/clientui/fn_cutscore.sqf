// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cutscore.sqf"
#include "..\x_setup.sqf"

disableSerialization;

sleep 10;

while {true} do {
	private _disp = uiNamespace getVariable "d_score_hud";
	if (isNil "_disp" || {isNull _disp}) then {
		"d_score_hud" cutRsc ["d_score_hud", "PLAIN"];
		_disp = uiNamespace getVariable "d_score_hud";
	};
	if (!visibleMap) then {
		(_disp displayCtrl 9999) ctrlSetText ("Score: " + str (score player));
	} else {
		(_disp displayCtrl 9999) ctrlSetText ("");
	};
	sleep 1;
};