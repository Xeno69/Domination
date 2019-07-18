// by Xeno
//#define __DEBUG__
#define THIS_FILE "init.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

disableRemoteSensors true;

if (isMultiplayer && {hasInterface}) then {
	enableRadio false;
	showChat false;
	0 fadeSound 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

addMissionEventhandler ["EachFrame", {
	if (isNil "d_init_processed") then {
		call compile preprocessFileLineNumbers "d_init.sqf";
	};
	removeMissionEventHandler ["EachFrame", _thisEventHandler];
}];

#ifdef __IFA3LITE__
if (isServer) then {
	private _date = date;
	_date set [0, 1944];
	setDate _date;
};
#endif

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];
