// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_killedsmtarget500.sqf"
#include "..\x_setup.sqf"

d_sm_winner = -500;
d_sm_resolved = true;
(_this select 0) removeAllEventHandlers "killed";
