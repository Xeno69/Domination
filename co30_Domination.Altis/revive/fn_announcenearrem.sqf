// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

__TRACE_1("","_this")

private _idx = xr_announce_unit_ar find _this;

if (_idx != -1) then {
	xr_announce_ar deleteAt _idx;
	xr_announce_unit_ar deleteAt _idx;
	if (xr_announce_ar isNotEqualTo []) then {
		private _hintar = [];
		{
			_hintar pushBack (_x # 1);
		} forEach xr_announce_ar;

		hintSilent parseText ("<t color='#FFFFFF' size='1'>" + (_hintar joinString "<br/>"));
	} else {
		hintSilent "";
	};
};
