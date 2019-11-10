// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_playerboxkilled.sqf"
#include "..\x_setup.sqf"

params ["_boxo"];
[_boxo] remoteExecCall ["d_fnc_RemABoxC"];
{
	if (!alive _x) then {
		d_player_ammoboxes set [_forEachIndex, -1];
	};
} forEach d_player_ammoboxes;
d_player_ammoboxes = d_player_ammoboxes - [objNull, -1];
private _bpos = _boxo getVariable "d_bpos";
private _dir = _boxo getVariable "d_bdir";
__TRACE_2("","_bpos","_dir")
deleteVehicle _boxo;
private _box = createVehicle [d_the_base_box, [0,0,100], [], 0, "NONE"];
_box setPosASL _bpos;
_box setDir _dir;
if (surfaceIsWater _bpos) then {
	// we assume it is the carrier
	private _aslh = d_the_carrier getVariable "d_asl_height";
	if (!isNil "_aslh") then {
		_box setPosASL [_bpos # 0, _bpos # 1, _aslh];
	};
};
_box setVariable ["d_bpos", getPosASL _box];
_box setVariable ["d_bdir", _dir];
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
clearItemCargoGlobal _box;
_box enableRopeAttach false;
_box enableSimulationGlobal false;
_box addEventhandler ["killed", {_this call d_fnc_playerboxkilled}];
[_box] remoteExecCall ["d_fnc_air_box", [0, -2] select isDedicated];

d_player_ammoboxes pushBack _box;
publicVariable "d_player_ammoboxes";