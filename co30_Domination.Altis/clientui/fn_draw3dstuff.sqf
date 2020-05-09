// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draw3dstuff.sqf"
#include "..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];

private ["_distp", "_cwt", "_col", "_ico", "_tex", "_hasperc", "_txt"];
private _d_3draw_ar = d_3draw_ar;
private _with_3Dicon = d_with_3Dicon;
private _d3d_locs4a = d_d3d_locs4a;
{
	_x params ["_obj"];
	_distp = _pos_cam distance _obj;
	_cwt = _obj getVariable ["d_curreptime" , -1];
	if (_with_3Dicon == 1) then {
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
	} else {
		_tex = "#(argb,8,8,3)color(0,0,0,0)";
	};
	if (_cwt == -1) then {
		drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, _x # 1, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} else {
		drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, format [_d3d_locs4a, round (_cwt - serverTime)], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_3draw_ar select {alive (_x select 0) && {_pos_cam distance2D (_x select 0) < 250}});

private _d_all_p_a_boxes = d_all_p_a_boxes;
{
	_x params ["_box"];
	_distp = _pos_cam distance _box;
	_col = _x # 1;
	_col set [3, 1 - (_distp / 200)];
	_hasperc = _box getVariable "d_abox_perc";
	_txt = [_x # 2, format ["%1 (%2)", _x # 2, _hasperc / 10]] select (!isNil "_hasperc");
	if (_with_3Dicon == 1) then {
		drawIcon3D ["a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _txt, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} else {
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _txt, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_all_p_a_boxes select {!isNull (_x select 0) && {_pos_cam distance2D (_x select 0) < 80}});

if (d_with_ai) then {
	private _d_allai_recruit_objs = d_allai_recruit_objs;
	private _d3d_locsaire = d_d3d_locsaire;
	{
		_distp = _pos_cam distance _x;
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1,1,0,1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 3 + (_distp * 0.05)]), 1, 1, 0, _d3d_locsaire, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} forEach (_d_allai_recruit_objs select {alive _x && {_pos_cam distance2D _x < 150}});
};

private _d_mhq_3ddraw = d_mhq_3ddraw;
{
	_distp = _pos_cam distance _x;
	drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 5 + (_distp * 0.05)]), 1, 1, 0, "MHQ " + (_x getVariable "d_ma_text"), 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
} forEach (_d_mhq_3ddraw select {alive _x && {_pos_cam distance2D _x < 150}});

if (!(d_cur_tgt_pos isEqualTo []) && {!(d_currentcamps isEqualTo [])}) then {
	private _d_currentcamps = d_currentcamps;
	if (player distance2D d_cur_tgt_pos < 1500) then {
		private _own_sides = d_own_sides;
		{
			_distp = _pos_cam distance _x;
			_m = 1 - (_distp / 200);
			_ico = if !((_x getVariable "d_SIDE") in _own_sides) then {
				_lin = floor (linearConversion [0, _x getVariable "d_CAPTIME", _x getVariable "d_CURCAPTIME", 0, 24]) min 24;
				_col = [[1, 1, 0, _m], [1 - (_lin * 0.04), _lin * 0.04, 0, _m]] select !(_x getVariable "d_STALL");
				format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", _lin]
			} else {
				_col = [0, 1, 0, _m];
				"\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_24_ca.paa"
			};

			drawIcon3D [_ico, _col, ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 8 + (_distp * 0.05)]), _m, _m, 0, str (_forEachIndex + 1), 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		} forEach _d_currentcamps select {_pos_cam distance2D _x < 150};
	};
};

#ifndef __TT__
if (d_showallnearusermarkers) then {
	private "_pos";
	private _toshow = d_allnearusermarkers # currentChannel;
	{
		_pos = markerPos _x;
		_pos set [2, 10];
		_distp = _pos_cam distance _pos;
		if (_distp < 1000) then {
			_m = 1 - (_distp / 1000);
			_col = getArray (configfile>>"CfgMarkerColors">>(getMarkerColor _x)>>"color");
			if (_col isEqualTo []) then {_col = [1, 1, 1, 1]};
			_col set [3, _m];
			//drawIcon3D [getText (configfile>>"CfgMarkers">>(markerType _x)>>"icon"), _col, _pos, _m, _m, 0, markerText _x, 1, 0.033 - (_distp / 15000), "RobotoCondensed"];
			drawIcon3D [getText (configfile>>"CfgMarkers">>(markerType _x)>>"icon"), _col, _pos, _m, _m, 0, markerText _x, 1, 0.055 - (_distp / 15000), "RobotoCondensed"];
		};
	} forEach _toshow select {!(getMarkerColor _x isEqualTo "")};
};
#endif