// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draw3d.sqf"
#include "..\x_macros.sqf"

if (alive player && {xr_uncon_units isNotEqualTo []}) then {
	private _cam2world = positionCameraToWorld [0,0,0];
	private ["_dist", "_utext"];
	private _fnc_gpln = d_fnc_getplayername;
	{
		_dist = _cam2world distance _x;
		_utext = _x getVariable "d_utext";
		if (isNil "_utext") then {
			_utext = "(Uncon) " + (_x call _fnc_gpln);
			_x setVariable ["d_utext", _utext];
		};
		drawIcon3D ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", [1,0,0,1 - (_dist / 200)], (getPosATLVisual _x) vectorAdd [0, 0, 1 + (_dist * 0.04)], 1, 1, 0, _utext, 1, 0.032 - (_dist / 9000), "RobotoCondensed"];
	} forEach xr_uncon_units select {_cam2world distance2D _x < 400};
};