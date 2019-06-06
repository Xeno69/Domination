// by psycho
#define THIS_FILE "fn_medicequip.sqf"
#include "..\..\x_setup.sqf"
params ["_healer"];

if (!local _healer || {_healer distance2D d_FLAG_BASE < 30}) exitWith {};

private _objs = [];

if (_healer getUnitTrait "medic") then {
	private _defi_pos = _healer modelToWorld [-0.5, 0.2, 0];
	private _defi = createSimpleObject ["Land_Defibrillator_F", _defi_pos];
	_defi setDir (getDir _healer - 180);
	private _position = getPosWorld _defi;
	_defi setPosATL [_position # 0, _position # 1, 0.01];
	_defi setVectorUp (surfaceNormal _position);
	_objs pushBack _defi;
	
	if (random 2 >= 1) then {
		private _bb_pos = _healer modelToWorld [0.4,(0.2 - (random 0.5)),0];
		private _bb = createSimpleObject ["Land_BloodBag_F", _bb_pos];
		_bb setDir (random 359);
		private _position = getPosWorld _bb;
		_bb setPosATL [_position # 0, _position # 1, 0.01];
		_bb setVectorUp (surfaceNormal _position);
		_objs pushBack _bb;
	};
};

for "_i" from 1 to (1 + (round random 3)) do {
	private _band_pos = _healer modelToWorld [random 1.3, 0.8 + (random 0.6), 0];
	private _band = createSimpleObject ["Land_Bandage_F", _band_pos];
	_band setDir (random 359);
	private _position = getPosWorld _band;
	_band setPosATL [_position # 0, _position # 1, 0.01];
	_band setVectorUp (surfaceNormal _position);
	_objs pushBack _band;
};
if (random 2 >= 1) then {
	private _ab_pos = _healer modelToWorld [-0.8, 0.6 - (random 0.4), 0];
	private _ab = createSimpleObject ["Land_Antibiotic_F", _ab_pos];
	_ab setDir (random 359);
	private _position = getPosWorld _ab;
	_ab setPosATL [_position # 0, _position # 1, 0.01];
	_ab setVectorUp (surfaceNormal _position);
	_objs pushBack _ab;
};

_objs remoteExecCall ["d_fnc_addfifo", 2];
