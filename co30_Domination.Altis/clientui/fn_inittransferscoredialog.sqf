// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;

params ["_disp"];

#define CTRL(A) (_disp displayCtrl A)

private _ctrl = CTRL(1001);

lbClear _ctrl;
{
	private _index = _ctrl lbAdd (name _x);
	_ctrl lbSetData [_index, netId _x];
} forEach (d_allplayers - [player]);

_ctrl lbSetCurSel 0;

CTRL(1007) ctrlEnable false;

d_transscore = 0;

d_slider_score = [10000, score player] select isMultiplayer;

_ctrl = CTRL(1001);
_ctrl sliderSetRange [0, d_slider_score];
_ctrl sliderSetPosition 0;

private _strscore = str d_slider_score;
CTRL(1009) ctrlSetText _strscore;
CTRL(1010) ctrlSetText _strscore;
CTRL(1011) ctrlSetText "0";

CTRL(1020) ctrlSetText "0";
CTRL(1021) ctrlSetText _strscore;