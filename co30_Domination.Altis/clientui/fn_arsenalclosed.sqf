// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

d_arsenal_opened = false;

__TRACE_1("","_this")

//__TRACE_1("","d_arsenal_opened")

if (alive player && {!(player getVariable ["xr_pluncon", false])}) then {
	player switchMove (player getVariable "d_arsenal_animstate");
};

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
	player actionNow ["NVGoggles", player];
};
[player, "NoVoice"] remoteExec ["setSpeaker"];

if (d_va_percentage == 0) then {
	if (!isNil "d_arsenalbox_cur_o" && {d_arsenalbox_cur_o getVariable ["d_player_ammobox", false]}) then {
		private _perc = d_arsenalbox_cur_o getVariable "d_abox_perc";
		if (!isNil "_perc") then {
			__TRACE("Calling sub box")
			if (_perc > 0 && {d_cur_pl_gear_xx isNotEqualTo (getUnitLoadout player)}) then {
				d_arsenalbox_cur_o remoteExecCall ["d_fnc_sub_box", 2];
			};
		};
		d_cur_pl_gear_xx = nil;
		d_arsenalbox_cur_o = nil;
	};
};
