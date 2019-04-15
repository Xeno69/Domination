// by Xeno
#define __DEBUG__
#define THIS_FILE "fn_selnthandler.sqf"
#include "..\..\..\x_setup.sqf"

__TRACE_1("","_this")

private _pos = _this select 1;

if (!isNil "d_next_sels_ar") then {
	private _idx = d_next_sels_ar findIf {_x != d_cur_sel_tar_obj && {_x distance2D _pos < 300}};
	__TRACE_1("","_idx")
	if (_idx != -1) then {
		private _obj = d_next_sels_ar # _idx;
		if (!isNull d_cur_sel_tar_obj) then {
			d_cur_sel_tar_obj setVariable ["d_selectionsmt", (d_cur_sel_tar_obj getVariable ["d_selectionsmt", 0]) - 1, true];
			private _ma = d_cur_sel_tar_obj getVariable "d_sel_mar";
			__TRACE_1("1","_ma")
			if (!isNil "_ma") then {
				_ma setMarkerColorLocal "ColorYellow";
			};
		};
		d_cur_sel_tar_obj = _obj;
		d_cur_sel_tar_obj setVariable ["d_selectionsmt", (d_cur_sel_tar_obj getVariable ["d_selectionsmt", 0]) + 1, true];
		private _ma = d_cur_sel_tar_obj getVariable "d_sel_mar";
		__TRACE_1("2","_ma")
		if (!isNil "_ma") then {
			_ma setMarkerColorLocal "ColorBlue";
		};
	};
};
