// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

private _pr = _this # 6;

__TRACE_1("","_pr")

while {alive _pr} do {
	__TRACE_1("","alive _pr")
	if (d_sm_mt_protection == 1 || {d_sm_mt_protection == 3}) then {
		__TRACE("In 1 or 3")
		if (d_cur_sm_idx != -1 && {!isNil "d_x_sm_pos"}) then {
			__TRACE_1("","d_x_sm_pos")
			if (_pr distance2D (d_x_sm_pos # 0) < 1000) then {
				__TRACE_1("deleting projectile","")
				deleteVehicle _pr;
				private _last = (_this # 7) getVariable ["d_last_anti_cas_msg", -1];
				if (time - _last > 5) then {
					(_this # 7) setVariable ["d_last_anti_cas_msg", time];
					(_this # 7) vehicleChat (localize "STR_DOM_MISSIONSTRING_2104");
				};
			};
		};
	};
	if (alive _pr) then {
		if (d_sm_mt_protection == 2 || {d_sm_mt_protection == 3}) then {
			__TRACE("In 2 or 3")
			if (d_cur_tgt_pos isNotEqualTo []) then {
				__TRACE("cur target pos ok")
				if (_pr distance2D d_cur_tgt_pos < 1000) then {
					__TRACE("dist below 1000")
					deleteVehicle _pr;
					private _last = (_this # 7) getVariable ["d_last_anti_cas_msg", -1];
					if (time - _last > 5) then {
						(_this # 7) setVariable ["d_last_anti_cas_msg", time];
						(_this # 7) vehicleChat (localize "STR_DOM_MISSIONSTRING_2105");
					};
				};
			};
		};
	};
	sleep 0.2;
};

__TRACE("End")
