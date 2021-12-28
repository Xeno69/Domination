// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

private _disp = uiNamespace getVariable "d_RscLastChance";
if (isNil "_disp" || {isNull _disp}) then {
	"d_RscLastChance" cutRsc ["d_RscLastChance", "PLAIN"];
	_disp = uiNamespace getVariable "d_RscLastChance";
};

private _ctrl = _disp displayCtrl 50;
if (_this == -1) then {
	_ctrl ctrlShow false;
	(_disp displayCtrl 3900) ctrlShow false;
} else {
	_ctrl ctrlShow true;
	(_disp displayCtrl 3900) ctrlShow true;
	private _lin = round (linearConversion [0, 60, 60 - _this, 0, 24, true]);
	_ctrl ctrlSetText format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _lin];
};