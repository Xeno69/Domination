// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenalclosed.sqf"
#include "..\..\..\x_setup.sqf"

call d_fnc_save_respawngear;
call d_fnc_save_layoutgear;
[player, getUnitLoadout player, d_player_side] remoteExecCall ["d_fnc_storeploadout", 2];
if (!isNil "d_arsenal_nvg_used") then {
	d_arsenal_nvg_used = nil;
	camUseNVG false;
};
if (d_with_ranked) then {
	call d_fnc_store_rwitems;
};
if (player getVariable ["d_currentvisionmode", 0] == 1 && {player call d_fnc_hasnvgoggles}) then {
	player action ["NVGoggles",player];
};