// by Xeno
#define THIS_FILE "fn_3draw_ar_prep.sqf"
#include "..\..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];
private ["_distp", "_cwt", "_tex"];
d_3draw_ar_prep = [];
{
	_x params ["_obj"];
	_distp = _pos_cam distance _obj;
	if (_distp < 250) then {
		_cwt = _obj getVariable ["d_curreptime" , -1];
		_tex = call {
			if (_x # 3 == 0) exitWith {
				"a3\ui_f\data\IGUI\Cfg\Actions\arrow_up_gs.paa"
			};
			if (_x # 3 == 1) exitWith {
				"a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa"
			};
			if (_x # 3 == 2) exitWith {
				"a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa"
			};
			"#(argb,8,8,3)color(0,0,0,0)"
		};
		if (_cwt == -1) then {
			d_3draw_ar_prep pushBack [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, _x # 1, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		} else {
			d_3draw_ar_prep pushBack [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, format [d_d3d_locs4a, round (_cwt - serverTime)], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	};
} forEach d_3draw_ar;
