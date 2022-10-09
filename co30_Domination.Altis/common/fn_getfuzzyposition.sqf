//by Longtime
//#define __DEBUG__
//#include "..\x_setup.sqf"

// get a fuzzy position - take a position and return a slightly different position with randomized X and Y axis
// useful when a building pos is already occupied but you want to place a unit anyway (but currently no collision check)
// todo - check for collision with units, determine if inside a building and move random position toward the bldg center

#define EYE_HEIGHT 1.53

params ["_pos", ["_radius", 1]];
private _fuzzy_pos = [((_pos # 0) + (random _radius) - 0.5*_radius), ((_pos # 1) + (random _radius) - 0.5*_radius), (_pos # 2) - EYE_HEIGHT];
_fuzzy_pos