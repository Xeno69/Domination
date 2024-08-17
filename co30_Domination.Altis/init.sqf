// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

if (productVersion # 2 < 217) exitWith {
	diag_log [diag_frameno, diag_ticktime, time, "You need at least Arma 3 patch 2.18 to run Domination!!!!"];
	endMission "LOSER";
	forceEnd;
};

if (isMultiplayer && {hasInterface}) then {
	enableRadio false;
	showChat false;
	0 fadeSound 0;
	0 fadeEnvironment 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

private _year = -1;
#ifdef __IFA3__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1944..."];
	private _date = date;
	_date set [0, 1944];
	_year = 1944;
	setDate _date;
};
#endif
#ifdef __VN__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1971..."];
	private _date = date;
	_date set [0, 1971];
	_year = 1971;
	setDate _date;
};
#endif
#ifdef __UNSUNG__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1971..."];
	private _date = date;
	_date set [0, 1971];
	_year = 1971;
	setDate _date;
};
#endif
#ifdef __SPE__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1944..."];
	private _date = date;
	_date set [0, 1944];
	_year = 1944;
	setDate _date;
};
#endif
#ifdef __JSDF__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 2022..."];
	private _date = date;
	_date set [0, 2022];
	_year = 2022;
	setDate _date;
};
#endif

_year spawn {
	params ["_year"];
	waitUntil {!isNil "d_use_systemtime"};
	if (d_use_systemtime == 1) then {
		private _st = systemTime;
		if (_year != -1) then {
			_year = _st # 0;
		};
		setDate [_year, _st # 1, _st # 2, _st # 3, _st # 4];
	};
};

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];
