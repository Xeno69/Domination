// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _stype = [d_servicepoint_building] call BIS_fnc_simpleObjectData;

if ((d_service_buildings # 0) isNotEqualTo []) then {
	private _pos = (d_service_buildings # 0) # 0;
	_pos set [2, 3.3];
	private _fac = createSimpleObject [_stype # 1, _pos];
	_fac setDir ((d_service_buildings # 0) # 1);
	_fac setPos _pos;
};

if ((d_service_buildings # 1) isNotEqualTo []) then {
	private _pos = (d_service_buildings # 1) # 0;
	_pos set [2, 3.3];
	private _fac = createSimpleObject [_stype # 1, _pos];
	_fac setDir ((d_service_buildings # 1) # 1);
	_fac setPos _pos;
};

if ((d_service_buildings # 2) isNotEqualTo []) then {
	private _pos = (d_service_buildings # 2) # 0;
	_pos set [2, 3.3];
	private _fac = createSimpleObject [_stype # 1, _pos];
	_fac setDir ((d_service_buildings # 2) # 1);
	_fac setPos _pos;
};
