// by Xeno
#define THIS_FILE "fn_hcsmexec.sqf"
#include "..\x_setup.sqf"

if ((_this select 0) < 50000) then {
	execVM format ["x_missions\%3\%2%1.sqf", _this select 0, d_sm_fname, d_sm_folder];
} else {
	[_this select 0] call d_fnc_getbymarkersm;
};
sleep 7.012;
[_this select 0, d_x_sm_pos, d_x_sm_type] remoteExecCall ["d_fnc_s_sm_up", 2];
