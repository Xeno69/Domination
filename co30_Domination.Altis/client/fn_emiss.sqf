// by Xeno
#define THIS_FILE "fn_emiss.sqf"
#include "..\x_setup.sqf"

if (remoteExecutedOwner != 2) exitWith {};

call {
	if (_this == 2) exitWith {
		endMission "End4";
	};
	if (_this == 3) exitWith {
		endMission "End5";
	};
	if (_this == 99) exitWith {
		endMission "End6";
	};
	endMission "Loser";
};
forceEnd;
