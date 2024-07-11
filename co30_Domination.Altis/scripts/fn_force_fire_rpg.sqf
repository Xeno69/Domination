scriptName "force ai fire rpg";
params ["_u", "_target"];

// in Arma 3, it isn't possible to reliably force a unit to fire a secondaryWeapon (RPG)
// instead a) force the unit to use the weapon and point it at the target
// and then b) use d_fnc_moduleCAS_guidedmissile to create the missile in flight
// note the greater randomPos deviation when further away from the target, just a messy first attempt and probably needs to be tuned

_u setVariable ["d_is_force_shooting", true, true];
_u setVariable ["d_force_fire_rpg_last_attempt_ts", time];

// keep weapon and magazine vars so we can remove and later restore
private _prim_weapon = _u getVariable ["d_prim_weapon", ""];
if (_prim_weapon isEqualTo "") then {
	_prim_weapon = primaryWeapon _u;
	_u setVariable ["d_prim_weapon", _prim_weapon];
};
private _prim_weapon_ammo_mag_arr = _u getVariable ["d_prim_weapon_ammo_mag_arr", []];
if (_prim_weapon_ammo_mag_arr isEqualTo []) then {
	_prim_weapon_ammo_mag_arr = primaryWeaponMagazine _u;
	_u setVariable ["d_prim_weapon_ammo_mag_arr", _prim_weapon_ammo_mag_arr];
};
// remove primary weapon, handgun weapon and grenades, restore later
_u removeMagazines "MiniGrenade";
_u removeWeaponGlobal _prim_weapon;
_u removeWeaponGlobal handgunWeapon _u;
_u removeMagazines (_prim_weapon_ammo_mag_arr select 0);
if (unitPos _u == "DOWN") then {
	_u setUnitPos "MIDDLE";
};
_u selectWeapon secondaryWeapon _u;
_u reveal _target;
_u doWatch _target;
_u doTarget _target;
sleep 3;

private _targeterror = 1.5; // in meters
if (_target distance2D _u > 100) then {
	_targeterror = 2;
};
if (_target distance2D _u > 250) then {
	_targeterror = 2.5;
};
if (_target distance2D _u > 400) then {
	_targeterror = 3;
};
if (_target distance2D _u > 550) then {
	_targeterror = 3.5;
};
private _targetpos = [[[getPosWorld _target, _targeterror]],[]] call BIS_fnc_randomPos;

private _missile_start_pos_hand = _u modelToWorld (_u selectionPosition "RightHandMiddle1");
private _vect = (getPos _u) vectorFromTo (getPos _target) vectorMultiply 2;
private _missile_start_pos = _missile_start_pos_hand vectorAdd _vect;

// fire the missile, use a basic RPG round to keep this simple TODO: figure out how to use classname (RPG32_F) to get ammo name (R_PG32V_F) 
[_targetpos, _missile_start_pos, "R_PG32V_F", 0, _u, 300, 10] call d_fnc_moduleCAS_guidedmissile;

// restore the primary weapon and primary weapon magazines removed earlier, ignore handgun and grenades for now
_u addMagazines [(_prim_weapon_ammo_mag_arr select 0), 5];
_u addWeaponGlobal _prim_weapon;
_u setAmmo [_prim_weapon, 999];
_u selectWeapon primaryWeapon _u;
_u setVariable ["d_is_force_shooting", false, true];
