// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_makenewtower.sqf"
#include "..\x_setup.sqf"

private _utower = createVehicle ["Land_Cargo_Tower_V3_F", _this, [], 0, "NONE"];
_utower setVectorUp [0, 0, 1];
_utower allowDamage false;
_utower addEventHandler ["HandleDamage", {0}];
_utower setDamage 0;

private _toppos = (getPosASL _utower) vectorAdd [-0.2, 1.3, 20.24];

private _vec = createVehicle [d_illum_tower, _this, [], 0, "CAN_COLLIDE"];
_vec setVectorUp (vectorUp _utower);
_vec setPosASL _toppos;

_utower setVariable ["d_tower", _vec];

_utower addEventhandler ["Killed", {
	private _tower = (_this # 0) getVariable "d_tower";
	if (!isNil "_tower" && {!isNull _tower}) then {
		_tower setVariable ["d_faster", true];
		_tower setDamage 1;
	} else {
		if (!isNull _tower) then {
			d_mt_spotted = false;
			d_mt_radio_down = true;
			if (d_ao_markers == 1) then {
				deleteMarker "d_m_t_rt";
			};
			[37] call d_fnc_DoKBMsg;
			deleteVehicle _tower;
		};
	};
}];

d_mtmissionobjs pushBack _vec;
d_mtmissionobjs pushBack _utower;

[
	getPos _utower,
	5,		//unit count
	_utower,		//fillRadius
	true,	//fillRoof
	false,	//fillEvenly
	true,	//fillTopDown
	false,	//disableTeleport
	0		//unitMovementMode
] call d_fnc_garrisonUnits;
 
_vec
