// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _disp = uiNamespace getVariable "d_AirDropDialog";

d_x_drop_array params ["_array"];
if (_array isEqualTo []) then {
	(_disp displayCtrl 11002) ctrlShow false;
} else {
	(_disp displayCtrl 11002) ctrlSetText (_array # 0);
};
_array = d_x_drop_array # 1;
if (_array isEqualTo []) then {
	(_disp displayCtrl 11003) ctrlShow false;
} else {
	(_disp displayCtrl 11003) ctrlSetText (_array # 0);
};
_array = d_x_drop_array # 2;
if (_array isEqualTo []) then {
	(_disp displayCtrl 11004) ctrlShow false;
} else {
	(_disp displayCtrl 11004) ctrlSetText (_array # 0);
};
