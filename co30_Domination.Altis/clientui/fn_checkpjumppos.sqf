// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkpjumppos.sqf"
#include "..\x_setup.sqf"

disableSerialization;

if (d_cur_tgt_pos isEqualTo []) exitWith {true};

private _res = (_this select 0) distance2D d_cur_tgt_pos > d_cur_target_radius + 200;

if (!_res) then {
	((ctrlParent (_this select 1)) displayCtrl 1000) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1867");
} else {
	((ctrlParent (_this select 1)) displayCtrl 1000) ctrlSetText "";
};

_res
