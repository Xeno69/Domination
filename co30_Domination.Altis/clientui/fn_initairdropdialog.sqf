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
if (d_with_airdrop == 2 && {d_sm_ammotrucktype_own_side isNotEqualTo ""}) then {
	(_disp displayCtrl 11008) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1232_AMMOTRUCK");
} else {
	(_disp displayCtrl 11008) ctrlShow false;
};
if (d_with_airdrop == 2 && {d_sm_apc_own_side isNotEqualTo ""}) then {
	(_disp displayCtrl 11020) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1232_APC");
} else {
	(_disp displayCtrl 11020) ctrlShow false;
};
if (d_with_airdrop == 2 && {d_sm_HunterGMG_own_side isNotEqualTo ""}) then {
	(_disp displayCtrl 11021) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1232_MRAP");
} else {
	(_disp displayCtrl 11021) ctrlShow false;
};
if (d_with_airdrop == 2 && {d_sm_tank_own_side isNotEqualTo ""}) then {
	(_disp displayCtrl 11022) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1232_TANK");
} else {
	(_disp displayCtrl 11022) ctrlShow false;
};
if (d_with_airdrop == 2 && {d_sm_tank_special_own_side isNotEqualTo ""}) then {
	(_disp displayCtrl 11023) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1232_TANK_SPECIAL");
} else {
	(_disp displayCtrl 11023) ctrlShow false;
};