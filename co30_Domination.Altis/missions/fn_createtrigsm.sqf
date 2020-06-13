// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createtrigsm.sqf"
#include "..\x_setup.sqf"
__TRACE_1("","_this")

if (!hasInterface) exitWith {};

params ["_pos", "_type"];

if (_type == 0) exitWith {
	d_sm_curptrigger = [_pos, [30, 30, 0, false, 80], ["ANYPLAYER", "PRESENT", true], ["player in thislist && {!(call d_fnc_hasrespirator)}", "d_sm_curptrig_script = 0 spawn d_fnc_smcough", "terminate d_sm_curptrig_script; d_sm_curptrig_script = nil"]] call d_fnc_createtriggerlocal;
};
