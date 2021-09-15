// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE("Eachframerun")

{
	if (diag_frameno >= (_x # 2)) then {
		call (_x # 0);
		_x set [2, diag_frameno + (_x # 1)];
		//__TRACE_1("2","_x")
	};
} forEach (values d_ef_hash);
