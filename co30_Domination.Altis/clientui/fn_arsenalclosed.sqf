// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenalclosed.sqf"
#include "..\x_setup.sqf"

d_arsenal_opened = false;

__TRACE_1("","d_arsenal_opened")

private _unip = uniform player;
if (_unip != "") then {
	if (getText (configFile>>"CfgWeapons">>_unip>>"ItemInfo">>"containerClass") == "Supply500") then {
		removeUniform player;
	};
};

if (d_no_mortar_ar == 1) then {
	if (backpack player isKindOf "B_Mortar_01_weapon_F" || {backpack player isKindOf "B_Mortar_01_support_F"}) then {
		removeBackpack player;
	};
};

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
	player action ["NVGoggles", player];
};