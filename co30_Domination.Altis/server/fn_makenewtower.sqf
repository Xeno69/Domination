// by Xeno
//#define __DEBUG__
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
_vec setVariable ["d_utower", _utower];

_utower addEventhandler ["Killed", {call d_fnc_utowerkilled}];
_utower setVariable ["d_delete_id", _utower addEventHandler ["Deleted", {call d_fnc_utowerkilled}]];

d_mtmissionobjs pushBack _vec;
d_mtmissionobjs pushBack _utower;

if (!d_preemptive_special_event) then {
	private _unitstog = [
		getPos _utower,
		3,		//unit count
		5,		//fillRadius
		true,	//fillRoof
		true,	//fillEvenly
		true,	//fillTopDown
		false,	//disableTeleport
		0		//unitMovementMode
	] call d_fnc_garrisonUnits;
	if (!isNil "_unitstog" && {_unitstog isNotEqualTo []}) then {
		d_delinfsm append _unitstog;
	};
	
	_unitstog = [
		getPos _utower,
		5,		//unit count
		5,		//fillRadius
		false,	//fillRoof
		false,	//fillEvenly
		false,	//fillTopDown
		false,	//disableTeleport
		0		//unitMovementMode
	] call d_fnc_garrisonUnits;
	if (!isNil "_unitstog" && {_unitstog isNotEqualTo []}) then {
		d_delinfsm append _unitstog;
	};
};

_vec
