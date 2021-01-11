// by Xeno
#define THIS_FILE "fn_flare40.sqf"
#include "..\x_setup.sqf"

private _foo = "#lightpoint" createVehicle (getPosASL _this);
_foo attachTo [_this, [0, 0, 0]];
_foo setLightColor [1, 1, 1];
_foo setLightAmbient [1, 1, 1];
//	_foo setLightIntensity 100000;
_foo setLightIntensity 80000;
_foo setLightUseFlare true;
_foo setLightFlareSize 10;
_foo setLightFlareMaxDistance 600;
_foo setLightDayLight true;
_foo setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];

waitUntil {
	sleep 0.1;
	!alive _this;
};
deletevehicle _foo;