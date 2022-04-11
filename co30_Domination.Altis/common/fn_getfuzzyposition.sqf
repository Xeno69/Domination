//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// get a fuzzy position - take a position and return a slightly different position with randomized X and Y axis
// useful when a building pos is already occupied but you want to place a unit anyway (but currently no collision check)
// todo - check for collision with units, determine if inside a building and move random position toward the bldg center

params ["_pos"];
private _fuzzy_pos = [((_pos # 0) + (random 1.25 max 0.5)), ((_pos # 1) + (random 1.25 max 0.5)), _pos # 2];
_fuzzy_pos