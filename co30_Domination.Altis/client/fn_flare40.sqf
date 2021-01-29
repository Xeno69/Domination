#define THIS_FILE "fn_flare40.sqf"
#include "..\x_setup.sqf"

params ["_lightp"];

_lightp setLightColor [1, 1, 1];
_lightp setLightAmbient [1, 1, 1];
//	_foo setLightIntensity 100000;
_lightp setLightIntensity 80000;
_lightp setLightUseFlare true;
_lightp setLightFlareSize 10;
_lightp setLightFlareMaxDistance 600;
_lightp setLightDayLight true;
_lightp setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];
