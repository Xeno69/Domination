//#define __DEBUG__
#define THIS_FILE "fn_sandstorm.sqf"
#include "..\x_setup.sqf"

#define __DURATION 2
#define __COLORCOEF 1

if (isDedicated) exitWith {};

while {true} do {
	if (rain isEqualTo 0 && {!d_rscspect_on && {!surfaceIsWater (getPosWorld player) && {!(player getVariable "xr_pluncon") && {!(player getVariable ["ace_isunconscious", false])}}}}) then {
		private _obj = vehicle player;
		private _velocity = [-8 + (random 16), -8 + (random 16), 0];
		private _color = [1.0 * __COLORCOEF, 0.9 * __COLORCOEF, 0.8 * __COLORCOEF];

		private _ps = "#particleSource" createVehicleLocal getPosWorld _obj;  
		_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8, 0], "", "Billboard", 1, __DURATION, [-((_velocity # 1) * (__DURATION / 2)), 0, -6], _velocity, 1, 1.275, 1, 0, [5], [_color + [0], _color + [0.2  + random 0.02], _color + [0]], [1000], 1, 0, "", "", _obj];
		_ps setParticleRandom [3, [10, 10, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.05], 0, 0];
		_ps setParticleCircle [0.1, [0, 0, 0]];
		_ps setDropInterval 0.01;
		sleep (random 1);
		deleteVehicle _ps;
		sleep (5 + random 25);
	} else {
		sleep 15;
	};
};
