// by Xeno
#define THIS_FILE "fn_currentcamps_prep.sqf"
#include "..\..\x_setup.sqf"

d_currentcamps_prep = [];
if (!(d_cur_tgt_pos isEqualTo []) && {player distance2D d_cur_tgt_pos < 1500}) then {
	private _pos_cam = positionCameraToWorld [0,0,0];
	private ["_distp", "_col", "_ico"];
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
			
			d_currentcamps_prep pushBack [_ico, _col, ASLToAGL ((visiblePositionASL _x) vectorAdd [0,0, 8 + (_distp * 0.05)]), _m, _m, 0, str (_forEachIndex + 1), 1, 0.033 - (_distp / 9000), "RobotoCondensed"];
		};
	} forEach d_currentcamps;
};