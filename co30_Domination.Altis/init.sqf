// by Xeno
//#define __DEBUG__
#define THIS_FILE "init.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

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

if (productVersion # 2 < 197) exitWith {
	diag_log [diag_frameno, diag_ticktime, time, "You need at least A3 patch 1.97 to run the mission!!!!"];
	endMission "END1";
	forceEnd;
};

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];
