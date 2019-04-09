// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_rhs.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"rhs_weap_m16a4",
			"rhs_weap_m16a4_carryhandle",
			"rhs_weap_m16a4_pmag"
		],
		// corporal rifles (gets added to private rifles)
		[
			"hgun_Pistol_heavy_01_F",
			"hgun_Pistol_heavy_01_snds_F",
			"rhs_weap_m38_rail",
			"rhs_weap_m16a4_grip",
			"rhs_weap_m16a4_carryhandle_grip",
			"rhs_weap_m16a4_carryhandle_grip_pmag",
			"rhs_weap_m16a4_carryhandle_pmag",
			"rhs_weap_m16a4_carryhandle_grip3_pmag",
			"rhs_weap_m16a4_carryhandle_grip2_pmag",
			"rhs_weap_m16a4_pmag_grip2",
			"rhs_weap_m16a4_pmag_grip",
			"rhs_weap_m16a4_pmag_grip3",
			"rhs_weap_m16a4_carryhandle_grip3",
			"rhs_weap_m16a4_grip3",
			"rhs_weap_m16a4_carryhandle_grip2",
			"rhs_weap_m16a4_grip2",
			"rhs_weap_m4",
			"rhs_weap_m4_carryhandle_grip",
			"rhs_weap_m4_carryhandle_mstock_grip",
			"rhs_weap_m4_carryhandle_pmag_grip",
			"rhs_weap_m4_grip",
			"rhs_weap_m4_mstock_grip",
			"rhs_weap_m4_pmag_grip",
			"rhs_weap_m4_carryhandle",
			"rhs_weap_m4_carryhandle_pmag",
			"rhs_weap_m4_carryhandle_grip2",
			"rhs_weap_m4_carryhandle_mstock_grip2",
			"rhs_weap_m4_carryhandle_pmag_grip2",
			"rhs_weap_m4_grip2",
			"rhs_weap_m4_mstock_grip2",
			"rhs_weap_m4_pmag_grip2",
			"rhs_weap_m4_pmag",
			"rhs_weap_m4_mstock",
			"rhs_weap_m4_carryhandle_grip3",
			"rhs_weap_m4_carryhandle_mstock_grip3",
			"rhs_weap_m4_carryhandle_pmag_grip3",
			"rhs_weap_m4_grip3",
			"rhs_weap_m4_mstock_grip3",
			"rhs_weap_m4_pmag_grip3"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"rhs_weap_m16a4_carryhandle_M203",
			"rhs_weap_m16a4_carryhandle_bipod",
			"rhs_weap_m4a1_carryhandle_m203",
			"rhs_weap_m4a1_carryhandle_m203S",
			"rhs_weap_m32",
			"rhs_weap_m16a4_bipod",
			"rhs_m4_compm4",
			"rhs_weap_m4_bipod",
			"rhs_m4_grip_compm4",
			"rhs_weap_m4a1_carryhandle",
			"rhs_weap_m4a1_carryhandle_bipod",
			"rhs_weap_m4a1_carryhandle_pmag",
			"rhs_m4a1_compm4",
			"rhs_weap_m4a1",
			"rhs_weap_m4a1_carryhandle_grip",
			"rhs_weap_m4a1_carryhandle_mstock_grip",
			"rhs_weap_m4a1_carryhandle_pmag_grip",
			"rhs_weap_m4a1_grip",
			"rhs_weap_m4a1_mstock_grip",
			"rhs_weap_m4a1_pmag_grip",
			"rhs_weap_m4a1_carryhandle_grip2",
			"rhs_weap_m4a1_carryhandle_mstock_grip2",
			"rhs_weap_m4a1_carryhandle_pmag_grip2",
			"rhs_weap_m4a1_grip2",
			"rhs_weap_m4a1_mstock_grip2",
			"rhs_weap_m4a1_pmag_grip2",
			"rhs_m4a1_eotech",
			"rhs_weap_m32_usmc",
			"rhs_weap_hk416d10_LMT_wd",
			"rhs_weap_hk416d10_LMT_d",
			"rhs_weap_hk416d145_d",
			"rhs_weap_hk416d145_d_2",
			"rhs_weap_hk416d145_wd",
			"rhs_weap_hk416d145_wd_2",
			"rhs_weap_m4a1_wd_mstock",
			"rhs_weap_hk416d10",
			"rhs_weap_hk416d10_LMT",
			"rhs_weap_hk416d10_LMT_grip2",
			"rhs_weap_hk416d10_LMT_grip",
			"rhs_weap_hk416d10_LMT_grip3",
			"rhs_weap_hk416d10_grip2",
			"rhs_weap_hk416d10_grip",
			"rhs_weap_hk416d10_compm4",
			"rhs_weap_hk416d10_grip3",
			"rhs_weap_hk416d145",
			"rhs_weap_hk416d145_grip2",
			"rhs_weap_hk416d145_grip",
			"rhs_weap_hk416d145_grip3",
			"rhs_weap_m27iar",
			"rhs_weap_m27iar_grip",
			"rhs_weap_m27iar_grip2",
			"rhs_weap_m27iar_grip3",
			"rhs_weap_m4_carryhandle_mstock",
			"rhs_weap_m4a1_carryhandle_mstock",
			"rhs_m4a1_grip_compm4",
			"rhs_weap_m4a1_carryhandle_grip3",
			"rhs_m4a1_grip_eotech_soc",
			"rhs_weap_m4a1_blockII",
			"rhs_weap_m4a1_blockII_grip2",
			"rhs_weap_m4a1_blockII_grip2_d",
			"rhs_weap_m4a1_blockII_grip2_wd",
			"rhs_weap_m4a1_blockII_grip2_KAC",
			"rhs_weap_m4a1_blockII_grip2_KAC_d",
			"rhs_weap_m4a1_blockII_grip2_KAC_wd",
			"rhs_weap_m4a1_blockII_bk",
			"rhs_weap_m4a1_blockII_grip_bk",
			"rhs_weap_m4a1_blockII_grip2_bk",
			"rhs_weap_m4a1_blockII_grip2_KAC_bk",
			"rhs_weap_m4a1_blockII_KAC_bk",
			"rhs_weap_m4a1_blockII_grip_KAC_bk",
			"rhs_weap_m4a1_blockII_d",
			"rhs_weap_m4a1_blockII_grip_d",
			"rhs_weap_m4a1_blockII_KAC_d",
			"rhs_weap_m4a1_blockII_grip_KAC_d",
			"rhs_weap_m4a1_blockII_KAC",
			"rhs_weap_m4a1_blockII_grip_KAC",
			"rhs_weap_m4a1_blockII_wd",
			"rhs_weap_m4a1_blockII_grip_wd",
			"rhs_weap_m4a1_blockII_KAC_wd",
			"rhs_weap_m4a1_blockII_grip_KAC_wd",
			"rhs_weap_m4a1_blockII_grip",
			"rhs_weap_m4a1_bipod",
			"rhs_weap_m4a1_d",
			"rhs_weap_m4a1_d_grip2",
			"rhs_weap_m4a1_d_mstock_grip2",
			"rhs_weap_m4a1_d_grip",
			"rhs_weap_m4a1_d_mstock_grip",
			"rhs_weap_m4a1_d_mstock",
			"rhs_weap_m4a1_d_grip3",
			"rhs_weap_m4a1_d_mstock_grip3",
			"rhs_weap_m4a1_pmag",
			"rhs_weap_m4a1_mstock",
			"rhs_weap_m4a1_carryhandle_mstock_grip3",
			"rhs_weap_m4a1_carryhandle_pmag_grip3",
			"rhs_weap_m4a1_grip3",
			"rhs_weap_m4a1_mstock_grip3",
			"rhs_weap_m4a1_pmag_grip3",
			"rhs_weap_mk18",
			"rhs_weap_mk18_grip2",
			"rhs_weap_mk18_grip2_bk",
			"rhs_weap_mk18_grip2_d",
			"rhs_weap_mk18_grip2_wd",
			"rhs_weap_mk18_grip",
			"rhs_weap_mk18_grip_bk",
			"rhs_weap_mk18_grip_d",
			"rhs_weap_mk18_grip_wd",
			"rhs_weap_mk18_grip2_KAC",
			"rhs_weap_mk18_grip2_KAC_bk",
			"rhs_weap_mk18_grip2_KAC_d",
			"rhs_weap_mk18_grip2_KAC_wd",
			"rhs_weap_mk18_grip_KAC",
			"rhs_weap_mk18_grip_KAC_bk",
			"rhs_weap_mk18_grip_KAC_d",
			"rhs_weap_mk18_grip_KAC_wd",
			"rhs_weap_mk18_bk",
			"rhs_weap_mk18_KAC_bk",
			"rhs_weap_mk18_d",
			"rhs_weap_mk18_KAC_d",
			"rhs_weap_mk18_KAC",
			"rhs_weap_mk18_eotech",
			"rhs_weap_mk18_eotech_sup",
			"rhs_weap_mk18_wd",
			"rhs_weap_mk18_KAC_wd",
			"arifle_MX_F",
			"rhs_weap_kar98k",
			"rhs_weap_g36c",
			"rhs_weap_g36c_grip2",
			"rhs_weap_g36c_grip1",
			"rhs_weap_g36c_grip3_eo",
			"rhs_weap_g36c_grip3",
			"rhs_weap_g36c_compm4",
			"rhs_weap_g36kv",
			"rhs_weap_g36kv_grip2",
			"rhs_weap_g36kv_grip1",
			"rhs_weap_g36kv_grip3_eo",
			"rhs_weap_g36kv_grip3",
			"rhs_weap_g36kv_compm4",
			"rhs_weap_M320",
			"rhs_weap_m4a1_m203",
			"rhs_weap_m4a1_m320",
			"rhs_weap_m4a1_m203s_d",
			"rhs_weap_m4a1_m203s",
			"rhs_weap_m4_m203",
			"rhs_weap_m4_m320",
			"rhs_weap_m4_m203S",
			"rhs_weap_g36kv_ag36",
			"rhs_weap_g36kv_ag36_eo",
			"rhs_weap_hk416d10_m320",
			"rhs_weap_hk416d145_m320",
			"rhs_weap_m4a1_blockII_M203",
			"rhs_weap_m4a1_blockII_M203_bk",
			"rhs_weap_m4a1_blockII_M203_d",
			"rhs_weap_m4a1_blockII_M203_wd",
			"rhs_weap_mk18_m320",
			"rhs_weap_m249",
			"rhs_weap_m249_pip_L",
			"rhs_weap_m249_pip_L_para",
			"rhs_weap_m249_pip_L_vfg",
			"rhs_weap_m249_pip_S",
			"rhs_weap_m249_pip_S_para",
			"rhs_weap_m249_pip_S_vfg",
			"rhs_weap_minimi_para_railed",
			"LMG_03_F",
			"rhs_weap_m249_pip_S_vfg1",
			"rhs_weap_m249_pip_S_vfg2",
			"rhs_weap_m249_pip_S_vfg3",
			"rhs_weap_m249_pip",
			"rhs_weap_m249_pip_L_vfg1",
			"rhs_weap_m249_pip_L_vfg2",
			"rhs_weap_m249_pip_L_vfg3",
			"rhsusf_weap_MP7A2",
			"rhsusf_weap_MP7A2_grip1",
			"rhsusf_weap_MP7A2_grip2",
			"rhsusf_weap_MP7A2_grip3",
			"rhsusf_weap_MP7A2_aor1",
			"rhsusf_weap_MP7A2_aor1_grip1",
			"rhsusf_weap_MP7A2_aor1_grip2",
			"rhsusf_weap_MP7A2_aor1_grip3",
			"rhsusf_weap_MP7A2_desert",
			"rhsusf_weap_MP7A2_desert_grip1",
			"rhsusf_weap_MP7A2_desert_grip2",
			"rhsusf_weap_MP7A2_desert_grip3",
			"arifle_MX_GL_F", "arifle_MXM_F", "arifle_Mk20_F", "arifle_MX_GL_Black_F", "arifle_MXM_Black_F"
		],
		// lieutenant rifles (gets added to...)
		[
			"rhs_weap_m240B_CAP",
			"rhs_weap_m240G",
			"rhs_weap_m240B",
			"rhs_weap_M590_8RD",
			"rhs_weap_M590_5RD",
			"rhs_weap_sr25",
			"rhs_weap_sr25_d",
			"rhs_weap_sr25_ec",
			"rhs_weap_sr25_ec_d",
			"rhs_weap_m14ebrri"
		],
		// captain rifles (gets added...)
		[
			"rhs_weap_m24sws",
			"rhs_weap_m24sws_blk",
			"rhs_weap_m24sws_blk_leu",
			"rhs_weap_m24sws_ghillie",
			"rhs_weap_m24sws_leu",
			"rhs_weap_m40a5",
			"rhs_weap_m40a5_d",
			"rhs_weap_m40_d_usmc",
			"rhs_weap_m40a5_wd",
			"rhs_weap_m40_wd_usmc",
			"rhs_weap_XM2010",
			"rhs_weap_XM2010_wd",
			"rhs_weap_XM2010_wd_leu",
			"rhs_weap_XM2010_sa",
			"rhs_weap_XM2010_d",
			"rhs_weap_XM2010_d_leu"
		],
		// major rifles (gets...)
		[
			"rhs_weap_M107",
			"rhs_weap_M107_d",
			"rhs_weap_M107_d_premier",
			"rhs_weap_M107_d_leu",
			"rhs_weap_M107_w",
			"rhs_weap_M107_w_premier",
			"rhs_weap_M107_w_leu",
			"rhs_weap_M107_premier",
			"rhs_weap_M107_leu",
			"rhs_weap_m82a1",
			"rhs_weap_m82a1_leu"
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
			"rhs_weap_maaws"			
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
			"rhs_uniform_cu_ocp",
			"rhs_uniform_cu_ocp_101st",
			"rhs_uniform_cu_ocp_10th",
			"rhs_uniform_cu_ocp_1stcav",
			"rhs_uniform_cu_ocp_82nd",
			"rhs_uniform_cu_ucp",
			"rhs_uniform_cu_ucp_101st",
			"rhs_uniform_cu_ucp_10th",
			"rhs_uniform_cu_ucp_1stcav",
			"rhs_uniform_cu_ucp_82nd",
			"rhs_uniform_FROG01_d",
			"rhs_uniform_FROG01_wd",
			"rhs_uniform_g3_blk",
			"rhs_uniform_g3_m81",
			"rhs_uniform_g3_mc",
			"rhs_uniform_g3_rgr",
			"rhs_uniform_g3_tan",
			"rhsusf_iotv_ocp_Grenadier",
			"rhsusf_iotv_ucp_Grenadier",
			"rhsusf_iotv_ocp_Medic",
			"rhsusf_iotv_ucp_Medic",
			"rhsusf_iotv_ocp",
			"rhsusf_iotv_ocp_Repair",
			"rhsusf_iotv_ucp_Repair",
			"rhsusf_iotv_ocp_Rifleman",
			"rhsusf_iotv_ucp_Rifleman",
			"rhsusf_iotv_ocp_SAW",
			"rhsusf_iotv_ucp_SAW",
			"rhsusf_iotv_ocp_Squadleader",
			"rhsusf_iotv_ucp_Squadleader",
			"rhsusf_iotv_ocp_Teamleader",
			"rhsusf_iotv_ucp_Teamleader",
			"rhsusf_iotv_ucp",
			
			"rhsusf_ach_bare",
			"rhsusf_ach_bare_des",
			"rhsusf_ach_bare_des_ess",
			"rhsusf_ach_bare_des_headset",
			"rhsusf_ach_bare_des_headset_ess",
			"rhsusf_ach_bare_ess",
			"rhsusf_ach_bare_headset",
			"rhsusf_ach_bare_headset_ess",
			"rhsusf_ach_bare_semi",
			"rhsusf_ach_bare_semi_ess",
			"rhsusf_ach_bare_semi_headset",
			"rhsusf_ach_bare_semi_headset_ess",
			"rhsusf_ach_bare_tan",
			"rhsusf_ach_bare_tan_ess",
			"rhsusf_ach_bare_tan_headset",
			"rhsusf_ach_bare_tan_headset_ess",
			"rhsusf_ach_bare_wood",
			"rhsusf_ach_bare_wood_ess",
			"rhsusf_ach_bare_wood_headset",
			"rhsusf_ach_bare_wood_headset_ess",
			"rhsusf_ach_helmet_M81",
			"rhsusf_ach_helmet_ocp",
			"rhsusf_ach_helmet_ESS_ocp",
			"rhsusf_ach_helmet_headset_ocp",
			"rhsusf_ach_helmet_headset_ess_ocp",
			"rhsusf_ach_helmet_camo_ocp",
			"rhsusf_ach_helmet_ocp_norotos",
			"rhsusf_ach_helmet_ucp",
			"rhsusf_ach_helmet_ESS_ucp",
			"rhsusf_ach_helmet_headset_ucp",
			"rhsusf_ach_helmet_headset_ess_ucp",
			"rhsusf_ach_helmet_ucp_norotos",
			"rhs_Booniehat_m81",
			"rhs_booniehat2_marpatd",
			"rhs_booniehat2_marpatwd",
			"rhs_Booniehat_ocp",
			"rhs_Booniehat_ucp",
			"rhsusf_Bowman",
			"rhsusf_bowman_cap",
			"rhsusf_opscore_aor1",
			"rhsusf_opscore_aor1_pelt",
			"rhsusf_opscore_aor1_pelt_nsw",
			"rhsusf_opscore_aor2",
			"rhsusf_opscore_aor2_pelt",
			"rhsusf_opscore_aor2_pelt_nsw",
			"rhsusf_opscore_bk",
			"rhsusf_opscore_bk_pelt",
			"rhsusf_opscore_coy_cover",
			"rhsusf_opscore_coy_cover_pelt",
			"rhsusf_opscore_fg",
			"rhsusf_opscore_fg_pelt",
			"rhsusf_opscore_fg_pelt_cam",
			"rhsusf_opscore_fg_pelt_nsw",
			"rhsusf_opscore_mc_cover",
			"rhsusf_opscore_mc_cover_pelt",
			"rhsusf_opscore_mc_cover_pelt_nsw",
			"rhsusf_opscore_mc_cover_pelt_cam",
			"rhsusf_opscore_mc",
			"rhsusf_opscore_mc_pelt",
			"rhsusf_opscore_mc_pelt_nsw",
			"rhsusf_opscore_paint",
			"rhsusf_opscore_paint_pelt",
			"rhsusf_opscore_paint_pelt_nsw",
			"rhsusf_opscore_paint_pelt_nsw_cam",
			"rhsusf_opscore_rg_cover",
			"rhsusf_opscore_rg_cover_pelt",
			"rhsusf_opscore_ut",
			"rhsusf_opscore_ut_pelt",
			"rhsusf_opscore_ut_pelt_cam",
			"rhsusf_opscore_ut_pelt_nsw",
			"rhsusf_opscore_ut_pelt_nsw_cam",
			"rhsusf_opscore_mar_fg",
			"rhsusf_opscore_mar_fg_pelt",
			"rhsusf_opscore_mar_ut",
			"rhsusf_opscore_mar_ut_pelt",
			"rhsusf_lwh_helmet_M1942",
			"rhsusf_lwh_helmet_marpatd",
			"rhsusf_lwh_helmet_marpatd_ess",
			"rhsusf_lwh_helmet_marpatd_headset",
			"rhsusf_lwh_helmet_marpatwd",
			"rhsusf_lwh_helmet_marpatwd_blk_ess",
			"rhsusf_lwh_helmet_marpatwd_headset_blk",
			"rhsusf_lwh_helmet_marpatwd_headset",
			"rhsusf_lwh_helmet_marpatwd_ess",
			"rhsusf_mich_bare",
			"rhsusf_mich_bare_alt",
			"rhsusf_mich_bare_headset",
			"rhsusf_mich_bare_norotos",
			"rhsusf_mich_bare_norotos_alt",
			"rhsusf_mich_bare_norotos_alt_headset",
			"rhsusf_mich_bare_norotos_arc",
			"rhsusf_mich_bare_norotos_arc_alt",
			"rhsusf_mich_bare_norotos_arc_alt_headset",
			"rhsusf_mich_bare_norotos_arc_headset",
			"rhsusf_mich_bare_norotos_headset",
			"rhsusf_mich_bare_semi",
			"rhsusf_mich_bare_alt_semi",
			"rhsusf_mich_bare_semi_headset",
			"rhsusf_mich_bare_norotos_semi",
			"rhsusf_mich_bare_norotos_alt_semi",
			"rhsusf_mich_bare_norotos_alt_semi_headset",
			"rhsusf_mich_bare_norotos_arc_semi",
			"rhsusf_mich_bare_norotos_arc_alt_semi",
			"rhsusf_mich_bare_norotos_arc_alt_semi_headset",
			"rhsusf_mich_bare_norotos_arc_semi_headset",
			"rhsusf_mich_bare_norotos_semi_headset",
			"rhsusf_mich_bare_tan",
			"rhsusf_mich_bare_alt_tan",
			"rhsusf_mich_bare_tan_headset",
			"rhsusf_mich_bare_norotos_tan",
			"rhsusf_mich_bare_norotos_alt_tan",
			"rhsusf_mich_bare_norotos_alt_tan_headset",
			"rhsusf_mich_bare_norotos_arc_tan",
			"rhsusf_mich_bare_norotos_arc_alt_tan",
			"rhsusf_mich_bare_norotos_arc_alt_tan_headset",
			"rhsusf_mich_bare_norotos_tan_headset",
			"rhsusf_mich_helmet_marpatd",
			"rhsusf_mich_helmet_marpatd_alt",
			"rhsusf_mich_helmet_marpatd_alt_headset",
			"rhsusf_mich_helmet_marpatd_headset",
			"rhsusf_mich_helmet_marpatd_norotos",
			"rhsusf_mich_helmet_marpatd_norotos_arc",
			"rhsusf_mich_helmet_marpatd_norotos_arc_headset",
			"rhsusf_mich_helmet_marpatd_norotos_headset",
			"rhsusf_mich_helmet_marpatwd",
			"rhsusf_mich_helmet_marpatwd_alt",
			"rhsusf_mich_helmet_marpatwd_alt_headset",
			"rhsusf_mich_helmet_marpatwd_headset",
			"rhsusf_mich_helmet_marpatwd_norotos",
			"rhsusf_mich_helmet_marpatwd_norotos_arc",
			"rhsusf_mich_helmet_marpatwd_norotos_arc_headset",
			"rhsusf_mich_helmet_marpatwd_norotos_headset",
			"rhsusf_patrolcap_ocp",
			"rhsusf_patrolcap_ucp",
			"rhsusf_protech_helmet",
			"rhsusf_protech_helmet_ess",
			"rhsusf_protech_helmet_rhino",
			"rhsusf_protech_helmet_rhino_ess",
			"rhs_8point_marpatd",
			"rhs_8point_marpatwd",
			"H_ShemagOpen_khk",
			"H_ShemagOpen_tan",
			"H_Shemag_olive",
			"rhsusf_mbav",
			"rhsusf_mbav_grenadier",
			"rhsusf_mbav_light",
			"rhsusf_mbav_mg",
			"rhsusf_mbav_medic",
			"rhsusf_mbav_rifleman",
			"rhsusf_cvc_green_helmet",
			"rhsusf_cvc_green_alt_helmet",
			"rhsusf_cvc_green_ess",
			"rhsusf_cvc_helmet",
			"rhsusf_cvc_alt_helmet",
			"rhsusf_cvc_ess",
			"rhsusf_hgu56p_black",
			"rhsusf_hgu56p_mask_black",
			"rhsusf_hgu56p_visor_black",
			"rhsusf_hgu56p_visor_mask_black",
			"rhsusf_hgu56p_visor_mask_black_skull",
			"rhsusf_hgu56p_mask_green",
			"rhsusf_hgu56p_visor_green",
			"rhsusf_hgu56p_visor_mask_green",
			"rhsusf_hgu56p",
			"rhsusf_hgu56p_mask",
			"rhsusf_hgu56p_mask_skull",
			"rhsusf_hgu56p_visor",
			"rhsusf_hgu56p_visor_mask",
			"rhsusf_hgu56p_visor_mask_mo",
			"rhsusf_hgu56p_visor_mask_skull",
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
		],
		// sergeant uniforms
		[
			"rhsusf_spcs_ocp",
			"rhsusf_spcs_ocp_rifleman",
			"rhsusf_spcs_ucp_rifleman",
			"rhsusf_spcs_ucp",		
			"rhsusf_spc",
			"rhsusf_spc_corpsman",
			"rhsusf_spc_crewman",
			"rhsusf_spc_iar",
			"rhsusf_spc_light",
			"rhsusf_spc_mg",
			"rhsusf_spc_marksman",
			"rhsusf_spc_patchless",
			"rhsusf_spc_patchless_radio",
			"rhsusf_spc_rifleman",
			"rhsusf_spc_squadleader",
			"rhsusf_spc_teamleader"	
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
		],
		// major uniforms
		[
			"U_B_GhillieSuit"
		],
		// colonel uniforms
		[
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
			"B_UavTerminal",
			"B_UAV_01_backpack_F",
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
			"rhs_weap_aks74n"		
		],
		// corporal rifles (gets added to private rifles)
		[
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
			"rhs_uniform_gorka_r_y",
			"rhs_uniform_gorka_r_g",
			"rhs_uniform_mflora_patchless",
			"rhs_uniform_vdv_mflora",
			"rhs_uniform_df15",
			"rhs_uniform_df15_tan",
			"rhs_uniform_emr_patchless",
			"rhs_uniform_vdv_emr",
			"rhs_uniform_msv_emr",
			"rhs_uniform_emr_des_patchless",
			"rhs_uniform_vdv_emr_des",
			"rhs_uniform_mvd_izlom",
			"rhs_uniform_m88_patchless",
			"rhs_uniform_flora_patchless",
			"rhs_uniform_vdv_flora",
			"rhs_uniform_vmf_flora",
			"rhs_uniform_vmf_flora_subdued",
			"rhs_uniform_flora",
			"rhs_uniform_rva_flora",
			"rhs_uniform_flora_patchless_alt",
			"rhs_6b23",
			"rhs_6b23_ML",
			"rhs_6b23_ML_vydra_3m",
			"rhs_6b23_ML_engineer",
			"rhs_6b23_ML_medic",
			"rhs_6b23_ML_crewofficer",
			"rhs_6b23_ML_sniper",
			"rhs_6b23_ML_rifleman",
			"rhs_6b23_ML_crew",
			"rhs_6b23_ML_6sh92",
			"rhs_6b23_ML_6sh92_vog",
			"rhs_6b23_ML_6sh92_vog_headset",
			"rhs_6b23_ML_6sh92_radio",
			"rhs_6b23_ML_6sh92_headset",
			"rhs_6b23_ML_6sh92_headset_mapcase",
			"rhs_6b23_digi",
			"rhs_6b23_digi_vydra_3m",
			"rhs_6b23_digi_engineer",
			"rhs_6b23_digi_medic",
			"rhs_6b23_digi_crewofficer",
			"rhs_6b23_digi_sniper",
			"rhs_6b23_digi_rifleman",
			"rhs_6b23_digi_crew",
			"rhs_6b23_6sh116",
			"rhs_vydra_3m",
			"rhs_6sh46",
			"rhs_6b23_6sh116_vog",
			"rhs_6b23_digi_6sh92",
			"rhs_6b23_digi_6sh92_vog",
			"rhs_6b23_digi_6sh92_vog_headset",
			"rhs_6b23_digi_6sh92_radio",
			"rhs_6b23_digi_6sh92_headset",
			"rhs_6b23_digi_6sh92_headset_mapcase",
			"rhs_6b23_6sh116_flora",
			"rhs_6b23_6sh116_vog_flora",
			"rhs_6b23_vydra_3m",
			"rhs_6b23_engineer",
			"rhs_6b23_medic",
			"rhs_6b23_crewofficer",
			"rhs_6b23_sniper",
			"rhs_6b23_rifleman",
			"rhs_6b23_crew",
			"rhs_6b23_6sh116_od",
			"rhs_6b23_6sh116_vog_od",
			"rhs_6b23_6sh92",
			"rhs_6b23_6sh92_vog",
			"rhs_6b23_6sh92_vog_headset",
			"rhs_6b23_6sh92_radio",
			"rhs_6b23_6sh92_headset",
			"rhs_6b23_6sh92_headset_mapcase",
			"rhs_6b23_digi_6sh92_Vog_Radio_Spetsnaz",
			"rhs_6b23_digi_6sh92_Spetsnaz",
			"rhs_6b23_digi_6sh92_headset_spetsnaz",
			"rhs_6b43",
			"rhs_6b5_khaki",
			"rhs_6b5_vsr",
			"rhs_6b5_medic_vsr",
			"rhs_6b5_officer_vsr",
			"rhs_6b5_sniper_vsr",
			"rhs_6b5",
			"rhs_6b5_medic",
			"rhs_6b5_officer",
			"rhs_6b5_sniper",
			"rhs_6b5_ttsko",
			"rhs_6b5_medic_ttsko",
			"rhs_6b5_officer_ttsko",
			"rhs_6b5_sniper_ttsko",
			"rhs_6b5_medic_khaki",
			"rhs_6b5_officer_khaki",
			"rhs_6b5_sniper_khaki",
			"rhs_6sh92",
			"rhs_6sh92_vsr",
			"rhs_6sh92_vsr_vog",
			"rhs_6sh92_vsr_vog_headset",
			"rhs_6sh92_vsr_radio",
			"rhs_6sh92_vsr_headset",
			"rhs_6sh92_digi",
			"rhs_6sh92_digi_vog",
			"rhs_6sh92_digi_vog_headset",
			"rhs_6sh92_digi_radio",
			"rhs_6sh92_digi_headset",
			"rhs_6sh92_vog",
			"rhs_6sh92_vog_headset",
			"rhs_6sh92_radio",
			"rhs_6sh92_headset",
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
			"rhs_fieldcap",
			"rhs_fieldcap_vsr",
			"rhs_fieldcap_ml",
			"rhs_fieldcap_digi",
			"rhs_fieldcap_digi2",
			"rhs_fieldcap_khk",
			"rhs_fieldcap_helm_ml",
			"rhs_fieldcap_helm_digi",
			"rhs_fieldcap_helm",
			"rhs_ssh68",
			"rhs_tsh4_ess_bala",
			"rhs_tsh4_bala",
			"rhs_beanie_green",
			"rhs_beanie",
			"H_ShemagOpen_khk",
			"H_ShemagOpen_tan",
			"H_Shemag_olive",
			"H_Shemag_olive_hs",
			"rhs_Booniehat_digi",
			"rhs_Booniehat_flora",
			"rhs_6b26_green",
			"rhs_6b26",
			"rhs_6b26_ess",
			"rhs_6b26_ess_bala",
			"rhs_6b26_bala",
			"rhs_6b26_ess_green",
			"rhs_6b26_ess_bala_green",
			"rhs_6b26_bala_green",
			"rhs_6b27m_green",
			"rhs_6b27m_ml",
			"rhs_6b27m_ml_ess",
			"rhs_6b27m_ML_ess_bala",
			"rhs_6b27m_ml_bala",
			"rhs_6b27m_digi",
			"rhs_6b27m_digi_ess",
			"rhs_6b27m_digi_ess_bala",
			"rhs_6b27m_digi_bala",
			"rhs_6b27m",
			"rhs_6b27m_ess",
			"rhs_6b27m_ess_bala",
			"rhs_6b27m_bala",
			"rhs_6b27m_green_ess",
			"rhs_6b27m_green_ess_bala",
			"rhs_6b27m_green_bala",
			"rhs_6b28_green",
			"rhs_6b28",
			"rhs_6b28_ess",
			"rhs_6b28_ess_bala",
			"rhs_6b28_bala",
			"rhs_6b28_flora_ess",
			"rhs_6b28_flora",
			"rhs_6b28_flora_ess_bala",
			"rhs_6b28_flora_bala",
			"rhs_6b28_green_ess",
			"rhs_6b28_green_ess_bala",
			"rhs_6b28_green_bala",
			"rhs_zsh7a",
			"rhs_zsh7a_mike",
			"rhs_zsh7a_mike_green",
			"rhs_zsh7a_mike_green_alt",
			"rhs_zsh7a_alt",
			"rhs_zsh7a_mike_alt",
			"rhs_zsh12",
			"rhs_zsh12_black",
			"rhs_zsh12_bala",
			"rhs_6b47",
			"rhs_6b47_ess",
			"rhs_6b47_ess_bala",
			"rhs_6b47_bala",
			"rhs_6b7_1m_emr_ess",
			"rhs_6b7_1m_emr_ess_bala",
			"rhs_6b7_1m_ess",
			"rhs_6b7_1m_ess_bala",
			"rhs_6b7_1m",
			"rhs_6b7_1m_olive",
			"rhs_6b7_1m_bala1_olive",
			"rhs_6b7_1m_bala2_olive",
			"rhs_6b7_1m_flora",
			"rhs_6b7_1m_bala1_flora",
			"rhs_6b7_1m_bala2_flora",
			"rhs_6b7_1m_flora_ns3",
			"rhs_6b7_1m_bala1",
			"rhs_6b7_1m_bala2",
			"rhs_6b7_1m_emr",
			"rhs_6b7_1m_bala1_emr",
			"rhs_6b7_1m_bala2_emr",
			
			"rhsusf_oakley_goggles_blk",
			"rhsusf_oakley_goggles_ylw",
			"rhs_goggles_yellow",
			"rhs_goggles_clear",
			"rhs_ess_black",
			"rhs_balaclava1_olive",
			"rhs_scarf",
			
			"rhs_beret_vdv1",
			"rhs_beret_vdv2",
			"rhs_beret_vdv3",
			"rhs_beret_milp",
			"rhs_beret_mp1",
			"rhs_beret_mp2"	
		],
		// corporal uniforms
		[
			
		],
		// sergeant uniforms
		[
			"rhs_6b13_Flora",
			"rhs_6b13",
			"rhs_6b13_crewofficer",
			"rhs_6b13_6sh92",
			"rhs_6b13_6sh92_vog",
			"rhs_6b13_6sh92_radio",
			"rhs_6b13_6sh92_headset_mapcase",
			"rhs_6b13_EMR_6sh92",
			"rhs_6b13_EMR_6sh92_vog",
			"rhs_6b13_EMR_6sh92_radio",
			"rhs_6b13_EMR_6sh92_headset_mapcase",
			"rhs_6b13_EMR",
			"rhs_6b13_Flora_crewofficer",
			"rhs_6b13_Flora_6sh92",
			"rhs_6b13_Flora_6sh92_vog",
			"rhs_6b13_Flora_6sh92_radio",
			"rhs_6b13_Flora_6sh92_headset_mapcase"
					
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
			"U_O_GhillieSuit"
		],
		// major uniforms
		[
			"U_O_FullGhillie_sard",
			"U_O_FullGhillie_ard"
		],
		// colonel uniforms
		[
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
			"rhsusf_bino_m24", 
			(if (d_no_faks == 1) then {"FirstAidKit"} else {""}),
			"Medikit",
			(if (d_without_nvg == 1) then {"rhs_1PN138"} else {""}),
			"ToolKit",
			"B_UavTerminal",
			"B_UAV_01_backpack_F"
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

private ["_all_weapons_items"];
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

#include "i_weapons_base.sqf";
