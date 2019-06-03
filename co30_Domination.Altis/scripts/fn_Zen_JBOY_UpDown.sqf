// Infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/

// Teleports the units to random windows of the building(s) within the distance
// Faces units in the right direction and orders them to stand up or crouch on a roof
// Units will only fill the building to as many positions as there are windows
// Multiple buildings can be filled either evenly or to the limit of each sequentially
// Usage : Call, execVM
// Params: 1. Array, the building(s) nearest this position is used
//         2. Array of objects, the units that will garrison the building(s)
//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
// Return: Array of objects, the units that were not garrisoned

//Zen_JBOY_UpDown

if !(call d_fnc_checkSHC) exitWith {};
params ["_dude", "_stances"];
_dude removeEventHandler ["FiredNear", _dude getVariable "zen_fn_idx"];
while {alive _dude} do {
	if (unitPos _dude == _stances select 0) then {
		_dude setUnitPos (_stances select 1);
	} else {
		_dude setUnitPos (_stances select 0);
	};
	sleep (1 + (random 7));
};