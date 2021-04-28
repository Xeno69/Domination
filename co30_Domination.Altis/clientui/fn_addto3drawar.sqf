// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (isNil "d_3draw_ar") then {
	d_3draw_ar = [];
};

params ["_obj"];

_obj setVariable ["d_tex", ["a3\ui_f\data\IGUI\Cfg\Actions\arrow_up_gs.paa", "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa", "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa"] # (_this # 3)];

d_3draw_ar pushBack _this;
