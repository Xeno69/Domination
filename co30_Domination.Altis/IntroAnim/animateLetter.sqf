//#define __DEBUG__
#define THIS_FILE "animateLetter.sqf"
#include "..\x_setup.sqf"

disableSerialization;
params ["_ctrl"];
__TRACE_1("","_this")

d_animL_controls = d_animL_controls - [_ctrl];
_ctrl ctrlSetTextColor d_intro_color;
_ctrl ctrlSetText (_this select 1);
_ctrl ctrlSetPosition [-0.1, 0.3];
_ctrl ctrlSetFade 0;
_ctrl ctrlSetScale 0.2;
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [((_this select 2) * 0.025) + 0.13,0.05 + (_this select 3) / 330];
_ctrl ctrlCommit 0.5;
_ctrl ctrlSetScale 4;
_ctrl ctrlCommit 0.25;
sleep 0.25;
_ctrl ctrlSetScale 1.2;
_ctrl ctrlCommit 0.25;
sleep 14.75;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
sleep 2;
d_animL_controls pushBack _ctrl;

true