// by Xeno
#define THIS_FILE "fn_clienttargetsel.sqf"
#include "..\..\x_setup.sqf"

params ["_type"];

if (_type == 0) then {
	hint "You now have 30 seconds to select the next main target by clicking on one of the next available targets (purple)\n\nA selected target will turn orange";
	
	d_cur_sel_tar_obj = objNull;
	
	d_nt_sel_handler = addMissionEventHandler ["MapSingleClick", {_this call d_fnc_selnthandler}];
} else {
	hint "30 Seconds selection is over";
	
	if (!isNil "d_nt_sel_handler") then {
		removeMissionEventHandler ["MapSingleClick", d_nt_sel_handler];
		d_nt_sel_handler = nil;
	};
	d_cur_sel_tar_obj = nil;
};