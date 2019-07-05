// by Xeno
#define THIS_FILE "fn_jumpover.sqf"
#include "..\x_setup.sqf"

if ((_this select 1) in actionKeys "GetOver" && {alive player && {currentWeapon player == primaryWeapon player && {currentWeapon player != "" && {isNull objectParent player && {speed player > 11 && {stance player == "STAND" && {getFatigue player < 0.5 && {isTouchingGround (vehicle player) &&  {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {!d_p_isju}}}}}}}}}}}) then {
	d_p_isju = true;
	0 spawn {
		scriptName "spawn_setupplayer4";
		private _v = velocity player;
		private _veloH = _v vectorAdd [0.6, 0.6, 0.1];
		private _veloL = _v vectorAdd [0, 0, -1];
		private _maxHight = (getPosATL player # 2) + 1.3;
		
		[player, "AovrPercMrunSrasWrflDf"] remoteExecCall ["switchMove"];
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