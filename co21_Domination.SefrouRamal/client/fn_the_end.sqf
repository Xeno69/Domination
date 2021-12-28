// by Xeno
#include "..\x_setup.sqf"

if (remoteExecutedOwner != 2) exitWith {};

if (_this == 0 && {hasInterface}) then {
	if (isNil "d_end_cam_running") then {
		0 spawn d_fnc_endcam;
	};
} else {
	endMission "END1";
	forceEnd;
};