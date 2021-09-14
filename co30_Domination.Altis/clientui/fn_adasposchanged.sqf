// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

//__TRACE_1("","_this")

params ["_ctrl", "_slpos"];

private _disp = ctrlParent _ctrl;

//__TRACE_1("","sliderPosition _ctrl")

d_a_d_selscore = round (sliderPosition _ctrl);

(_disp displayCtrl 1016) ctrlSetText str(d_a_d_selscore);
