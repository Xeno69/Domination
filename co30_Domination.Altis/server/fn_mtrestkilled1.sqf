// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_obj"];

d_mt_mobile_hq_down = true;
publicVariable "d_mt_mobile_hq_down";
_obj removeAllEventHandlers "killed";
private _mt_done = _obj getVariable ["d_mt_done", false];
__TRACE_1("","_mt_done")
if (!_mt_done) then {
#ifndef __TT__
	[53] call d_fnc_DoKBMsg;
#else
	[60] call d_fnc_DoKBMsg;
#endif
};

if (!d_spe) then {
	_obj spawn {
		scriptName "spawn mtrestkilled1";
		sleep (60 + random 60);
		deleteVehicle _this;
	};
} else {
	_obj spawn {
		scriptName "spawn checkmtrestkilled1 1";
		private _epos = _this getVariable "d_v_pos";
		private _edir = getDir _this;
		private _vup = vectorUp _this;
		deleteVehicle _this;
		private _obj = createVehicle ["Land_Slum_House02_ruins_F", _epos, [], 0, "NONE"];
		_obj setDir _edir;
		_obj setPos _epos;
		_obj setVectorUp _vup;
		sleep (60 + random 60);
		deleteVehicle _obj;
	};
};

if (!_mt_done) then {
	private _killer = _this # 2;
	if (isNull _killer) then {
		if (!d_with_ace) then {
			_killer = (_this # 0) getVariable ["d_last_damager", _killer];
		} else {
			_killer = (_this # 0) getVariable ["ace_medical_lastDamageSource", _killer];
		};
	};
	if (!isNull _killer && {isPlayer [_killer]}) then {
		[_killer, 2] call d_fnc_addScore;
	};
};
