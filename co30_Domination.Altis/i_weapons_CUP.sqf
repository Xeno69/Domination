// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

//Weapons not present:
//AK101-109
//SAIGA_MK03
//TYPE_56_2
//CZ584
//Sa58P

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"CUP_arifle_OTS14_GROZA", "CUP_smg_MP5A5",  
			"CUP_lmg_M240", "CUP_lmg_M60E4", "CUP_arifle_CZ805_A1", "CUP_arifle_CZ805_A1_blk", "CUP_arifle_CZ805_A1_coyote", "CUP_arifle_CZ805_A2",
			"CUP_arifle_CZ805_A2_blk", "CUP_arifle_CZ805_A2_coyote", "CUP_smg_EVO",
			
			//L7A2
			"CUP_lmg_L7A2", 
			
			//G36
			"CUP_arifle_G36C", "CUP_arifle_G36C_camo", "CUP_arifle_G36C_wdl", "CUP_arifle_G36C_hex", "CUP_arifle_G36C_VFG", "CUP_arifle_G36C_VFG_camo", "CUP_arifle_G36C_VFG_wdl", "CUP_arifle_G36C_VFG_hex",
			
			//M16
			"CUP_arifle_M16A1", "CUP_arifle_M16A2", "CUP_arifle_M16A4_Base",
			
			//M4
			"CUP_arifle_M4A1", "CUP_arifle_M4A1_camo", "CUP_arifle_M4A1_black", "CUP_arifle_M4A1_desert",
			"CUP_arifle_M4A1_MOE_short_black", "CUP_arifle_M4A1_MOE_short_desert", "CUP_arifle_M4A1_MOE_short_winter", "CUP_arifle_M4A1_MOE_short_wdl",
			
			//MK1x
			"CUP_arifle_Mk16_CQC", "CUP_arifle_Mk16_CQC_black", "CUP_arifle_Mk16_CQC_woodland"
			
		],
		// corporal rifles (gets added to private rifles)
		[
			"CUP_arifle_OTS14_GROZA_GL", "CUP_arifle_OTS14_GROZA_Grip", "CUP_smg_MP5SD6", 
			"CUP_arifle_CZ805_GL", "CUP_arifle_CZ805_GL_blk", "CUP_arifle_CZ805_GL_coyote",
			
			//G36
			"CUP_arifle_G36K", "CUP_arifle_G36K_camo", "CUP_arifle_G36K_wdl","CUP_arifle_G36K_VFG", "CUP_arifle_G36K_VFG_camo", "CUP_arifle_G36K_VFG_wdl",
			"CUP_arifle_MG36", "CUP_arifle_MG36_camo", "CUP_arifle_MG36_wdl", "CUP_arifle_MG36_hex",
			
			//HK4x
			"CUP_arifle_HK416_CQB_Black", "CUP_arifle_HK416_CQB_Desert", "CUP_arifle_HK416_CQB_Wood",
			
			//M16
			"CUP_arifle_Colt727", "CUP_arifle_M16A1GL", "CUP_arifle_M16A2_GL", "CUP_arifle_M16A4_GL",
			
			//M4
			"CUP_arifle_M4A1_BUIS_GL", "CUP_arifle_M4A1_BUIS_camo_GL", "CUP_arifle_M4A1_BUIS_desert_GL",
			"CUP_arifle_M4A3_desert", "CUP_arifle_M4A3_black", "CUP_arifle_M4A3_camo",
			
			//MK1x
			"CUP_arifle_Mk16_CQC_AFG", "CUP_arifle_Mk16_CQC_AFG_black", "CUP_arifle_Mk16_CQC_AFG_woodland",
			"CUP_arifle_Mk16_CQC_FG", "CUP_arifle_Mk16_CQC_FG_black", "CUP_arifle_Mk16_CQC_FG_woodland",
			"CUP_arifle_Mk16_CQC_SFG", "CUP_arifle_Mk16_CQC_SFG_black", "CUP_arifle_Mk16_CQC_SFG_woodland",
			"CUP_arifle_Mk16_CQC_EGLM", "CUP_arifle_Mk16_CQC_EGLM_black", "CUP_arifle_Mk16_CQC_EGLM_woodland",
			"CUP_arifle_Mk16_STD", "CUP_arifle_Mk16_STD_black", "CUP_arifle_Mk16_STD_woodland"
			
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"CUP_arifle_AUG_A1", "CUP_glaunch_M79", "CUP_lmg_minimi", "CUP_lmg_m249_para", "CUP_lmg_Mk48_des", "CUP_lmg_Mk48_wdl",
			
			//L7A2
			"CUP_lmg_L7A2_Flat",
			
			//G36
			"CUP_arifle_G36K_RIS", "CUP_arifle_G36K_RIS_camo", "CUP_arifle_G36K_RIS_wdl", "CUP_arifle_G36K_AG36", "CUP_arifle_G36K_AG36_camo", "CUP_arifle_G36K_AG36_wdl",
			"CUP_arifle_G36A", "CUP_arifle_G36A_camo", "CUP_arifle_G36A_wdl",
			
			//HK4x
			"CUP_arifle_HK416_CQB_M203_Black", "CUP_arifle_HK416_CQB_M203_Desert", "CUP_arifle_HK416_CQB_M203_Wood",
			"CUP_arifle_HK416_Black", "CUP_arifle_HK416_Desert", "CUP_arifle_HK416_Wood",
			"CUP_arifle_HK_M27", "CUP_arifle_HK_M27_VFG", 	
			
			//L85
			"CUP_arifle_L85A2", "CUP_arifle_L86A2",
			
			//M16
			"CUP_arifle_Colt727_M203",
			
			//MK1x
			"CUP_arifle_Mk16_STD_AFG", "CUP_arifle_Mk16_STD_AFG_black", "CUP_arifle_Mk16_STD_AFG_woodland",
			"CUP_arifle_Mk16_STD_FG", "CUP_arifle_Mk16_STD_FG_black", "CUP_arifle_Mk16_STD_FG_woodland",
			"CUP_arifle_Mk16_STD_SFG", "CUP_arifle_Mk16_STD_SFG_black", "CUP_arifle_Mk16_STD_SFG_woodland",
			"CUP_arifle_Mk16_STD_EGLM", "CUP_arifle_Mk16_STD_EGLM_black", "CUP_arifle_Mk16_STD_EGLM_woodland",
			"CUP_arifle_Mk16_SV", "CUP_arifle_Mk16_SV_black", "CUP_arifle_Mk16_SV_woodland"
		],
		// lieutenant rifles (gets added to...)
		[
			"CUP_sgun_M1014", "CUP_lmg_m249_para_gl", "CUP_lmg_M249_E2", "CUP_lmg_minimi_railed", "CUP_lmg_L110A1",
			"CUP_lmg_MG3",
			
			//G36
			"CUP_arifle_G36K_RIS_AG36", "CUP_arifle_G36K_RIS_AG36_camo", "CUP_arifle_G36K_RIS_AG36_wdl",
			"CUP_arifle_G36A_RIS", "CUP_arifle_G36A_RIS_wdl", "CUP_arifle_G36A_RIS_camo", "CUP_arifle_AG36", "CUP_arifle_AG36_camo", "CUP_arifle_AG36_wdl",
			"CUP_arifle_G36A3", "CUP_arifle_G36A3_camo", "CUP_arifle_G36A3_wdl", "CUP_arifle_G36A3_grip", "CUP_arifle_G36A3_grip_camo", "CUP_arifle_G36A3_grip_wdl",
			
			//HK4x
			"CUP_arifle_HK416_M203_Black", "CUP_arifle_HK416_M203_Desert", "CUP_arifle_HK416_M203_Wood",
			"CUP_arifle_HK416_M203_Black", "CUP_arifle_HK416_M203_Desert",
			"CUP_arifle_HK_M27_AG36", 
			"CUP_arifle_HK417_12", "CUP_arifle_HK417_12_Wood", "CUP_arifle_HK417_12_Desert",
			
			//L85
			"CUP_arifle_L85A2_G", "CUP_arifle_L85A2_G", "CUP_arifle_L85A2_NG", "CUP_arifle_L85A2_GL",
			
			//MK1x
			"CUP_arifle_Mk17_CQC", "CUP_arifle_Mk17_CQC_black", "CUP_arifle_Mk17_CQC_woodland"
		],
		// captain rifles (gets added...)
		[
			"CUP_glaunch_Mk13", "CUP_srifle_Mk12SPR",
			"CUP_arifle_Mk20",
			
			"CUP_lmg_MG3_rail",
			
			//G36
			"CUP_arifle_G36A_AG36_RIS", "CUP_arifle_G36A_AG36_RIS_camo", "CUP_arifle_G36A_AG36_RIS_wdl",
			"CUP_arifle_G36A3_AG36", "CUP_arifle_G36A3_AG36_camo", "CUP_arifle_G36A3_AG36_wdl",
			"CUP_arifle_G36E", "CUP_arifle_G36E_camo", "CUP_arifle_G36E_wdl",
			
			//HK4x
			"CUP_arifle_HK417_12_M203", "CUP_arifle_HK417_12_M203_Wood", "CUP_arifle_HK417_12_M203_Desert",
			
			//M4
			"CUP_arifle_M4A1_SOMMOD_black", "CUP_arifle_M4A1_SOMMOD_ctrgt", "CUP_arifle_M4A1_SOMMOD_ctrg", "CUP_arifle_M4A1_SOMMOD_tan", "CUP_arifle_M4A1_SOMMOD_hex", "CUP_arifle_M4A1_SOMMOD_snow", "CUP_arifle_M4A1_SOMMOD_green",
			
			//MK1x
			"CUP_arifle_Mk17_CQC_AFG", "CUP_arifle_Mk17_CQC_AFG_black", "CUP_arifle_Mk17_CQC_AFG_woodland",
			"CUP_arifle_Mk17_CQC_FG", "CUP_arifle_Mk17_CQC_FG_black", "CUP_arifle_Mk17_CQC_FG_woodland",
			"CUP_arifle_Mk17_CQC_SFG", "CUP_arifle_Mk17_CQC_SFG_black", "CUP_arifle_Mk17_CQC_SFG_woodland",
			"CUP_arifle_Mk17_CQC_EGLM", "CUP_arifle_Mk17_CQC_EGLM_black", "CUP_arifle_Mk17_CQC_EGLM_woodland",
			"CUP_arifle_Mk17_STD", "CUP_arifle_Mk17_STD_black", "CUP_arifle_Mk17_STD_woodland"
		],
		// major rifles (gets...)
		[
			"CUP_srifle_M14_DMR", "CUP_srifle_M24_blk", "CUP_srifle_M24_des", "CUP_srifle_M24_wdl", "CUP_srifle_M40A3", "CUP_srifle_M110", "CUP_srifle_M14", "CUP_arifle_XM8_Carbine",
			"CUP_arifle_XM8_Carbine_GL", "CUP_arifle_xm8_sharpshooter", "CUP_arifle_xm8_SAW", "CUP_arifle_XM8_Compact", "CUP_arifle_XM8_Compact_Rail",	"CUP_srifle_CZ750",
			"CUP_arifle_XM8_Railed", "CUP_arifle_XM8_Carbine_FG",
			
			//G36
			"CUP_arifle_G36K_KSK", "CUP_arifle_G36K_KSK_camo", "CUP_arifle_G36K_KSK_VFG", "CUP_arifle_G36K_KSK_VFG_camo",
			
			//HK4x
			"CUP_arifle_HK417_20", "CUP_arifle_HK417_20_Wood", "CUP_arifle_HK417_20_Desert",
			
			//L129A1
			"CUP_srifle_L129A1", "CUP_srifle_L129A1_ctrg", "CUP_srifle_L129A1_ctrgt", "CUP_srifle_L129A1_d", "CUP_srifle_L129A1_w",
			
			//MK1x
			"CUP_arifle_Mk17_STD_AFG", "CUP_arifle_Mk17_STD_AFG_black", "CUP_arifle_Mk17_STD_AFG_woodland",
			"CUP_arifle_Mk17_STD_FG", "CUP_arifle_Mk17_STD_FG_black", "CUP_arifle_Mk17_STD_FG_woodland",
			"CUP_arifle_Mk17_STD_SFG", "CUP_arifle_Mk17_STD_SFG_black", "CUP_arifle_Mk17_STD_SFG_woodland",
			"CUP_arifle_Mk17_STD_EGLM", "CUP_arifle_Mk17_STD_EGLM_black", "CUP_arifle_Mk17_STD_EGLM_woodland",
			"CUP_arifle_Mk20", "CUP_arifle_Mk20_black", "CUP_arifle_Mk20_woodland"
			
			
		],
		// colonel rifles (...)
		[
			"CUP_sgun_AA12", "CUP_glaunch_M32", "CUP_srifle_AS50", "CUP_srifle_AWM_des", "CUP_srifle_AWM_wdl", "CUP_srifle_G22_des", "CUP_srifle_G22_wdl",
			"CUP_srifle_AS50",
			
			//G36
			"CUP_arifle_G36K_KSK_AFG", "CUP_arifle_G36K_KSK_AFG_camo",
			
			//M107
			"CUP_srifle_M107_Base", "CUP_srifle_M107_Pristine", "CUP_srifle_M107_Desert", "CUP_srifle_M107_Snow", "CUP_srifle_M107_Woodland",
			
			//M16
			"CUP_arifle_M16A1GL_FS", "CUP_arifle_M16A1GL_USA"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"CUP_launch_M72A6", "CUP_launch_M136", "CUP_launch_FIM92Stinger"
		],
		// corporal launchers
		[
			"CUP_launch_M72A6_Special"
		],
		// sergeant launchers
		[
			"CUP_launch_MAAWS", "CUP_launch_NLAW"
		],
		// lieutenant launchers
		[
			"CUP_launch_M47"
		],
		// captain launchers
		[
			"CUP_launch_Mk153Mod0", "CUP_launch_Mk153Mod0_blk"
		],
		// major launchers
		[
		],
		// colonel launchers
		[
			"CUP_launch_Javelin"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"PISTOLS",
		// private pistols
		[
			"CUP_hgun_CZ75"
		],
		// corporal pistols
		[
			"CUP_hgun_M9", "CUP_hgun_Compact"
		],
		// sergeant pistols
		[
			"CUP_hgun_Glock17", "CUP_hgun_Glock17_blk", "CUP_hgun_Glock17_tan", "CUP_hgun_Phantom", "CUP_hgun_Duty"
		],
		// lieutenant pistols
		[
			"CUP_hgun_Colt1911", "CUP_hgun_Deagle"
		],
		// captain pistols
		[
			"CUP_hgun_MicroUzi"
		],
		// major pistols
		[
		],
		// colonel pistols
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"OPTICS",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private optics
		[

		],
		// corporal optics
		[
			"CUP_optic_Kobra", "CUP_optic_HoloBlack", "CUP_optic_HoloWdl", "CUP_optic_HoloDesert", "CUP_optic_CompM2_Black", "CUP_optic_CompM2_Woodland",
			"CUP_optic_CompM2_Woodland2", "CUP_optic_CompM2_Desert", "CUP_optic_MRad", "CUP_optic_TrijiconRx01_desert",
			"CUP_optic_TrijiconRx01_black", "CUP_acc_Flashlight", "CUP_acc_Flashlight_wdl", "CUP_acc_Flashlight_desert", "CUP_muzzle_snds_mp5"
		],
		// sergeant optics
		[
			"CUP_optic_PSO_1", "CUP_optic_Eotech533", "CUP_optic_Eotech533Grey", "CUP_optic_CompM4", "CUP_optic_ElcanM145", "CUP_optic_ZDDot", "CUP_optic_Elcan",
			"CUP_optic_Elcan_reflex", "CUP_acc_CZ_M3X", "CUP_acc_LLM", "CUP_optic_PGO7V", "CUP_optic_PGO7V2", "CUP_optic_PGO7V3"
		],
		// lieutenant optics
		[
			 "CUP_optic_MAAWS_Scope", "CUP_optic_PechenegScope", "CUP_optic_SUSAT", "CUP_optic_ACOG", "CUP_optic_PSO_3", "CUP_optic_RCO", "CUP_optic_RCO_desert",
			 "CUP_acc_XM8_light_module"
		],
		// captain optics
		[
			"muzzle_snds_acp", "CUP_optic_CWS", "CUP_optic_LeupoldMk4_CQ_T", "CUP_optic_ELCAN_SpecterDR", "CUP_optic_AN_PVS_4", "CUP_acc_ANPEQ_15", "CUP_acc_ANPEQ_2",
			"CUP_acc_ANPEQ_2_camo", "CUP_acc_ANPEQ_2_desert", "CUP_acc_ANPEQ_2_grey", "CUP_optic_NSPU_RPG"
		],
		// major optics
		[
			"LaserDesignator", "CUP_optic_SMAW_Scope", "CUP_optic_GOSHAWK", "CUP_optic_NSPU", "CUP_optic_AN_PAS_13c2", "CUP_optic_AN_PVS_10", "CUP_optic_AN_PAS_13c1",
			"CUP_optic_SB_11_4x20_PM"
		],
		// colonel optics
		[
			"CUP_Mxx_camo", "CUP_Mxx_camo_half", "CUP_SVD_camo_g", "CUP_SVD_camo_g_half", "CUP_SVD_camo_d", "CUP_SVD_camo_d_half", "CUP_optic_SB_3_12x50_PMII",
			"CUP_optic_LeupoldMk4", "CUP_optic_Leupold_VX3", "CUP_optic_LeupoldM3LR", "CUP_optic_LeupoldMk4_10x40_LRT_Desert", "CUP_optic_LeupoldMk4_10x40_LRT_Woodland",
			"CUP_optic_LeupoldMk4_MRT_tan"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
		],
		// corporal muzzles
		[
		],
		// sergeant muzzles
		[
			"CUP_muzzle_snds_AWM", "CUP_muzzle_snds_M16", "muzzle_snds_L"
		],
		// lieutenant muzzles
		[
			"CUP_acc_Glock17_Flashlight", "CUP_muzzle_snds_G36_black", "CUP_muzzle_snds_G36_desert", "CUP_muzzle_snds_MicroUzi", "CUP_muzzleFlash2SCAR_L", "CUP_muzzle_snds_SCAR_L",
			"CUP_muzzle_mfsup_SCAR_L", "CUP_muzzle_snds_l85"
		],
		// captain muzzles
		[
			"CUP_acc_sffh", "CUP_acc_bfa", "CUP_muzzle_snds_M110", "CUP_muzzle_snds_M14", "CUP_muzzle_snds_M16_camo", "CUP_muzzle_mfsup_SCAR_H", "CUP_muzzle_snds_SCAR_H"
		],
		// major muzzles
		[
			"CUP_muzzle_snds_M9", "CUP_muzzle_snds_Mk12", "CUP_muzzle_snds_XM8"
		],
		// colonel muzzles
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"UNIFORMS",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private uniforms
		[
			"CUP_U_B_USArmy_Base", "CUP_U_B_USArmy_TwoKnee", "CUP_U_B_USArmy_UBACS", "CUP_U_B_USArmy_Soft", "CUP_U_B_USArmy_PilotOverall", "CUP_U_B_USMC_Officer",
			"CUP_U_B_USMC_MARPAT_WDL_Sleeves", "CUP_U_B_USMC_MARPAT_WDL_RolledUp", "CUP_U_B_USMC_MARPAT_WDL_Kneepad", "CUP_U_B_USMC_MARPAT_WDL_TwoKneepads", "CUP_U_B_USMC_PilotOverall",
			"CUP_U_B_USMC_MARPAT_WDL_RollUpKneepad", "CUP_U_B_FR_SpecOps", "CUP_U_B_FR_Scout", "CUP_U_B_FR_Officer", "CUP_U_B_FR_Corpsman", "CUP_U_B_FR_DirAction",
			"CUP_U_B_FR_DirAction2", "CUP_U_B_FR_Light", "CUP_U_B_FR_Scout1", "CUP_U_B_FR_Scout2", "CUP_U_B_FR_Scout3", "CUP_B_USMC_Navy_Blue", "CUP_B_USMC_Navy_Brown",
			"CUP_B_USMC_Navy_Green", "CUP_B_USMC_Navy_Red", "CUP_B_USMC_Navy_Violet", "CUP_B_USMC_Navy_White", "CUP_B_USMC_Navy_Yellow", "CUP_U_B_USMC_FROG1_WMARPAT",
			"CUP_U_B_USMC_FROG1_DMARPAT", "CUP_U_B_USMC_FROG2_WMARPAT", "CUP_U_B_USMC_FROG2_DMARPAT", "CUP_U_B_USMC_FROG3_WMARPAT", "CUP_U_B_USMC_FROG3_DMARPAT",
			"CUP_U_B_USMC_FROG4_WMARPAT", "CUP_U_B_USMC_FROG4_DMARPAT",

			"CUP_H_USArmy_Boonie", "CUP_H_USA_Cap", "CUP_H_USArmy_HelmetMICH", "CUP_H_USArmy_HelmetMICH_ESS", "CUP_H_USArmy_HelmetMICH_earpro", "CUP_H_USArmy_HelmetMICH_earpro_ess",
			"CUP_H_USArmy_HelmetMICH_headset", "CUP_H_USArmy_HelmetMICH_headset_ess", "CUP_H_USArmy_HelmetMICH_wdl", "CUP_H_USArmy_Helmet_ECH1_Sand", "CUP_H_USArmy_Helmet_ECH2_Sand",
			"CUP_H_USArmy_Helmet_ECH1_Black", "CUP_H_USArmy_Helmet_ECH2_Black", "CUP_H_USArmy_Helmet_ECH1_Green", "CUP_H_USArmy_Helmet_ECH2_GREEN", "CUP_H_USArmy_Helmet_Pro",
			"CUP_H_USArmy_Helmet_Pro_gog", "CUP_H_USArmy_Helmet_M1_Olive", "CUP_H_USArmy_Helmet_M1_Vine", "CUP_H_USArmy_Helmet_M1_m81", "CUP_H_USArmy_Helmet_M1_btp", "CUP_H_USMC_Officer_Cap",
			"CUP_H_USMC_HelmetWDL", "CUP_H_USMC_Headset_HelmetWDL", "CUP_H_USMC_Headset_GoggleW_HelmetWDL", "CUP_H_USMC_Crew_Helmet", "CUP_H_USMC_Goggles_HelmetWDL",
			"CUP_H_USMC_Helmet_Pilot", "CUP_H_FR_Cap_Headset_Green", "CUP_H_FR_Cap_Officer_Headset", "CUP_H_FR_BandanaGreen", "CUP_H_FR_BandanaWdl", "CUP_H_FR_ECH", "CUP_H_FR_BoonieMARPAT",
			"CUP_H_FR_BoonieWDL", "CUP_H_FR_BeanieGreen", "CUP_H_FR_Headset", "CUP_H_FR_Bandana_Headset", "CUP_H_FR_Headband_Headset", "CUP_H_FR_PRR_BoonieWDL", "CUP_H_USMC_ACVC_WDL",
			"CUP_H_USMC_ACVC_DES", "CUP_H_USMC_MICH2000_WDL", "CUP_H_USMC_MICH2000_DES", "CUP_H_USMC_MICH2000_ESS_COMM_WDL", "CUP_H_USMC_MICH2000_ESS_COMM_DES",
			"CUP_H_USMC_MICH2000_COMM_WDL", "CUP_H_USMC_MICH2000_COMM_DES", "CUP_H_USMC_MICH2000_DEF_WDL", "CUP_H_USMC_MICH2000_DEF_DES", "CUP_H_USMC_MICH2000_DEF_ESS_WDL",
			"CUP_H_USMC_MICH2000_DEF_ESS_DES", "CUP_H_USMC_LWH_NVGMOUNT_WDL", "CUP_H_USMC_LWH_NVGMOUNT_DES", "CUP_H_USMC_LWH_WDL", "CUP_H_USMC_LWH_DES", "CUP_H_USMC_LWH_NVGMOUNT_ESS_HS_WDL",
			"CUP_H_USMC_LWH_NVGMOUNT_ESS_HS_DES", "CUP_H_USMC_LWH_ESS_HS_WDL", "CUP_H_USMC_LWH_ESS_HS_DES", "CUP_H_USMC_LWH_NVGMOUNT_ESS_WDL", "CUP_H_USMC_LWH_NVGMOUNT_ESS_DES",
			"CUP_H_USMC_LWH_ESS_WDL", "CUP_H_USMC_LWH_ESS_DES", "CUP_H_USMC_LWH_NVGMOUNT_ESS_LR_WDL", "CUP_H_USMC_LWH_NVGMOUNT_ESS_LR_DES", "CUP_H_USMC_LWH_ESS_LR_WDL",
			"CUP_H_USMC_LWH_ESS_LR_DES", "CUP_H_USMC_BOONIE_WDL", "CUP_H_USMC_BOONIE_DES", "CUP_H_USMC_BOONIE_PRR_WDL", "CUP_H_USMC_BOONIE_PRR_DES", "CUP_H_USMC_CAP_WDL",
			"CUP_H_USMC_CAP_DES", "CUP_H_USMC_CAP_PRR_WDL", "CUP_H_USMC_CAP_PRR_DES"
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
			"CUP_FR_NeckScarf", "CUP_FR_NeckScarf2"
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
		],
		// major uniforms
		[
		],
		// colonel uniforms
		[
			"CUP_U_B_BAF_DDPM_Ghillie", "CUP_U_B_BAF_DPM_Ghillie"
		]
	],
	// additional weapons and items, no rank
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
			"MineDetector", "Binocular", (if (d_no_faks == 1) then {"FirstAidKit"} else {""}), "Medikit",
			(if (d_without_nvg == 1) then {"NVGoggles"} else {""}),
			"ToolKit", "B_UavTerminal"
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"CUP_arifle_FNFAL", "CUP_arifle_FNFAL_desert", "CUP_arifle_FNFAL_woodland", "CUP_arifle_FNFAL_sand", "CUP_arifle_SR3M_Vikhr", "CUP_arifle_SR3M_Vikhr_VFG", "CUP_arifle_OTS14_GROZA", "CUP_arifle_AK47", "CUP_arifle_AK74", "CUP_arifle_AK74M", "CUP_arifle_AKS74", "CUP_arifle_AKS74U", "CUP_arifle_AKM", "CUP_arifle_AKS",
			"CUP_arifle_RPK74", "CUP_arifle_RPK74M", "CUP_smg_bizon", "CUP_lmg_PKM", "CUP_srifle_CZ550", "CUP_smg_vityaz", "CUP_smg_vityaz_vfg"
		],
		// corporal rifles (gets added to private rifles)
		[
			"CUP_arifle_RPK74M_top_rail", "CUP_arifle_RPK74_top_rail", "CUP_arifle_AK74M_top_rail", "CUP_arifle_AK74M_camo", "CUP_arifle_AK74_top_rail", "CUP_arifle_AK47_top_rail", "CUP_arifle_AK47_GL", "CUP_arifle_AKS74U_top_rail", "CUP_arifle_AKM_top_rail",
			"CUP_arifle_AKM_GL", "CUP_arifle_SR3M_Vikhr_top_rail", "CUP_arifle_SR3M_Vikhr_VFG_top_rail", "CUP_arifle_OTS14_GROZA_GL", "CUP_arifle_OTS14_GROZA_Grip", "CUP_arifle_AK74M_GL", "CUP_arifle_AK107", "CUP_arifle_AK74_GL",
			"CUP_arifle_RPK74_45", "CUP_lmg_Pecheneg", "CUP_srifle_CZ550_rail", "CUP_smg_vityaz_top_rail", "CUP_smg_vityaz_vfg_top_rail", "CUP_smg_vityaz_vfg_front_rail",
			"CUP_arifle_FNFAL5060", "CUP_arifle_FNFAL5060_desert", "CUP_arifle_FNFAL5060_sand", "CUP_arifle_FNFAL5060_woodland"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"CUP_arifle_RPK74_45_top_rail", "CUP_arifle_AK74M_GL_top_rail", "CUP_arifle_AK74_GL_top_rail", "CUP_arifle_AK47_GL_top_rail", "CUP_arifle_AKM_GL_top_rail", "CUP_lmg_UK59", "CUP_arifle_AUG_A1", "CUP_arifle_AK107_GL"
		],
		// lieutenant rifles (gets added to...)
		[
			"CUP_arifle_FNFAL_railed_sand", "CUP_arifle_FNFAL_railed", "CUP_arifle_FNFAL_railed_desert", "CUP_arifle_FNFAL_railed_woodland", "CUP_arifle_RPK74M_railed", "CUP_arifle_AK74M_railed", "CUP_sgun_Saiga12K"
		],
		// captain rifles (gets added...)
		[
			"CUP_arifle_FNFAL5060_railed", "CUP_arifle_FNFAL5060_railed_desert", "CUP_arifle_FNFAL5060_railed_sand", "CUP_arifle_FNFAL5060_railed_woodland", "CUP_arifle_AK74M_GL_railed", "CUP_arifle_AS_VAL", "CUP_arifle_AS_VAL_flash", "CUP_arifle_AS_VAL_VFG", "CUP_srifle_VSSVintorez", "CUP_srifle_VSSVintorez_VFG", "CUP_srifle_VSSVintorez_flash"
		],
		// major rifles (gets...)
		[
			"CUP_arifle_AS_VAL_top_rail", "CUP_arifle_AS_VAL_flash_top", "CUP_srifle_VSSVintorez_top_rail", "CUP_srifle_VSSVintorez_VFG_top_rail", "CUP_srifle_VSSVintorez_flash_top", "CUP_srifle_LeeEnfield", "CUP_srifle_LeeEnfield_rail",
			"CUP_srifle_SVD", "CUP_srifle_SVD_des"
		],
		// colonel rifles (...)
		[
			"CUP_sgun_AA12","CUP_srifle_ksvk", "CUP_glaunch_6G30", "CUP_arifle_AKS_Gold"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"CUP_launch_Igla", "CUP_launch_9K32Strela", "CUP_launch_RPG7V"
		],
		// corporal launchers
		[
			"CUP_launch_RPG18"
		],
		// sergeant launchers
		[
			"CUP_launch_MAAWS"
		],
		// lieutenant launchers
		[
			"CUP_launch_M47"
		],
		// captain launchers
		[
		],
		// major launchers
		[
		],
		// colonel launchers
		[
			"CUP_launch_Metis"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"PISTOLS",
		// private pistols
		[
			"CUP_hgun_Makarov"
		],
		// corporal pistols
		[
			 "CUP_hgun_PMM"
		],
		// sergeant pistols
		[
		],
		// lieutenant pistols
		[
			"CUP_hgun_PB6P9", "CUP_hgun_Deagle"
		],
		// captain pistols
		[
			"CUP_hgun_SA61"
		],
		// major pistols
		[
			"CUP_hgun_TaurusTracker455"
		],
		// colonel pistols
		[
			"CUP_hgun_TaurusTracker455_gold"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"OPTICS",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private optics
		[

		],
		// corporal optics
		[
			"CUP_optic_Kobra", "CUP_optic_HoloBlack", "CUP_optic_HoloWdl", "CUP_optic_HoloDesert", "CUP_optic_CompM2_Black", "CUP_optic_CompM2_Woodland",
			"CUP_optic_CompM2_Woodland2", "CUP_optic_CompM2_Desert", "CUP_optic_MRad", "CUP_optic_TrijiconRx01_desert",
			"CUP_optic_TrijiconRx01_black", "CUP_acc_Flashlight", "CUP_acc_Flashlight_wdl", "CUP_acc_Flashlight_desert"
		],
		// sergeant optics
		[
			"CUP_optic_PSO_1", "CUP_optic_Eotech533", "CUP_optic_Eotech533Grey", "CUP_optic_CompM4", "CUP_optic_ElcanM145", "CUP_optic_ZDDot", "CUP_optic_Elcan",
			"CUP_optic_Elcan_reflex", "CUP_acc_CZ_M3X", "CUP_acc_LLM", "CUP_optic_PGO7V", "CUP_optic_PGO7V2", "CUP_optic_PGO7V3"
		],
		// lieutenant optics
		[
			 "CUP_optic_MAAWS_Scope", "CUP_optic_PechenegScope", "CUP_optic_SUSAT", "CUP_optic_ACOG", "CUP_optic_PSO_3", "CUP_optic_RCO", "CUP_optic_RCO_desert",
			 "CUP_acc_XM8_light_module"
		],
		// captain optics
		[
			"CUP_muzzle_Bizon", "CUP_muzzle_PBS4", "CUP_muzzle_pb6p9", "CUP_optic_CWS", "CUP_optic_LeupoldMk4_CQ_T", "CUP_optic_ELCAN_SpecterDR", "CUP_optic_AN_PVS_4", "CUP_acc_ANPEQ_15", "CUP_acc_ANPEQ_2",
			"CUP_acc_ANPEQ_2_camo", "CUP_acc_ANPEQ_2_desert", "CUP_acc_ANPEQ_2_grey", "CUP_optic_NSPU_RPG"
		],
		// major optics
		[
			"LaserDesignator", "CUP_optic_SMAW_Scope", "CUP_optic_GOSHAWK", "CUP_optic_NSPU", "CUP_optic_AN_PAS_13c2", "CUP_optic_AN_PVS_10", "CUP_optic_AN_PAS_13c1",
			"CUP_optic_SB_11_4x20_PM", "CUP_optic_no23mk2"
		],
		// colonel optics
		[
			"CUP_Mxx_camo", "CUP_Mxx_camo_half", "CUP_SVD_camo_g", "CUP_SVD_camo_g_half", "CUP_SVD_camo_d", "CUP_SVD_camo_d_half", "CUP_optic_SB_3_12x50_PMII",
			"CUP_optic_LeupoldMk4", "CUP_optic_Leupold_VX3", "CUP_optic_LeupoldM3LR", "CUP_optic_LeupoldMk4_10x40_LRT_Desert", "CUP_optic_LeupoldMk4_10x40_LRT_Woodland",
			"CUP_optic_LeupoldMk4_MRT_tan"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
		],
		// corporal muzzles
		[
		],
		// sergeant muzzles
		[
			"CUP_muzzle_snds_AWM", "CUP_muzzle_snds_M16", "CUP_muzzle_snds_SR3M"
		],
		// lieutenant muzzles
		[
			"CUP_muzzle_snds_G36_black", "CUP_muzzle_snds_G36_desert", "CUP_muzzle_snds_MicroUzi", "CUP_muzzleFlash2SCAR_L", "CUP_muzzle_snds_SCAR_L",
			"CUP_muzzle_mfsup_SCAR_L"
		],
		// captain muzzles
		[
			"CUP_acc_sffh", "CUP_acc_bfa", "CUP_muzzle_snds_M110", "CUP_muzzle_snds_M14", "CUP_muzzle_snds_M16_camo", "CUP_muzzle_mfsup_SCAR_H", "CUP_muzzle_snds_SCAR_H"
		],
		// major muzzles
		[
			"CUP_muzzle_snds_M9", "CUP_muzzle_snds_Mk12", "CUP_muzzle_snds_XM8"
		],
		// colonel muzzles
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"UNIFORMS",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private uniforms
		[
			"CUP_U_O_RUS_Flora_1", "CUP_U_O_RUS_EMR_1", "CUP_U_O_RUS_Flora_2", "CUP_U_O_RUS_EMR_2", "CUP_U_O_RUS_Flora_1_VDV", "CUP_U_O_RUS_EMR_1_VDV",
			"CUP_U_O_RUS_Flora_2_VDV", "CUP_U_O_RUS_EMR_2_VDV", "CUP_U_O_RUS_Commander", "CUP_U_O_RUS_Gorka_Partizan", "CUP_U_O_RUS_Gorka_Partizan_A",
			"CUP_U_O_RUS_Gorka_Green",  "CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Green", "CUP_U_O_SLA_Urban", "CUP_U_O_SLA_Desert",
			"CUP_U_O_Partisan_TTsKO", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_SLA_Overalls_Pilot",
			"CUP_U_O_SLA_Overalls_Tank", "CUP_U_O_SLA_Officer_Suit", "CUP_U_O_TK_Officer", "CUP_U_O_TK_MixedCamo", "CUP_U_O_TK_Green",
			"CUP_U_O_CHDKZ_Bardak", "CUP_U_O_CHDKZ_Commander", "CUP_U_O_CHDKZ_Lopotev", "CUP_U_O_CHDKZ_Kam_01", "CUP_U_O_CHDKZ_Kam_02", "CUP_U_O_CHDKZ_Kam_03",
			"CUP_U_O_CHDKZ_Kam_04", "CUP_U_O_CHDKZ_Kam_05", "CUP_U_O_CHDKZ_Kam_06", "CUP_U_O_CHDKZ_Kam_07", "CUP_U_O_CHDKZ_Kam_08",

			"CUP_H_RUS_6B27_NVG", "CUP_H_RUS_6B27_NVG_olive", "CUP_H_RUS_6B27", "CUP_H_RUS_6B27_olive", "CUP_H_RUS_TSH_4_Brown", "CUP_H_RUS_ZSH_Shield_Up",
			"CUP_H_RUS_ZSH_Shield_Down", "CUP_H_RUS_Bandana_HS", "CUP_H_RUS_Beret_VDV", "CUP_H_RUS_Beret_Spetsnaz", "CUP_H_RUS_ZSH_1_Goggles", "CUP_H_RUS_ZSH_1",
			"CUP_H_SLA_TankerHelmet", "CUP_H_SLA_Helmet", "CUP_H_SLA_OfficerCap", "CUP_H_SLA_SLCap", "CUP_H_SLA_Boonie", "CUP_H_SLA_Beret", "CUP_H_SLA_BeanieGreen",
			"CUP_H_SLA_BeretRed"
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
			"CUP_RUS_Balaclava_blk", "CUP_RUS_Balaclava_grn"
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
		],
		// major uniforms
		[
		],
		// colonel uniforms
		[
			"CUP_U_O_RUS_Ghillie", "CUP_U_O_TK_Ghillie_Top"
		]
	],
	// additional weapons and items, no rank
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
			"MineDetector", "Binocular", (if (d_no_faks == 1) then {"FirstAidKit"} else {""}), "Medikit",
			(if (d_without_nvg == 1) then {"NVGoggles"} else {""}),
			"ToolKit", "B_UavTerminal"
		]
	]
];

private "_all_weapons_items";
if (!d_tt_ver) then {
#ifdef __OWN_SIDE_BLUFOR__
	_all_weapons_items = _all_weapons_items_blufor;
#endif
#ifdef __OWN_SIDE_OPFOR__
	_all_weapons_items = _all_weapons_items_opfor;
#endif
} else {
	if (side (group player) == blufor) then {
		__TRACE("Player is blufor")
		_all_weapons_items = _all_weapons_items_blufor;
	} else {
		__TRACE("Player is opfor")
		_all_weapons_items = _all_weapons_items_opfor;
	};
};

#include "i_weapons_base.sqf"
