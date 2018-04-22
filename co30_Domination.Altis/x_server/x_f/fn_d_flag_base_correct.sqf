// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_d_flag_base_correct.sqf"
#include "..\..\x_setup.sqf"

#ifndef __TT__
private _pos_flag = getPosAsl d_FLAG_BASE;
private _dir_flag = getDir d_FLAG_BASE;
#else
private _pos_flag_e = getPosAsl d_EFLAG_BASE;
private _dir_flag_e = getDir d_EFLAG_BASE;
private _pos_flag_w = getPosAsl d_WFLAG_BASE;
private _dir_flag_w = getDir d_WFLAG_BASE;
#endif

sleep 600;

while {true} do {
#ifndef __TT__
	d_FLAG_BASE setDir _dir_flag;
	d_FLAG_BASE setPosASL _pos_flag;
	d_FLAG_BASE setVectorUp [0,0,1];
#else
	d_EFLAG_BASE setDir _dir_flag_e;
	d_EFLAG_BASE setPosASL _pos_flag_e;
	d_EFLAG_BASE setVectorUp [0,0,1];
	d_WFLAG_BASE setDir _dir_flag_w;
	d_WFLAG_BASE setPosASL _pos_flag_w;
	d_WFLAG_BASE setVectorUp [0,0,1];
#endif
	sleep 600;
};