// by Xeno
#define THIS_FILE "fn_draw3d_ace.sqf"
#include "..\x_setup.sqf"

if (alive player && {!(player getVariable ["ace_isunconscious", false])}) then {
	private _cam2world = positionCameraToWorld [0,0,0];
	private ["_dist", "_utext"];
	{
		_dist = _cam2world distance _x;
		if (_dist < 400) then {
			_utext = _x getVariable "d_utext";
			if (isNil "_utext") then {
				_utext = "(Uncon) " + (_x call d_fnc_getplayername);
				_x setVariable ["d_utext", _utext];
			};
			drawIcon3D ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa", [1,0,0,1 - (_dist / 200)], (getPosATLVisual _x) vectorAdd [0, 0, 1 + (_dist * 0.05)], 1, 1, 0, _utext, 2, 0.032 - (_dist / 9000), "RobotoCondensed"];
		};
	} forEach (d_allplayers select {alive _x && {_x getVariable ["ace_isunconscious", false]}});
};
