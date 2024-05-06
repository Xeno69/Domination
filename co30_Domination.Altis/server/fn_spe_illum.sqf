// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_trg_center", "_mtradius"];

sleep 1;

private _gr = createGroup sideLogic;
private _modules = [];

for "_i" from 1 to 6 do {
	private _module = _gr createUnit ["SPE_ModuleFlare_F", _trg_center getPos [random _mtradius, random 360], [], 0, "NONE"];
	_module setVariable ["type", selectRandom ["SPE_40mm_White", "SPE_40mm_Yellow", "SPE_40mm_Green", "SPE_40mm_Red"]];
	_module setVariable ["repeat", 1];
	_module setVariable ["bis_fnc_initmodules_activate", true];
	_modules pushBack _module;
	sleep (1 + random 2);
};

while {!d_mt_done} do {
	sleep 1;
};
sleep 30;
deleteVehicle _modules;
deleteGroup _gr;
