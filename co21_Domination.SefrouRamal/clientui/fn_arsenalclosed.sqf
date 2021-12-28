// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

d_arsenal_opened = false;

//__TRACE_1("","_this")

//__TRACE_1("","d_arsenal_opened")

call d_fnc_pcheck;

if (alive player) then {
	call d_fnc_save_respawngear;
	call d_fnc_save_layoutgear;
	[player, getUnitLoadout player, d_player_side] remoteExecCall ["d_fnc_storeploadout", 2];
	call d_fnc_store_rwitems;
};
if (!isNil "d_arsenal_nvg_used") then {
	d_arsenal_nvg_used = nil;
	camUseNVG false;
};
if (player getVariable ["d_currentvisionmode", 0] == 1 && {player call d_fnc_hasnvgoggles}) then {
	player action ["NVGoggles", player];
};
[player, "NoVoice"] remoteExec ["setSpeaker"];
