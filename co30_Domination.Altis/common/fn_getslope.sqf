//#define __DEBUG__
//#include "..\x_setup.sqf"

// from warfare
// Returns an average slope value of terrain within passed radius.
// a little bit modified. no need to create a "global" logic, local is enough, etc
// parameters: position, radius
// example: _slope = [the_pos, the_radius] call d_fnc_GetSlope;

params ["_pos",["_dist",5]];

private _slope = 0;
private _height = (ATLToASL _pos) # 2;
_slope = _slope + abs(((ATLToASL [(_pos # 0) - _dist, _pos # 1, 0]) # 2) - _height);
_slope = _slope + abs(((ATLToASL [(_pos # 0) + _dist, _pos # 1, 0]) # 2) - _height);
_slope = _slope + abs(((ATLToASL [_pos # 0, (_pos # 1) - _dist, 0]) # 2) - _height);
_slope = _slope + abs(((ATLToASL [_pos # 0, (_pos # 1) + _dist, 0]) # 2) - _height);
_slope = _slope / 8;
//__TRACE_1("","_slope")
_slope
