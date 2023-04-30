// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_indep = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"PRACS_g3a3","PRACS_g3a3_w","PRACS_g3a4","PRACS_g3a4_w","PRACS_g3a4_aco",
			"PRACS_CETME","PRACS_CETME_BNT",
			"PRACS_UZI","PRACS_UZI_FS"
		],
		// corporal rifles (gets added to private rifles)
		[
			"PRACS_g3a3_Elcan","PRACS_g3a3_ACOG","PRACS_g3a3_W_ELCAN_BP",
			"PRACS_g3a4_Elcan","PRACS_g3a4_ACOG","PRACS_g3a4_w_ELCAN_BP",
			"PRACS_FNC",
			"PRACS_HK33","PRACS_HK33_MKS",
			"PRACS_HK33A4","PRACS_HK33A4_T1","PRACS_HK33A4_ELCAN",
			"PRACS_galil_SAR",
			"PRACS_galil_ACE23","PRACS_galil_ACE23_EOT","PRACS_galil_ACE23_EOT_XP","PRACS_galil_ACE23_G33_T1","PRACS_galil_ACE23_ACOG",
			"PRACS_rk62","PRACS_rk62_ELCAN_SD","PRACS_rk62_T1",
			"PRACS_g3a3t40","PRACS_g3a4t40","PRACS_g3a4t40_aco",
			"PRACS_UZI_Commando"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"rhs_weap_m249",
			"rhs_weap_minimi_para_railed",
			"rhs_weap_m249_pip",
			"rhs_weap_m249_pip_S","rhs_weap_m249_pip_S_para","rhs_weap_m249_pip_S_vfg",
			"rhs_weap_m249_pip_L","rhs_weap_m249_pip_L_para","rhs_weap_m249_pip_L_vfg",
			"rhs_weap_m249_pip_S_vfg1","rhs_weap_m249_pip_S_vfg2","rhs_weap_m249_pip_S_vfg3",
			"rhs_weap_m249_pip_L_vfg1","rhs_weap_m249_pip_L_vfg2","rhs_weap_m249_pip_L_vfg3",
			"PRACS_M249_EO_Short","PRACS_M249_EO_Short_QSB","PRACS_M249_Marine",
			"PRACS_M60A2",
			"rhs_weap_m32","rhs_weap_m32_usmc",
			"PRACS_g3a3_W_ACOG_SD",
			"PRACS_galil_ACE23_EOT_XP_P15_SD","PRACS_galil_ACE23_SF","PRACS_galil_ACE23_SF_ACO","PRACS_galil_ACE23_SF_EOT_XP_P15_SD",
			"PRACS_HK416_recon","PRACS_HK416_Commando","PRACS_HK416_Commando_2","PRACS_HK416_Commando_3","PRACS_HK416_Commando_4",
			"PRACS_HK416_m320_recon",
			"PRACS_HK53","PRACS_HK53_XPS","PRACS_HK53_ACO"
		],
		// lieutenant rifles (gets added to...)
		[
			"rhs_weap_m240G","rhs_weap_m240B","PRACS_m240B_Su320",
			"PRACS_M60E4","PRACS_M60E4_ACO",
			"PRACS_Mk48","PRACS_Mk48_STD",
			"PRACS_Mk48_Para","PRACS_Mk48_Para_EOT_2","PRACS_Mk48_Para_EOT","PRACS_Mk48_Para_ACO",
			"PRACS_Mk48_light","PRACS_Mk48_light_ACO",
			"rhs_weap_M590_8RD","rhs_weap_M590_5RD",
			"PRACS_g3a4_w_M8541_BP",
			"PRACS_galil_ARM_308",
			"PRACS_M24","PRACS_M24_BP_SD","PRACS_M40_BP_M",
			"PRACS_M40_BP_M",
			"PRACS_Commando_Mk10"
		],
		// captain rifles (gets added...)
		[
			"PRACS_M60E4_ACO_SD","PRACS_M60E4_xps_g33_SD","PRACS_M60E4_ELCAN_SD"
		],
		// major rifles (gets...)
		[
			"PRACS_M107"
		],
		// colonel rifles (...)
		[
			
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"rhs_weap_fim92",
			"rhs_weap_m72a7"
		],
		// corporal launchers
		[
			"rhs_weap_M136",
			"rhs_weap_M136_hedp",
			"rhs_weap_M136_hp"
		],
		// sergeant launchers
		[
			"rhs_weap_smaw",
			"rhs_weap_smaw_green"
		],
		// lieutenant launchers
		[
			"rhs_weap_maaws",
			"PRACS_SAAWS"
		],
		// capain launchers
		[
		],
		// major launchers
		[
		],
		// colonel launchers
		[
			"rhs_weap_fgm148"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"PISTOLS",
		// private pistols
		[
		],
		// corporal pistols
		[
		],
		// sergeant pistols
		[
			"rhsusf_weap_glock17g4"
		],
		// lieutenant pistols
		[
			"rhsusf_weap_m9"
		],
		// captain pistols
		[
			"rhsusf_weap_m1911a1"
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
			"optic_ACO_grn",
			"optic_aco",
			"optic_ACO_grn_smg",
			"optic_Aco_smg",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_T1_low",
			"rhsusf_acc_T1_low_fwd",
			"rhsusf_acc_compm4",
			"rhsusf_acc_eotech_xps3",
			"rhsusf_acc_EOTECH",
			"rhsusf_acc_wmx",
			"rhsusf_acc_wmx_bk",
			"rhsusf_acc_M952V",
			"acc_pointer_IR"
		],
		// sergeant optics
		[
			"rhsusf_acc_ACOG2_USMC",
			"rhsusf_acc_ACOG3_USMC",
			"rhsusf_acc_ACOG_USMC",
			"rhs_weap_optic_smaw",
			"rhsusf_acc_g33_t1",
			"rhsusf_acc_g33_xps3",
			"rhsusf_acc_g33_xps3_tan",
			"rhsusf_acc_ACOG",
			"rhsusf_acc_ACOG2",
			"rhsusf_acc_ACOG3",
			"rhsusf_acc_ACOG_anpvs27",
			"rhsusf_acc_ACOG_MDO",
			"rhsusf_acc_ACOG_d",
			"rhsusf_acc_ACOG_wd",
			"rhsusf_acc_ACOG_RMR",
			"rhsusf_acc_SpecterDR",
			"rhsusf_acc_SpecterDR_OD",
			"rhsusf_acc_SpecterDR_D",
			"rhsusf_acc_SpecterDR_A",
			"acc_flashlight","optic_Holosight_smg"
		],
		// lieutenant optics
		[
			"rhsusf_acc_LEUPOLDMK4",
			"rhsusf_acc_LEUPOLDMK4_2",
			"rhsusf_acc_LEUPOLDMK4_2_d",
			"rhs_optic_maaws",
			"rhsusf_acc_M8541",
			"rhsusf_acc_M8541_low",
			"rhsusf_acc_M8541_low_d",
			"rhsusf_acc_M8541_low_wd",
			"rhsusf_acc_premier_low",
			"rhsusf_acc_premier_anpvs27",
			"rhsusf_acc_premier",
			"optic_MRD","optic_MRCO",
			"optic_ERCO_khk_F",
			"optic_ERCO_blk_F",
			"optic_ERCO_snd_F"
		],
		// captain optics
		[
			"optic_Hamr",
			"rhsusf_acc_anpas13gv1",
			"rhsusf_acc_anpvs27"
		],
		// major optics
		[
			"LaserDesignator", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_tws", "optic_tws_mg", "optic_DMS"
		],
		// colonel optics
		[
			"optic_SOS", "optic_NVS", "optic_Nightstalker", "optic_LRPS"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
			"rhsusf_acc_SF3P556",
			"rhsusf_acc_SFMB556"
		],
		// corporal muzzles
		[
			"rhsusf_acc_grip2",
			"rhsusf_acc_grip2_tan",
			"rhsusf_acc_grip1",
			"rhsusf_acc_grip3",
			"rhsusf_acc_grip3_tan"
		],
		// sergeant muzzles
		[
			"acc_flashlight",
			"rhsusf_acc_anpeq15side",
			"rhsusf_acc_anpeq15_top",
			"rhsusf_acc_anpeq15_wmx_light",
			"rhsusf_acc_anpeq15_wmx",
			"rhsusf_acc_anpeq15side_bk",
			"rhsusf_acc_anpeq15_bk_top",
			"rhsusf_acc_anpeq15",
			"rhsusf_acc_anpeq15_light",
			"rhsusf_acc_anpeq15_bk_light",
			"rhsusf_acc_anpeq15_bk",
			"rhsusf_acc_anpeq15A",
			"rhsusf_acc_harris_bipod",
			"rhsusf_acc_nt4_tan",
			"rhsusf_acc_nt4_black",
			"rhsusf_acc_rotex5_tan",
			"rhsusf_acc_rotex5_grey",
			"rhsusf_acc_rotex_mp7_aor1",
			"rhsusf_acc_rotex_mp7",
			"rhsusf_acc_rotex_mp7_desert",
			"rhsusf_acc_rotex_mp7_winter",
			"rhsusf_acc_grip4",
			"acc_flashlight_pistol",
			"rhsusf_acc_omega9k",
			"rhsusf_acc_SR25S",
			"rhsusf_acc_M2010S",
			"rhs_acc_dtk",
			"rhs_acc_dtk1983",
			"rhs_acc_dtk1l",
			"rhs_acc_dtk1p",
			"rhs_acc_dtk1",
			"rhs_acc_dtk2",
			"rhs_acc_dtk3",
			"rhs_acc_dtk4short",
			"rhs_acc_dtk4screws",
			"rhs_acc_dtk4long",
			"rhsusf_ANPVS_14",
			"rhsusf_ANPVS_15",
			"rhsusf_Rhino"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_B", "muzzle_snds_H","muzzle_snds_L", "muzzle_snds_M", "muzzle_snds_acp"
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			"muzzle_snds_H_MG"
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
			"PRACS_SIS_Uniform",
			"PRACS_coverall",
			"PRACS_Tanker_coverall",
			"PRACS_M10_DES_uniform",
			"PRACS_M10_SDPM_uniform",
			"PRACS_M10_ASDPM_uniform",
			"PRACS_M10_Digital_uniform",
			"PRACS_M10_SMAR_uniform",
			"PRACS_M10_RFP_uniform",
			"PRACS_M10_RFP_G_uniform",
			"PRACS_M10_1ID_uniform",
			"PRACS_M10_2PARA_uniform",
			"PRACS_M10_4A_uniform",
			"PRACS_M10_Artillery_uniform",
			"PRACS_M10_SNG_D_uniform",
			"PRACS_M10_3MTN_uniform",
			"PRACS_M10_Commando_uniform",
			"PRACS_M10_Digital_Commando_uniform",
			"PRACS_M10_Digital_Commando_OD_uniform",
			"PRACS_M10_Marine_uniform",
			"PRACS_M10_Boat_crew_uniform",
			"PRACS_M10_Naval_crew_uniform",
			"PRACS_M10_Recon_uniform",
			"PRACS_M10_M04_uniform",
			"PRACS_M10_RSAF_uniform",
			"PRACS_M10_Fusilier_uniform",

			"PRACS_SIS_Chestrig",
			"PRACS_air_TacVest",
			"PRACS_holster_vest",
			"PRACS_CIRAS",
			"PRACS_CIRAS_rifleman",
			"PRACS_CIRAS_Recon_SF",
			"PRACS_CIRAS_SF",
			"PRACS_CIRAS_SMG",
			"PRACS_CIRAS_SMG_SF",
			"PRACS_CIRAS_GAL_rifleman",
			"PRACS_CIRAS_G3_Recon",
			"PRACS_CIRAS_G3_rifleman",
			"PRACS_CIRAS_G3_grenadier",
			"PRACS_CIRAS_G3_medic",
			"PRACS_CIRAS_medic",
			"PRACS_CIRAS_GAL_medic",
			"PRACS_CIRAS_grenadier",
			"PRACS_CIRAS_grenadier_SF",
			"PRACS_CIRAS_GAL_grenadier",
			"PRACS_CIRAS_MG",
			"PRACS_CIRAS_MG_SF",
			"PRACS_O_CIRAS",
			"PRACS_O_CIRAS_rifleman",
			"PRACS_O_CIRAS_Recon_SF",
			"PRACS_O_CIRAS_SF",
			"PRACS_O_CIRAS_SMG",
			"PRACS_O_CIRAS_SMG_SF",
			"PRACS_O_CIRAS_G3_Recon",
			"PRACS_O_CIRAS_GAL_rifleman",
			"PRACS_O_CIRAS_G3_rifleman",
			"PRACS_O_CIRAS_G3_grenadier",
			"PRACS_O_CIRAS_GAL_grenadier",
			"PRACS_O_CIRAS_G3_medic",
			"PRACS_O_CIRAS_medic",
			"PRACS_O_CIRAS_GAL_medic",
			"PRACS_O_CIRAS_grenadier",
			"PRACS_O_CIRAS_grenadier_SF",
			"PRACS_O_CIRAS_MG",
			"PRACS_O_CIRAS_MG_SF",
			"PRACS_C_CIRAS",
			"PRACS_C_CIRAS_rifleman",
			"PRACS_C_CIRAS_Recon_SF",
			"PRACS_C_CIRAS_SF",
			"PRACS_C_CIRAS_GAL_rifleman",
			"PRACS_C_CIRAS_SMG",
			"PRACS_C_CIRAS_SMG_SF",
			"PRACS_C_CIRAS_Officer",
			"PRACS_C_CIRAS_Officer_HR",
			"PRACS_C_CIRAS_TL",
			"PRACS_C_CIRAS_SL",
			"PRACS_C_CIRAS_PSG",
			"PRACS_C_CIRAS_GAL_Officer",
			"PRACS_C_CIRAS_GAL_TL",
			"PRACS_C_CIRAS_GAL_SL",
			"PRACS_C_CIRAS_GAL_PSG",
			"PRACS_C_CIRAS_G3_Recon",
			"PRACS_C_CIRAS_G3_rifleman",
			"PRACS_C_CIRAS_G3_grenadier",
			"PRACS_C_CIRAS_GAL_grenadier",
			"PRACS_C_CIRAS_G3_medic",
			"PRACS_C_CIRAS_GAL_medic",
			"PRACS_C_CIRAS_medic",
			"PRACS_C_CIRAS_grenadier",
			"PRACS_C_CIRAS_grenadier_SF",
			"PRACS_C_CIRAS_MG",
			"PRACS_C_CIRAS_MG_SF",
			"PRACS_RFP_CIRAS",
			"PRACS_RFP_CIRAS_rifleman",
			"PRACS_RFP_CIRAS_Recon_SF",
			"PRACS_RFP_CIRAS_SF",
			"PRACS_RFP_CIRAS_GAL_rifleman",
			"PRACS_RFP_CIRAS_SMG",
			"PRACS_RFP_CIRAS_SMG_SF",
			"PRACS_RFP_CIRAS_G3_Recon",
			"PRACS_RFP_CIRAS_G3_rifleman",
			"PRACS_RFP_CIRAS_G3_grenadier",
			"PRACS_RFP_CIRAS_GAL_grenadier",
			"PRACS_RFP_CIRAS_G3_medic",
			"PRACS_RFP_CIRAS_GAL_medic",
			"PRACS_RFP_CIRAS_medic",
			"PRACS_RFP_CIRAS_grenadier",
			"PRACS_RFP_CIRAS_grenadier_SF",
			"PRACS_RFP_CIRAS_MG",
			"PRACS_RFP_CIRAS_MG_SF",
			"PRACS_QSB_CIRAS",
			"PRACS_QSB_CIRAS_rifleman",
			"PRACS_QSB_CIRAS_Recon_SF",
			"PRACS_QSB_CIRAS_SF",
			"PRACS_QSB_CIRAS_GAL_rifleman",
			"PRACS_QSB_CIRAS_SMG",
			"PRACS_QSB_CIRAS_SMG_SF",
			"PRACS_QSB_CIRAS_G3_Recon",
			"PRACS_QSB_CIRAS_G3_rifleman",
			"PRACS_QSB_CIRAS_G3_grenadier",
			"PRACS_QSB_CIRAS_GAL_grenadier",
			"PRACS_QSB_CIRAS_G3_medic",
			"PRACS_QSB_CIRAS_GAL_medic",
			"PRACS_QSB_CIRAS_medic",
			"PRACS_QSB_CIRAS_grenadier",
			"PRACS_QSB_CIRAS_grenadier_SF",
			"PRACS_QSB_CIRAS_MG",
			"PRACS_QSB_CIRAS_MG_SF",

			"PRACS_SIS_Cap",
			"PRACS_Navy_Cap",
			"PRACS_Booniehat_6TDES",
			"PRACS_Booniehat_HS_6TDES",
			"PRACS_Booniehat_ASDPM_B",
			"PRACS_Booniehat_HS_ASDPM",
			"PRACS_Booniehat_SDPM",
			"PRACS_Booniehat_HS_SDPM",
			"PRACS_Booniehat_CSAR",
			"PRACS_Booniehat_HS_CSAR",
			"PRACS_Booniehat_GDES",
			"PRACS_Booniehat_HS_GDES",
			"PRACS_Booniehat_MDES",
			"PRACS_Booniehat_HS_MDES",
			"PRACS_Booniehat_RFP",
			"PRACS_Booniehat_HS_RFP",
			"PRACS_Booniehat_RFPG",
			"PRACS_Booniehat_HS_RFPG",
			"PRACS_Booniehat_Digital",
			"PRACS_Booniehat_HS_Digital",
			"PRACS_Booniehat_SMAR",
			"PRACS_Booniehat_HS_SMAR",
			"PRACS_Booniehat_M04",
			"PRACS_Pilot_Headset",
			"PRACS_Patrol_SDPM_Cap",
			"PRACS_Patrol_DesDPM_Cap",
			"PRACS_Patrol_CSAR_Cap",
			"PRACS_Patrol_ASDPM_B_Cap",
			"PRACS_Patrol_6TDes_Cap",
			"PRACS_Patrol_RFP_Cap",
			"PRACS_Patrol_RFP_G_Cap",
			"PRACS_Patrol_Grey6TDes_Cap",
			"PRACS_Patrol_Digital_Cap",
			"PRACS_Patrol_SMAR_Cap",
			"PRACS_LWH",
			"PRACS_LWH_ESS",
			"PRACS_LWH_HS",
			"PRACS_LWH_6TDES",
			"PRACS_LWH_ESS_6TDES",
			"PRACS_LWH_HS_6TDES",
			"PRACS_LWH_SMAR",
			"PRACS_LWH_ESS_SMAR",
			"PRACS_LWH_HS_SMAR",
			"PRACS_ACH_ASDPM",
			"PRACS_ACH_RFP_F",
			"PRACS_ACH_QSB",

			"rhs_Booniehat_m81",
			"rhsusf_Bowman",
			"rhsusf_bowman_cap",
			"rhsusf_protech_helmet",
			"rhsusf_protech_helmet_ess",
			"rhsusf_protech_helmet_rhino",
			"rhsusf_protech_helmet_rhino_ess",
			"H_ShemagOpen_khk",
			"H_ShemagOpen_tan",
			"H_Shemag_olive",
			"rhsusf_cvc_green_helmet",
			"rhsusf_cvc_green_alt_helmet",
			"rhsusf_cvc_green_ess",
			"rhsusf_cvc_helmet",
			"rhsusf_cvc_alt_helmet",
			"rhsusf_cvc_ess",
			"rhsusf_shemagh_grn",
			"rhsusf_shemagh_od",
			"rhsusf_shemagh_tan",
			"rhsusf_shemagh2_tan",
			"rhsusf_shemagh_white",
			"rhsusf_shemagh2_white",
			"rhsusf_shemagh_gogg_grn",
			"rhsusf_shemagh2_gogg_grn",
			"rhsusf_shemagh2_gogg_od",
			"rhsusf_shemagh_gogg_tan",
			"rhsusf_shemagh2_gogg_tan",
			"rhsusf_shemagh_gogg_white",
			"rhsusf_shemagh2_gogg_white",
			"rhsusf_oakley_goggles_blk",
			"rhsusf_oakley_goggles_ylw",
			"rhs_goggles_yellow",
			"rhs_goggles_clear",
			"rhs_ess_black"
		],
		// corporal uniforms
		[
			"PRACS_Flight_medic_uniform",
			"PRACS_Flight_medic_RSAF_uniform",
			"PRACS_Flight_medic_RSM_uniform",
			"PRACS_Flight_medic_RSN_uniform",
			"PRACS_air_crew_Door_Gunner_uniform",
			"PRACS_air_crew_Door_Gunner_RSAF_uniform",
			"PRACS_air_crew_Door_Gunner_RSM_uniform",
			"PRACS_air_crew_Door_Gunner_RSN_uniform",
			"PRACS_M10_1ID_TL_uniform",
			"PRACS_M10_2PARA_TL_uniform",
			"PRACS_M10_4A_TL_uniform",
			"PRACS_M10_ADA_uniform",
			"PRACS_M10_SNG_D_TL_uniform",
			"PRACS_M10_3MTN_TL_uniform",
			"PRACS_M10_CSAR_uniform",
			"PRACS_M10_Marine_Raider_uniform",
			"PRACS_M10_Marine_TL_uniform",
			"PRACS_M10_Fusilier_TL_uniform",
			"PRACS_M10_QSB_TL_uniform",
			
			"PRACS_CIRAS_GAL_TL",
			"PRACS_CIRAS_G3_TL",
			"PRACS_CIRAS_TL",
			"PRACS_O_CIRAS_TL",
			"PRACS_O_CIRAS_GAL_TL",
			"PRACS_O_CIRAS_G3_TL",
			"PRACS_C_CIRAS_G3_TL",
			"PRACS_RFP_CIRAS_TL",
			"PRACS_RFP_CIRAS_GAL_TL",
			"PRACS_RFP_CIRAS_G3_TL",
			"PRACS_QSB_CIRAS_pistol_TL",
			"PRACS_QSB_CIRAS_TL",
			"PRACS_QSB_CIRAS_GAL_TL",
			"PRACS_QSB_CIRAS_G3_TL",
			"PRACS_QSB_CIRAS_GAL_grenadier_TL",
			"PRACS_QSB_CIRAS_MG_SF_TL",

			"PRACS_Royal_Marine_beret",
			"PRACS_Royal_Fusilier_beret",
			"PRACS_QSB_beret",
			"PRACS_1st_Infantry_beret",
			"PRACS_SNG_beret",
			"PRACS_para_beret",
			"PRACS_3mtn_beret",
			"PRACS_Commando_beret",
			"PRACS_Recon_beret",
			"PRACS_4th_armored_beret",
			"PRACS_RSAF_beret",
			"PRACS_RSAF_CSAR_beret",
			"PRACS_navy_beret",
			"PRACS_HGU55_PMBU12",
			"PRACS_HGU55_PMBU12_Raised",
			"PRACS_HGU55_PMBU12_black",
			"PRACS_HGU55_Raised_PMBU12_black",
			"PRACS_HGU55_PMBU12_white",
			"PRACS_HGU55_Raised_PMBU12_white",
			"PRACS_HGU55_PMBU12_blue",
			"PRACS_HGU55_Raised_PMBU12_blue",
			"PRACS_HGU55_PMBU12_blueD",
			"PRACS_HGU55_Raised_PMBU12_blueD",
			"PRACS_HGU55_PMBU12_Orange",
			"PRACS_HGU55_Raised_PMBU12_Orange",
			"PRACS_HGU55_PMBU12_Purple",
			"PRACS_HGU55_Raised_PMBU12_Purple",
			"PRACS_HGU55_PMBU12_Red",
			"PRACS_HGU55_Raised_PMBU12_Red",
			"PRACS_HGU55_PMBU12_Red2",
			"PRACS_HGU55_Raised_PMBU12_Red2",
			"PRACS_HGU55_PMBU12_Red3",
			"PRACS_HGU55_Raised_PMBU12_Red3",
			"PRACS_HGU55_PMBU12_green",
			"PRACS_HGU55_Raised_PMBU12_green",
			"PRACS_HGU55_PMBU12_Special1",
			"PRACS_HGU55_Raised_PMBU12_Special1",
			"PRACS_HGU55_PMBU12_Special2",
			"PRACS_HGU55_Raised_PMBU12_Special2",
			"PRACS_HGU55_PMBU12_Special3",
			"PRACS_HGU55_Raised_PMBU12_Special3",
			"PRACS_HGU55_PMBU12_Special4",
			"PRACS_HGU55_Raised_PMBU12_Special4",
			"PRACS_HGU55_PMBU12_Special5",
			"PRACS_HGU55_Raised_PMBU12_Special5",
			"PRACS_HGU55_PMBU12_Special6",
			"PRACS_HGU55_Raised_PMBU12_Special6"
		],
		// sergeant uniforms
		[
			"PRACS_Jet_Pilot_uniform",
			"PRACS_G_suit_uniform",
			"PRACS_G_suit_A4_uniform",
			"PRACS_G_suit_A4_Marine_uniform",
			"PRACS_G_suit_A4_Navy_uniform",
			"PRACS_G_suit_MIII_uniform",
			"PRACS_G_suit_M5_uniform",
			"PRACS_G_suit_F16_uniform",
			"PRACS_Pilot_suit_uniform",
			"PRACS_Pilot_suit_C130_uniform",
			"PRACS_Pilot_suit_P3_uniform",
			"PRACS_Pilot_suit_E2_uniform",
			"PRACS_Pilot_suit_E2_navy_uniform",
			"PRACS_Pilot_suit_OV1_uniform",
			"PRACS_Heli_crew_pilot_uniform",
			"PRACS_Heli_crew_RSAF_uniform",
			"PRACS_Heli_crew_RSM_uniform",
			"PRACS_Heli_crew_RSN_uniform",
			"PRACS_M10_1ID_SL_uniform",
			"PRACS_M10_1ID_PSG_uniform",
			"PRACS_M10_2PARA_PFR_uniform",
			"PRACS_M10_2PARA_SL_uniform",
			"PRACS_M10_2PARA_PSG_uniform",
			"PRACS_M10_4A_SL_uniform",
			"PRACS_M10_4A_PSG_uniform",
			"PRACS_M10_Artillery_SL_uniform",
			"PRACS_M10_SNG_D_SL_uniform",
			"PRACS_M10_SNG_D_PSG_uniform",
			"PRACS_M10_3MTN_SL_uniform",
			"PRACS_M10_3MTN_PSG_uniform",
			"PRACS_M10_Digital_Commando_PSG_uniform",
			"PRACS_M10_Digital_Commando_PL_uniform",
			"PRACS_M10_Marine_SL_uniform",
			"PRACS_M10_Marine_Raider_SL_uniform",
			"PRACS_M10_Marine_PSG_uniform",
			"PRACS_M10_Recon_PSG_uniform",
			"PRACS_M10_RSAF_ground_crew_NCO_uniform",
			"PRACS_M10_Fusilier_SL_uniform",
			"PRACS_M10_Fusilier_PSG_uniform",
			"PRACS_M10_QSB_SL_uniform",
			"PRACS_M10_QSB_PSG_uniform",

			"PRACS_Jet_Pilot_harness",
			"PRACS_Jet_Pilot_vest",
			"PRACS_aircrew_flotation_vest",
			"PRACS_aircrew_vest",
			"PRACS_CIRAS_GAL_SL",
			"PRACS_CIRAS_G3_SL",
			"PRACS_CIRAS_SL",
			"PRACS_O_CIRAS_SL",
			"PRACS_O_CIRAS_GAL_SL",
			"PRACS_O_CIRAS_G3_SL",
			"PRACS_C_CIRAS_G3_SL",
			"PRACS_RFP_CIRAS_SL",
			"PRACS_RFP_CIRAS_GAL_SL",
			"PRACS_RFP_CIRAS_G3_SL",
			"PRACS_QSB_CIRAS_SMG_SF_SL",
			"PRACS_QSB_CIRAS_SL",
			"PRACS_QSB_CIRAS_GAL_SL",
			"PRACS_QSB_CIRAS_G3_SL",
			"PRACS_CIRAS_GAL_PSG",
			"PRACS_CIRAS_G3_PSG",
			"PRACS_CIRAS_PSG",
			"PRACS_O_CIRAS_PSG",
			"PRACS_O_CIRAS_GAL_PSG",
			"PRACS_O_CIRAS_G3_PSG",
			"PRACS_C_CIRAS_G3_PSG",
			"PRACS_RFP_CIRAS_PSG",
			"PRACS_RFP_CIRAS_GAL_PSG",
			"PRACS_RFP_CIRAS_G3_PSG",
			"PRACS_QSB_CIRAS_PSG",
			"PRACS_QSB_CIRAS_GAL_PSG",
			"PRACS_QSB_CIRAS_G3_PSG",

			"PRACS_ACH_ASDPM_camo",
			"PRACS_ACH_RFP_F_camo",
			"PRACS_ACH_QSB_camo",
			"PRACS_QSB_opscore",
			"PRACS_Jet_Pilot_helmet",
			"PRACS_Attack_Heli_pilot_helmet"
		],
		// lieutenant uniforms
		[
			"PRACS_M10_1ID_PL_uniform",
			"PRACS_M10_2PARA_PL_uniform",
			"PRACS_M10_4A_PL_uniform",
			"PRACS_M10_Arty_officer_uniform",
			"PRACS_M10_SNG_D_PL_uniform",
			"PRACS_M10_3MTN_PL_uniform",
			"PRACS_M10_Marine_PL_uniform",
			"PRACS_M10_RSAF_Ground_Crew_Officer_uniform",
			"PRACS_M10_RSAF_ground_crew_Commander_uniform",
			"PRACS_M10_Fusilier_PL_uniform",
			"PRACS_M10_QSB_PL_uniform",

			"PRACS_CIRAS_GAL_Officer",
			"PRACS_CIRAS_G3_Officer",
			"PRACS_CIRAS_G3_Commander",
			"PRACS_CIRAS_Officer",
			"PRACS_CIRAS_Officer_HR",
			"PRACS_O_CIRAS_Officer",
			"PRACS_O_CIRAS_Officer_HR",
			"PRACS_O_CIRAS_GAL_Officer",
			"PRACS_O_CIRAS_GAL_Commander",
			"PRACS_O_CIRAS_G3_Officer",
			"PRACS_C_CIRAS_G3_Officer",
			"PRACS_C_CIRAS_G3_Commander",
			"PRACS_RFP_CIRAS_Officer",
			"PRACS_RFP_CIRAS_Officer_HR",
			"PRACS_RFP_CIRAS_GAL_Officer",
			"PRACS_RFP_CIRAS_G3_Officer",
			"PRACS_RFP_CIRAS_G3_Commander",
			"PRACS_QSB_CIRAS_Officer",
			"PRACS_QSB_CIRAS_Officer_HR",
			"PRACS_QSB_CIRAS_GAL_Officer",
			"PRACS_QSB_CIRAS_G3_Officer",
			"PRACS_QSB_CIRAS_G3_Commander"
		],
		// captain uniforms
		[
			"PRACS_M10_1ID_CO_uniform",
			"PRACS_M10_2PARA_CO_uniform",
			"PRACS_M10_4A_CO_uniform",
			"PRACS_M10_SNG_D_CO_uniform",
			"PRACS_M10_3MTN_CO_uniform",
			"PRACS_M10_Digital_Commando_CO_uniform",
			"PRACS_M10_Marine_CO_uniform",
			"PRACS_M10_Fusilier_CO_uniform",
			"PRACS_M10_QSB_CO_uniform",
			"PRACS_Officer_Cap",
			"PRACS_RSAF_Officer_Cap",
			"PRACS_RSM_Officer_Cap",
			"PRACS_RSN_Officer_Cap"
		],
		// major uniforms
		[
			"PRACS_Police_Cap","PRACS_Police_Vest","PRACS_Police_Uniform",
			"U_B_GhillieSuit"
		],
		// colonel uniforms
		[
			"PRACS_M10_2PARA_COL_uniform",
			"PRACS_M10_4A_COL_uniform",
			"PRACS_M10_SNG_D_COL_uniform",
			"PRACS_M10_3MTN_COL_uniform",
			"PRACS_M10_Digital_Commando_COL_uniform",
			"PRACS_M10_1ID_COL_uniform",
			"PRACS_M10_Marine_COL_uniform",
			"PRACS_M10_Fusilier_COL_uniform",
			"PRACS_M10_QSB_COL_uniform",
			"U_B_FullGhillie_sard",
			"U_B_FullGhillie_ard"
		]
	],
	// additional weapons and items, no rank
	[
		1,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// private items
		[
			"ItemRadio",
			"ItemMap",
			"ItemGPS",
			"ItemCompass",
			"ItemWatch",
			"MineDetector",
			"rhsusf_bino_m24",
			(if (d_no_faks == 1) then {"FirstAidKit"} else {""}),
			"Medikit",
			"ToolKit",
			"PRACS_UavTerminal",
			"PRACS_UAV_MP",
			(if (d_without_nvg == 1) then {"rhsusf_ANPVS_14"} else {""})
		],
		// corporal items
		[
			"rhsusf_bino_lerca_1200_black",
			"rhsusf_bino_lerca_1200_tan",
			"rhsusf_bino_Leupold_Mk4"
		],
		// sergeant items
		[
		],
		// lieutenant items
		[
			"Rangefinder"
		],
		// captain items
		[
		],
		// major items
		[
		],
		// colonel items
		[
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"rhs_weap_ak74",
			"PRACS_SLA_Aks74N","PRACS_SLA_Ak74",
			"rhs_weap_aks74n"
		],
		// corporal rifles (gets added to private rifles)
		[
			"PRACS_Ak74N_ACO","PRACS_Ak74M_PLUM_ACO",
			"hgun_Pistol_heavy_01_F",
			"hgun_Pistol_heavy_01_snds_F",
			"rhs_weap_m38_rail",
			"rhs_weap_ak74_3",
			"rhs_weap_ak74_2",
			"rhs_weap_aks74",
			"rhs_weap_ak74n_2_npz",
			"rhs_weap_aks74_2",
			"rhs_weap_aks74u",
			"rhs_weap_ak74m_camo",
			"rhs_weap_ak74m_camo_dtk",
			"rhs_weap_ak74m_plummag",
			"rhs_weap_ak74m_plummag_dtk",
			"rhs_weap_ak74m_desert",
			"rhs_weap_ak74m_desert_dtk",
			"rhs_weap_ak74m_fullplum",
			"rhs_weap_ak74m_fullplum_dtk",
			"rhs_weap_ak74m_2mag",
			"rhs_weap_ak74m_2mag_dtk",
			"rhs_weap_ak74m_2mag_camo",
			"rhs_weap_ak74m_2mag_camo_dtk",
			"rhs_weap_ak74m",
			"rhs_weap_ak74m_dtk",
			"rhs_weap_45th_ak74m"

		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"PRACS_SLA_Aks74N_gp25","PRACS_SLA_Ak74_gp25","PRACS_Ak74M_GP25_ACO","PRACS_Ak74N_GP25_ACO","PRACS_Ak74M_PLUM_GP25_ACO",
			"PRACS_ak105_ACO","PRACS_Ak105_esp_1","PRACS_Ak105_esp_2",
			"PRACS_VAL_CTU","PRACS_VAL_CTU_2",
			"rhs_weap_akmn_gp25",
			"rhs_weap_akmn_gp25_npz",
			"rhs_weap_ak74m_gp25_npz",
			"rhs_weap_ak74mr_gp25",
			"rhs_weap_ak74m_fullplum_gp25_npz",
			"rhs_weap_ak103_zenitco01",
			"rhs_weap_ak103_zenitco01_b33",
			"rhs_weap_ak104_zenitco01",
			"rhs_weap_ak104_zenitco01_b33",
			"rhs_weap_ak103",
			"rhs_weap_ak103_dtk",
			"rhs_weap_45th_ak103",
			"rhs_weap_ak103_1_npz",
			"rhs_weap_ak103_2_npz",
			"rhs_weap_ak103_npz",
			"rhs_weap_ak104_npz",
			"rhs_weap_ak105_npz",
			"rhs_weap_ak103_1",
			"rhs_weap_ak103_1_dtk",
			"rhs_weap_ak103_2",
			"rhs_weap_ak103_2_dtk",
			"rhs_weap_akms_gp25",
			"rhs_weap_akm_gp25",
			"rhs_weap_45th_akm_gp25",
			"rhs_weap_aks74n_gp25",
			"rhs_weap_aks74_gp25",
			"rhs_weap_ak103_gp25",
			"rhs_weap_ak74m_gp25",
			"rhs_weap_ak74m_gp25_dtk",
			"rhs_weap_ak74m_fullplum_gp25",
			"rhs_weap_ak74m_fullplum_gp25_dtk",
			"rhs_weap_ak74_gp25",
			"rhs_weap_ak74m_fullplum_gp25_folded",
			"rhs_weap_ak74m_fullplum_gp25_npz_dtk",
			"rhs_weap_ak74m_gp25_folded",
			"rhs_weap_m84",
			"rhs_weap_asval",
			"rhs_weap_asval_grip",
			"rhs_weap_vss",
			"rhs_weap_vss_grip",
			"rhs_weap_pkm"
		],
		// lieutenant rifles (gets added to...)
		[
			"PRACS_SVDs_Recon","PRACS_SVDs_Recon_2",
			"rhs_weap_ak74m_zenitco01_b33",
			"rhs_weap_ak74m_zenitco01",
			"rhs_weap_ak105_zenitco01",
			"rhs_weap_ak105_zenitco01_b33",
			"rhs_weap_pkp",
			"rhs_weap_svdp",
			"rhs_weap_svdp_wd",
			"rhs_weap_svds",
			"arifle_AK12_F",
			"arifle_AK12_GL_F"
		],
		// captain rifles (gets added...)
		[
			"rhs_weap_savz61"
		],
		// major rifles (gets...)
		[
			"rhs_weap_t5000"
		],
		// colonel rifles (...)
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"rhs_weap_igla",
			"rhs_weap_rshg2",
			"rhs_weap_rpg26"
		],
		// corporal launchers
		[
			"rhs_weap_rpg7"
		],
		// sergeant launchers
		[
		],
		// lieutenant launchers
		[
			"rhs_weap_smaw",
			"rhs_weap_smaw_green"
		],
		// capain launchers
		[
			"rhs_weap_maaws"
		],
		// major launchers
		[

		],
		// colonel launchers
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"PISTOLS",
		// private pistols
		[
			"rhs_weap_tr8"
		],
		// corporal pistols
		[
			"rhs_weap_makarov_pm"
		],
		// sergeant pistols
		[
			"rhs_weap_pb_6p9",
			"rhs_weap_pya"
		],
		// lieutenant pistols
		[
			"rhs_weap_tt33",
			"rhs_weap_pp2000"
		],
		// captain pistols
		[

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
			"optic_ACO_grn",
			"optic_aco",
			"optic_ACO_grn_smg",
			"optic_Aco_smg",
			"rhsusf_acc_compm4",
			"rhsusf_acc_eotech_xps3",
			"rhsusf_acc_EOTECH",
			"rhsusf_acc_T1_high",
			"rhsusf_acc_T1_low",
			"rhsusf_acc_T1_low_fwd",
			"acc_pointer_IR",
			"rhsusf_acc_wmx",
			"rhsusf_acc_wmx_bk",
			"rhsusf_acc_M952V",

			"rhs_acc_ekp8_02",
			"rhs_acc_ekp8_18",
			"rhs_acc_1p87",
			"rhs_acc_ekp1",
			"rhs_acc_pkas",
			"rhs_acc_1p63",
            "rhs_acc_rakursPM"
		],
		// sergeant optics
		[
			"rhsusf_acc_ACOG2_USMC",
			"rhsusf_acc_ACOG3_USMC",
			"rhsusf_acc_ACOG_USMC",
			"rhs_weap_optic_smaw",
			"rhsusf_acc_g33_t1",
			"rhsusf_acc_g33_xps3",
			"rhsusf_acc_g33_xps3_tan",
			"rhsusf_acc_ACOG",
			"rhsusf_acc_ACOG2",
			"rhsusf_acc_ACOG3",
			"rhsusf_acc_ACOG_anpvs27",
			"rhsusf_acc_ACOG_MDO",
			"rhsusf_acc_ACOG_d",
			"rhsusf_acc_ACOG_wd",
			"rhsusf_acc_ACOG_RMR",
			"rhsusf_acc_SpecterDR",
			"rhsusf_acc_SpecterDR_OD",
			"rhsusf_acc_SpecterDR_D",
			"rhsusf_acc_SpecterDR_A",
			"acc_flashlight","optic_Holosight_smg",

			"rhs_acc_pgo7v",
			"rhs_acc_pso1m2",
			"rhs_acc_pgo7v2",
			"rhs_acc_pgo7v3",
			"rhs_acc_1p29"

		],
		// lieutenant optics
		[
			"rhsusf_acc_LEUPOLDMK4",
			"rhsusf_acc_LEUPOLDMK4_2",
			"rhsusf_acc_LEUPOLDMK4_2_d",
			"rhs_optic_maaws",
			"rhsusf_acc_M8541",
			"rhsusf_acc_M8541_low",
			"rhsusf_acc_M8541_low_d",
			"rhsusf_acc_M8541_low_wd",
			"rhsusf_acc_premier_low",
			"rhsusf_acc_premier_anpvs27",
			"rhsusf_acc_premier",
			"optic_MRD","optic_MRCO",
			"optic_ERCO_khk_F",
			"optic_ERCO_blk_F",
			"optic_ERCO_snd_F",

			"rhs_acc_pso1m21",
			"rhs_acc_1p78"
		],
		// captain optics
		[
			"optic_Aco","optic_ACO_grn","optic_Arco","optic_Hamr",
			"rhsusf_acc_anpas13gv1",
			"rhsusf_acc_anpvs27",

			"rhs_acc_dh520x56"
		],
		// major optics
		[
			"optic_Aco_smg", "optic_ACO_grn_smg", "optic_tws", "optic_tws_mg", "optic_DMS"
		],
		// colonel optics
		[
			"optic_SOS", "optic_NVS", "optic_Nightstalker", "optic_LRPS"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
			"rhsusf_acc_SF3P556",
			"rhsusf_acc_SFMB556",

			"rhs_acc_dtk",
			"rhs_acc_dtk1l",
			"rhs_acc_dtk1p",
			"rhs_acc_dtk1",
			"rhs_acc_dtk2",
			"rhs_acc_dtk3"
		],
		// corporal muzzles
		[
			"rhsusf_acc_grip2",
			"rhsusf_acc_grip2_tan",
			"rhsusf_acc_grip1",
			"rhsusf_acc_rotex_mp7_aor1",
			"rhsusf_acc_rotex_mp7",
			"rhsusf_acc_rotex_mp7_desert",
			"rhsusf_acc_rotex_mp7_winter",
			"rhsusf_acc_grip4",
			"rhsusf_acc_SR25S",
			"rhsusf_acc_grip3",
			"rhsusf_acc_grip3_tan",
			"rhsusf_acc_M2010S",
			"rhs_acc_dtk1983",
			"rhsusf_Rhino",
			"rhs_acc_pgs64",
			"rhs_acc_pgs64_74u",
			"rhs_acc_pgs64_74un",
			"rhs_acc_ak5",
			"rhs_acc_perst1ik",
			"rhs_acc_perst1ik_ris",
			"rhs_acc_perst3",
			"rhs_acc_perst3_top",
			"rhs_acc_perst3_2dp_h",
			"rhs_acc_perst3_2dp_light_h",
			"rhs_acc_2dpZenit",
			"rhs_acc_2dpZenit_ris",
			"rhs_acc_grip_rk2",
			"rhs_acc_grip_rk6"
		],
		// sergeant muzzles
		[
			"muzzle_snds_B",
			"acc_flashlight",
			"rhsusf_acc_anpeq15side",
			"rhsusf_acc_anpeq15_top",
			"rhsusf_acc_anpeq15_wmx_light",
			"rhsusf_acc_anpeq15_wmx",
			"rhsusf_acc_anpeq15side_bk",
			"rhsusf_acc_anpeq15_bk_top",
			"rhsusf_acc_anpeq15",
			"rhsusf_acc_anpeq15_light",
			"rhsusf_acc_anpeq15_bk_light",
			"rhsusf_acc_anpeq15_bk",
			"rhsusf_acc_anpeq15A",
			"rhsusf_acc_harris_bipod",
			"rhsusf_acc_nt4_tan",
			"rhsusf_acc_nt4_black",
			"rhsusf_acc_rotex5_tan",
			"rhsusf_acc_rotex5_grey",
			"rhsusf_acc_omega9k",
			"acc_flashlight_pistol",
			"rhs_acc_dtk4long",
			"rhs_acc_dtk4screws",
			"rhs_acc_dtk4short",
			"rhs_acc_tgpa",
			"rhs_acc_tgpv",
			"rhs_acc_tgpv2",
			"rhs_acc_pbs1",
			"rhs_acc_pbs4",
			"rhs_acc_harris_swivel"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_H","muzzle_snds_L", "muzzle_snds_M", "muzzle_snds_acp"
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			"muzzle_snds_H_MG"
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

			"PRACS_SLA_M88_uniform","PRACS_SLA_M88_Paratrooper_uniform",
			"PRACS_SLA_M88_Especas_uniform","PRACS_SLA_M88_Especas_Recon_uniform","PRACS_SLA_M88_Guards_uniform",
			"PRACS_SLA_M88_Tanker_uniform","PRACS_SLA_M88_Artilleryman_uniform","PRACS_SLA_M88_NAVY_uniform",
			"PRACS_SLA_Jet_Pilot_uniform",
			"PRACS_SLA_Gorka_Black_uniform",
			"PRACS_SLA_Border_Guard_uniform",

			"PRACS_SLA_6b2","PRACS_SLA_6b2_chicom","PRACS_SLA_6b2_SVD","PRACS_SLA_6b2_Holster",
			"PRACS_SLA_6B23","PRACS_SLA_6B23_O","PRACS_SLA_6B23_M",
			"PRACS_SLA_6sh92","PRACS_SLA_6sh92_R","PRACS_SLA_6sh92_R_SF","PRACS_SLA_6sh92_R_Black",
			"PRACS_SLA_6sh92_VOG","PRACS_SLA_6sh92_VOG_SF",

			"rhs_altyn_novisor",
			"rhs_altyn_novisor_ess",
			"rhs_altyn_novisor_ess_bala",
			"rhs_altyn_novisor_bala",
			"rhs_altyn_visordown",
			"rhs_altyn",
			"rhs_altyn_bala",
			"H_Bandanna_khk_hs",
			"H_Bandanna_camo",
			"H_Bandanna_sand",
			"H_Bandanna_sgg",
			"H_Bandanna_khk",
			"H_Bandanna_gry",
			"rhs_gssh18",
			"rhs_ssh68",
			"PRACS_SLA_ssh68","PRACS_SLA_ssh68_Navy","PRACS_SLA_ssh68_cover",
			"PRACS_SLA_6B27M","PRACS_SLA_6B27M_ess",
			"PRACS_SLA_Soft_Cap",
			"PRACS_SLA_NAVY_Soft_Cap",
			"PRACS_SLA_Booniehat",
			"PRACS_SLA_Booniehat_NAVY",
			"PRACS_SLA_Operator_Cap",
			"PRACS_SLA_Operator_Cap_hs",
			"rhs_tsh4_ess_bala",
			"rhs_tsh4_bala",
			"rhs_beanie_green",
			"rhs_beanie",
			"H_ShemagOpen_khk",
			"H_ShemagOpen_tan",
			"H_Shemag_olive",
			"H_Shemag_olive_hs",
			"rhs_zsh7a",
			"rhs_zsh7a_mike",
			"rhs_zsh7a_mike_green",
			"rhs_zsh7a_mike_green_alt",
			"rhs_zsh7a_alt",
			"rhs_zsh7a_mike_alt",

			"rhsusf_oakley_goggles_blk",
			"rhsusf_oakley_goggles_ylw",
			"rhs_goggles_yellow",
			"rhs_goggles_clear",
			"rhs_ess_black",
			"rhs_balaclava1_olive",
			"rhs_scarf"
		],
		// corporal uniforms
		[
			"PRACS_SLA_M88_TL_uniform",
			"PRACS_SLA_M88_Paratrooper_TL_uniform",
			"PRACS_SLA_M88_Especas_TL_uniform",
			"PRACS_SLA_M88_Guards_TL_uniform",
			"PRACS_SLA_M88_UN_uniform",
			"PRACS_SLA_M88_NAVY_TL_uniform",

			"PRACS_SLA_6B23_6sh92","PRACS_SLA_6B23_6sh92_L_Radio","PRACS_SLA_6B23_6sh92_L_Headset","PRACS_SLA_6B23_6sh92_VOG",
			"PRACS_SLA_6B23_UN",

			"PRACS_SLA_ssh68_UN",
			"PRACS_SLA_UN_beret"
		],
		// sergeant uniforms
		[
			"PRACS_SLA_M88_SL_uniform","PRACS_SLA_M88_PSG_uniform",
			"PRACS_SLA_M88_Paratrooper_SL_uniform","PRACS_SLA_M88_Paratrooper_PSG_uniform",
			"PRACS_SLA_M88_Especas_SL_uniform","PRACS_SLA_M88_Especas_PSG_uniform",
			"PRACS_SLA_M88_Especas_Recon_PSG_uniform",
			"PRACS_SLA_M88_Guards_SL_uniform","PRACS_SLA_M88_Guards_PSG_uniform",
			"PRACS_SLA_M88_NAVY_SL_uniform","PRACS_SLA_M88_NAVY_PSG_uniform",
			"PRACS_SLA_M88_UN_PSG_uniform",

			"PRACS_SLA_Especas_Beret",
			"PRACS_SLA_Guards_Beret"
		],
		// lieutenant uniforms
		[
			"PRACS_SLA_M88_O_uniform","PRACS_SLA_M88_C_uniform",
			"PRACS_SLA_M88_Paratrooper_O_uniform","PRACS_SLA_M88_Paratrooper_C_uniform",
			"PRACS_SLA_M88_Especas_O_uniform",
			"PRACS_SLA_M88_Guards_O_uniform","PRACS_SLA_M88_Guards_C_uniform",
			"PRACS_SLA_M88_Tanker_O_uniform",
			"PRACS_SLA_M88_Artilleryman_O_uniform",
			"PRACS_SLA_M88_NAVY_Officer_uniform",
			"PRACS_SLA_Border_Guard_PL_uniform"
		],
		// captain uniforms
		[
			"U_O_GhillieSuit",
			"PRACS_SLA_M88_UN_O_uniform",
			"PRACS_SLA_Border_Guard_CO_uniform",
			
			"PRACS_SLA_Generals_Cap",
			"PRACS_SLA_Border_Guard_Cap",
			"PRACS_SLA_Political_Officer_Cap"
		],
		// major uniforms
		[
			"U_O_FullGhillie_sard",
			"U_O_FullGhillie_ard"
		],
		// colonel uniforms
		[
			"PRACS_SLA_M88_G_uniform","PRACS_SLA_M88_Paratrooper_G_uniform","PRACS_SLA_M88_Guards_G_uniform",
			"PRACS_SLA_Border_Guard_GEN_uniform","PRACS_SLA_Border_Guard_PO1_uniform"
		]
	],
	// additional weapons and items, no rank
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		[
			"ItemRadio",
			"ItemMap",
			"ItemGPS",
			"ItemCompass",
			"ItemWatch",
			"MineDetector",
			"rhssaf_zrak_rd7j",
			(if (d_no_faks == 1) then {"FirstAidKit"} else {""}),
			"Medikit",
			(if (d_without_nvg == 1) then {"rhs_1PN138"} else {""}),
			"ToolKit",
			"O_UavTerminal",
			"O_UAV_01_backpack_F"
		],
		// corporal items
		[
			"rhs_pdu4"
		],
		// sergeant items
		[
		],
		// lieutenant items
		[
			"Rangefinder"
		],
		// captain items
		[
		],
		// major items
		[
		],
		// colonel items
		[
		]
	]
];

private "_all_weapons_items";
if (!d_tt_ver) then {
#ifdef __OWN_SIDE_INDEPENDENT__
	_all_weapons_items = _all_weapons_items_indep;
#endif
#ifdef __OWN_SIDE_OPFOR__
	_all_weapons_items = _all_weapons_items_opfor;
#endif
} else {
	if (side (group player) == independent) then {
		__TRACE("Player is indep")
		_all_weapons_items = _all_weapons_items_indep;
	} else {
		__TRACE("Player is opfor")
		_all_weapons_items = _all_weapons_items_opfor;
	};
};

#include "i_weapons_base.sqf"
