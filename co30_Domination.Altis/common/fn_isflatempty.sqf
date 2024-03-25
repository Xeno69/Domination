// from Killzone_Kid https://community.bistudio.com/wiki/isFlatEmpty
// check if position is flat and empty

// deprecated, does not work very well -Longtime

params ["_pos", "_params"];
_pos = _pos findEmptyPosition [0, _params select 0];
if (_pos isEqualTo []) exitWith {
	[]
};
_params = +_params;
_params set [0, -1];
_pos = _pos isFlatEmpty _params;
if (_pos isEqualTo []) exitWith {
	[]
};
_pos