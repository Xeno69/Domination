// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;
private _newvd = round (_this # 1);
((uiNamespace getVariable "D_StatusDialog") displayCtrl 3333) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358V", _newvd];

if (!isNull objectParent player) then {
	private _vp = vehicle player;
	if (_vp isKindOf "Car" || {_vp isKindOf "Tank" || {_vp isKindOf "Motorcycle"}}) then {
		if (d_isvdreduced) then {
			d_isvdreduced = false;
		};
		if (d_ViewDistanceVec != viewDistance) then {
			setViewDistance _newvd;
			setObjectViewDistance _newvd + 100;
		};
	};
};

d_ViewDistanceVec = _newvd;
d_curobjectdistance = _newvd + 100;

profileNamespace setVariable ["dom_viewdistancevec", _newvd];