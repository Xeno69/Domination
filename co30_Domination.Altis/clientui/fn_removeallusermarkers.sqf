// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

if (isMultiplayer && {!d_pisadminp}) exitWith {};

remoteExec ["d_fnc_rallusermarkers", 2];
