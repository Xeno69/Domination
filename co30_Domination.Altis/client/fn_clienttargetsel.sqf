// by Xeno
#define THIS_FILE "fn_clienttargetsel.sqf"
#include "..\x_setup.sqf"

params ["_type"];

if (_type == 0) then {
	[localize "STR_DOM_MISSIONSTRING_1955", "GLOBAL"] call d_fnc_HintChatMsg;
	
	d_cur_sel_tar_obj = objNull;
	
	d_nt_sel_handler = addMissionEventHandler ["MapSingleClick", {_this call d_fnc_selnthandler}];
	
	"d_ProgressBar3" cutRsc ["d_ProgressBar3", "PLAIN"];
	private _control = (uiNamespace getVariable "d_ProgressBar3") displayCtrl 3800;

	_control ctrlSetPositionW 0.4;
	_control ctrlCommit 0;
	_control ctrlSetPositionW 0;
	_control ctrlCommit 30;
} else {
	"d_ProgressBar3" cutFadeOut 0;
	[localize "STR_DOM_MISSIONSTRING_1956", "GLOBAL"] call d_fnc_HintChatMsg;
	
	if (!isNil "d_nt_sel_handler") then {
		removeMissionEventHandler ["MapSingleClick", d_nt_sel_handler];
		d_nt_sel_handler = nil;
	};
	d_cur_sel_tar_obj = nil;
};