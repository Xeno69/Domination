// by Xeno
#include "..\x_setup.sqf"

private _nearTrees = nearestTerrainObjects [d_x_sm_pos # 0, ["TREE", "SMALL TREE"], 25, false, true];

if (_nearTrees isNotEqualTo []) then {
	{
		if (damage _x >= 0.9) then {
			_x hideObjectGlobal true;
		};
	} forEach _nearTrees;
};