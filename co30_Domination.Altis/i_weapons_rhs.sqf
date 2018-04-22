// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_rhs.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

#ifdef __OWN_SIDE_BLUFOR__
private _helipilotgear = [];
private _helipilothelmet = [];
if (d_pilots_only == 1) then {
	_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
	_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
} else {
	if (d_only_pilots_can_fly isEqualTo []) then {
		_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
		_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
	} else {
		if (str player in d_only_pilots_can_fly) then {
			_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
			_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
		};
	};
};

private _all_weapons_items = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			["rhs_weap_m16a4",1,true],
			["rhs_weap_m16a4_carryhandle",1,true],
			["rhs_weap_m16a4_pmag",1,true]
			
		],
		// corporal rifles (gets added to private rifles)
		[
			["hgun_Pistol_heavy_01_F",1,true],
			["hgun_Pistol_heavy_01_snds_F",1,true],
			["rhs_weap_m38_rail",1,true],
			["rhs_weap_m16a4_grip",1,true],
			["rhs_weap_m16a4_carryhandle_grip",1,true],
			["rhs_weap_m16a4_carryhandle_grip_pmag",1,true],	
			["rhs_weap_m16a4_carryhandle_pmag",1,true],
			["rhs_weap_m16a4_carryhandle_grip3_pmag",1,true],
			["rhs_weap_m16a4_carryhandle_grip2_pmag",1,true],
			["rhs_weap_m16a4_pmag_grip2",1,true],
			["rhs_weap_m16a4_pmag_grip",1,true],
			["rhs_weap_m16a4_pmag_grip3",1,true],
			["rhs_weap_m16a4_carryhandle_grip3",1,true],
			["rhs_weap_m16a4_grip3",1,true],
			["rhs_weap_m16a4_carryhandle_grip2",1,true],
			["rhs_weap_m16a4_grip2",1,true],
			["rhs_weap_m4",1,true],
			["rhs_weap_m4_carryhandle_grip",1,true],
			["rhs_weap_m4_carryhandle_mstock_grip",1,true],
			["rhs_weap_m4_carryhandle_pmag_grip",1,true],
			["rhs_weap_m4_grip",1,true],
			["rhs_weap_m4_mstock_grip",1,true],
			["rhs_weap_m4_pmag_grip",1,true],
			["rhs_weap_m4_carryhandle",1,true],
			["rhs_weap_m4_carryhandle_pmag",1,true],
			["rhs_weap_m4_carryhandle_grip2",1,true],
			["rhs_weap_m4_carryhandle_mstock_grip2",1,true],
			["rhs_weap_m4_carryhandle_pmag_grip2",1,true],
			["rhs_weap_m4_grip2",1,true],
			["rhs_weap_m4_mstock_grip2",1,true],
			["rhs_weap_m4_pmag_grip2",1,true],
			["rhs_weap_m4_pmag",1,true],
			["rhs_weap_m4_mstock",1,true],
			["rhs_weap_m4_carryhandle_grip3",1,true],
			["rhs_weap_m4_carryhandle_mstock_grip3",1,true],
			["rhs_weap_m4_carryhandle_pmag_grip3",1,true],
			["rhs_weap_m4_grip3",1,true],
			["rhs_weap_m4_mstock_grip3",1,true],
			["rhs_weap_m4_pmag_grip3",1,true]
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			["rhs_weap_m16a4_carryhandle_M203",1,true],
			["rhs_weap_m16a4_carryhandle_bipod",1,true],
			["rhs_weap_m4a1_carryhandle_m203",1,true],
			["rhs_weap_m4a1_carryhandle_m203S",1,true],
			["rhs_weap_m32",1,true],
			["rhs_weap_m16a4_bipod",1,true],
			["rhs_m4_compm4",1,true],
			["rhs_weap_m4_bipod",1,true],
			["rhs_m4_grip_compm4",1,true],
			["rhs_weap_m4a1_carryhandle",1,true],
			["rhs_weap_m4a1_carryhandle_bipod",1,true],
			["rhs_weap_m4a1_carryhandle_pmag",1,true],
			["rhs_m4a1_compm4",1,true],
			["rhs_weap_m4a1",1,true],
			["rhs_weap_m4a1_carryhandle_grip",1,true],
			["rhs_weap_m4a1_carryhandle_mstock_grip",1,true],
			["rhs_weap_m4a1_carryhandle_pmag_grip",1,true],
			["rhs_weap_m4a1_grip",1,true],
			["rhs_weap_m4a1_mstock_grip",1,true],
			["rhs_weap_m4a1_pmag_grip",1,true],
			["rhs_weap_m4a1_carryhandle_grip2",1,true],
			["rhs_weap_m4a1_carryhandle_mstock_grip2",1,true],
			["rhs_weap_m4a1_carryhandle_pmag_grip2",1,true],
			["rhs_weap_m4a1_grip2",1,true],
			["rhs_weap_m4a1_mstock_grip2",1,true],
			["rhs_weap_m4a1_pmag_grip2",1,true],
			["rhs_m4a1_eotech",1,true],
			["rhs_weap_m32_usmc",1,true],
			["rhs_weap_hk416d10_LMT_wd",1,true],
			["rhs_weap_hk416d10_LMT_d",1,true],
			["rhs_weap_hk416d145_d",1,true],
			["rhs_weap_hk416d145_d_2",1,true],
			["rhs_weap_hk416d145_wd",1,true],
			["rhs_weap_hk416d145_wd_2",1,true],
			["rhs_weap_m4a1_wd_mstock",1,true],
			["rhs_weap_hk416d10",1,true],
			["rhs_weap_hk416d10_LMT",1,true],
			["rhs_weap_hk416d10_LMT_grip2",1,true],
			["rhs_weap_hk416d10_LMT_grip",1,true],
			["rhs_weap_hk416d10_LMT_grip3",1,true],
			["rhs_weap_hk416d10_grip2",1,true],
			["rhs_weap_hk416d10_grip",1,true],
			["rhs_weap_hk416d10_compm4",1,true],
			["rhs_weap_hk416d10_grip3",1,true],
			["rhs_weap_hk416d145",1,true],
			["rhs_weap_hk416d145_grip2",1,true],
			["rhs_weap_hk416d145_grip",1,true],
			["rhs_weap_hk416d145_grip3",1,true],
			["rhs_weap_m27iar",1,true],
			["rhs_weap_m27iar_grip",1,true],
			["rhs_weap_m27iar_grip2",1,true],
			["rhs_weap_m27iar_grip3",1,true],
			["rhs_weap_m4_carryhandle_mstock",1,true],
			["rhs_weap_m4a1_carryhandle_mstock",1,true],
			["rhs_m4a1_grip_compm4",1,true],
			["rhs_weap_m4a1_carryhandle_grip3",1,true],
			["rhs_m4a1_grip_eotech_soc",1,true],
			["rhs_weap_m4a1_blockII",1,true],
			["rhs_weap_m4a1_blockII_grip2",1,true],
			["rhs_weap_m4a1_blockII_grip2_d",1,true],
			["rhs_weap_m4a1_blockII_grip2_wd",1,true],
			["rhs_weap_m4a1_blockII_grip2_KAC",1,true],
			["rhs_weap_m4a1_blockII_grip2_KAC_d",1,true],
			["rhs_weap_m4a1_blockII_grip2_KAC_wd",1,true],
			["rhs_weap_m4a1_blockII_bk",1,true],
			["rhs_weap_m4a1_blockII_grip_bk",1,true],
			["rhs_weap_m4a1_blockII_grip2_bk",1,true],
			["rhs_weap_m4a1_blockII_grip2_KAC_bk",1,true],
			["rhs_weap_m4a1_blockII_KAC_bk",1,true],
			["rhs_weap_m4a1_blockII_grip_KAC_bk",1,true],
			["rhs_weap_m4a1_blockII_d",1,true],
			["rhs_weap_m4a1_blockII_grip_d",1,true],
			["rhs_weap_m4a1_blockII_KAC_d",1,true],
			["rhs_weap_m4a1_blockII_grip_KAC_d",1,true],
			["rhs_weap_m4a1_blockII_KAC",1,true],
			["rhs_weap_m4a1_blockII_grip_KAC",1,true],
			["rhs_weap_m4a1_blockII_wd",1,true],
			["rhs_weap_m4a1_blockII_grip_wd",1,true],
			["rhs_weap_m4a1_blockII_KAC_wd",1,true],
			["rhs_weap_m4a1_blockII_grip_KAC_wd",1,true],
			["rhs_weap_m4a1_blockII_grip",1,true],
			["rhs_weap_m4a1_bipod",1,true],
			["rhs_weap_m4a1_d",1,true],
			["rhs_weap_m4a1_d_grip2",1,true],
			["rhs_weap_m4a1_d_mstock_grip2",1,true],
			["rhs_weap_m4a1_d_grip",1,true],
			["rhs_weap_m4a1_d_mstock_grip",1,true],
			["rhs_weap_m4a1_d_mstock",1,true],
			["rhs_weap_m4a1_d_grip3",1,true],
			["rhs_weap_m4a1_d_mstock_grip3",1,true],
			["rhs_weap_m4a1_pmag",1,true],
			["rhs_weap_m4a1_mstock",1,true],
			["rhs_weap_m4a1_carryhandle_mstock_grip3",1,true],
			["rhs_weap_m4a1_carryhandle_pmag_grip3",1,true],
			["rhs_weap_m4a1_grip3",1,true],
			["rhs_weap_m4a1_mstock_grip3",1,true],
			["rhs_weap_m4a1_pmag_grip3",1,true],
			["rhs_weap_mk18",1,true],
			["rhs_weap_mk18_grip2",1,true],
			["rhs_weap_mk18_grip2_bk",1,true],
			["rhs_weap_mk18_grip2_d",1,true],
			["rhs_weap_mk18_grip2_wd",1,true],
			["rhs_weap_mk18_grip",1,true],
			["rhs_weap_mk18_grip_bk",1,true],
			["rhs_weap_mk18_grip_d",1,true],
			["rhs_weap_mk18_grip_wd",1,true],
			["rhs_weap_mk18_grip2_KAC",1,true],
			["rhs_weap_mk18_grip2_KAC_bk",1,true],
			["rhs_weap_mk18_grip2_KAC_d",1,true],
			["rhs_weap_mk18_grip2_KAC_wd",1,true],
			["rhs_weap_mk18_grip_KAC",1,true],
			["rhs_weap_mk18_grip_KAC_bk",1,true],
			["rhs_weap_mk18_grip_KAC_d",1,true],
			["rhs_weap_mk18_grip_KAC_wd",1,true],
			["rhs_weap_mk18_bk",1,true],
			["rhs_weap_mk18_KAC_bk",1,true],
			["rhs_weap_mk18_d",1,true],
			["rhs_weap_mk18_KAC_d",1,true],
			["rhs_weap_mk18_KAC",1,true],
			["rhs_weap_mk18_eotech",1,true],
			["rhs_weap_mk18_eotech_sup",1,true],
			["rhs_weap_mk18_wd",1,true],
			["rhs_weap_mk18_KAC_wd",1,true],
			["arifle_MX_F",1,true],
			["rhs_weap_kar98k",1,true],
			["rhs_weap_g36c",1,true],
			["rhs_weap_g36c_grip2",1,true],
			["rhs_weap_g36c_grip1",1,true],
			["rhs_weap_g36c_grip3_eo",1,true],
			["rhs_weap_g36c_grip3",1,true],
			["rhs_weap_g36c_compm4",1,true],
			["rhs_weap_g36kv",1,true],
			["rhs_weap_g36kv_grip2",1,true],
			["rhs_weap_g36kv_grip1",1,true],
			["rhs_weap_g36kv_grip3_eo",1,true],
			["rhs_weap_g36kv_grip3",1,true],
			["rhs_weap_g36kv_compm4",1,true],
			["rhs_weap_M320",1,true],
			["rhs_weap_m4a1_m203",1,true],
			["rhs_weap_m4a1_m320",1,true],
			["rhs_weap_m4a1_m203s_d",1,true],
			["rhs_weap_m4a1_m203s",1,true],
			["rhs_weap_m4_m203",1,true],
			["rhs_weap_m4_m320",1,true],
			["rhs_weap_m4_m203S",1,true],
			["rhs_weap_g36kv_ag36",1,true],
			["rhs_weap_g36kv_ag36_eo",1,true],
			["rhs_weap_hk416d10_m320",1,true],
			["rhs_weap_hk416d145_m320",1,true],
			["rhs_weap_m4a1_blockII_M203",1,true],
			["rhs_weap_m4a1_blockII_M203_bk",1,true],
			["rhs_weap_m4a1_blockII_M203_d",1,true],
			["rhs_weap_m4a1_blockII_M203_wd",1,true],
			["rhs_weap_mk18_m320",1,true],
			["rhs_weap_m249",1,true],
			["rhs_weap_m249_pip_L",1,true],
			["rhs_weap_m249_pip_L_para",1,true],
			["rhs_weap_m249_pip_L_vfg",1,true],
			["rhs_weap_m249_pip_S",1,true],
			["rhs_weap_m249_pip_S_para",1,true],
			["rhs_weap_m249_pip_S_vfg",1,true],
			["rhs_weap_minimi_para_railed",1,true],
			["LMG_03_F",1,true],
			["rhs_weap_m249_pip_S_vfg1",1,true],
			["rhs_weap_m249_pip_S_vfg2",1,true],
			["rhs_weap_m249_pip_S_vfg3",1,true],
			["rhs_weap_m249_pip",1,true],
			["rhs_weap_m249_pip_L_vfg1",1,true],
			["rhs_weap_m249_pip_L_vfg2",1,true],
			["rhs_weap_m249_pip_L_vfg3",1,true],
			["rhsusf_weap_MP7A2",1,true],
			["rhsusf_weap_MP7A2_grip1",1,true],
			["rhsusf_weap_MP7A2_grip2",1,true],
			["rhsusf_weap_MP7A2_grip3",1,true],
			["rhsusf_weap_MP7A2_aor1",1,true],
			["rhsusf_weap_MP7A2_aor1_grip1",1,true],
			["rhsusf_weap_MP7A2_aor1_grip2",1,true],
			["rhsusf_weap_MP7A2_aor1_grip3",1,true],
			["rhsusf_weap_MP7A2_desert",1,true],
			["rhsusf_weap_MP7A2_desert_grip1",1,true],
			["rhsusf_weap_MP7A2_desert_grip2",1,true],
			["rhsusf_weap_MP7A2_desert_grip3",1,true],
			["arifle_MX_GL_F",1,true], ["arifle_MXM_F",1,true], ["arifle_Mk20_F",1,true], ["arifle_MX_GL_Black_F",1,true], ["arifle_MXM_Black_F",1,true]
		],
		// lieutenant rifles (gets added to...)
		[
			["rhs_weap_m240B_CAP",1,true],
			["rhs_weap_m240G",1,true],
			["rhs_weap_m240B",1,true],
			["rhs_weap_M590_8RD",1,true],
			["rhs_weap_M590_5RD",1,true],
			["rhs_weap_sr25",1,true],
			["rhs_weap_sr25_d",1,true],
			["rhs_weap_sr25_ec",1,true],
			["rhs_weap_sr25_ec_d",1,true],
			["rhs_weap_m14ebrri",1,true]
		],
		// captain rifles (gets added...)
		[
			["rhs_weap_m24sws",1,true],
			["rhs_weap_m24sws_blk",1,true],
			["rhs_weap_m24sws_blk_leu",1,true],
			["rhs_weap_m24sws_ghillie",1,true],
			["rhs_weap_m24sws_leu",1,true],
			["rhs_weap_m40a5",1,true],
			["rhs_weap_m40a5_d",1,true],
			["rhs_weap_m40_d_usmc",1,true],
			["rhs_weap_m40a5_wd",1,true],
			["rhs_weap_m40_wd_usmc",1,true],
			["rhs_weap_XM2010",1,true],
			["rhs_weap_XM2010_wd",1,true],
			["rhs_weap_XM2010_wd_leu",1,true],
			["rhs_weap_XM2010_sa",1,true],
			["rhs_weap_XM2010_d",1,true],
			["rhs_weap_XM2010_d_leu",1,true]
		],
		// major rifles (gets...)
		[
			["rhs_weap_M107",1,true],
			["rhs_weap_M107_d",1,true],
			["rhs_weap_M107_d_premier",1,true],
			["rhs_weap_M107_d_leu",1,true],
			["rhs_weap_M107_w",1,true],
			["rhs_weap_M107_w_premier",1,true],
			["rhs_weap_M107_w_leu",1,true],
			["rhs_weap_M107_premier",1,true],
			["rhs_weap_M107_leu",1,true],
			["rhs_weap_m82a1",1,true],
			["rhs_weap_m82a1_leu",1,true]
		],
		// colonel rifles (...)
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private sniper rifles
		[
		],
		// corporal sniper rifles
		[
		],
		// sergeant sniper rifles
		[
		],
		// lieutenant sniper rifles
		[
		],
		// captain sniper rifles
		[
		],
		// major sniper rifles
		[
		],
		// colonel sniper rifles
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private MG
		[
		],
		// corporal MG
		[
		],
		// sergeant MG
		[
		],
		// lieutenant MG
		[
		],
		// captain MG
		[
		],
		// major MG
		[
		],
		// colonel MG
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			["rhs_weap_fim92",1,true],
			["rhs_weap_m72a7",1,true]
		],
		// corporal launchers
		[
			["rhs_weap_M136",1,true],
			["rhs_weap_M136_hedp",1,true],
			["rhs_weap_M136_hp",1,true]
		],
		// sergeant launchers
		[
			["rhs_weap_smaw",1,true],
			["rhs_weap_smaw_green",1,true]		
		],
		// lieutenant launchers
		[
			["rhs_weap_maaws",1,true]			
		],
		// capain launchers
		[
		],
		// major launchers
		[
		],
		// colonel launchers
		[
			["rhs_weap_fgm148",1,true]
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
			["rhsusf_weap_glock17g4",1,true]
		],
		// lieutenant pistols
		[
			["rhsusf_weap_m9",1,true]
		],
		// captain pistols
		[
			["rhsusf_weap_m1911a1",1,true]
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
			["optic_ACO_grn",1,true],
			["optic_aco",1,true],
			["optic_ACO_grn_smg",1,true],
			["optic_Aco_smg",1,true],
			["rhsusf_acc_T1_high",1,true],
			["rhsusf_acc_T1_low",1,true],
			["rhsusf_acc_T1_low_fwd",1,true],
			["rhsusf_acc_compm4",1,true],
			["rhsusf_acc_eotech_xps3",1,true],
			["rhsusf_acc_EOTECH",1,true],
			["rhsusf_acc_wmx",1,true],
			["rhsusf_acc_wmx_bk",1,true],
			["rhsusf_acc_M952V",1,true],
			["acc_pointer_IR",1,true]
		],
		// sergeant optics
		[
			["rhsusf_acc_ACOG2_USMC",1,true],
			["rhsusf_acc_ACOG3_USMC",1,true],
			["rhsusf_acc_ACOG_USMC",1,true],
			["rhs_weap_optic_smaw",1,true],
			["rhsusf_acc_g33_t1",1,true],
			["rhsusf_acc_g33_xps3",1,true],
			["rhsusf_acc_g33_xps3_tan",1,true],
			["rhsusf_acc_ACOG",1,true],
			["rhsusf_acc_ACOG2",1,true],
			["rhsusf_acc_ACOG3",1,true],
			["rhsusf_acc_ACOG_anpvs27",1,true],
			["rhsusf_acc_ACOG_MDO",1,true],
			["rhsusf_acc_ACOG_d",1,true],
			["rhsusf_acc_ACOG_wd",1,true],
			["rhsusf_acc_ACOG_RMR",1,true],
			["rhsusf_acc_SpecterDR",1,true],
			["rhsusf_acc_SpecterDR_OD",1,true],
			["rhsusf_acc_SpecterDR_D",1,true],
			["rhsusf_acc_SpecterDR_A",1,true],
			["acc_flashlight",1,true],["optic_Holosight_smg",1,true]
		],
		// lieutenant optics
		[
			["rhsusf_acc_LEUPOLDMK4",1,true],
			["rhsusf_acc_LEUPOLDMK4_2",1,true],
			["rhsusf_acc_LEUPOLDMK4_2_d",1,true],
			["rhs_optic_maaws",1,true],		
			["rhsusf_acc_M8541",1,true],
			["rhsusf_acc_M8541_low",1,true],
			["rhsusf_acc_M8541_low_d",1,true],
			["rhsusf_acc_M8541_low_wd",1,true],
			["rhsusf_acc_premier_low",1,true],
			["rhsusf_acc_premier_anpvs27",1,true],
			["rhsusf_acc_premier",1,true],
			["optic_MRD",1,true],["optic_MRCO",1,true],
			["optic_ERCO_khk_F",1,true],
			["optic_ERCO_blk_F",1,true],
			["optic_ERCO_snd_F",1,true]
		],
		// captain optics
		[
			["optic_Hamr",1,true],
			["rhsusf_acc_anpas13gv1",1,true],
			["rhsusf_acc_anpvs27",1,true]
		],
		// major optics
		[
			["LaserDesignator",1,true], ["optic_Aco_smg",1,true], ["optic_ACO_grn_smg",1,true], ["optic_tws",1,true], ["optic_tws_mg",1,true], ["optic_DMS",1,true]
		],
		// colonel optics
		[
			["optic_SOS",1,true], ["optic_NVS",1,true], ["optic_Nightstalker",1,true], ["optic_LRPS",1,true]
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
			["rhsusf_acc_SF3P556",1,true],
			["rhsusf_acc_SFMB556",1,true]
		],
		// corporal muzzles
		[
			["rhsusf_acc_grip2",1,true],
			["rhsusf_acc_grip2_tan",1,true],
			["rhsusf_acc_grip1",1,true],
			["rhsusf_acc_grip3",1,true],
			["rhsusf_acc_grip3_tan",1,true]
		],
		// sergeant muzzles
		[
			["acc_flashlight",1,true],
			["rhsusf_acc_anpeq15side",1,true],
			["rhsusf_acc_anpeq15_top",1,true],
			["rhsusf_acc_anpeq15_wmx_light",1,true],
			["rhsusf_acc_anpeq15_wmx",1,true],
			["rhsusf_acc_anpeq15side_bk",1,true],
			["rhsusf_acc_anpeq15_bk_top",1,true],
			["rhsusf_acc_anpeq15",1,true],
			["rhsusf_acc_anpeq15_light",1,true],
			["rhsusf_acc_anpeq15_bk_light",1,true],
			["rhsusf_acc_anpeq15_bk",1,true],
			["rhsusf_acc_anpeq15A",1,true],
			["rhsusf_acc_harris_bipod",1,true],
			["rhsusf_acc_nt4_tan",1,true],
			["rhsusf_acc_nt4_black",1,true],
			["rhsusf_acc_rotex5_tan",1,true],
			["rhsusf_acc_rotex5_grey",1,true],
			["rhsusf_acc_rotex_mp7_aor1",1,true],
			["rhsusf_acc_rotex_mp7",1,true],
			["rhsusf_acc_rotex_mp7_desert",1,true],
			["rhsusf_acc_rotex_mp7_winter",1,true],
			["rhsusf_acc_grip4",1,true],
			["acc_flashlight_pistol",1,true],
			["rhsusf_acc_omega9k",1,true],
			["rhsusf_acc_SR25S",1,true],
			["rhsusf_acc_M2010S",1,true],
			["rhs_acc_dtk",1,true],
			["rhs_acc_dtk1983",1,true],
			["rhs_acc_dtk1l",1,true],
			["rhs_acc_dtk1p",1,true],
			["rhs_acc_dtk1",1,true],
			["rhs_acc_dtk2",1,true],
			["rhs_acc_dtk3",1,true],
			["rhs_acc_dtk4short",1,true],
			["rhs_acc_dtk4screws",1,true],
			["rhs_acc_dtk4long",1,true],
			["rhsusf_ANPVS_14",1,true],
			["rhsusf_ANPVS_15",1,true],
			["rhsusf_Rhino",1,true]
		],
		// lieutenant muzzles
		[
			["muzzle_snds_B",1, true], ["muzzle_snds_H",1, true],["muzzle_snds_L",1, true], ["muzzle_snds_M",1, true], ["muzzle_snds_acp", 1, true]
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			["muzzle_snds_H_MG",1, true]
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
			["rhs_uniform_cu_ocp",1],
			["rhs_uniform_cu_ocp_101st",1],
			["rhs_uniform_cu_ocp_10th",1],
			["rhs_uniform_cu_ocp_1stcav",1],
			["rhs_uniform_cu_ocp_82nd",1],
			["rhs_uniform_cu_ucp",1],
			["rhs_uniform_cu_ucp_101st",1],
			["rhs_uniform_cu_ucp_10th",1],
			["rhs_uniform_cu_ucp_1stcav",1],
			["rhs_uniform_cu_ucp_82nd",1],
			["rhs_uniform_FROG01_d",1],
			["rhs_uniform_FROG01_wd",1],
			["rhs_uniform_g3_blk",1],
			["rhs_uniform_g3_m81",1],
			["rhs_uniform_g3_mc",1],
			["rhs_uniform_g3_rgr",1],
			["rhs_uniform_g3_tan",1],
			["rhsusf_iotv_ocp_Grenadier",1],
			["rhsusf_iotv_ucp_Grenadier",1],
			["rhsusf_iotv_ocp_Medic",1],
			["rhsusf_iotv_ucp_Medic",1],
			["rhsusf_iotv_ocp",1],
			["rhsusf_iotv_ocp_Repair",1],
			["rhsusf_iotv_ucp_Repair",1],
			["rhsusf_iotv_ocp_Rifleman",1],
			["rhsusf_iotv_ucp_Rifleman",1],
			["rhsusf_iotv_ocp_SAW",1],
			["rhsusf_iotv_ucp_SAW",1],
			["rhsusf_iotv_ocp_Squadleader",1],
			["rhsusf_iotv_ucp_Squadleader",1],
			["rhsusf_iotv_ocp_Teamleader",1],
			["rhsusf_iotv_ucp_Teamleader",1],
			["rhsusf_iotv_ucp",1],
			
			["rhsusf_ach_bare",1],
			["rhsusf_ach_bare_des",1],
			["rhsusf_ach_bare_des_ess",1],
			["rhsusf_ach_bare_des_headset",1],
			["rhsusf_ach_bare_des_headset_ess",1],
			["rhsusf_ach_bare_ess",1],
			["rhsusf_ach_bare_headset",1],
			["rhsusf_ach_bare_headset_ess",1],
			["rhsusf_ach_bare_semi",1],
			["rhsusf_ach_bare_semi_ess",1],
			["rhsusf_ach_bare_semi_headset",1],
			["rhsusf_ach_bare_semi_headset_ess",1],
			["rhsusf_ach_bare_tan",1],
			["rhsusf_ach_bare_tan_ess",1],
			["rhsusf_ach_bare_tan_headset",1],
			["rhsusf_ach_bare_tan_headset_ess",1],
			["rhsusf_ach_bare_wood",1],
			["rhsusf_ach_bare_wood_ess",1],
			["rhsusf_ach_bare_wood_headset",1],
			["rhsusf_ach_bare_wood_headset_ess",1],
			["rhsusf_ach_helmet_M81",1],
			["rhsusf_ach_helmet_ocp",1],
			["rhsusf_ach_helmet_ESS_ocp",1],
			["rhsusf_ach_helmet_headset_ocp",1],
			["rhsusf_ach_helmet_headset_ess_ocp",1],
			["rhsusf_ach_helmet_camo_ocp",1],
			["rhsusf_ach_helmet_ocp_norotos",1],
			["rhsusf_ach_helmet_ucp",1],
			["rhsusf_ach_helmet_ESS_ucp",1],
			["rhsusf_ach_helmet_headset_ucp",1],
			["rhsusf_ach_helmet_headset_ess_ucp",1],
			["rhsusf_ach_helmet_ucp_norotos",1],
			["rhs_Booniehat_m81",1],
			["rhs_booniehat2_marpatd",1],
			["rhs_booniehat2_marpatwd",1],
			["rhs_Booniehat_ocp",1],
			["rhs_Booniehat_ucp",1],
			["rhsusf_Bowman",1],
			["rhsusf_bowman_cap",1],
			["rhsusf_opscore_aor1",1],
			["rhsusf_opscore_aor1_pelt",1],
			["rhsusf_opscore_aor1_pelt_nsw",1],
			["rhsusf_opscore_aor2",1],
			["rhsusf_opscore_aor2_pelt",1],
			["rhsusf_opscore_aor2_pelt_nsw",1],
			["rhsusf_opscore_bk",1],
			["rhsusf_opscore_bk_pelt",1],
			["rhsusf_opscore_coy_cover",1],
			["rhsusf_opscore_coy_cover_pelt",1],
			["rhsusf_opscore_fg",1],
			["rhsusf_opscore_fg_pelt",1],
			["rhsusf_opscore_fg_pelt_cam",1],
			["rhsusf_opscore_fg_pelt_nsw",1],
			["rhsusf_opscore_mc_cover",1],
			["rhsusf_opscore_mc_cover_pelt",1],
			["rhsusf_opscore_mc_cover_pelt_nsw",1],
			["rhsusf_opscore_mc_cover_pelt_cam",1],
			["rhsusf_opscore_mc",1],
			["rhsusf_opscore_mc_pelt",1],
			["rhsusf_opscore_mc_pelt_nsw",1],
			["rhsusf_opscore_paint",1],
			["rhsusf_opscore_paint_pelt",1],
			["rhsusf_opscore_paint_pelt_nsw",1],
			["rhsusf_opscore_paint_pelt_nsw_cam",1],
			["rhsusf_opscore_rg_cover",1],
			["rhsusf_opscore_rg_cover_pelt",1],
			["rhsusf_opscore_ut",1],
			["rhsusf_opscore_ut_pelt",1],
			["rhsusf_opscore_ut_pelt_cam",1],
			["rhsusf_opscore_ut_pelt_nsw",1],
			["rhsusf_opscore_ut_pelt_nsw_cam",1],
			["rhsusf_opscore_mar_fg",1],
			["rhsusf_opscore_mar_fg_pelt",1],
			["rhsusf_opscore_mar_ut",1],
			["rhsusf_opscore_mar_ut_pelt",1],
			["rhsusf_lwh_helmet_M1942",1],
			["rhsusf_lwh_helmet_marpatd",1],
			["rhsusf_lwh_helmet_marpatd_ess",1],
			["rhsusf_lwh_helmet_marpatd_headset",1],
			["rhsusf_lwh_helmet_marpatwd",1],
			["rhsusf_lwh_helmet_marpatwd_blk_ess",1],
			["rhsusf_lwh_helmet_marpatwd_headset_blk",1],
			["rhsusf_lwh_helmet_marpatwd_headset",1],
			["rhsusf_lwh_helmet_marpatwd_ess",1],
			["rhsusf_mich_bare",1],
			["rhsusf_mich_bare_alt",1],
			["rhsusf_mich_bare_headset",1],
			["rhsusf_mich_bare_norotos",1],
			["rhsusf_mich_bare_norotos_alt",1],
			["rhsusf_mich_bare_norotos_alt_headset",1],
			["rhsusf_mich_bare_norotos_arc",1],
			["rhsusf_mich_bare_norotos_arc_alt",1],
			["rhsusf_mich_bare_norotos_arc_alt_headset",1],
			["rhsusf_mich_bare_norotos_arc_headset",1],
			["rhsusf_mich_bare_norotos_headset",1],
			["rhsusf_mich_bare_semi",1],
			["rhsusf_mich_bare_alt_semi",1],
			["rhsusf_mich_bare_semi_headset",1],
			["rhsusf_mich_bare_norotos_semi",1],
			["rhsusf_mich_bare_norotos_alt_semi",1],
			["rhsusf_mich_bare_norotos_alt_semi_headset",1],
			["rhsusf_mich_bare_norotos_arc_semi",1],
			["rhsusf_mich_bare_norotos_arc_alt_semi",1],
			["rhsusf_mich_bare_norotos_arc_alt_semi_headset",1],
			["rhsusf_mich_bare_norotos_arc_semi_headset",1],
			["rhsusf_mich_bare_norotos_semi_headset",1],
			["rhsusf_mich_bare_tan",1],
			["rhsusf_mich_bare_alt_tan",1],
			["rhsusf_mich_bare_tan_headset",1],
			["rhsusf_mich_bare_norotos_tan",1],
			["rhsusf_mich_bare_norotos_alt_tan",1],
			["rhsusf_mich_bare_norotos_alt_tan_headset",1],
			["rhsusf_mich_bare_norotos_arc_tan",1],
			["rhsusf_mich_bare_norotos_arc_alt_tan",1],
			["rhsusf_mich_bare_norotos_arc_alt_tan_headset",1],
			["rhsusf_mich_bare_norotos_tan_headset",1],
			["rhsusf_mich_helmet_marpatd",1],
			["rhsusf_mich_helmet_marpatd_alt",1],
			["rhsusf_mich_helmet_marpatd_alt_headset",1],
			["rhsusf_mich_helmet_marpatd_headset",1],
			["rhsusf_mich_helmet_marpatd_norotos",1],
			["rhsusf_mich_helmet_marpatd_norotos_arc",1],
			["rhsusf_mich_helmet_marpatd_norotos_arc_headset",1],
			["rhsusf_mich_helmet_marpatd_norotos_headset",1],
			["rhsusf_mich_helmet_marpatwd",1],
			["rhsusf_mich_helmet_marpatwd_alt",1],
			["rhsusf_mich_helmet_marpatwd_alt_headset",1],
			["rhsusf_mich_helmet_marpatwd_headset",1],
			["rhsusf_mich_helmet_marpatwd_norotos",1],
			["rhsusf_mich_helmet_marpatwd_norotos_arc",1],
			["rhsusf_mich_helmet_marpatwd_norotos_arc_headset",1],
			["rhsusf_mich_helmet_marpatwd_norotos_headset",1],
			["rhsusf_patrolcap_ocp",1],
			["rhsusf_patrolcap_ucp",1],
			["rhsusf_protech_helmet",1],
			["rhsusf_protech_helmet_ess",1],
			["rhsusf_protech_helmet_rhino",1],
			["rhsusf_protech_helmet_rhino_ess",1],
			["rhs_8point_marpatd",1],
			["rhs_8point_marpatwd",1],
			["H_ShemagOpen_khk",1],
			["H_ShemagOpen_tan",1],
			["H_Shemag_olive",1],
			["rhsusf_mbav",1],
			["rhsusf_mbav_grenadier",1],
			["rhsusf_mbav_light",1],
			["rhsusf_mbav_mg",1],
			["rhsusf_mbav_medic",1],
			["rhsusf_mbav_rifleman",1],
			["rhsusf_cvc_green_helmet",1],
			["rhsusf_cvc_green_alt_helmet",1],
			["rhsusf_cvc_green_ess",1],
			["rhsusf_cvc_helmet",1],
			["rhsusf_cvc_alt_helmet",1],
			["rhsusf_cvc_ess",1],
			["rhsusf_hgu56p_black",1],
			["rhsusf_hgu56p_mask_black",1],
			["rhsusf_hgu56p_visor_black",1],
			["rhsusf_hgu56p_visor_mask_black",1],
			["rhsusf_hgu56p_visor_mask_black_skull",1],
			["rhsusf_hgu56p_mask_green",1],
			["rhsusf_hgu56p_visor_green",1],
			["rhsusf_hgu56p_visor_mask_green",1],
			["rhsusf_hgu56p",1],
			["rhsusf_hgu56p_mask",1],
			["rhsusf_hgu56p_mask_skull",1],
			["rhsusf_hgu56p_visor",1],
			["rhsusf_hgu56p_visor_mask",1],
			["rhsusf_hgu56p_visor_mask_mo",1],
			["rhsusf_hgu56p_visor_mask_skull",1],
			["rhsusf_shemagh_grn",1],
			["rhsusf_shemagh_od",1],
			["rhsusf_shemagh_tan",1],
			["rhsusf_shemagh2_tan",1],
			["rhsusf_shemagh_white",1],
			["rhsusf_shemagh2_white",1],
			["rhsusf_shemagh_gogg_grn",1],
			["rhsusf_shemagh2_gogg_grn",1],
			["rhsusf_shemagh2_gogg_od",1],
			["rhsusf_shemagh_gogg_tan",1],
			["rhsusf_shemagh2_gogg_tan",1],
			["rhsusf_shemagh_gogg_white",1],
			["rhsusf_shemagh2_gogg_white",1],
			["rhsusf_oakley_goggles_blk",1],
			["rhsusf_oakley_goggles_ylw",1],
			["rhs_goggles_yellow",1],
			["rhs_goggles_clear",1],
			["rhs_ess_black",1]		
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
			["rhsusf_spcs_ocp",1],
			["rhsusf_spcs_ocp_rifleman",1],
			["rhsusf_spcs_ucp_rifleman",1],
			["rhsusf_spcs_ucp",1],		
			["rhsusf_spc",1],
			["rhsusf_spc_corpsman",1],
			["rhsusf_spc_crewman",1],
			["rhsusf_spc_iar",1],
			["rhsusf_spc_light",1],
			["rhsusf_spc_mg",1],
			["rhsusf_spc_marksman",1],
			["rhsusf_spc_patchless",1],
			["rhsusf_spc_patchless_radio",1],
			["rhsusf_spc_rifleman",1],
			["rhsusf_spc_squadleader",1],
			["rhsusf_spc_teamleader",1]	
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
		],
		// major uniforms
		[
			["U_B_GhillieSuit",1]
		],
		// colonel uniforms
		[
			["U_B_FullGhillie_sard",1],
			["U_B_FullGhillie_ard",1]
		]
	],
	// additional weapons and items, no rank
	[
		1,  // 0 = always added for each rank in the ranked version
		"ITEMS",

		[



			["MineDetector",1,true],
			["Binocular",1,true], 
			["FirstAidKit",1,true],
			["Medikit",1,true],
			["ToolKit",1,true],
			["B_UavTerminal",1,true],
			["B_UAV_01_backpack_F",1,true]
		],
		// corporal items
		[
			["lerca_1200_black",1,true],
			["lerca_1200_tan",1,true],
			["Leupold_Mk4",1,true]
		],
		// sergeant items
		[
		],
		// lieutenant items
		[
			["Rangefinder",1,true]
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

d_all_magazines = [
	["30Rnd_45ACP_Mag_SMG_01",10], ["11Rnd_45ACP_Mag",10], ["16Rnd_9x21_Mag",10], ["30Rnd_9x21_Mag",10], ["30Rnd_65x39_caseless_mag_Tracer",10],
		["30Rnd_65x39_caseless_mag",10], ["100Rnd_65x39_caseless_mag",10], ["20Rnd_762x51_Mag",10], ["30Rnd_556x45_Stanag",10],
		["7Rnd_408_mag",3], ["5Rnd_127x108_Mag",3], ["rhsgref_5Rnd_762x54_m38",10],
		["200Rnd_65x39_cased_Box",10], ["200Rnd_65x39_cased_Box_Tracer",10], ["100Rnd_65x39_caseless_mag_Tracer",10],
		["NLAW_F",3], ["Titan_AT",1], ["RPG32_F",3], ["Titan_AA",3], ["RPG32_HE_F",3],
		["1Rnd_HE_Grenade_shell",10], ["1Rnd_Smoke_Grenade_shell",10], ["1Rnd_SmokeBlue_Grenade_shell",10], ["1Rnd_SmokeGreen_Grenade_shell",10], ["1Rnd_SmokeOrange_Grenade_shell",10],
		["1Rnd_SmokePurple_Grenade_shell",10], ["1Rnd_SmokeRed_Grenade_shell",10], ["1Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_HE_Grenade_shell",10], ["3Rnd_Smoke_Grenade_shell",10],
		["3Rnd_SmokeBlue_Grenade_shell",10], ["3Rnd_SmokeGreen_Grenade_shell",10], ["3Rnd_SmokeOrange_Grenade_shell",10], ["3Rnd_SmokePurple_Grenade_shell",10],
		["3Rnd_SmokeRed_Grenade_shell",10], ["3Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_UGL_FlareCIR_F",10], ["3Rnd_UGL_FlareGreen_F",10], ["3Rnd_UGL_FlareRed_F",10],
		["3Rnd_UGL_FlareWhite_F",10], ["3Rnd_UGL_FlareYellow_F",10], ["UGL_FlareCIR_F",10], ["UGL_FlareGreen_F",10], ["UGL_FlareRed_F",10], ["UGL_FlareWhite_F",10], ["UGL_FlareYellow_F",10],
		["DemoCharge_Remote_Mag",5], ["SatchelCharge_Remote_Mag",5], ["ATMine_Range_Mag",5], ["ClaymoreDirectionalMine_Remote_Mag",5], ["APERSMine_Range_Mag",5], ["APERSBoundingMine_Range_Mag",5],
		["SLAMDirectionalMine_Wire_Mag",5], ["APERSTripMine_Wire_Mag",5],
		["Laserbatteries",5],
		["HandGrenade",5], ["MiniGrenade",5], ["SmokeShell",5], ["SmokeShellYellow",5], ["SmokeShellGreen",5], ["SmokeShellRed",5], ["SmokeShellPurple",5], ["SmokeShellOrange",5], ["SmokeShellBlue",5],
		["B_IR_Grenade",5],
		["Chemlight_green",5], ["Chemlight_red",5], ["Chemlight_yellow",5], ["Chemlight_blue",5],
		["200Rnd_556x45_Box_F",1],
		["200Rnd_556x45_Box_Red_F",1],
		["150Rnd_762x54_Box",1],
		["150Rnd_762x54_Box_Tracer",1],
		["200Rnd_556x45_Box_Tracer_F",1],
		["200Rnd_556x45_Box_Tracer_Red_F",1],
		["130Rnd_338_Mag",1],
		["150Rnd_93x64_Mag",1],
		["150Rnd_556x45_Drum_Mag_F",1],
		["150Rnd_556x45_Drum_Mag_Tracer_F",1],
		["30Rnd_556x45_Stanag_Tracer_Yellow",1],
		["30Rnd_556x45_Stanag_Tracer_Green",1],
		["30Rnd_556x45_Stanag_Tracer_Red",1],
		["rhs_mag_30Rnd_556x45_Mk262_Stanag",1],
		["rhs_mag_30Rnd_556x45_Mk318_Stanag",1],
		["rhs_mag_30Rnd_556x45_M200_Stanag",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Yellow",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag",1],
		["rhsusf_100Rnd_556x45_M200_soft_pouch",1],
		["rhsusf_100Rnd_556x45_soft_pouch",1],
		["rhs_200rnd_556x45_M_SAW",1],
		["rhs_200rnd_556x45_B_SAW",1],
		["rhsusf_200Rnd_556x45_soft_pouch",1],
		["rhs_200rnd_556x45_T_SAW",1],
		["rhs_100Rnd_762x54mmR",1],
		["rhsusf_100Rnd_762x51_m61_ap",1],
		["rhsusf_50Rnd_762x51_m61_ap",1],
		["rhsusf_100Rnd_762x51_m62_tracer",1],
		["rhsusf_50Rnd_762x51_m62_tracer",1],
		["rhsusf_100Rnd_762x51",1],
		["rhsusf_50Rnd_762x51",1],
		["rhsusf_100Rnd_762x51_m80a1epr",1],
		["rhsusf_50Rnd_762x51_m80a1epr",1],
		["rhsusf_100Rnd_762x51_m82_blank",1],
		["rhsusf_50Rnd_762x51_m82_blank",1],
		["rhs_100Rnd_762x54mmR_7BZ3",1],
		["rhs_100Rnd_762x54mmR_7N13",1],
		["rhs_100Rnd_762x54mmR_7N26",1],
		["rhs_100Rnd_762x54mmR_green",1],
		["rhssaf_250Rnd_762x54R",1],
		["16Rnd_9x21_yellow_Mag",1],
		["16Rnd_9x21_green_Mag",1],
		["16Rnd_9x21_red_Mag",1],
		["30Rnd_9x21_Yellow_Mag",1],
		["30Rnd_9x21_Green_Mag",1],
		["30Rnd_9x21_Red_Mag",1],
		["rhs_mag_9x19mm_7n21_44",1],
		["rhs_mag_9x19mm_7n21_20",1],
		["rhs_mag_9x19mm_7n31_44",1],
		["rhs_mag_9x19mm_7n31_20",1],
		["rhs_mag_m4009",1],
		["rhs_mag_M397_HET",1],
		["rhs_mag_M433_HEDP",1],
		["rhs_mag_M441_HE",1],
		["rhs_mag_m576",1],
		["rhs_mag_M585_white",1],
		["rhs_mag_m661_green",1],
		["rhs_mag_m662_red",1],
		["rhs_mag_m713_Red",1],
		["rhs_mag_m714_White",1],
		["rhs_mag_m715_Green",1],
		["rhs_mag_m716_yellow",1],
		["6Rnd_GreenSignal_F",1],
		["6Rnd_RedSignal_F",1],
		["IEDUrbanBig_Remote_Mag",1],
		["IEDLandBig_Remote_Mag",1],
		["rhs_mag_m7a3_cs",1],
		["rhs_mag_an_m14_th3",1],
		["I_IR_Grenade",1],
		["O_IR_Grenade",1],
		["10Rnd_127x54_Mag",1],
		["10Rnd_762x54_Mag",1],
		["10Rnd_93x64_DMR_05_Mag",1],
		["10Rnd_9x21_Mag",1],
		["10Rnd_338_Mag",1],
		["20Rnd_650x39_Cased_Mag_F",1],
		["5Rnd_127x108_APDS_Mag",1],
		["9Rnd_45ACP_Mag",1],
		["IEDUrbanSmall_Remote_Mag",1],
		["IEDLandSmall_Remote_Mag",1],
		["rhs_mag_m18_green",1],
		["rhs_mag_m18_yellow",1],
		["rhs_mag_m18_red",1],
		["rhs_mag_m18_purple",1],
		["rhs_rpg7_OG7V_mag",1],
		["rhs_mag_m67",1],
		["rhs_mag_rsp30_white",1],
		["rhs_mag_rsp30_green",1],
		["rhs_mag_rsp30_red",1],
		["rhs_mag_mk3a2",1],
		["rhs_mag_mk84",1],
		["rhs_rpg7_TBG7V_mag",1],
		["rhs_mag_m69",1],
		["rhs_rpg7_PG7VL_mag",1],
		["rhs_rpg7_PG7VR_mag",1],
		["rhs_rpg7_PG7V_mag",1],
		["RPG7_F",1],
		["6Rnd_45ACP_Cylinder",1],
		["rhsusf_mag_10Rnd_STD_50BMG_M33",1],
		["rhsusf_mag_10Rnd_STD_50BMG_mk211",1],
		["rhs_mag_9x19_17",1],
		["rhsusf_mag_7x45acp_MHP",1],
		["rhs_mag_9x18_8_57N181S",1],
		["rhsusf_20Rnd_762x51_m118_special_Mag",1],
		["rhsusf_20Rnd_762x51_m62_Mag",1],
		["rhsusf_20Rnd_762x51_m993_Mag",1],
		["rhs_mag_9k32_rocket",1],
		["rhs_mag_9k38_rocket",1],
		["rhsusf_mag_15Rnd_9x19_FMJ",1],
		["rhsusf_mag_17Rnd_9x19_FMJ",1],
		["rhsusf_mag_15Rnd_9x19_JHP",1],
		["rhsusf_mag_17Rnd_9x19_JHP",1],
		["rhs_mag_an_m8hc",1],
		["rhs_fim92_mag",1],
		["rhs_fgm148_magazine_AT",1],
		["rhsusf_m112_mag",1],
		["rhsusf_m112x4_mag",1],
		["rhsusf_mine_m14_mag",1],
		["rhs_mine_M19_mag",1],
		["rhs_mag_smaw_SR",1],
		["rhs_mag_smaw_HEDP",1],
		["rhs_mag_smaw_HEAA",1],
		["rhs_rpg7_type69_airburst_mag",1],
		["rhs_VG40MD_White",1],
		["rhs_VG40MD_Green",1],
		["rhs_VG40MD_Red",1],
		["rhs_VG40OP_white",1],
		["rhs_VG40OP_green",1],
		["rhs_VG40OP_red",1],
		["rhs_VG40SZ",1],
		["rhs_VG40TB",1],
		["rhs_VOG25P",1],
		["rhs_VOG25",1],
		["rhs_GDM40",1],
		["rhs_GRD40_White",1],
		["rhs_GRD40_Green",1],
		["rhs_GRD40_Red",1],
		["30Rnd_545x39_Mag_F",1],
		["30Rnd_545x39_Mag_Green_F",1],
		["30Rnd_762x39_Mag_F",1],
		["30Rnd_762x39_Mag_Green_F",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",1],
		["10Rnd_50BW_Mag_F",1],
		["100Rnd_580x42_Mag_F",1],
		["100Rnd_580x42_Mag_Tracer_F",1],
		["30Rnd_580x42_Mag_F",1],
		["30Rnd_556x45_Stanag_green",1],
		["30Rnd_556x45_Stanag_red",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Green",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Red",1],
		["30Rnd_545x39_Mag_Tracer_F",1],
		["30Rnd_545x39_Mag_Tracer_Green_F",1],
		["30Rnd_580x42_Mag_Tracer_F",1],
		["30Rnd_762x39_Mag_Tracer_F",1],
		["30Rnd_762x39_Mag_Tracer_Green_F",1],
		["20Rnd_556x45_UW_mag",1],
		["30Rnd_65x39_caseless_green",1],
		["30Rnd_65x39_caseless_green_mag_Tracer",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Red",1],
		["30Rnd_9x21_Mag_SMG_02",1],
		["rhs_10rnd_9x39mm_SP5",1],
		["rhs_20rnd_9x39mm_SP5",1],
		["rhs_10rnd_9x39mm_SP6",1],
		["rhs_20rnd_9x39mm_SP6",1],
		["rhsgref_10rnd_765x17_vz61",1],
		["rhsgref_20rnd_765x17_vz61",1],
		["rhsusf_mag_40Rnd_46x30_AP",1],
		["rhsusf_mag_40Rnd_46x30_FMJ",1],
		["rhsusf_mag_40Rnd_46x30_JHP",1],
		["rhs_30Rnd_545x39_AK",1],
		["rhs_30Rnd_545x39_AK_no_tracers",1],
		["rhs_45Rnd_545X39_AK",1],
		["rhsusf_5Rnd_00Buck",1],
		["rhsusf_5Rnd_300winmag_xm2010",1],
		["rhsusf_5Rnd_Slug",1],
		["rhsusf_5Rnd_FRAG",1],
		["rhsusf_5Rnd_HE",1],
		["rhs_5Rnd_338lapua_t5000",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Orange",1],
		["rhs_30Rnd_762x39mm",1],
		["rhs_30Rnd_762x39mm_89",1],
		["rhs_30Rnd_762x39mm_tracer",1],
		["rhs_30Rnd_762x39mm_U",1],
		["rhsgref_5Rnd_762x54_m38",1],
		["rhsgref_5Rnd_792x57_kar98k",1],
		["rhsusf_mag_6Rnd_m4009",1],
		["rhsusf_mag_6Rnd_M397_HET",1],
		["rhsusf_mag_6Rnd_M433_HEDP",1],
		["rhsusf_mag_6Rnd_M441_HE",1],
		["rhsusf_mag_6Rnd_M576_Buckshot",1],
		["rhsusf_mag_6Rnd_M585_white",1],
		["rhsusf_mag_6Rnd_m661_green",1],
		["rhsusf_mag_6Rnd_m662_red",1],
		["rhsusf_mag_6Rnd_M713_red",1],
		["rhsusf_mag_6Rnd_M714_white",1],
		["rhsusf_mag_6Rnd_M715_green",1],
		["rhsusf_mag_6Rnd_M716_yellow",1],
		["rhsusf_mag_6Rnd_M781_Practice",1],
		["rhs_10Rnd_762x54mmR_7N1",1],
		["rhs_30Rnd_545x39_7N10_AK",1],
		["rhs_45Rnd_545X39_7N10_AK",1],
		["rhs_30Rnd_545x39_7N22_AK",1],
		["rhs_45Rnd_545X39_7N22_AK",1],
		["rhs_30Rnd_545x39_7N6_AK",1],
		["rhs_45Rnd_545X39_7N6_AK",1],
		["rhs_30Rnd_545x39_AK_green",1],
		["rhs_45Rnd_545X39_AK_Green",1],
		["rhs_30Rnd_545x39_7U1_AK",1],
		["rhs_45Rnd_545X39_7U1_AK",1],
		["rhsusf_10Rnd_762x51_m118_special_Mag",1],
		["rhsusf_5Rnd_762x51_m118_special_Mag",1],
		["rhsusf_10Rnd_762x51_m62_Mag",1],
		["rhsusf_5Rnd_762x51_m62_Mag",1],
		["rhsusf_10Rnd_762x51_m993_Mag",1],
		["rhsusf_5Rnd_762x51_m993_Mag",1],
		["rhsusf_8Rnd_00Buck",1],
		["rhsusf_8Rnd_Slug",1],
		["rhsusf_8Rnd_FRAG",1],
		["rhsusf_8Rnd_HE",1],
		["rhs_mag_maaws_HEDP",1],
		["rhs_mag_maaws_HEAT",1],
		["rhs_mag_maaws_HE",1],
		["rhssaf_100rnd_556x45_EPR_G36",1],
		["rhssaf_30rnd_556x45_EPR_G36",1],
		["rhssaf_30rnd_556x45_MDIM_G36",1],
		["rhssaf_30rnd_556x45_TDIM_G36",1],
		["rhssaf_30rnd_556x45_SOST_G36",1],
		["rhssaf_30rnd_556x45_SPR_G36",1],
		["rhssaf_30rnd_556x45_Tracers_G36",1],
		["rhsgref_30rnd_556x45_m21_t",1],
		["rhsgref_30rnd_556x45_m21",1],
		["rhssaf_10Rnd_792x57_m76_tracer",1],
		["rhsgref_10Rnd_792x57_m76",1],
		["rhs_mag_M781_Practice",1]
];

d_backpackclasses = [
	["rhsusf_assault_eagleaiii_coy",1],
	["B_rhsusf_B_BACKPACK",1],
	["rhsusf_assault_eagleaiii_ocp",1],
	["rhsusf_assault_eagleaiii_ucp",1],
	["rhsusf_falconii_coy",1],
	["rhsusf_falconii_mc",1],
	["rhsusf_falconii",1],
	["RHS_M2_Gun_Bag",1],
	["RHS_M2_Tripod_Bag",1],
	["rhs_M252_Gun_Bag",1],
	["rhs_M252_Bipod_Bag",1],
	["RHS_M2_MiniTripod_Bag",1],
	["RHS_Mk19_Gun_Bag",1],
	["RHS_Mk19_Tripod_Bag",1],
	["rhs_Tow_Gun_Bag",1],
	["rhs_TOW_Tripod_Bag",1],
	["rhssaf_kitbag_digital",1],
	["rhssaf_kitbag_md2camo",1],
	["rhssaf_kitbag_smb",1],
	["rhsgref_hidf_alicepack",1],
	["rhsgref_ttsko_alicepack",1],
	["rhsgref_wdl_alicepack",1],
	["rhssaf_alice_md2camo",1],
	["rhssaf_alice_smb",1]
];
#endif

#ifdef __OWN_SIDE_OPFOR__
private _helipilotgear = [];
private _helipilothelmet = [];
if (d_pilots_only == 1) then {
	_helipilotgear = ["U_O_HeliPilotCoveralls",1,true];
	_helipilothelmet = ["H_PilotHelmetFighter_O",1,true];
} else {
	if (d_only_pilots_can_fly isEqualTo []) then {
		_helipilotgear = ["U_O_HeliPilotCoveralls",1,true];
		_helipilothelmet = ["H_PilotHelmetFighter_O",1,true];
	} else {
		if (str player in d_only_pilots_can_fly) then {
			_helipilotgear = ["U_O_HeliPilotCoveralls",1,true];
			_helipilothelmet = ["H_PilotHelmetFighter_O",1,true];
		};
	};
};

private _all_weapons_items = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			["rhs_weap_ak74",1,true],
			["rhs_weap_aks74n",1,true]		
		],
		// corporal rifles (gets added to private rifles)
		[
			["hgun_Pistol_heavy_01_F",1,true],
			["hgun_Pistol_heavy_01_snds_F",1,true],
			["rhs_weap_m38_rail",1,true],
			["rhs_weap_ak74_3",1,true],
			["rhs_weap_ak74_2",1,true],
			["rhs_weap_aks74",1,true],
			["rhs_weap_ak74n_2_npz",1,true],
			["rhs_weap_aks74_2",1,true],
			["rhs_weap_aks74u",1,true],
			["rhs_weap_ak74m_camo",1,true],
			["rhs_weap_ak74m_camo_dtk",1,true],
			["rhs_weap_ak74m_plummag",1,true],
			["rhs_weap_ak74m_plummag_dtk",1,true],
			["rhs_weap_ak74m_desert",1,true],
			["rhs_weap_ak74m_desert_dtk",1,true],
			["rhs_weap_ak74m_fullplum",1,true],
			["rhs_weap_ak74m_fullplum_dtk",1,true],
			["rhs_weap_ak74m_2mag",1,true],
			["rhs_weap_ak74m_2mag_dtk",1,true],
			["rhs_weap_ak74m_2mag_camo",1,true],
			["rhs_weap_ak74m_2mag_camo_dtk",1,true],
			["rhs_weap_ak74m",1,true],
			["rhs_weap_ak74m_dtk",1,true],
			["rhs_weap_45th_ak74m",1,true]
			
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[			
			["rhs_weap_akmn_gp25",1,true],
			["rhs_weap_akmn_gp25_npz",1,true],
			["rhs_weap_ak74m_gp25_npz",1,true],
			["rhs_weap_ak74mr_gp25",1,true],
			["rhs_weap_ak74m_fullplum_gp25_npz",1,true],
			["rhs_weap_ak103_zenitco01",1,true],
			["rhs_weap_ak103_zenitco01_b33",1,true],
			["rhs_weap_ak104_zenitco01",1,true],
			["rhs_weap_ak104_zenitco01_b33",1,true],
			["rhs_weap_ak103",1,true],
			["rhs_weap_ak103_dtk",1,true],
			["rhs_weap_45th_ak103",1,true],
			["rhs_weap_ak103_1_npz",1,true],
			["rhs_weap_ak103_2_npz",1,true],
			["rhs_weap_ak103_npz",1,true],
			["rhs_weap_ak104_npz",1,true],
			["rhs_weap_ak105_npz",1,true],			
			["rhs_weap_ak103_1",1,true],
			["rhs_weap_ak103_1_dtk",1,true],
			["rhs_weap_ak103_2",1,true],
			["rhs_weap_ak103_2_dtk",1,true],
			["rhs_weap_akms_gp25",1,true],
			["rhs_weap_akm_gp25",1,true],
			["rhs_weap_45th_akm_gp25",1,true],
			["rhs_weap_aks74n_gp25",1,true],
			["rhs_weap_aks74_gp25",1,true],
			["rhs_weap_ak103_gp25",1,true],
			["rhs_weap_ak74m_gp25",1,true],
			["rhs_weap_ak74m_gp25_dtk",1,true],
			["rhs_weap_ak74m_fullplum_gp25",1,true],
			["rhs_weap_ak74m_fullplum_gp25_dtk",1,true],
			["rhs_weap_ak74_gp25",1,true],
			["rhs_weap_ak74m_fullplum_gp25_folded",1,true],
			["rhs_weap_ak74m_fullplum_gp25_npz_dtk",1,true],
			["rhs_weap_ak74m_gp25_folded",1,true],
			["rhs_weap_m84",1,true],
			["rhs_weap_asval",1,true],
			["rhs_weap_asval_grip",1,true],
			["rhs_weap_vss",1,true],
			["rhs_weap_vss_grip",1,true],
			["rhs_weap_pkm",1,true]
		],
		// lieutenant rifles (gets added to...)
		[		
			["rhs_weap_ak74m_zenitco01_b33",1,true],
			["rhs_weap_ak74m_zenitco01",1,true],
			["rhs_weap_ak105_zenitco01",1,true],
			["rhs_weap_ak105_zenitco01_b33",1,true],
			["rhs_weap_pkp",1,true],
			["rhs_weap_svdp",1,true],
			["rhs_weap_svdp_wd",1,true],
			["rhs_weap_svds",1,true],
			["arifle_AK12_F",1,true],
			["arifle_AK12_GL_F",1,true]
		],
		// captain rifles (gets added...)
		[		
			["rhs_weap_savz61",1,true]
		],
		// major rifles (gets...)
		[		
			["rhs_weap_t5000",1]
		],
		// colonel rifles (...)
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private sniper rifles
		[
		],
		// corporal sniper rifles
		[
		],
		// sergeant sniper rifles
		[
		],
		// lieutenant sniper rifles
		[
		],
		// captain sniper rifles
		[
		],
		// major sniper rifles
		[
		],
		// colonel sniper rifles
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private MG
		[
		],
		// corporal MG
		[
		],
		// sergeant MG
		[
		],
		// lieutenant MG
		[
		],
		// captain MG
		[
		],
		// major MG
		[
		],
		// colonel MG
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[			
			["rhs_weap_igla",1],
			["rhs_weap_rshg2",1],
			["rhs_weap_rpg26",1]
		],
		// corporal launchers
		[
			["rhs_weap_rpg7",1]
		],
		// sergeant launchers
		[
		],
		// lieutenant launchers
		[
			["rhs_weap_smaw",1,true],
			["rhs_weap_smaw_green",1,true]
		],
		// capain launchers
		[
			["rhs_weap_maaws",1,true]
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
			["rhs_weap_tr8",1,true]
		],
		// corporal pistols
		[
			["rhs_weap_makarov_pm",1,true]
		],
		// sergeant pistols
		[
			["rhs_weap_pb_6p9",1,true],
			["rhs_weap_pya",1,true]
		],
		// lieutenant pistols
		[
			["rhs_weap_tt33",1,true],
			["rhs_weap_pp2000",1,true]
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
			["optic_ACO_grn",1,true],
			["optic_aco",1,true],
			["optic_ACO_grn_smg",1,true],
			["optic_Aco_smg",1,true],
			["rhsusf_acc_compm4",1,true],
			["rhsusf_acc_eotech_xps3",1,true],
			["rhsusf_acc_EOTECH",1,true],
			["rhsusf_acc_T1_high",1,true],
			["rhsusf_acc_T1_low",1,true],
			["rhsusf_acc_T1_low_fwd",1,true],
			["acc_pointer_IR",1,true],
			["rhsusf_acc_wmx",1,true],
			["rhsusf_acc_wmx_bk",1,true],
			["rhsusf_acc_M952V",1,true],
			
			["rhs_acc_ekp8_02",1,true],
			["rhs_acc_ekp8_18",1,true],
			["rhs_acc_1p87",1,true],
			["rhs_acc_ekp1",1,true],
			["rhs_acc_pkas",1,true],
			["rhs_acc_1p63",1,true],
            ["rhs_acc_rakursPM",1,true]
		],
		// sergeant optics
		[
			["rhsusf_acc_ACOG2_USMC",1,true],
			["rhsusf_acc_ACOG3_USMC",1,true],
			["rhsusf_acc_ACOG_USMC",1,true],
			["rhs_weap_optic_smaw",1,true],
			["rhsusf_acc_g33_t1",1,true],
			["rhsusf_acc_g33_xps3",1,true],
			["rhsusf_acc_g33_xps3_tan",1,true],
			["rhsusf_acc_ACOG",1,true],
			["rhsusf_acc_ACOG2",1,true],
			["rhsusf_acc_ACOG3",1,true],
			["rhsusf_acc_ACOG_anpvs27",1,true],
			["rhsusf_acc_ACOG_MDO",1,true],
			["rhsusf_acc_ACOG_d",1,true],
			["rhsusf_acc_ACOG_wd",1,true],
			["rhsusf_acc_ACOG_RMR",1,true],
			["rhsusf_acc_SpecterDR",1,true],
			["rhsusf_acc_SpecterDR_OD",1,true],
			["rhsusf_acc_SpecterDR_D",1,true],
			["rhsusf_acc_SpecterDR_A",1,true],
			["acc_flashlight",1,true],["optic_Holosight_smg",1,true],
			
			["rhs_acc_pgo7v",1,true],
			["rhs_acc_pso1m2",1,true],
			["rhs_acc_pgo7v2",1,true],
			["rhs_acc_pgo7v3",1,true],
			["rhs_acc_1p29",1,true]

		],
		// lieutenant optics
		[
			["rhsusf_acc_LEUPOLDMK4",1,true],
			["rhsusf_acc_LEUPOLDMK4_2",1,true],
			["rhsusf_acc_LEUPOLDMK4_2_d",1,true],
			["rhs_optic_maaws",1,true],
			["rhsusf_acc_M8541",1,true],
			["rhsusf_acc_M8541_low",1,true],
			["rhsusf_acc_M8541_low_d",1,true],
			["rhsusf_acc_M8541_low_wd",1,true],
			["rhsusf_acc_premier_low",1,true],
			["rhsusf_acc_premier_anpvs27",1,true],
			["rhsusf_acc_premier",1,true],
			["optic_MRD",1,true],["optic_MRCO",1,true],
			["optic_ERCO_khk_F",1,true],
			["optic_ERCO_blk_F",1,true],
			["optic_ERCO_snd_F",1,true],
			
			["rhs_acc_pso1m21",1,true],
			["rhs_acc_1p78",1,true]
		],
		// captain optics
		[
			["optic_Aco",1,true],["optic_ACO_grn",1,true],["optic_Arco",1,true],["optic_Hamr",1,true],
			["rhsusf_acc_anpas13gv1",1,true],
			["rhsusf_acc_anpvs27",1,true],
			
			["rhs_acc_dh520x56",1,true]
		],
		// major optics
		[
			["optic_Aco_smg",1,true], ["optic_ACO_grn_smg",1,true], ["optic_tws",1,true], ["optic_tws_mg",1,true], ["optic_DMS",1,true]
		],
		// colonel optics
		[
			["optic_SOS",1,true], ["optic_NVS",1,true], ["optic_Nightstalker",1,true], ["optic_LRPS",1,true]
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"MUZZLES",
		// third array index just means that it is an item and not a weapon thus must be added with addItemCargo and not addWeaponCargo
		// private muzzles
		[
			["rhsusf_acc_SF3P556",1,true],
			["rhsusf_acc_SFMB556",1,true],
			
			["rhs_acc_dtk",1,true],
			["rhs_acc_dtk1l",1,true],
			["rhs_acc_dtk1p",1,true],
			["rhs_acc_dtk1",1,true],
			["rhs_acc_dtk2",1,true],
			["rhs_acc_dtk3",1,true]
		],
		// corporal muzzles
		[
			["rhsusf_acc_grip2",1,true],
			["rhsusf_acc_grip2_tan",1,true],
			["rhsusf_acc_grip1",1,true],
			["rhsusf_acc_rotex_mp7_aor1",1,true],
			["rhsusf_acc_rotex_mp7",1,true],
			["rhsusf_acc_rotex_mp7_desert",1,true],
			["rhsusf_acc_rotex_mp7_winter",1,true],
			["rhsusf_acc_grip4",1,true],
			["rhsusf_acc_SR25S",1,true],
			["rhsusf_acc_grip3",1,true],
			["rhsusf_acc_grip3_tan",1,true],
			["rhsusf_acc_M2010S",1,true],
			["rhs_acc_dtk1983",1,true],
			["rhsusf_Rhino",1,true],
			["rhs_acc_pgs64",1,true],
			["rhs_acc_pgs64_74u",1,true],
			["rhs_acc_pgs64_74un",1,true],
			["rhs_acc_ak5",1,true],
			["rhs_acc_perst1ik",1,true],
			["rhs_acc_perst1ik_ris",1,true],
			["rhs_acc_perst3",1,true],
			["rhs_acc_perst3_top",1,true],
			["rhs_acc_perst3_2dp_h",1,true],
			["rhs_acc_perst3_2dp_light_h",1,true],
			["rhs_acc_2dpZenit",1,true],
			["rhs_acc_2dpZenit_ris",1,true],
			["rhs_acc_grip_rk2",1,true],
			["rhs_acc_grip_rk6",1,true]			
		],
		// sergeant muzzles
		[
			["muzzle_snds_B",1,true],
			["acc_flashlight",1,true],
			["rhsusf_acc_anpeq15side",1,true],
			["rhsusf_acc_anpeq15_top",1,true],
			["rhsusf_acc_anpeq15_wmx_light",1,true],
			["rhsusf_acc_anpeq15_wmx",1,true],
			["rhsusf_acc_anpeq15side_bk",1,true],
			["rhsusf_acc_anpeq15_bk_top",1,true],
			["rhsusf_acc_anpeq15",1,true],
			["rhsusf_acc_anpeq15_light",1,true],
			["rhsusf_acc_anpeq15_bk_light",1,true],
			["rhsusf_acc_anpeq15_bk",1,true],
			["rhsusf_acc_anpeq15A",1,true],
			["rhsusf_acc_harris_bipod",1,true],
			["rhsusf_acc_nt4_tan",1,true],
			["rhsusf_acc_nt4_black",1,true],
			["rhsusf_acc_rotex5_tan",1,true],
			["rhsusf_acc_rotex5_grey",1,true],
			["rhsusf_acc_omega9k",1,true],
			["acc_flashlight_pistol",1,true],
			["rhs_acc_dtk4long",1,true],
			["rhs_acc_dtk4screws",1,true],
			["rhs_acc_dtk4short",1,true],
			["rhs_acc_tgpa",1,true],
			["rhs_acc_tgpv",1,true],
			["rhs_acc_tgpv2",1,true],
			["rhs_acc_pbs1",1,true],
			["rhs_acc_pbs4",1,true],
			["rhs_acc_harris_swivel",1,true]
		],
		// lieutenant muzzles
		[
			["muzzle_snds_H",1, true],["muzzle_snds_L",1, true], ["muzzle_snds_M",1, true], ["muzzle_snds_acp", 1, true]
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			["muzzle_snds_H_MG",1, true]
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
			["rhs_uniform_gorka_r_y",1],
			["rhs_uniform_gorka_r_g",1],
			["rhs_uniform_mflora_patchless",1],
			["rhs_uniform_vdv_mflora",1],
			["rhs_uniform_df15",1],
			["rhs_uniform_df15_tan",1],
			["rhs_uniform_emr_patchless",1],
			["rhs_uniform_vdv_emr",1],
			["rhs_uniform_msv_emr",1],
			["rhs_uniform_emr_des_patchless",1],
			["rhs_uniform_vdv_emr_des",1],
			["rhs_uniform_mvd_izlom",1],
			["rhs_uniform_m88_patchless",1],
			["rhs_uniform_flora_patchless",1],
			["rhs_uniform_vdv_flora",1],
			["rhs_uniform_vmf_flora",1],
			["rhs_uniform_vmf_flora_subdued",1],
			["rhs_uniform_flora",1],
			["rhs_uniform_rva_flora",1],
			["rhs_uniform_flora_patchless_alt",1],
			["rhs_6b23",1],
			["rhs_6b23_ML",1],
			["rhs_6b23_ML_vydra_3m",1],
			["rhs_6b23_ML_engineer",1],
			["rhs_6b23_ML_medic",1],
			["rhs_6b23_ML_crewofficer",1],
			["rhs_6b23_ML_sniper",1],
			["rhs_6b23_ML_rifleman",1],
			["rhs_6b23_ML_crew",1],
			["rhs_6b23_ML_6sh92",1],
			["rhs_6b23_ML_6sh92_vog",1],
			["rhs_6b23_ML_6sh92_vog_headset",1],
			["rhs_6b23_ML_6sh92_radio",1],
			["rhs_6b23_ML_6sh92_headset",1],
			["rhs_6b23_ML_6sh92_headset_mapcase",1],
			["rhs_6b23_digi",1],
			["rhs_6b23_digi_vydra_3m",1],
			["rhs_6b23_digi_engineer",1],
			["rhs_6b23_digi_medic",1],
			["rhs_6b23_digi_crewofficer",1],
			["rhs_6b23_digi_sniper",1],
			["rhs_6b23_digi_rifleman",1],
			["rhs_6b23_digi_crew",1],
			["rhs_6b23_6sh116",1],
			["rhs_vydra_3m",1],
			["rhs_6sh46",1],
			["rhs_6b23_6sh116_vog",1],
			["rhs_6b23_digi_6sh92",1],
			["rhs_6b23_digi_6sh92_vog",1],
			["rhs_6b23_digi_6sh92_vog_headset",1],
			["rhs_6b23_digi_6sh92_radio",1],
			["rhs_6b23_digi_6sh92_headset",1],
			["rhs_6b23_digi_6sh92_headset_mapcase",1],
			["rhs_6b23_6sh116_flora",1],
			["rhs_6b23_6sh116_vog_flora",1],
			["rhs_6b23_vydra_3m",1],
			["rhs_6b23_engineer",1],
			["rhs_6b23_medic",1],
			["rhs_6b23_crewofficer",1],
			["rhs_6b23_sniper",1],
			["rhs_6b23_rifleman",1],
			["rhs_6b23_crew",1],
			["rhs_6b23_6sh116_od",1],
			["rhs_6b23_6sh116_vog_od",1],
			["rhs_6b23_6sh92",1],
			["rhs_6b23_6sh92_vog",1],
			["rhs_6b23_6sh92_vog_headset",1],
			["rhs_6b23_6sh92_radio",1],
			["rhs_6b23_6sh92_headset",1],
			["rhs_6b23_6sh92_headset_mapcase",1],
			["rhs_6b23_digi_6sh92_Vog_Radio_Spetsnaz",1],
			["rhs_6b23_digi_6sh92_Spetsnaz",1],
			["rhs_6b23_digi_6sh92_headset_spetsnaz",1],
			["rhs_6b43",1],
			["rhs_6b5_khaki",1],
			["rhs_6b5_vsr",1],
			["rhs_6b5_medic_vsr",1],
			["rhs_6b5_officer_vsr",1],
			["rhs_6b5_sniper_vsr",1],
			["rhs_6b5",1],
			["rhs_6b5_medic",1],
			["rhs_6b5_officer",1],
			["rhs_6b5_sniper",1],
			["rhs_6b5_ttsko",1],
			["rhs_6b5_medic_ttsko",1],
			["rhs_6b5_officer_ttsko",1],
			["rhs_6b5_sniper_ttsko",1],
			["rhs_6b5_medic_khaki",1],
			["rhs_6b5_officer_khaki",1],
			["rhs_6b5_sniper_khaki",1],
			["rhs_6sh92",1],
			["rhs_6sh92_vsr",1],
			["rhs_6sh92_vsr_vog",1],
			["rhs_6sh92_vsr_vog_headset",1],
			["rhs_6sh92_vsr_radio",1],
			["rhs_6sh92_vsr_headset",1],
			["rhs_6sh92_digi",1],
			["rhs_6sh92_digi_vog",1],
			["rhs_6sh92_digi_vog_headset",1],
			["rhs_6sh92_digi_radio",1],
			["rhs_6sh92_digi_headset",1],
			["rhs_6sh92_vog",1],
			["rhs_6sh92_vog_headset",1],
			["rhs_6sh92_radio",1],
			["rhs_6sh92_headset",1],
			["rhs_altyn_novisor",1],
			["rhs_altyn_novisor_ess",1],
			["rhs_altyn_novisor_ess_bala",1],
			["rhs_altyn_novisor_bala",1],
			["rhs_altyn_visordown",1],
			["rhs_altyn",1],
			["rhs_altyn_bala",1],
			["H_Bandanna_khk_hs",1],
			["H_Bandanna_camo",1],
			["H_Bandanna_sand",1],
			["H_Bandanna_sgg",1],
			["H_Bandanna_khk",1],
			["H_Bandanna_gry",1],
			["rhs_gssh18",1],
			["rhs_fieldcap",1],
			["rhs_fieldcap_vsr",1],
			["rhs_fieldcap_ml",1],
			["rhs_fieldcap_digi",1],
			["rhs_fieldcap_digi2",1],
			["rhs_fieldcap_khk",1],
			["rhs_fieldcap_helm_ml",1],
			["rhs_fieldcap_helm_digi",1],
			["rhs_fieldcap_helm",1],
			["rhs_ssh68",1],
			["rhs_tsh4_ess_bala",1],
			["rhs_tsh4_bala",1],
			["rhs_beanie_green",1],
			["rhs_beanie",1],
			["H_ShemagOpen_khk",1],
			["H_ShemagOpen_tan",1],
			["H_Shemag_olive",1],
			["H_Shemag_olive_hs",1],
			["rhs_Booniehat_digi",1],
			["rhs_Booniehat_flora",1],
			["rhs_6b26_green",1],
			["rhs_6b26",1],
			["rhs_6b26_ess",1],
			["rhs_6b26_ess_bala",1],
			["rhs_6b26_bala",1],
			["rhs_6b26_ess_green",1],
			["rhs_6b26_ess_bala_green",1],
			["rhs_6b26_bala_green",1],
			["rhs_6b27m_green",1],
			["rhs_6b27m_ml",1],
			["rhs_6b27m_ml_ess",1],
			["rhs_6b27m_ML_ess_bala",1],
			["rhs_6b27m_ml_bala",1],
			["rhs_6b27m_digi",1],
			["rhs_6b27m_digi_ess",1],
			["rhs_6b27m_digi_ess_bala",1],
			["rhs_6b27m_digi_bala",1],
			["rhs_6b27m",1],
			["rhs_6b27m_ess",1],
			["rhs_6b27m_ess_bala",1],
			["rhs_6b27m_bala",1],
			["rhs_6b27m_green_ess",1],
			["rhs_6b27m_green_ess_bala",1],
			["rhs_6b27m_green_bala",1],
			["rhs_6b28_green",1],
			["rhs_6b28",1],
			["rhs_6b28_ess",1],
			["rhs_6b28_ess_bala",1],
			["rhs_6b28_bala",1],
			["rhs_6b28_flora_ess",1],
			["rhs_6b28_flora",1],
			["rhs_6b28_flora_ess_bala",1],
			["rhs_6b28_flora_bala",1],
			["rhs_6b28_green_ess",1],
			["rhs_6b28_green_ess_bala",1],
			["rhs_6b28_green_bala",1],
			["rhs_zsh7a",1],
			["rhs_zsh7a_mike",1],
			["rhs_zsh7a_mike_green",1],
			["rhs_zsh7a_mike_green_alt",1],
			["rhs_zsh7a_alt",1],
			["rhs_zsh7a_mike_alt",1],
			["rhs_zsh12",1],
			["rhs_zsh12_black",1],
			["rhs_zsh12_bala",1],
			["rhs_6b47",1],
			["rhs_6b47_ess",1],
			["rhs_6b47_ess_bala",1],
			["rhs_6b47_bala",1],
			["rhs_6b7_1m_emr_ess",1],
			["rhs_6b7_1m_emr_ess_bala",1],
			["rhs_6b7_1m_ess",1],
			["rhs_6b7_1m_ess_bala",1],
			["rhs_6b7_1m",1],
			["rhs_6b7_1m_olive",1],
			["rhs_6b7_1m_bala1_olive",1],
			["rhs_6b7_1m_bala2_olive",1],
			["rhs_6b7_1m_flora",1],
			["rhs_6b7_1m_bala1_flora",1],
			["rhs_6b7_1m_bala2_flora",1],
			["rhs_6b7_1m_flora_ns3",1],
			["rhs_6b7_1m_bala1",1],
			["rhs_6b7_1m_bala2",1],
			["rhs_6b7_1m_emr",1],
			["rhs_6b7_1m_bala1_emr",1],
			["rhs_6b7_1m_bala2_emr",1],
			
			["rhsusf_oakley_goggles_blk",1],
			["rhsusf_oakley_goggles_ylw",1],
			["rhs_goggles_yellow",1],
			["rhs_goggles_clear",1],
			["rhs_ess_black",1],
			["rhs_balaclava1_olive",1],
			["rhs_scarf",1],
			
			["rhs_beret_vdv1",1],
			["rhs_beret_vdv2",1],
			["rhs_beret_vdv3",1],
			["rhs_beret_milp",1],
			["rhs_beret_mp1",1],
			["rhs_beret_mp2",1]	
		],
		// corporal uniforms
		[
			
		],
		// sergeant uniforms
		[
			["rhs_6b13_Flora",1],
			["rhs_6b13",1],
			["rhs_6b13_crewofficer",1],
			["rhs_6b13_6sh92",1],
			["rhs_6b13_6sh92_vog",1],
			["rhs_6b13_6sh92_radio",1],
			["rhs_6b13_6sh92_headset_mapcase",1],
			["rhs_6b13_EMR_6sh92",1],
			["rhs_6b13_EMR_6sh92_vog",1],
			["rhs_6b13_EMR_6sh92_radio",1],
			["rhs_6b13_EMR_6sh92_headset_mapcase",1],
			["rhs_6b13_EMR",1],
			["rhs_6b13_Flora_crewofficer",1],
			["rhs_6b13_Flora_6sh92",1],
			["rhs_6b13_Flora_6sh92_vog",1],
			["rhs_6b13_Flora_6sh92_radio",1],
			["rhs_6b13_Flora_6sh92_headset_mapcase",1]
					
		],
		// lieutenant uniforms
		[
		],
		// captain uniforms
		[
			["U_O_GhillieSuit",1]
		],
		// major uniforms
		[
			["U_O_FullGhillie_sard",1],
			["U_O_FullGhillie_ard",1]
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
			["MineDetector",1,true],
			["Binocular",1,true], 
			["FirstAidKit",1,true],
			["Medikit",1,true],
			["rhs_1PN138",1,true],
			["ToolKit",1,true],
			["B_UavTerminal",1,true],
			["B_UAV_01_backpack_F",1,true]
		],
		// corporal items
		[
			["rhs_pdu4",1,true]
			
			
		],
		// sergeant items
		[
		],
		// lieutenant items
		[
			["Rangefinder",1,true]
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

d_all_magazines = [
		["30Rnd_45ACP_Mag_SMG_01",10], ["11Rnd_45ACP_Mag",10], ["16Rnd_9x21_Mag",10], ["30Rnd_9x21_Mag",10], ["30Rnd_65x39_caseless_mag_Tracer",10],
		["30Rnd_65x39_caseless_mag",10], ["100Rnd_65x39_caseless_mag",10], ["20Rnd_762x51_Mag",10], ["30Rnd_556x45_Stanag",10],
		["7Rnd_408_mag",3], ["5Rnd_127x108_Mag",3], ["rhsgref_5Rnd_762x54_m38",10],
		["200Rnd_65x39_cased_Box",10], ["200Rnd_65x39_cased_Box_Tracer",10], ["100Rnd_65x39_caseless_mag_Tracer",10],
		["NLAW_F",3], ["Titan_AT",1], ["RPG32_F",3], ["Titan_AA",3], ["RPG32_HE_F",3],
		["1Rnd_HE_Grenade_shell",10], ["1Rnd_Smoke_Grenade_shell",10], ["1Rnd_SmokeBlue_Grenade_shell",10], ["1Rnd_SmokeGreen_Grenade_shell",10], ["1Rnd_SmokeOrange_Grenade_shell",10],
		["1Rnd_SmokePurple_Grenade_shell",10], ["1Rnd_SmokeRed_Grenade_shell",10], ["1Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_HE_Grenade_shell",10], ["3Rnd_Smoke_Grenade_shell",10],
		["3Rnd_SmokeBlue_Grenade_shell",10], ["3Rnd_SmokeGreen_Grenade_shell",10], ["3Rnd_SmokeOrange_Grenade_shell",10], ["3Rnd_SmokePurple_Grenade_shell",10],
		["3Rnd_SmokeRed_Grenade_shell",10], ["3Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_UGL_FlareCIR_F",10], ["3Rnd_UGL_FlareGreen_F",10], ["3Rnd_UGL_FlareRed_F",10],
		["3Rnd_UGL_FlareWhite_F",10], ["3Rnd_UGL_FlareYellow_F",10], ["UGL_FlareCIR_F",10], ["UGL_FlareGreen_F",10], ["UGL_FlareRed_F",10], ["UGL_FlareWhite_F",10], ["UGL_FlareYellow_F",10],
		["DemoCharge_Remote_Mag",5], ["SatchelCharge_Remote_Mag",5], ["ATMine_Range_Mag",5], ["ClaymoreDirectionalMine_Remote_Mag",5], ["APERSMine_Range_Mag",5], ["APERSBoundingMine_Range_Mag",5],
		["SLAMDirectionalMine_Wire_Mag",5], ["APERSTripMine_Wire_Mag",5],
		["Laserbatteries",5],
		["HandGrenade",5], ["MiniGrenade",5],
		["SmokeShell",5], ["SmokeShellYellow",5], ["SmokeShellGreen",5], ["SmokeShellRed",5], ["SmokeShellPurple",5], ["SmokeShellOrange",5], ["SmokeShellBlue",5],
		//["B_IR_Grenade",5],
		["Chemlight_green",5], ["Chemlight_red",5], ["Chemlight_yellow",5], ["Chemlight_blue",5],
		["200Rnd_556x45_Box_F",1],
		["200Rnd_556x45_Box_Red_F",1],
		["150Rnd_762x54_Box",1],
		["150Rnd_762x54_Box_Tracer",1],
		["200Rnd_556x45_Box_Tracer_F",1],
		["200Rnd_556x45_Box_Tracer_Red_F",1],
		["130Rnd_338_Mag",1],
		["150Rnd_93x64_Mag",1],
		["150Rnd_556x45_Drum_Mag_F",1],
		["150Rnd_556x45_Drum_Mag_Tracer_F",1],
		["30Rnd_556x45_Stanag_Tracer_Yellow",1],
		["30Rnd_556x45_Stanag_Tracer_Green",1],
		["30Rnd_556x45_Stanag_Tracer_Red",1],
		["rhs_mag_30Rnd_556x45_Mk262_Stanag",1],
		["rhs_mag_30Rnd_556x45_Mk318_Stanag",1],
		["rhs_mag_30Rnd_556x45_M200_Stanag",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Yellow",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag",1],
		["rhsusf_100Rnd_556x45_M200_soft_pouch",1],
		["rhsusf_100Rnd_556x45_soft_pouch",1],
		["rhs_200rnd_556x45_M_SAW",1],
		["rhs_200rnd_556x45_B_SAW",1],
		["rhsusf_200Rnd_556x45_soft_pouch",1],
		["rhs_200rnd_556x45_T_SAW",1],
		["rhs_100Rnd_762x54mmR",1],
		["rhsusf_100Rnd_762x51_m61_ap",1],
		["rhsusf_50Rnd_762x51_m61_ap",1],
		["rhsusf_100Rnd_762x51_m62_tracer",1],
		["rhsusf_50Rnd_762x51_m62_tracer",1],
		["rhsusf_100Rnd_762x51",1],
		["rhsusf_50Rnd_762x51",1],
		["rhsusf_100Rnd_762x51_m80a1epr",1],
		["rhsusf_50Rnd_762x51_m80a1epr",1],
		["rhsusf_100Rnd_762x51_m82_blank",1],
		["rhsusf_50Rnd_762x51_m82_blank",1],
		["rhs_100Rnd_762x54mmR_7BZ3",1],
		["rhs_100Rnd_762x54mmR_7N13",1],
		["rhs_100Rnd_762x54mmR_7N26",1],
		["rhs_100Rnd_762x54mmR_green",1],
		["rhssaf_250Rnd_762x54R",1],
		["16Rnd_9x21_yellow_Mag",1],
		["16Rnd_9x21_green_Mag",1],
		["16Rnd_9x21_red_Mag",1],
		["30Rnd_9x21_Yellow_Mag",1],
		["30Rnd_9x21_Green_Mag",1],
		["30Rnd_9x21_Red_Mag",1],
		["rhs_mag_9x19mm_7n21_44",1],
		["rhs_mag_9x19mm_7n21_20",1],
		["rhs_mag_9x19mm_7n31_44",1],
		["rhs_mag_9x19mm_7n31_20",1],
		["rhs_mag_m4009",1],
		["rhs_mag_M397_HET",1],
		["rhs_mag_M433_HEDP",1],
		["rhs_mag_M441_HE",1],
		["rhs_mag_m576",1],
		["rhs_mag_M585_white",1],
		["rhs_mag_m661_green",1],
		["rhs_mag_m662_red",1],
		["rhs_mag_m713_Red",1],
		["rhs_mag_m714_White",1],
		["rhs_mag_m715_Green",1],
		["rhs_mag_m716_yellow",1],
		["6Rnd_GreenSignal_F",1],
		["6Rnd_RedSignal_F",1],
		["IEDUrbanBig_Remote_Mag",1],
		["IEDLandBig_Remote_Mag",1],
		["rhs_mag_m7a3_cs",1],
		["rhs_mag_an_m14_th3",1],
		//["I_IR_Grenade",1],
		//["O_IR_Grenade",1],
		["10Rnd_127x54_Mag",1],
		["10Rnd_762x54_Mag",1],
		["10Rnd_93x64_DMR_05_Mag",1],
		["10Rnd_9x21_Mag",1],
		["10Rnd_338_Mag",1],
		["20Rnd_650x39_Cased_Mag_F",1],
		["5Rnd_127x108_APDS_Mag",1],
		["9Rnd_45ACP_Mag",1],
		["IEDUrbanSmall_Remote_Mag",1],
		["IEDLandSmall_Remote_Mag",1],
		["rhs_mag_m18_green",1],
		["rhs_mag_m18_yellow",1],
		["rhs_mag_m18_red",1],
		["rhs_mag_m18_purple",1],
		["rhs_rpg7_OG7V_mag",1],
		["rhs_mag_m67",1],
		["rhs_mag_rsp30_white",1],
		["rhs_mag_rsp30_green",1],
		["rhs_mag_rsp30_red",1],
		["rhs_mag_mk3a2",1],
		//["rhs_mag_mk84",1],
		["rhs_rpg7_TBG7V_mag",1],
		//["rhs_mag_m69",1],
		["rhs_rpg7_PG7VL_mag",1],
		["rhs_rpg7_PG7VR_mag",1],
		["rhs_rpg7_PG7V_mag",1],
		["RPG7_F",1],
		["6Rnd_45ACP_Cylinder",1],
		["rhsusf_mag_10Rnd_STD_50BMG_M33",1],
		["rhsusf_mag_10Rnd_STD_50BMG_mk211",1],
		["rhs_mag_9x19_17",1],
		["rhsusf_mag_7x45acp_MHP",1],
		["rhs_mag_9x18_8_57N181S",1],
		["rhsusf_20Rnd_762x51_m118_special_Mag",1],
		["rhsusf_20Rnd_762x51_m62_Mag",1],
		["rhsusf_20Rnd_762x51_m993_Mag",1],
		["rhs_mag_9k32_rocket",1],
		["rhs_mag_9k38_rocket",1],
		["rhsusf_mag_15Rnd_9x19_FMJ",1],
		["rhsusf_mag_17Rnd_9x19_FMJ",1],
		["rhsusf_mag_15Rnd_9x19_JHP",1],
		["rhsusf_mag_17Rnd_9x19_JHP",1],
		["rhs_mag_an_m8hc",1],
		["rhs_fim92_mag",1],
		["rhs_fgm148_magazine_AT",1],
		["rhsusf_m112_mag",1],
		["rhsusf_m112x4_mag",1],
		["rhsusf_mine_m14_mag",1],
		["rhs_mine_M19_mag",1],
		["rhs_mag_smaw_SR",1],
		["rhs_mag_smaw_HEDP",1],
		["rhs_mag_smaw_HEAA",1],
		["rhs_rpg7_type69_airburst_mag",1],
		["rhs_VG40MD_White",1],
		["rhs_VG40MD_Green",1],
		["rhs_VG40MD_Red",1],
		["rhs_VG40OP_white",1],
		["rhs_VG40OP_green",1],
		["rhs_VG40OP_red",1],
		["rhs_VG40SZ",1],
		["rhs_VG40TB",1],
		["rhs_VOG25P",1],
		["rhs_VOG25",1],
		["rhs_GDM40",1],
		["rhs_GRD40_White",1],
		["rhs_GRD40_Green",1],
		["rhs_GRD40_Red",1],
		["30Rnd_545x39_Mag_F",1],
		["30Rnd_545x39_Mag_Green_F",1],
		["30Rnd_762x39_Mag_F",1],
		["30Rnd_762x39_Mag_Green_F",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Green",1],
		["10Rnd_50BW_Mag_F",1],
		["100Rnd_580x42_Mag_F",1],
		["100Rnd_580x42_Mag_Tracer_F",1],
		["30Rnd_580x42_Mag_F",1],
		["30Rnd_556x45_Stanag_green",1],
		["30Rnd_556x45_Stanag_red",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Green",1],
		["30Rnd_9x21_Mag_SMG_02_Tracer_Red",1],
		["30Rnd_545x39_Mag_Tracer_F",1],
		["30Rnd_545x39_Mag_Tracer_Green_F",1],
		["30Rnd_580x42_Mag_Tracer_F",1],
		["30Rnd_762x39_Mag_Tracer_F",1],
		["30Rnd_762x39_Mag_Tracer_Green_F",1],
		["20Rnd_556x45_UW_mag",1],
		["30Rnd_65x39_caseless_green",1],
		["30Rnd_65x39_caseless_green_mag_Tracer",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow",1],
		["30Rnd_45ACP_Mag_SMG_01_Tracer_Red",1],
		["30Rnd_9x21_Mag_SMG_02",1],
		["rhs_10rnd_9x39mm_SP5",1],
		["rhs_20rnd_9x39mm_SP5",1],
		["rhs_10rnd_9x39mm_SP6",1],
		["rhs_20rnd_9x39mm_SP6",1],
		["rhsgref_10rnd_765x17_vz61",1],
		["rhsgref_20rnd_765x17_vz61",1],
		["rhsusf_mag_40Rnd_46x30_AP",1],
		["rhsusf_mag_40Rnd_46x30_FMJ",1],
		["rhsusf_mag_40Rnd_46x30_JHP",1],
		["rhs_30Rnd_545x39_AK",1],
		["rhs_30Rnd_545x39_AK_no_tracers",1],
		["rhs_45Rnd_545X39_AK",1],
		["rhsusf_5Rnd_00Buck",1],
		["rhsusf_5Rnd_300winmag_xm2010",1],
		["rhsusf_5Rnd_Slug",1],
		["rhsusf_5Rnd_FRAG",1],
		["rhsusf_5Rnd_HE",1],
		["rhs_5Rnd_338lapua_t5000",1],
		["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Orange",1],
		["rhs_30Rnd_762x39mm",1],
		["rhs_30Rnd_762x39mm_89",1],
		["rhs_30Rnd_762x39mm_tracer",1],
		["rhs_30Rnd_762x39mm_U",1],
		["rhsgref_5Rnd_762x54_m38",1],
		["rhsgref_5Rnd_792x57_kar98k",1],
		["rhsusf_mag_6Rnd_m4009",1],
		["rhsusf_mag_6Rnd_M397_HET",1],
		["rhsusf_mag_6Rnd_M433_HEDP",1],
		["rhsusf_mag_6Rnd_M441_HE",1],
		["rhsusf_mag_6Rnd_M576_Buckshot",1],
		["rhsusf_mag_6Rnd_M585_white",1],
		["rhsusf_mag_6Rnd_m661_green",1],
		["rhsusf_mag_6Rnd_m662_red",1],
		["rhsusf_mag_6Rnd_M713_red",1],
		["rhsusf_mag_6Rnd_M714_white",1],
		["rhsusf_mag_6Rnd_M715_green",1],
		["rhsusf_mag_6Rnd_M716_yellow",1],
		["rhsusf_mag_6Rnd_M781_Practice",1],
		["rhs_10Rnd_762x54mmR_7N1",1],
		["rhs_30Rnd_545x39_7N10_AK",1],
		["rhs_45Rnd_545X39_7N10_AK",1],
		["rhs_30Rnd_545x39_7N22_AK",1],
		["rhs_45Rnd_545X39_7N22_AK",1],
		["rhs_30Rnd_545x39_7N6_AK",1],
		["rhs_45Rnd_545X39_7N6_AK",1],
		["rhs_30Rnd_545x39_AK_green",1],
		["rhs_45Rnd_545X39_AK_Green",1],
		["rhs_30Rnd_545x39_7U1_AK",1],
		["rhs_45Rnd_545X39_7U1_AK",1],
		["rhsusf_10Rnd_762x51_m118_special_Mag",1],
		["rhsusf_5Rnd_762x51_m118_special_Mag",1],
		["rhsusf_10Rnd_762x51_m62_Mag",1],
		["rhsusf_5Rnd_762x51_m62_Mag",1],
		["rhsusf_10Rnd_762x51_m993_Mag",1],
		["rhsusf_5Rnd_762x51_m993_Mag",1],
		["rhsusf_8Rnd_00Buck",1],
		["rhsusf_8Rnd_Slug",1],
		["rhsusf_8Rnd_FRAG",1],
		["rhsusf_8Rnd_HE",1],
		["rhs_mag_maaws_HEDP",1],
		["rhs_mag_maaws_HEAT",1],
		["rhs_mag_maaws_HE",1],
		["rhssaf_100rnd_556x45_EPR_G36",1],
		["rhssaf_30rnd_556x45_EPR_G36",1],
		["rhssaf_30rnd_556x45_MDIM_G36",1],
		["rhssaf_30rnd_556x45_TDIM_G36",1],
		["rhssaf_30rnd_556x45_SOST_G36",1],
		["rhssaf_30rnd_556x45_SPR_G36",1],
		["rhssaf_30rnd_556x45_Tracers_G36",1],
		["rhsgref_30rnd_556x45_m21_t",1],
		["rhsgref_30rnd_556x45_m21",1],
		["rhssaf_10Rnd_792x57_m76_tracer",1],
		["rhsgref_10Rnd_792x57_m76",1],
		["rhs_mag_M781_Practice",1]

];

d_backpackclasses = [
		["rhs_sidor",1],
		["rhs_rpg_empty",1],
		["rhs_assault_umbts",1],
		["rhs_assault_umbts_engineer_empty",1],
		["RHS_Podnos_Bipod_Bag",1],
		["RHS_Podnos_Gun_Bag",1],
		["RHS_Metis_Gun_Bag",1],
		["RHS_Metis_Tripod_Bag",1],
		["RHS_Kornet_Gun_Bag",1],
		["RHS_Kornet_Tripod_Bag",1],
		["RHS_AGS30_Tripod_Bag",1],
		["RHS_AGS30_Gun_Bag",1],
		["RHS_DShkM_Gun_Bag",1],
		["RHS_DShkM_TripodHigh_Bag",1],
		["RHS_DShkM_TripodLow_Bag",1],
		["RHS_Kord_Tripod_Bag",1],
		["RHS_Kord_Gun_Bag",1],
		["RHS_NSV_Tripod_Bag",1],
		["RHS_NSV_Gun_Bag",1],
		["RHS_SPG9_Gun_Bag",1],
		["rhssaf_kitbag_digital",1],
		["rhssaf_kitbag_md2camo",1],
		["rhssaf_kitbag_smb",1],
		["RHS_SPG9_Tripod_Bag",1],
		["rhsgref_hidf_alicepack",1],
		["rhsgref_ttsko_alicepack",1],
		["rhsgref_wdl_alicepack",1],
		["rhssaf_alice_md2camo",1],
		["rhssaf_alice_smb",1]
	
];
#endif

#ifdef __OWN_SIDE_INDEPENDENT__
#endif

#ifdef __TT__
private _helipilotgear = [];
private _helipilothelmet = [];
if (d_pilots_only == 1) then {
	_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
	_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
	_helipilotgeare = ["U_O_HeliPilotCoveralls",1,true];
	_helipilothelmete = ["H_PilotHelmetFighter_O",1,true];
} else {
	if (d_only_pilots_can_fly isEqualTo []) then {
		_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
		_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
		_helipilotgeare = ["U_O_HeliPilotCoveralls",1,true];
		_helipilothelmete = ["H_PilotHelmetFighter_O",1,true];
	} else {
		if (str player in d_only_pilots_can_fly) then {
			_helipilotgear = ["U_B_HeliPilotCoveralls",1,true];
			_helipilothelmet = ["H_PilotHelmetFighter_B",1,true];
			_helipilotgeare = ["U_O_HeliPilotCoveralls",1,true];
			_helipilothelmete = ["H_PilotHelmetFighter_O",1,true];
		};
	};
};

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			//["arifle_MX_F",1], ["arifle_MX_Black_F",1], ["hgun_PDW2000_F",1]
			["arifle_MX_F",1]
		],
		// corporal rifles (gets added to private rifles)
		[
			["arifle_MX_GL_F",1], ["arifle_MXM_F",1], ["arifle_Mk20_F",1], ["arifle_MX_GL_Black_F",1], ["arifle_MXM_Black_F",1]
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			["arifle_SDAR_F",1], ["arifle_MX_SW_F",1], ["arifle_MXC_F",1], ["arifle_Mk20C_F",1], ["arifle_MXC_Black_F", 1], ["arifle_MX_SW_Black_F",1]
		],
		// lieutenant rifles (gets added to...)
		[
			["arifle_TRG21_F",1],["arifle_TRG21_GL_F",1], ["arifle_Mk20_GL_F",1]
		],
		// captain rifles (gets added...)
		[
			["arifle_TRG20_F",1]
		],
		// major rifles (gets...)
		[
		],
		// colonel rifles (...)
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private sniper rifles
		[
		],
		// corporal sniper rifles
		[
		],
		// sergeant sniper rifles
		[
			["srifle_EBR_F",1]
		],
		// lieutenant sniper rifles
		[
		],
		// captain sniper rifles
		[
		],
		// major sniper rifles
		[
		],
		// colonel sniper rifles
		[
			["srifle_LRR_F",1], ["srifle_GM6_F",1]
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private MG
		[
		],
		// corporal MG
		[
			["LMG_Mk200_F",1]
		],
		// sergeant MG
		[
			["SMG_01_F",1]
		],
		// lieutenant MG
		[
		],
		// captain MG
		[
			["SMG_02_F",1]
		],
		// major MG
		[
		],
		// colonel MG
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			["launch_NLAW_F",1], ["launch_B_Titan_F",1]
		],
		// corporal launchers
		[
			["launch_RPG32_F",1]
		],
		// sergeant launchers
		[
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
		],
		// major launchers
		[
			["launch_B_Titan_short_F",1]
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
		],
		// corporal pistols
		[
			["hgun_P07_F",1]
		],
		// sergeant pistols
		[
		],
		// lieutenant pistols
		[
		],
		// captain pistols
		[
		],
		// major pistols
		[
			["hgun_Pistol_heavy_01_F",1]
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
			["optic_Holosight",1, true],["acc_pointer_IR",1, true]
		],
		// sergeant optics
		[
			["acc_flashlight",1, true],["optic_Holosight_smg",1, true]
		],
		// lieutenant optics
		[
			 ["optic_MRD",1, true],["optic_MRCO",1, true]
		],
		// captain optics
		[
			["optic_Aco",1, true],["optic_ACO_grn",1, true],["optic_Arco",1, true],["optic_Hamr",1, true]
		],
		// major optics
		[
			["LaserDesignator",1,true], ["optic_Aco_smg",1,true], ["optic_ACO_grn_smg",1,true], ["optic_tws",1,true], ["optic_tws_mg",1,true], ["optic_DMS",1,true]
		],
		// colonel optics
		[
			["optic_SOS",1,true], ["optic_NVS",1,true], ["optic_Nightstalker",1,true], ["optic_LRPS",1,true]
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
			["muzzle_snds_B",1, true]
		],
		// lieutenant muzzles
		[
			["muzzle_snds_H",1, true],["muzzle_snds_L",1, true], ["muzzle_snds_M",1, true], ["muzzle_snds_acp", 1, true]
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			["muzzle_snds_H_MG",1, true]
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
			["H_Cap_blu",1,true], ["H_Cap_headphones",1,true], ["H_Cap_red",1,true], ["H_HelmetB",1,true], ["H_Booniehat_khk",1,true], ["H_HelmetB_paint",1,true], ["H_MilCap_mcamo",1,true],
			["U_B_CombatUniform_mcam",1,true],["U_B_CombatUniform_mcam_tshirt",1,true], ["U_B_CombatUniform_mcam_vest",1,true], ["U_B_GhillieSuit",1,true],
			["U_B_Wetsuit",1,true], ["V_RebreatherB",1,true], ["V_Rangemaster_belt",1,true], ["V_BandollierB_khk",1,true], ["V_BandollierB_cbr",1,true], ["V_BandollierB_rgr",1,true],
			["V_PlateCarrier1_rgr",1,true], ["V_PlateCarrier2_rgr",1,true], ["V_PlateCarrierGL_rgr",1,true], ["V_TacVest_khk",1,true], ["V_TacVest_brn",1,true],
			["V_TacVest_oli",1,true], ["V_TacVest_blk",1,true], ["U_B_CombatUniform_mcam_worn",1,true], ["U_B_CombatUniform_wdl",1,true], ["U_B_CombatUniform_wdl_tshirt",1,true],
			["U_B_CombatUniform_wdl_vest",1,true], ["U_B_CombatUniform_sgg",1,true], ["U_B_CombatUniform_sgg_tshirt",1,true], ["U_B_CombatUniform_sgg_vest",1,true], ["U_B_SpecopsUniform_sgg",1,true],
			_helipilotgear,_helipilothelmet
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
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
		]
	],
	// additional weapons and items, no rank
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
			["MineDetector",1], ["Binocular",1], (if (d_no_faks == 1) then {["FirstAidKit",5,true]} else {[]}), ["Medikit",5,true],
			(if (d_without_nvg == 1) then {["NVGoggles",1,true]} else {[]}),
			["ToolKit",1,true], ["B_UavTerminal",1,true]
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			//["arifle_MX_F",1], ["arifle_MX_Black_F",1], ["hgun_PDW2000_F",1]
			["arifle_MX_Black_F",1]
		],
		// corporal rifles (gets added to private rifles)
		[
			["arifle_MX_GL_F",1], ["arifle_MXM_F",1], ["arifle_Mk20_F",1], ["arifle_MX_GL_Black_F",1], ["arifle_MXM_Black_F",1]
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			["arifle_SDAR_F",1], ["arifle_MX_SW_F",1], ["arifle_MXC_F",1], ["arifle_Mk20C_F",1], ["arifle_MXC_Black_F", 1], ["arifle_MX_SW_Black_F",1]
		],
		// lieutenant rifles (gets added to...)
		[
			["arifle_TRG21_F",1],["arifle_TRG21_GL_F",1], ["arifle_Mk20_GL_F",1]
		],
		// captain rifles (gets added...)
		[
			["arifle_TRG20_F",1]
		],
		// major rifles (gets...)
		[
		],
		// colonel rifles (...)
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private sniper rifles
		[
		],
		// corporal sniper rifles
		[
		],
		// sergeant sniper rifles
		[
			["srifle_EBR_F",1]
		],
		// lieutenant sniper rifles
		[
		],
		// captain sniper rifles
		[
		],
		// major sniper rifles
		[
		],
		// colonel sniper rifles
		[
			["srifle_LRR_F",1], ["srifle_GM6_F",1]
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private MG
		[
		],
		// corporal MG
		[
			["LMG_Mk200_F",1]
		],
		// sergeant MG
		[
			["SMG_01_F",1]
		],
		// lieutenant MG
		[
		],
		// captain MG
		[
			["SMG_02_F",1]
		],
		// major MG
		[
		],
		// colonel MG
		[
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			["launch_NLAW_F",1], ["launch_B_Titan_F",1]
		],
		// corporal launchers
		[
			["launch_RPG32_F",1]
		],
		// sergeant launchers
		[
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
		],
		// major launchers
		[
			["launch_B_Titan_short_F",1]
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
		],
		// corporal pistols
		[
			["hgun_P07_F",1]
		],
		// sergeant pistols
		[
		],
		// lieutenant pistols
		[
		],
		// captain pistols
		[
		],
		// major pistols
		[
			["hgun_Pistol_heavy_01_F",1]
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
			["optic_Holosight",1, true],["acc_pointer_IR",1, true]
		],
		// sergeant optics
		[
			["acc_flashlight",1, true],["optic_Holosight_smg",1, true]
		],
		// lieutenant optics
		[
			 ["optic_MRD",1, true],["optic_MRCO",1, true]
		],
		// captain optics
		[
			["optic_Aco",1, true],["optic_ACO_grn",1, true],["optic_Arco",1, true],["optic_Hamr",1, true]
		],
		// major optics
		[
			["LaserDesignator",1,true], ["optic_Aco_smg",1,true], ["optic_ACO_grn_smg",1,true], ["optic_tws",1,true], ["optic_tws_mg",1,true], ["optic_DMS",1,true]
		],
		// colonel optics
		[
			["optic_SOS",1,true], ["optic_NVS",1,true], ["optic_Nightstalker",1,true], ["optic_LRPS",1,true]
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
			["muzzle_snds_B",1, true]
		],
		// lieutenant muzzles
		[
			["muzzle_snds_H",1, true],["muzzle_snds_L",1, true], ["muzzle_snds_M",1, true], ["muzzle_snds_acp", 1, true]
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			["muzzle_snds_H_MG",1, true]
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
			["H_Cap_blu",1,true], ["H_Cap_headphones",1,true], ["H_Cap_red",1,true], ["H_HelmetB",1,true], ["H_Booniehat_khk",1,true], ["H_HelmetB_paint",1,true], ["H_MilCap_mcamo",1,true],
			["U_B_CombatUniform_mcam",1,true],["U_B_CombatUniform_mcam_tshirt",1,true], ["U_B_CombatUniform_mcam_vest",1,true], ["U_B_GhillieSuit",1,true],
			["U_B_Wetsuit",1,true], ["V_RebreatherB",1,true], ["V_Rangemaster_belt",1,true], ["V_BandollierB_khk",1,true], ["V_BandollierB_cbr",1,true], ["V_BandollierB_rgr",1,true],
			["V_PlateCarrier1_rgr",1,true], ["V_PlateCarrier2_rgr",1,true], ["V_PlateCarrierGL_rgr",1,true], ["V_TacVest_khk",1,true], ["V_TacVest_brn",1,true],
			["V_TacVest_oli",1,true], ["V_TacVest_blk",1,true], ["U_B_CombatUniform_mcam_worn",1,true], ["U_B_CombatUniform_wdl",1,true], ["U_B_CombatUniform_wdl_tshirt",1,true],
			["U_B_CombatUniform_wdl_vest",1,true], ["U_B_CombatUniform_sgg",1,true], ["U_B_CombatUniform_sgg_tshirt",1,true], ["U_B_CombatUniform_sgg_vest",1,true], ["U_B_SpecopsUniform_sgg",1,true],
			_helipilotgeare,_helipilothelmete
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
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
		]
	],
	// additional weapons and items, no rank
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
			["MineDetector",1], ["Binocular",1], (if (d_no_faks == 1) then {["FirstAidKit",5,true]} else {[]}), ["Medikit",5,true],
			(if (d_without_nvg == 1) then {["NVGoggles",1,true]} else {[]}),
			["ToolKit",1,true], ["B_UavTerminal",1,true]
		]
	]
];

private _d_all_magazines_blufor = [
	["30Rnd_45ACP_Mag_SMG_01",10], ["11Rnd_45ACP_Mag",10], ["16Rnd_9x21_Mag",10], ["30Rnd_9x21_Mag",10], ["30Rnd_65x39_caseless_mag",10], ["30Rnd_65x39_caseless_mag_Tracer",10],
	["30Rnd_65x39_caseless_mag",10], ["100Rnd_65x39_caseless_mag",10], ["20Rnd_762x51_Mag",10], ["30Rnd_556x45_Stanag",10],
	["7Rnd_408_mag",3], ["5Rnd_127x108_Mag",3],
	["200Rnd_65x39_cased_Box",10], ["200Rnd_65x39_cased_Box_Tracer",10], ["100Rnd_65x39_caseless_mag_Tracer",10],
	["NLAW_F",3], ["Titan_AT",1], ["RPG32_F",3], ["Titan_AA",3], ["RPG32_HE_F",3],
	["1Rnd_HE_Grenade_shell",10], ["1Rnd_Smoke_Grenade_shell",10], ["1Rnd_SmokeBlue_Grenade_shell",10], ["1Rnd_SmokeGreen_Grenade_shell",10], ["1Rnd_SmokeOrange_Grenade_shell",10],
	["1Rnd_SmokePurple_Grenade_shell",10], ["1Rnd_SmokeRed_Grenade_shell",10], ["1Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_HE_Grenade_shell",10], ["3Rnd_Smoke_Grenade_shell",10],
	["3Rnd_SmokeBlue_Grenade_shell",10], ["3Rnd_SmokeGreen_Grenade_shell",10], ["3Rnd_SmokeOrange_Grenade_shell",10], ["3Rnd_SmokePurple_Grenade_shell",10],
	["3Rnd_SmokeRed_Grenade_shell",10], ["3Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_UGL_FlareCIR_F",10], ["3Rnd_UGL_FlareGreen_F",10], ["3Rnd_UGL_FlareRed_F",10],
	["3Rnd_UGL_FlareWhite_F",10], ["3Rnd_UGL_FlareYellow_F",10], ["UGL_FlareCIR_F",10], ["UGL_FlareGreen_F",10], ["UGL_FlareRed_F",10], ["UGL_FlareWhite_F",10], ["UGL_FlareYellow_F",10],
	["DemoCharge_Remote_Mag",5], ["SatchelCharge_Remote_Mag",5], ["ATMine_Range_Mag",5], ["ClaymoreDirectionalMine_Remote_Mag",5], ["APERSMine_Range_Mag",5], ["APERSBoundingMine_Range_Mag",5],
	["SLAMDirectionalMine_Wire_Mag",5], ["APERSTripMine_Wire_Mag",5],
	["Laserbatteries",5],
	["HandGrenade",5], ["MiniGrenade",5], ["SmokeShell",5], ["SmokeShellYellow",5], ["SmokeShellGreen",5], ["SmokeShellRed",5], ["SmokeShellPurple",5], ["SmokeShellOrange",5], ["SmokeShellBlue",5],
	["B_IR_Grenade",5],
	["Chemlight_green",5], ["Chemlight_red",5], ["Chemlight_yellow",5], ["Chemlight_blue",5]
];

private _d_backpackclasses_blufor = [
	"B_AssaultPack_khk", "B_AssaultPack_dgtl", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_AssaultPack_blk", "B_AssaultPack_blk", "B_AssaultPack_cbr",
	"B_AssaultPack_mcamo", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_cbr", "B_Bergen_sgg", "B_Bergen_mcamo", "B_Bergen_rgr", "B_Bergen_blk", "B_FieldPack_blk", "B_FieldPack_cbr",
	"B_Carryall_mcamo", "B_AssaultPack_rgr_LAT", "B_AssaultPack_rgr_Medic", "B_AssaultPack_rgr_Repair", "B_AssaultPack_blk_DiverExp", "B_Kitbag_rgr_Exp",
	"B_FieldPack_blk_DiverExp"
];

private _d_all_magazines_opfor = [
	["30Rnd_45ACP_Mag_SMG_01",10], ["11Rnd_45ACP_Mag",10], ["16Rnd_9x21_Mag",10], ["30Rnd_9x21_Mag",10], ["30Rnd_65x39_caseless_mag",10], ["30Rnd_65x39_caseless_mag_Tracer",10],
	["30Rnd_65x39_caseless_mag",10], ["100Rnd_65x39_caseless_mag",10], ["20Rnd_762x51_Mag",10], ["30Rnd_556x45_Stanag",10],
	["7Rnd_408_mag",3], ["5Rnd_127x108_Mag",3],
	["200Rnd_65x39_cased_Box",10], ["200Rnd_65x39_cased_Box_Tracer",10], ["100Rnd_65x39_caseless_mag_Tracer",10],
	["NLAW_F",3], ["Titan_AT",1], ["RPG32_F",3], ["Titan_AA",3], ["RPG32_HE_F",3],
	["1Rnd_HE_Grenade_shell",10], ["1Rnd_Smoke_Grenade_shell",10], ["1Rnd_SmokeBlue_Grenade_shell",10], ["1Rnd_SmokeGreen_Grenade_shell",10], ["1Rnd_SmokeOrange_Grenade_shell",10],
	["1Rnd_SmokePurple_Grenade_shell",10], ["1Rnd_SmokeRed_Grenade_shell",10], ["1Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_HE_Grenade_shell",10], ["3Rnd_Smoke_Grenade_shell",10],
	["3Rnd_SmokeBlue_Grenade_shell",10], ["3Rnd_SmokeGreen_Grenade_shell",10], ["3Rnd_SmokeOrange_Grenade_shell",10], ["3Rnd_SmokePurple_Grenade_shell",10],
	["3Rnd_SmokeRed_Grenade_shell",10], ["3Rnd_SmokeYellow_Grenade_shell",10], ["3Rnd_UGL_FlareCIR_F",10], ["3Rnd_UGL_FlareGreen_F",10], ["3Rnd_UGL_FlareRed_F",10],
	["3Rnd_UGL_FlareWhite_F",10], ["3Rnd_UGL_FlareYellow_F",10], ["UGL_FlareCIR_F",10], ["UGL_FlareGreen_F",10], ["UGL_FlareRed_F",10], ["UGL_FlareWhite_F",10], ["UGL_FlareYellow_F",10],
	["DemoCharge_Remote_Mag",5], ["SatchelCharge_Remote_Mag",5], ["ATMine_Range_Mag",5], ["ClaymoreDirectionalMine_Remote_Mag",5], ["APERSMine_Range_Mag",5], ["APERSBoundingMine_Range_Mag",5],
	["SLAMDirectionalMine_Wire_Mag",5], ["APERSTripMine_Wire_Mag",5],
	["Laserbatteries",5],
	["HandGrenade",5], ["MiniGrenade",5], ["SmokeShell",5], ["SmokeShellYellow",5], ["SmokeShellGreen",5], ["SmokeShellRed",5], ["SmokeShellPurple",5], ["SmokeShellOrange",5], ["SmokeShellBlue",5],
	["B_IR_Grenade",5],
	["Chemlight_green",5], ["Chemlight_red",5], ["Chemlight_yellow",5], ["Chemlight_blue",5]
];

private _d_backpackclasses_opfor = [
	"B_AssaultPack_khk", "B_AssaultPack_dgtl", "B_AssaultPack_rgr", "B_AssaultPack_sgg", "B_AssaultPack_blk", "B_AssaultPack_blk", "B_AssaultPack_cbr",
	"B_AssaultPack_mcamo", "B_Kitbag_mcamo", "B_Kitbag_sgg", "B_Kitbag_cbr", "B_Bergen_sgg", "B_Bergen_mcamo", "B_Bergen_rgr", "B_Bergen_blk", "B_FieldPack_blk", "B_FieldPack_cbr",
	"B_Carryall_mcamo", "B_AssaultPack_rgr_LAT", "B_AssaultPack_rgr_Medic", "B_AssaultPack_rgr_Repair", "B_AssaultPack_blk_DiverExp", "B_Kitbag_rgr_Exp",
	"B_FieldPack_blk_DiverExp"
];

private ["_all_weapons_items"];
if (str player in d_entities_tt_blufor) then {
	__TRACE("Player is blufor")
	_all_weapons_items = _all_weapons_items_blufor;
	d_all_magazines = _d_all_magazines_blufor;
	d_backpackclasses = _d_backpackclasses_blufor;
} else {
	__TRACE("Player is opfor")
	_all_weapons_items = _all_weapons_items_opfor;
	d_all_magazines = _d_all_magazines_opfor;
	d_backpackclasses = _d_backpackclasses_opfor;
};
#endif

#include "i_weapons_base.sqf";
