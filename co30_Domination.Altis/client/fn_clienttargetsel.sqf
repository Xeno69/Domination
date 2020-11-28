// by Xeno
#define THIS_FILE "fn_clienttargetsel.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

params ["_type"];

if (_type == 0) then {
	[localize "STR_DOM_MISSIONSTRING_1955", "GLOBAL"] call d_fnc_HintChatMsg;
	
	d_cur_sel_tar_obj = objNull;
	
	d_nt_sel_handler = addMissionEventHandler ["MapSingleClick", {call d_fnc_selnthandler}];
	
	"d_ProgressBar3" cutRsc ["d_ProgressBar3", "PLAIN"];
	private _control = (uiNamespace getVariable "d_ProgressBar3") displayCtrl 3800;

	_control ctrlSetPositionW 0.4;
	_control ctrlCommit 0;
	_control ctrlSetPositionW 0;
	_control ctrlCommit 30;
	
	d_clienttargetsel_scr = 0 spawn {
		scriptName "spawn clienttargetsel";
		{
			private _mar = _x getVariable "d_sel_mar";
			if (!isNil "_mar") then {
				private _num = _x getVariable ["d_selectionsmt", 0];
				if (!isNil "_num") then {
					_mar setMarkerTextLocal format ["  %1", _num];
				};
			};
		} forEach d_next_sels_ar;
		while {true} do {
			sleep 1;
			if (isNil "d_next_sels_ar") exitWith {};
			{
				private _mar = _x getVariable "d_sel_mar";
				if (!isNil "_mar") then {
					private _num = _x getVariable ["d_selectionsmt", 0];
					if (!isNil "_num") then {
						_mar setMarkerTextLocal format ["  %1", _num];
					};
				};
				sleep 0.001;
			} forEach d_next_sels_ar;
		};
	};
} else {
	terminate d_clienttargetsel_scr;
	d_clienttargetsel_scr = nil;
	
	"d_ProgressBar3" cutFadeOut 0;
	[localize "STR_DOM_MISSIONSTRING_1956", "GLOBAL"] call d_fnc_HintChatMsg;
	
	if (!isNil "d_nt_sel_handler") then {
		removeMissionEventHandler ["MapSingleClick", d_nt_sel_handler];
		d_nt_sel_handler = nil;
	};
	d_cur_sel_tar_obj = nil;
};