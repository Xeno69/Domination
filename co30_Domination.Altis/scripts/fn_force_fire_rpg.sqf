scriptName "force ai fire rpg";
params ["_u", "_target"];

// in Arma 3, it isn't possible to reliably force a unit to fire a secondaryWeapon (RPG)
// instead a) force the unit to use the weapon and point it at the target
// and then b) use d_fnc_moduleCAS_guidedmissile to create the missile in flight
// note the greater randomPos deviation when further away from the target, just a messy first attempt and probably needs to be tuned

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
sleep 1.75;
_u reveal _target;
_u doWatch _target;
_u doTarget _target;
sleep 1.25;

// calculate the ballistic drop of the projectile so we can adjust the elevation (Z-axis)
// distance d, initial velocity v, gravity g (9.8), height h
// d = v * sqrt(2h/g)
// h = (d/v)^2 * 9.8 / 2
private _projectileVelocity = 300; // in meters
private _elevationAdjustmentBeforeTargetError = ((_target distance _u) / _projectileVelocity) ^ 2 * (9.8 / 2);

// target position should not be exact or the RPG will always perfectly hit the unit
// calculate an error rate to apply later
private _targetErrorBase = 2; // in meters
_targetError = (_target distance _u) / 100 + _targetErrorBase;

// apply the error rate and z elevation
private _targetposx = ((getPosWorld _target) select 0) + random [(-1 * _targetError), 0, _targetError];
private _targetposy = ((getPosWorld _target) select 1) + random [(-1 * _targetError), 0, _targetError];
private _targetposz = ((getPosWorld _target) select 2) + random [(-1 * _targetError), 0, _targetError] + _elevationAdjustmentBeforeTargetError; // add z elevation to compensate for gravity
private _targetpos = [_targetposx, _targetposy, _targetposz];

private _missile_start_pos_hand = _u modelToWorld (_u selectionPosition "RightHandMiddle1");
private _vect = (getPos _u) vectorFromTo (getPos _target) vectorMultiply 3; // 3x1m forward so AI won't shoot into walls
private _missile_start_pos = _missile_start_pos_hand vectorAdd _vect;

// fire the missile, use a basic RPG round to keep this simple TODO: figure out how to use classname (RPG32_F) to get ammo name (R_PG32V_F) 
[_targetpos, _missile_start_pos, "R_PG32V_F", 0, _u, _projectileVelocity, 10, true] call d_fnc_moduleCAS_guidedmissile;

// restore the primary weapon and primary weapon magazines removed earlier, ignore handgun and grenades for now
_u addMagazines [(_prim_weapon_ammo_mag_arr select 0), 5];
_u addWeaponGlobal _prim_weapon;
_u setAmmo [_prim_weapon, 999];
_u selectWeapon primaryWeapon _u;
_u setVariable ["d_is_force_shooting", false, true];
