// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

_start_key = 1;
private _fnc_inc_num = {
	_start_key = _start_key + 1;
	_start_key
};

private _v_p = vehicle player;
private _is_para = _v_p isKindOf "ParachuteBase";

d_DomUserMenu = [
	["Domination", false],
	[localize "STR_DOM_MISSIONSTRING_304", [call _fnc_inc_num], "", -5, [["expression", "0 call d_fnc_DomCommandingMenuExec"]], "1", "1"],
	["-", [0], "", -1, [["expression", ""]], "1", "1"]
];

if (d_player_can_call_arti > 0 && {d_areArtyVecsAvailable && {!_is_para}}) then {
#ifndef __TT__
	if (!visibleMap && {!d_arty_firing}) then {
#else
	if (!visibleMap && {d_player_side == opfor && {!d_arty_firing_e} || {d_player_side == blufor && {!d_arty_firing_w}}}) then {
#endif
		d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_153", [call _fnc_inc_num], "", -5, [["expression", "1 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
	};
#ifndef __TT__
	if (d_arty_firing) then {
#else
	if (d_player_side == opfor && {d_arty_firing_e} || {d_player_side == blufor && {d_arty_firing_w}}) then {
#endif
		d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1853", [call _fnc_inc_num], "", -5, [["expression", "50 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
	};
};

d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

#ifndef __IFA3__
if (!d_tt_ver) then {
	__TRACE_1("","d_taxi_aircrafts")
	//diag_log ["DOM trying to create air taxi menu entry, _is_para", _is_para, "d_taxi_aircrafts:", d_taxi_aircrafts, "d_heli_taxi_available:", d_heli_taxi_available];
	if (!visibleMap && {!_is_para && {d_taxi_aircrafts isNotEqualTo []}}) then {
		if (d_heli_taxi_available) then {
			d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_535", [call _fnc_inc_num], "", -5, [["expression", "30 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
		} else {
			if (!isNil {player getVariable "d_can_change_taxi"}) then {
				d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1934", [call _fnc_inc_num], "", -5, [["expression", "31 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
			};
		};
	};
};
#endif

__TRACE_1("","isNil 'd_drop_aircraft_avail'")
if (d_player_can_call_drop > 0 && {!visibleMap && {!_is_para && {isNil "d_drop_aircraft_avail"}}}) then {
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
	if (_clattached isEqualTo "") then {
		private _chemar = call d_fnc_haschemlight;
		__TRACE_1("","_chemar")
		if (count _chemar > 0) then {
			d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

			{
				private _strnum = call {
					if (_x == "Chemlight_green") exitWith {"15"};
					if (_x == "Chemlight_red") exitWith {"16"};
					if (_x == "Chemlight_yellow") exitWith {"17"};
					if (_x == "Chemlight_blue") exitWith {"18"};
					""
				};
				if (_strnum isNotEqualTo "") then {
					d_DomUserMenu pushBack [format [localize "STR_DOM_MISSIONSTRING_1506", getText(configFile>>"CfgMagazines">>_x>>"displayName")], [call _fnc_inc_num], "", -5, [["expression", _strnum + " call d_fnc_DomCommandingMenuExec"]], "1", "1"];
				};
			} forEach _chemar;
		};
	} else {
		if (_clattached isNotEqualTo "") then {
			d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

			d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1505", [call _fnc_inc_num], "", -5, [["expression", "20 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
		};
	};

	d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

	d_DomUserMenu pushBack [[localize "STR_DOM_MISSIONSTRING_1727", localize "STR_DOM_MISSIONSTRING_1726"] select d_earplugs_fitted, [call _fnc_inc_num], "", -5, [["expression", "40 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (d_with_ranked && {d_transf_allow == 0}) then {
	if (count d_allplayers - 1 > 0) then {
		d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];

		d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1880", [call _fnc_inc_num], "", -5, [["expression", "99 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
	};
};

if (!d_with_ranked && {d_enable_extra_cas == 1}) then {
	d_DomUserMenu pushBack ["-", [0], "", -1, [["expression", ""]], "1", "1"];
	// create uav
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1327a", [call _fnc_inc_num], "", -5, [["expression", "60 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};

if (!d_with_ranked && {d_player_can_call_arti > 0 && {d_enable_extra_cas == 1}}) then {
	// create combat uav
	d_DomUserMenu pushBack [localize "STR_DOM_MISSIONSTRING_1327b", [call _fnc_inc_num], "", -5, [["expression", "70 call d_fnc_DomCommandingMenuExec"]], "1", "1"];
};
