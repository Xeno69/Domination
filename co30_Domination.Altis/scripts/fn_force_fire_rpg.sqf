scriptName "force ai fire rpg";
params ["_u", "_target"];
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
private _secondary_weapon = secondaryWeapon _u;
// remove primary weapon, handgun weapon and grenades, restore later
_u removeMagazines "MiniGrenade";
_u removeWeaponGlobal _prim_weapon;
_u removeWeaponGlobal handgunWeapon _u;
_u removeMagazines (_prim_weapon_ammo_mag_arr select 0);
// create a hidden vehicle and targetsoldier
private _tmpveh = "B_Quadbike_01_F" createVehicle [0,0,0];
_tmpveh enableSimulation false;
_tmpveh hideObjectGlobal true;
_tmpveh setVehiclePosition [(getPosATL _target), [], 0, "CAN_COLLIDE"];
private _tmptgtsoldier = "B_TargetSoldier" createVehicle (getPosATL _target);
_tmptgtsoldier enableSimulation false;
_tmptgtsoldier hideObjectGlobal true;
_tmptgtsoldier moveInDriver _tmpveh;
_u doWatch _tmpveh;
_u doTarget _tmpveh;
_u selectWeapon _secondary_weapon;
_u doSuppressiveFire _tmpveh;
sleep 8;
deleteVehicle [_tmpveh, _tmptgtsoldier];
d_units_shooting_rpg deleteAt (d_units_shooting_rpg find _u);
publicVariable "d_units_shooting_rpg";
if (secondaryWeaponMagazine _u isNotEqualTo []) then {
	// the RPG was not fired, do not attempt to force fire again (set a variable)
	_u setVariable ["d_do_not_force_fire_rpg", true];
};
reload _u;
_u doWatch objNull;
_u doTarget objNull;
// restore the primary weapon and primary weapon magazines removed earlier, ignore handgun and grenades for now
_u addMagazines [(_prim_weapon_ammo_mag_arr select 0), 5];
_u addWeaponGlobal _prim_weapon;
_u selectWeapon _prim_weapon;
sleep 4;
_u setAmmo [_prim_weapon, 999];