// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draw3dstuff.sqf"
#include "..\..\..\x_setup.sqf"

//__scale3 +5
//__scale4 +1.5
//__scale5 +2.5

private _pos_cam = positionCameraToWorld [0,0,0];

private ["_distp", "_cwt", "_col", "_ico"];
{
	_x params ["_obj"];
	_distp = _pos_cam distance _obj;
	if (_distp < 250) then {
		_cwt = _obj getVariable ["d_curreptime" , -1];
		if (_cwt == -1) then {
			drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, _x # 1, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		} else {
			drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, format [d_d3d_locs4a, round (_cwt - time)], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	};
} forEach d_3draw_ar;

{
	_x params ["_box"];
	if (!isNull _box) then {
		_distp = _pos_cam distance _box;
		if (_distp < 80) then {
			_col = _x # 1;
			_col set [3, 1 - (_distp / 200)];
			drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _x # 2, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	};
} forEach d_all_p_a_boxes;

if (d_with_ai) then {
	{
		_distp = _pos_cam distance _x;
		if (_distp < 150) then {
			drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1,1,0,1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 3 + (_distp * 0.05)]), 1, 1, 0, d_d3d_locsaire, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	} forEach d_allai_recruit_objs;
};

{
	_distp = _pos_cam distance _x;
	if (_distp < 150) then {
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 5 + (_distp * 0.05)]), 1, 1, 0, format ["MHQ %1", _x getVariable "d_ma_text"], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (d_mhq_3ddraw select {alive _x});

{
	_distp = _pos_cam distance _x;
	if (_distp < 150) then {
		_m = 1 - (_distp / 200);
		private "_col";
		_ico = if !((_x getVariable "d_SIDE") in d_own_sides) then {
			_lin = floor (linearConversion [0, _x getVariable "d_CAPTIME", _x getVariable "d_CURCAPTIME", 0, 24]) min 24;
			_col = [[1, 1, 0, _m], [1 - (_lin * 0.04), _lin * 0.04, 0, _m]] select !(_x getVariable "d_STALL");
			format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _lin]
		} else {
			_col = [0, 1, 0, _m];
			"\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_24_ca.paa"
		};
		
		drawIcon3D [_ico, _col, ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 8 + (_distp * 0.05)]), _m, _m, 0, "", 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach d_currentcamps;