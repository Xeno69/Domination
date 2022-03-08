// by Xeno
#include "..\x_setup.sqf"

if (d_air_v_dam < 0.6 && {_this # 7 in ["hitengine", "hitengine1", "hitengine2", "hitengine3", "hitengine4", "hithrotor", "hitrotor", "hitvrotor"]}) then {
	if (_this # 2 >= 0.6) then {
		d_air_v_dam = _this # 2;
	};
};
