//#define __DEBUG__
#define THIS_FILE "fn_jumpover.sqf"
#include "..\x_setup.sqf"

if ((_this # 1) in d_ak_getover && {d_player_canu && {speed player > 11 && {currentWeapon player == primaryWeapon player && {currentWeapon player != "" && {isNull objectParent player && {stance player isEqualTo "STAND" && {getFatigue player < 0.5 && {isTouchingGround (vehicle player) && {!d_p_isju}}}}}}}}}) then {
	d_p_isju = true;
	0 spawn {
		scriptName "spawn jumpover";
		private _v = velocity player;
		private _veloH = _v vectorAdd [0.6, 0.6, 0.1];
		private _veloL = _v vectorAdd [0, 0, -1];
		private _maxHight = (getPosATL player # 2) + 1.3;

		__TRACE("Calling d_fnc_swm")
		[player, 0] remoteExecCall ["d_fnc_swm"];
		sleep 0.05;
		while {animationState player == "AovrPercMrunSrasWrflDf"} do {
			if (getPosATL player # 2 > _maxHight) then {
				player setVelocity _veloL;
			} else {
				player setVelocity _veloH;
			};
			sleep 0.05;
		};
		sleep 1;
		d_p_isju = false;
	};
	true
} else {
	false
};