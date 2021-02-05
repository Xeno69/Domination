// by Xeno
//#define __DEBUG__
#define THIS_FILE "init.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

if (productVersion # 2 < 201) exitWith {
	diag_log [diag_frameno, diag_ticktime, time, "You need at least A3 patch 2.01 to run the mission!!!!"];
	endMission "END1";
	forceEnd;
};

if (isMultiplayer && {hasInterface}) then {
	enableRadio false;
	showChat false;
	0 fadeSound 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

isNil {call compileScript ["d_init.sqf", false]};

#ifdef __IFA3LITE__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1944..."];
	private _date = date;
	_date set [0, 1944];
	setDate _date;
};
#endif

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];
