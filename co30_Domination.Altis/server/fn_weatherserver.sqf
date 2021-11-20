// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _wchange = 1800 + random 600;

while {true} do {
	sleep _wchange;
	private _overCast = [random 1, random 0.49] select d_ws;

	_wchange = 1800 + random 600;
	_wchange setOvercast _overCast;

	if (d_enable_fog == 0) then {
		private _fog = [[0, 0, 0], [random 0.1, 0.1, 20 + (random 40)]] select (random 100 > 90);
		400 setFog _fog;
	} else {
		0 setFog [0, 0, 0];
	};

	if (d_WithWinterWeather == 0) then {
		private _ww = if (_overCast > 0.5) then {if (rain <= 0.3) then {1} else {2}} else {0};
		if (_ww != d_winterw) then {
			d_winterw = _ww;
			publicVariable "d_winterw";
		};
	};
};
