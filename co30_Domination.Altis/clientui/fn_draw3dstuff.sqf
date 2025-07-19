// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _pos_cam = positionCameraToWorld [0,0,0];

private ["_distp", "_cwt", "_col", "_ico", "_tex", "_hasp", "_txt", "_obj", "_box"];
private _with_3Di = d_with_3Dicon;
private _d3d_locs4a = d_d3d_locs4a;
private _d_3draw_ar = d_3draw_ar;
private _iaar = [_pos_cam, 250, 250, 0, false];
{
	_obj = _x # 0;
	_distp = _pos_cam distance _obj;
	_tex = ["#(argb,8,8,3)color(0,0,0,0)", _obj getVariable "d_tex"] select (_with_3Di == 1);
	if (_x # 4 == 0) then {
		drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, _x # 1, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} else {
		drawIcon3D [_tex, [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((getPosASL _obj) vectorAdd [0, 0, (_x # 2) + (_distp * 0.05)]), 1, 1, 0, format [_d3d_locs4a, round ((_obj getVariable ["d_curreptime" , -1]) - serverTime) max 0], 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_3draw_ar select {alive (_x # 0) && {(_x # 0) inArea _iaar}});

private _d_all_p_a_boxes = d_all_p_a_boxes;
_iaar = [_pos_cam, 80, 80, 0, false];
{
	_box = _x # 0;
	_distp = _pos_cam distance _box;
	_col = _x # 1;
	_col set [3, 1 - (_distp / 200)];
	_hasp = (_box getVariable "d_abox_perc") toFixed 2;
	_txt = [_x # 2, format ["%1 (%2)", _x # 2, _hasp]] select (!isNil "_hasp");
	if (_with_3Di == 1 && {d_force_isstreamfriendlyui != 1 && {!isStreamFriendlyUIEnabled}}) then {
		drawIcon3D ["a3\ui_f\data\IGUI\Cfg\Actions\reammo_ca.paa", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, _txt, 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} else {
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", _col, ASLToAGL ((getPosASL _box) vectorAdd [0, 0, 1.5 + (_distp * 0.05)]), 1, 1, 0, "", 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
	};
} forEach (_d_all_p_a_boxes select {!isNull (_x # 0) && {(_x # 0) inArea _iaar}});

if (d_with_ai) then {
	private _d3d_locsaire = d_d3d_locsaire;
	private _d_allai_recruit_objs = d_allai_recruit_objs;
	_iaar = [_pos_cam, 150, 150, 0, false];
	{
		_distp = _pos_cam distance _x;
		drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [1, 1, 0, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 3 + (_distp * 0.05)]), 1, 1, 0, _d3d_locsaire, 2, 0.033 - (_distp / 9000), "RobotoCondensed"];
	} forEach (_d_allai_recruit_objs select {alive _x && {_x inArea _iaar}});
};

private _d_mhq_3ddraw = d_mhq_3ddraw;
_iaar = [_pos_cam, 150, 150, 0, false];
{
	_distp = _pos_cam distance _x;
	drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", [0, 0, 1, 1 - (_distp / 200)], ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 5 + (_distp * 0.05)]), 1, 1, 0, _x getVariable "d_mhq_txt", 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
} forEach (_d_mhq_3ddraw select {alive _x && {_x inArea _iaar}});

if (d_cur_tgt_pos isNotEqualTo [] && {d_currentcamps isNotEqualTo []}) then {
	if (_pos_cam distance2D d_cur_tgt_pos < 1500) then {
		private _own_sides = d_own_sides;
		private _d_dr3dca_hash = d_dr3dca_hash;
		private _d_currentcamps = d_currentcamps;
		{
			_distp = _pos_cam distance _x;
			_m = 1 - (_distp / 200);
			_ico = if !((_x getVariable "d_SIDE") in _own_sides) then {
				_lin = floor (linearConversion [0, _x getVariable "d_CAPTIME", _x getVariable "d_CURCAPTIME", 0, 24]) min 24;
				_col = [[1, 1, 0, _m], [1 - (_lin * 0.04), _lin * 0.04, 0, _m]] select !(_x getVariable "d_STALL");
				_d_dr3dca_hash get _lin
			} else {
				_col = [0, 1, 0, _m];
				"\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_24_ca.paa"
			};
			if (d_force_isstreamfriendlyui != 1) then {
				drawIcon3D [_ico, _col, ASLToAGL ((visiblePositionASL _x) vectorAdd [0, 0, 8 + (_distp * 0.05)]), _m, _m, 0, str (_forEachIndex + 1), 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
			};
		} forEach _d_currentcamps select {_x inArea _iaar};
	};
};

private _col_s = d_color_hash;
if (d_showallnearusermarkers) then {
	private "_pos";
	private _d_allnearusermarkers = d_allnearusermarkers;
	_iaar = [_pos_cam, 1000, 1000, 0, false];
	{
		_pos = markerPos _x;
		_pos set [2, 10];
		if (_pos inArea _iaar) then {
			_distp = _pos_cam distance _pos;
			_m = 1 - (_distp / 1000);
			_col = _col_s get (getMarkerColor _x);
			if (_col isEqualTo []) then {
				_col = [1, 1, 1, _m];
			} else {
				_col set [3, _m];
			};
			drawIcon3D [getText (configfile>>"CfgMarkers">>(markerType _x)>>"icon"), _col, _pos, _m, _m, 0, markerText _x, 1, 0.055 - (_distp / 15000), "RobotoCondensed"];
			drawLine3D [_pos vectorAdd [0, 0, -10], _pos vectorAdd [0, 0, -1], _col, 5];
		};
	} forEach (_d_allnearusermarkers # currentChannel);
};
#ifndef __TT__
if (!isNull d_near_player_flag && {d_force_isstreamfriendlyui != 1 && {!isStreamFriendlyUIEnabled}}) then {
	drawLaser [
		d_near_player_flag_pos,
		[0, 0, 1],
		[5, 5, 5],
		[],
		10,
		10,
		120,
		false
	];
	if (d_near_player_flag_pos2 distance2D player < 500) then {
		_col = _col_s get (getMarkerColor d_near_player_flag_marker);
		if (_col isEqualType 1 || {_col isEqualTo []}) then {
			_col = [1, 1, 1, 1];
		};
		drawIcon3D [getText (configfile>>"CfgMarkers">>(markerType d_near_player_flag_marker)>>"icon"), _col, d_near_player_flag_pos2, 1, 1, 0, "Parajump", 1];
		drawLine3D [d_near_player_flag_pos2 vectorAdd [0, 0, -15], d_near_player_flag_pos2 vectorAdd [0, 0, -1], _col, 5];
	};
};
#endif
