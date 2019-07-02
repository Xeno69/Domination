// by Xeno
#define THIS_FILE "fn_hcsmexec.sqf"
#include "..\x_setup.sqf"

if ((_this select 0) < 50000) then {
	execVM format ["x_missions\%3\%2%1.sqf", _this select 0, d_sm_fname, d_sm_folder];
} else {
	[_this select 0] call d_fnc_getbymarkersm;
};
sleep 7.012;
[_this select 0, d_x_sm_pos, d_x_sm_type] call d_fnc_s_sm_up;

if (random 100 > 50 && {!(toLower d_x_sm_type in ["convoy", "deliver", "prisoners", "evac", "specops"])}) then {
	d_sm_check_trigger = [d_x_sm_pos # 0, [30, 30, 0, false], ["ANYPLAYER", "PRESENT", false], ["this", "0 spawn d_fnc_smsurprise; deleteVehicle d_sm_check_trigger", ""]] call d_fnc_createtriggerlocal;
};
