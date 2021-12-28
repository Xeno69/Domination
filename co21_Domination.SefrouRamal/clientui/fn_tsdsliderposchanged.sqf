// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

//__TRACE_1("","_this")

params ["_ctrl", "_slpos"];

private _disp = ctrlParent _ctrl;

//__TRACE_1("","sliderPosition _ctrl")

d_transscore = round ((d_slider_score / 10) * (sliderPosition _ctrl));

(_disp displayCtrl 1010) ctrlSetText str(d_slider_score - d_transscore);
(_disp displayCtrl 1011) ctrlSetText str(d_transscore);

if (d_transscore > 0) then {
	(_disp displayCtrl 1007) ctrlEnable true;
} else {
	(_disp displayCtrl 1007) ctrlEnable false;
};