// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_addfifo.sqf"
#include "..\x_setup.sqf"

if (_this isEqualType []) then {
	d_fifo_ar append _this;
} else {
	d_fifo_ar pushBack _this;
};

if (count d_fifo_ar > 20) then {
	d_fifo_counter = d_fifo_counter + 1;
	
	if (d_fifo_counter >= 5) then {
		private _num = count d_fifo_ar - 20;
		for "_i" from 0 to (_num - 1) do {
			deleteVehicle (d_fifo_ar # _i);
		};
		d_fifo_ar deleteRange [0, _num];
		d_fifo_counter = 0;
	};
};