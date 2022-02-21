// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

disableSerialization;
private _newvd = round (_this # 1);
((uiNamespace getVariable "D_StatusDialog") displayCtrl 3334) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358A", _newvd];

if (!isNull objectParent player) then {
	private _vp = vehicle player;
	if (_vp isKindOf "Helicopter" || {_vp isKindOf "Plane"}) then {
		if (d_isvdreduced) then {
			d_isvdreduced = false;
		};
		if (d_ViewDistanceAir != viewDistance) then {
			setViewDistance _newvd;
			setObjectViewDistance _newvd + 100;
		};
	};
};

d_ViewDistanceAir = _newvd;
d_curobjectdistance = _newvd + 100;

profileNamespace setVariable ["dom_viewdistanceair", _newvd];