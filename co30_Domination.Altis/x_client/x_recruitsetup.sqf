// by Xeno
#define THIS_FILE "x_recruitsetup.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

player reveal d_AI_HUT;

d_AI_HUT addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_314"], {_this call d_fnc_recruitaiaction}];

if (!isNil "d_additional_recruit_buildings") then {
	{
		["d_RecruitB_" + str _forEachIndex, _x, "ICON", "ColorYellow", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_313", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;

		_x addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_314"], {_this call d_fnc_recruitaiaction}];
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
#ifdef __IFA3LITE__
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
#ifdef __ROSCHE__
	private _pchar = switch (d_player_side) do {
		case blufor: {"B"};
		case opfor: {"O"};
		case independent: {"I"};
	};
	d_UnitsToRecruit = ["_Soldier_F", "_soldier_AR_F", "_soldier_exp_F", "_Soldier_GL_F", "_soldier_M_F", "_medic_F", "_soldier_repair_F", "_soldier_LAT_F"] apply {_pchar + _x};
#endif
};

player setVariable ["d_recdbusy", false];
