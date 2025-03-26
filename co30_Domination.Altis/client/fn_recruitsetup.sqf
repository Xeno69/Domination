// by Xeno
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

player reveal d_AI_HUT;

d_AI_HUT addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_314"], {call d_fnc_recruitaiaction}, -1, 1.5, true, true, "", "true", 10];

if (!isNil "d_additional_recruit_buildings") then {
	{
		["d_RecruitB_" + str _forEachIndex, _x, "ICON", "ColorYellow", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_313", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;

		_x addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_314"], {call d_fnc_recruitaiaction}, -1, 1.5, true, true, "", "true", 10];
		player reveal _x;
	} forEach (d_additional_recruit_buildings select {!isNil "_x" && {!isNull _x}});
};

d_current_ai_num = 0;
d_current_ai_units = [];

if (isNil "d_UnitsToRecruit") then {
#ifdef __ALTIS__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B"};
		case opfor: {"O"};
		case independent: {"I"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
#ifdef __STRATIS__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B"};
		case opfor: {"O"};
		case independent: {"I"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
#ifdef __MALDEN__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B"};
		case opfor: {"O"};
		case independent: {"I"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
#ifdef __TANOA__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B_T"};
		case opfor: {"O_T"};
		case independent: {"I_T"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
#ifdef __CUP_CHERNARUS__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["CUP_B_USMC_Soldier", "CUP_B_USMC_Soldier_AR", "CUP_B_FR_Soldier_Exp", "CUP_B_USMC_Soldier_GL", "CUP_B_USMC_Soldier_MG", "CUP_B_USMC_Medic", "CUP_B_USMC_Engineer", "CUP_B_USMC_Soldier_AT"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __CUP_CHERNARUS2020__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["CUP_B_USMC_Soldier", "CUP_B_USMC_Soldier_AR", "CUP_B_FR_Soldier_Exp", "CUP_B_USMC_Soldier_GL", "CUP_B_USMC_Soldier_MG", "CUP_B_USMC_Medic", "CUP_B_USMC_Engineer", "CUP_B_USMC_Soldier_AT"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __CUP_TAKISTAN__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["CUP_B_US_Soldier", "CUP_B_US_Soldier_AR", "CUP_B_US_Soldier_Engineer_EOD", "CUP_B_US_Soldier_GL", "CUP_B_US_Soldier_MG", "CUP_B_US_Medic", "CUP_B_US_Engineer", "CUP_B_US_Soldier_AT"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __CUP_SARA__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["CUP_B_US_Soldier", "CUP_B_US_Soldier_AR", "CUP_B_US_Soldier_Engineer_EOD", "CUP_B_US_Soldier_GL", "CUP_B_US_Soldier_MG", "CUP_B_US_Medic", "CUP_B_US_Engineer", "CUP_B_US_Soldier_AT"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __IFA3__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {[]};
		case opfor: {["LIB_SOV_rifleman", "LIB_SOV_sapper", "LIB_SOV_medic", "LIB_SOV_mgunner", "LIB_SOV_AT_soldier", "LIB_US_rifleman", "LIB_US_engineer", "LIB_US_medic", "LIB_US_mgunner", "LIB_US_AT_soldier"]};
		case independent: {[]};
	};
#endif
#ifdef __RHS__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["rhsusf_army_ucp_rifleman", "rhsusf_army_ucp_sniper", "rhsusf_army_ucp_medic", "rhsusf_army_ucp_machinegunner", "rhsusf_army_ucp_maaws", "rhsusf_army_ucp_grenadier", "rhsusf_army_ucp_aa", "rhsusf_army_ucp_javelin"]};
		case opfor: {["rhs_vdv_des_rifleman", "rhs_vdv_des_marksman", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_at", "rhs_vdv_des_grenadier_rpg", "rhs_vdv_des_engineer", "rhs_vdv_des_aa", "rhs_vdv_des_grenadier", "rhs_vdv_des_RShG2"]};
		case independent: {[]};
	};
#endif
#ifdef __GMCWG__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {
			call {
				if (d_gmcwgwinter) exitWith {
					["gm_ge_army_rifleman_g3a3_parka_80_win", "gm_ge_army_grenadier_g3a3_parka_80_win", "gm_ge_army_demolition_g3a4_parka_80_win", "gm_ge_army_machinegunner_mg3_parka_80_win", "gm_ge_army_antitank_g3a3_pzf44_parka_80_win", "gm_ge_army_antitank_g3a3_pzf84_parka_80_win", "gm_ge_army_engineer_g3a4_parka_80_win", "gm_ge_army_medic_g3a3_parka_80_win"]
				};
				["gm_ge_army_rifleman_g3a3_80_ols", "gm_ge_army_grenadier_g3a3_80_ols", "gm_ge_army_demolition_g3a4_80_ols", "gm_ge_army_machinegunner_mg3_80_ols", "gm_ge_army_antitank_g3a3_pzf44_80_ols", "gm_ge_army_antitank_g3a3_pzf84_80_ols", "gm_ge_army_engineer_g3a4_80_ols", "gm_ge_army_medic_g3a3_80_ols"]
			};
		};
	};
#endif
#ifdef __LIVONIA__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B_W"};
		case opfor: {"O_T"};
		case independent: {"I_T"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_Exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
#ifdef __UNSUNG__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["uns_men_US_11ACR_RIFLEMAN", "uns_men_US_11ACR_GL", "uns_men_US_11ACR_AT", "uns_men_US_11ACR_HMG", "uns_men_US_11ACR_MED", "uns_men_US_11ACR_ENG", "uns_men_US_6SFG_MRK2"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __CSLA__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {[]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __VN__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["vn_b_men_army_15", "vn_b_men_army_07", "vn_b_men_army_12", "vn_b_men_army_06", "vn_b_men_army_03", "vn_b_men_army_04", "vn_b_men_army_05", "vn_b_men_army_10"]};
		case opfor: {[]};
		case independent: {[]};
	};
#endif
#ifdef __CSLA__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {[]};
		case opfor: {["CSLA_mrRPG75", "CSLA_mrVG70", "CSLA_mrRPG7", "CSLA_mr9P135M", "CSLA_mrMedi", "CSLA_mrUK59", "CSLA_mrOP63", "CSLA_engSapper"]};
		case independent: {[]};
	};
#endif
#ifdef __WS__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B_D"};
		case opfor: {"O"};
		case independent: {"I"};
	};
	d_UnitsToRecruit = ["_Soldier_lxWS", "_soldier_AR_lxWS", "_soldier_exp_lxWS", "_Soldier_GL_lxWS", "_soldier_M_lxWS", "_medic_lxWS", "_soldier_repair_lxWS", "_soldier_LAT_lxWS"] apply {_pchar + _x};
#endif
#ifdef __SPE__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["SPE_GER_rifleman_2", "SPE_GER_sapper", "SPE_GER_hmgunner", "SPE_GER_medic", "SPE_GER_Flamethrower_Operator", "SPE_GER_LAT_Rifleman", "SPE_GER_ober_grenadier"]};
		case opfor: {[]};
		case independent: {["SPE_US_Rifleman", "SPE_US_AT_Soldier", "SPE_US_Engineer", "SPE_US_Grenadier", "SPE_US_Flamethrower_Operator", "SPE_US_Medic", "SPE_US_HMGunner"]};
	};
#endif
#ifdef __JSDF__
	d_UnitsToRecruit = switch (d_player_side) do {
		case blufor: {["Sparky_JSDF_Overhaul_Soldier_JGSDF", "Sparky_JSDF_Overhaul_Marksman_JGSDF", "Sparky_JSDF_Overhaul_Minimi_JGSDF", "Sparky_JSDF_Overhaul_GL_JGSDF", "Sparky_JSDF_Overhaul_Medic_JGSDF", "Sparky_JSDF_Overhaul_LAT_JGSDF", "Sparky_JSDF_Overhaul_AT_JGSDF", "Sparky_JSDF_Overhaul_AA_JGSDF", "Sparky_JSDF_Overhaul_HAT_JGSDF"]};
		case opfor: {["rhs_vdv_des_rifleman", "rhs_vdv_des_marksman", "rhs_vdv_des_medic", "rhs_vdv_des_machinegunner", "rhs_vdv_des_at", "rhs_vdv_des_grenadier_rpg", "rhs_vdv_des_engineer", "rhs_vdv_des_aa", "rhs_vdv_des_grenadier", "rhs_vdv_des_RShG2"]};
		case independent: {[]};
	};
#endif
};

player setVariable ["d_recdbusy", false];
