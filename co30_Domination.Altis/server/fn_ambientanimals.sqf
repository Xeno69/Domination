#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!isServer || {diag_fps < 15}) exitWith {
	__TRACE("Exit")
};

params ["_cur_tgt_pos", "_cur_tgt_radius"];

private _bestPlacesMeadow = selectBestPlaces [_cur_tgt_pos, _cur_tgt_radius, "meadow - houses", 30, 15];
__TRACE_1("","_bestPlacesMeadow")

if (isNil "d_cur_tgt_animals_units") then {
	d_cur_tgt_animals_units = [];
};

__TRACE_1("1","count _bestPlacesMeadow")
if (_bestPlacesMeadow isEqualTo [] || {count _bestPlacesMeadow < 5}) exitWith {};

private _animalClasses = ["Goat_random_F", "Sheep_random_F", "Hen_random_F", "Cock_random_F", "Alsatian_Random_F", "Fin_random_F", "Snake_random_F"];

for "_i" from 0 to 5 do {
    private _idx = _bestPlacesMeadow call d_fnc_randomfloorarray;
	private _spawnPos = _bestPlacesMeadow # _idx # 0;
	_bestPlacesMeadow deleteAt _idx;
	__TRACE_1("","_spawnPos")
	private _thisClass = selectRandom _animalClasses;
	private _numAnimals = selectRandom [1, 2, 3];
	if (_thisClass in ["Alsatian_Random_F","Fin_random_F","Snake_random_F"]) then {_numAnimals = 1};
	__TRACE_2("","_numAnimals","_thisClass")
	
	for "_i" from 1 to _numAnimals step 1 do {	
		private _thisAnimal = createAgent [_thisClass, _spawnPos, [], 0, "NONE"];
		[_thisAnimal] call bis_fnc_animalBehaviour;
		private _dir = random 360;
		_thisAnimal setFormDir _dir;
		_thisAnimal setDir _dir;	
		d_cur_tgt_animals_units pushBack _thisAnimal;
		_thisAnimal addEventHandler ["killed", {call d_fnc_killedanimal}];
	};
#ifdef __DEBUG__
	[str _spawnPos, _spawnPos, "ICON", "ColorBlack", [0.6, 0.6], "Animal", 0, "mil_dot"] call d_fnc_createmarkerlocal;
#endif	
};
