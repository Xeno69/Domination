// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

waitUntil {time > 0};
sleep 2;

private _mmm = markerPos "d_base_sb_ammoload";
__TRACE_1("","_mmm")

if (_mmm isNotEqualTo [0,0,0]) then {
	private _stype = [d_servicepoint_building] call BIS_fnc_simpleObjectData;
	_mmm set [2, 3.3];
	private _fac = createSimpleObject [_stype # 1, _mmm];
	_fac setDir (markerDir "d_base_sb_ammoload");
	_fac setPos _mmm;
};
if (!isNil "d_base_aa_vec" && {d_base_aa_vec isNotEqualTo ""}) then {
	[d_own_side, d_base_aa_vec, "d_base_anti_air"] call d_fnc_cgraa;
};
if (!isNil "d_base_tank_vec" && {d_base_tank_vec isNotEqualTo ""}) then {
	[d_own_side, d_base_tank_vec, "d_base_tank"] call d_fnc_cgraa;
};
if (!isNil "d_base_apc_vec" && {d_base_apc_vec isNotEqualTo ""}) then {
	[d_own_side, d_base_apc_vec, "d_base_apc"] call d_fnc_cgraa;
};