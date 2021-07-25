// by Xeno
#include "..\x_setup.sqf"

sleep 5;
while {true} do {
	if (!isNil "bis_fnc_drawminefields_markers" && {bis_fnc_drawMinefields_markers isNotEqualTo []}) then {
		bis_fnc_drawMinefields_active = false;
		bis_fnc_drawMinefields_refresh = false;
		{deletemarker _x} foreach bis_fnc_drawMinefields_markers;
		bis_fnc_drawMinefields_markers = [];
	};
	sleep 0.5;
};
