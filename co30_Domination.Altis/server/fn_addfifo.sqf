// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addfifo.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (_this isEqualType []) then {
	d_fifo_ar append _this;
} else {
	d_fifo_ar pushBack _this;
};

if (count d_fifo_ar > 30) then {
	__TRACE_1("","_this")
	
	private _num = count d_fifo_ar - 20;
	for "_i" from 0 to (_num - 1) do {
		deleteVehicle (d_fifo_ar # _i);
	};
	d_fifo_ar deleteRange [0, _num];
};