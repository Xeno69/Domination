// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draw3dstuff.sqf"
#include "..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];

private ["_distp", "_cwt", "_col", "_ico", "_tex"];
private _d_3draw_ar = d_3draw_ar;
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
			drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, _x # 1, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		} else {
			drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, format [d_d3d_locs4a, round (_cwt - serverTime)], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	};
} forEach (_d_3draw_ar select {alive (_x select 0)});

private _d_all_p_a_boxes = d_all_p_a_boxes;
{
	_x params ["_box"];
	_distp = _pos_cam distance _box;
	if (_distp < 80) then {
		_col = _x # 1;
		_col set [3, 1 - (_distp / 200)];
		drawIcon3D ["a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _x # 2, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_all_p_a_boxes select {!isNull (_x select 0)});

if (d_with_ai) then {
	private _d_allai_recruit_objs = d_allai_recruit_objs;
	{
		_distp = _pos_cam distance _x;
		if (_distp < 150) then {
			drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1,1,0,1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 3 + (_distp * 0.05)]), 1, 1, 0, d_d3d_locsaire, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	} forEach (_d_allai_recruit_objs select {alive _x});
};

private _d_mhq_3ddraw = d_mhq_3ddraw;
{
	_distp = _pos_cam distance _x;
	if (_distp < 150) then {
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 5 + (_distp * 0.05)]), 1, 1, 0, format ["MHQ %1", _x getVariable "d_ma_text"], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_mhq_3ddraw select {alive _x});

if !(d_cur_tgt_pos isEqualTo []) then {
	private _d_currentcamps = d_currentcamps;
	if (player distance2D d_cur_tgt_pos < 1500) then {
		{
			_distp = _pos_cam distance _x;
			if (_distp < 150) then {
				_m = 1 - (_distp / 200);
				_ico = if !((_x getVariable "d_SIDE") in d_own_sides) then {
					_lin = floor (linearConversion [0, _x getVariable "d_CAPTIME", _x getVariable "d_CURCAPTIME", 0, 24]) min 24;
					_col = [[1, 1, 0, _m], [1 - (_lin * 0.04), _lin * 0.04, 0, _m]] select !(_x getVariable "d_STALL");
					format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _lin]
				} else {
					_col = [0, 1, 0, _m];
					"\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_24_ca.paa"
				};
				
				drawIcon3D [_ico, _col, ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 8 + (_distp * 0.05)]), _m, _m, 0, str (_forEachIndex + 1), 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
			};		
		} forEach _d_currentcamps;
	};
};

#ifndef __TT__
if (d_showallnearusermarkers) then {
	private "_pos";
	private _toshow = d_allnearusermarkers # currentChannel;
	{
		if !(getMarkerColor _x isEqualTo "") then {
			_pos = markerPos _x;
			_pos set [2, 6];
			_distp = _pos_cam distance _pos;
			_m = 1 - (_distp / 1000);
			_col = getArray (configfile>>"CfgMarkerColors">>(getMarkerColor _x)>>"color");
			if (_col isEqualTo []) then {_col = [1, 1, 1, 1]};
			_col set [3, _m];
			drawIcon3D [getText (configfile>>"CfgMarkers">>(markerType _x)>>"icon"), _col, _pos, _m, _m, 0, markerText _x, 1, 0.033 - (_distp / 15000), "RobotoCondensed"];
		};
	} forEach _toshow;
};
#endif