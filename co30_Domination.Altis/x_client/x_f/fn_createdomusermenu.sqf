//#define __DEBUG__
// by Xeno
#define THIS_FILE "fn_createdomusermenu.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

_start_key = 1;
private _fnc_inc_num = {
	_start_key = _start_key + 1;
	_start_key
};

private _v_p = vehicle player;
private _is_para = (_v_p isKindOf "BIS_Steerable_Parachute") || {_v_p isKindOf "ParachuteBase"};

d_DomUserMenu = [
	["Domination", false],
	[localize "STR_DOM_MISSIONSTRING_304", [call _fnc_inc_num], "", -5, [["expression", "0 call d_fnc_DomCommandingMenuExec"]], "1", "1"],
	["-", [0], "", -1, [["expression", ""]], "1", "1"]
];

if (d_player_can_call_arti > 0 && {d_areArtyVecsAvailable && {!_is_para}}) then {
#ifndef __TT__
	if (!visibleMap && {!d_arty_firing}) then {
#else
	if (!visibleMap && {d_player_side == opfor && {!d_arty_firing_e || {d_player_side == blufor && {!d_arty_firing_w}}}}) then {
#endif
		d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_153", [call _fnc_inc_num], "", -5, [["expression", "1 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
	};
#ifndef __TT__
	if (d_arty_firing) then {
#else
	if (d_player_side == opfor && {d_arty_firing_e || {d_player_side == blufor && {d_arty_firing_w}}}) then {
#endif
		d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1853", [call _fnc_inc_num], "", -5, [["expression", "50 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
	};
};

d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

#ifndef __IFA3LITE__
if (!d_tt_ver && {!visibleMap && {!_is_para}}) then {
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_535", [call _fnc_inc_num], "", -5, [["expression", "30 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};
#endif

if (d_player_can_call_drop > 0 && {!visibleMap && {!_is_para}}) then {
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_230", [call _fnc_inc_num], "", -5, [["expression", "2 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (player getUnitTrait "Medic" && {isNull objectParent player && {(player getVariable "d_medtent") isEqualTo []}}) then {
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_305", [call _fnc_inc_num], "", -5, [["expression", "5 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (player getUnitTrait "engineer" && {isNull objectParent player && {(player getVariable "d_farp_pos") isEqualTo []}}) then {
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_307", [call _fnc_inc_num], "", -5, [["expression", "6 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (d_pisadminp && {!visibleMap}) then {
	d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];
	
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1420", [call _fnc_inc_num], "", -5, [["expression", "7 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (!d_with_ace) then {
	private _clattached = player getVariable ["d_p_clattached", ""];
	__TRACE_1("","_clattached")
	if (_clattached == "") then {
		private _chemar = call d_fnc_haschemlight;
		__TRACE_1("","_chemar")
		if (count _chemar > 0) then {
			d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];
			
			{
				private _strnum = switch (_x) do {
					case "Chemlight_green": {"15"};
					case "Chemlight_red": {"16"};
					case "Chemlight_yellow": {"17"};
					case "Chemlight_blue": {"18"};
					default {""};
				};
				if (_strnum != "") then {
					d_DomUserMenu pushBack [format [localize "STR_DOM_MISSIONSTRING_1506", getText(configFile>>"CfgMagazines">>_x>>"displayName")], [call _fnc_inc_num], "", -5, [["expression", _strnum + " call d_fnc_DomCommandingMenuExec"]], "1", "1"];
				};
			} forEach _chemar;
		};
	} else {
		if (_clattached != "") then {
			d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];
			
			d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1505", [call _fnc_inc_num], "", -5, [["expression", "20 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
		};
	};

	d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

	d_DomUserMenu pushBack [[localize "STR_DOM_MISSIONSTRING_1727", localize "STR_DOM_MISSIONSTRING_1726"] select d_earplugs_fitted, [call _fnc_inc_num], "", -5, [["expression", "40 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};
