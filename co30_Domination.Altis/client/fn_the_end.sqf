// by Xeno
#define THIS_FILE "fn_the_end.sqf"
#include "..\x_setup.sqf"

if (remoteExecutedOwner != 2) exitWith {};

if (_this == 0 && {hasInterface}) then {
	if (isNil "d_end_cam_running") then {
		execVM "client\x_endcam.sqf";
	};
} else {
	endMission "END1";
	forceEnd;
};