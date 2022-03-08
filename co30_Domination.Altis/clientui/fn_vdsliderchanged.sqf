// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

disableSerialization;
private _newvd = round (_this # 1);
((uiNamespace getVariable "D_StatusDialog") displayCtrl 1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", _newvd];
if (!d_isvdreduced) then {
	setViewDistance _newvd;
	setObjectViewDistance _newvd + 100;
};
d_curviewdistance = _newvd;
d_curobjectdistance = _newvd + 100;

profileNamespace setVariable ["dom_viewdistance", _newvd];

if (d_VD_Combi_use_InfVD) then {
	d_ViewDistanceAir = d_curviewdistance;
	d_ViewDistanceVec = d_curviewdistance;
	((uiNamespace getVariable "D_StatusDialog") displayCtrl 3500) sliderSetPosition d_curviewdistance;
	((uiNamespace getVariable "D_StatusDialog") displayCtrl 3501) sliderSetPosition d_curviewdistance;
};