// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

params ["_disp"];

private _ctrl = _disp displayCtrl 1001;

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (name _x);
	_ctrl lbSetData [_index, netId _x];
} forEach (d_allplayers - [player]);

_ctrl lbSetCurSel 0;

(_disp displayCtrl 1007) ctrlEnable false;

d_transscore = 0;

d_slider_score = [10000, score player] select isMultiplayer;

_ctrl = _disp displayCtrl 1001;
_ctrl sliderSetRange [0, d_slider_score];
_ctrl sliderSetPosition 0;

private _strscore = str d_slider_score;
(_disp displayCtrl 1009) ctrlSetText _strscore;
(_disp displayCtrl 1010) ctrlSetText _strscore;
(_disp displayCtrl 1011) ctrlSetText "0";

(_disp displayCtrl 1020) ctrlSetText "0";
(_disp displayCtrl 1021) ctrlSetText _strscore;