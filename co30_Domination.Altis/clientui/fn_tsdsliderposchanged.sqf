// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tsdsliderposchanged.sqf"
#include "..\x_setup.sqf"

#define CTRL(A) (_disp displayCtrl A)

if (!hasInterface) exitWith {};

disableSerialization;

__TRACE_1("","_this")

params ["_ctrl", "_slpos"];

private _disp = ctrlParent _ctrl;

__TRACE_1("","sliderPosition _ctrl")

d_transscore = round ((d_slider_score / 10) * (sliderPosition _ctrl));

CTRL(1010) ctrlSetText str(d_slider_score - d_transscore);
CTRL(1011) ctrlSetText str(d_transscore);

if (d_transscore > 0) then {
	CTRL(1007) ctrlEnable true;
} else {
	CTRL(1007) ctrlEnable false;
};