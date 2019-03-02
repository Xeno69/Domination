//#define __DEBUG__
#define THIS_FILE "fn_ambientradiochatter.sqf"
#include "..\x_setup.sqf"
if !(hasInterface) exitWith {};

d_radio_carlist = [];

private _cfg = configFile >> "CfgVehicles";
for "_i" from 0 to ((count _cfg) -1) do {
	if (isClass (_cfg select _i)) then {
		private _cfgName = configName (_cfg select _i);
		if (_cfgName isKindOf "Car" && {getNumber ((_cfg select _i) >> "scope") == 2 && {getNumber ((_cfg select _i) >> "side") == 3}}) then {
			__TRACE_1("","_cfgName")
			d_radio_carlist pushBack _cfgname;
		};
	};
};

uisleep _this;

while {true} do {
    if(!d_player_in_vec && {diag_fps > 30}) then {
	    private _veh = (player nearEntities [["Air","Car","Tank","Ship"], 10]) # 0;
	    if (!isNil "_veh") then	{
	        if (!(typeOf _veh in d_radio_carlist) && {!(_veh isKindOf "BIS_Steerable_Parachute") && {!(_veh isKindOf "ParachuteBase") && {!(_veh isKindOf "StaticWeapon")}}}) then {
		        _veh say3D [format ["ambientradio%1", ceil random 30], 50, 1];
            };        
		};
	};
	uisleep (1 + random 59);
};
