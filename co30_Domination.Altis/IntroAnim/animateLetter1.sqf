//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;
params ["_ctrl"];

__TRACE_1("","_this")

d_animL_controls = d_animL_controls - [_ctrl];
_ctrl ctrlSetTextColor d_intro_color;
_ctrl ctrlSetText (_this select 1);
_ctrl ctrlSetPosition [((_this select 2) * 0.025) + 0.13,0.05 + (_this select 3) / 330];
_ctrl ctrlSetFade 0;
_ctrl ctrlSetScale 10;
_ctrl ctrlCommit 0;
_ctrl ctrlSetScale 1.2;
_ctrl ctrlCommit 0.5;
sleep 15;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
sleep 2;
d_animL_controls pushBack _ctrl;

true