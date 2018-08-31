// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_CUP.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"CUP_smg_MP5A5", "CUP_arifle_G36A", "CUP_arifle_G36A_camo", "CUP_arifle_G36K", "CUP_arifle_G36K_camo", "CUP_arifle_G36C",
			"CUP_arifle_G36C_camo", "CUP_arifle_M16A2", "CUP_arifle_M16A4_Base", "CUP_arifle_M4A1", "CUP_arifle_M4A1_camo", "CUP_arifle_M4A1_black".
			"CUP_arifle_M4A1_desert", "CUP_lmg_M240", "CUP_lmg_M60E4"
		],
		// corporal rifles (gets added to private rifles)
		[
			"CUP_smg_MP5SD6", "CUP_arifle_MG36", "CUP_arifle_MG36_camo", "CUP_arifle_M16A2_GL", "CUP_arifle_M16A4_GL", "CUP_arifle_M4A1_BUIS_GL",
			"CUP_arifle_M4A1_BUIS_camo_GL", "CUP_arifle_M4A1_BUIS_desert_GL", "CUP_arifle_M4A3_desert"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"CUP_glaunch_M79", "CUP_lmg_minimi", "CUP_lmg_m249_para", "CUP_lmg_Mk48_des", "CUP_lmg_Mk48_wdl"
		],
		// lieutenant rifles (gets added to...)
		[
			"CUP_sgun_M1014", "CUP_lmg_m249_para_gl", "CUP_lmg_M249_E2", "CUP_lmg_minimi_railed", "CUP_arifle_Mk16_CQC", "CUP_arifle_Mk16_CQC_FG",
			"CUP_arifle_Mk16_CQC_SFG", "CUP_arifle_Mk16_CQC_EGLM", "CUP_arifle_Mk16_STD", "CUP_arifle_Mk16_STD_FG", "CUP_arifle_Mk16_STD_SFG",
			"CUP_arifle_Mk16_STD_EGLM", "CUP_arifle_Mk16_SV"
		],
		// captain rifles (gets added...)
		[
			"CUP_glaunch_M32", "CUP_srifle_Mk12SPR", "CUP_arifle_Mk17_CQC", "CUP_arifle_Mk17_CQC_FG", "CUP_arifle_Mk17_CQC_SFG", "CUP_arifle_Mk17_CQC_EGLM",
			"CUP_arifle_Mk17_STD", "CUP_arifle_Mk17_STD_FG", "CUP_arifle_Mk17_STD_SFG", "CUP_arifle_Mk17_STD_EGLM", "CUP_arifle_Mk20"
		],
		// major rifles (gets...)
		[
			"CUP_srifle_M14_DMR", "CUP_srifle_M24_des", "CUP_srifle_M24_wdl", "CUP_srifle_M40A3", "CUP_srifle_M110", "CUP_srifle_M14", "CUP_arifle_XM8_Carbine",
			"CUP_arifle_XM8_Carbine_GL", "CUP_arifle_xm8_sharpshooter", "CUP_arifle_xm8_SAW", "CUP_arifle_XM8_Compact", "CUP_arifle_XM8_Compact_Rail",
			"CUP_arifle_XM8_Railed", "CUP_arifle_XM8_Carbine_FG"
		],
		// colonel rifles (...)
		[
			"CUP_sgun_AA12", "CUP_glaunch_Mk13", "CUP_srifle_AS50", "CUP_srifle_AWM_des", "CUP_srifle_AWM_wdl", "CUP_srifle_G22_des", "CUP_srifle_G22_wdl",
			"CUP_srifle_M107_Base"
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
		// capain launchers
		[
			"CUP_launch_Mk153Mod0"
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
		],
		// corporal pistols
		[
			"CUP_hgun_M9"
		],
		// sergeant pistols
		[
			"CUP_hgun_Glock17", "CUP_hgun_Glock17_blk", "CUP_hgun_Glock17_tan"
		],
		// lieutenant pistols
		[
			"CUP_hgun_Colt1911"
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
			"acc_flashlight_smg_01", "optic_Holosight_smg_blk_F", "optic_Holosight_smg_khk_F"
		],
		// corporal optics
		[
			"optic_Holosight", "acc_pointer_IR", "optic_Aco", "optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Holosight_blk_F",
			"optic_Holosight_khk_F"
		],
		// sergeant optics
		[
			"acc_flashlight", "optic_Holosight_smg", "acc_flashlight_pistol"
		],
		// lieutenant optics
		[
			 "optic_MRD", "optic_MRCO", "optic_Yorris"
		],
		// captain optics
		[
			"optic_ACO_grn", "optic_Arco", "optic_Hamr", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Hamr_khk_F"
		],
		// major optics
		[
			"LaserDesignator", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_DMS", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_DMS_ghex_F"
		],
		// colonel optics
		[
			"optic_SOS", "optic_NVS", "optic_Nightstalker", "optic_LRPS", "optic_tws", "optic_tws_mg", "optic_KHS_blk", "optic_KHS_hex",
			"optic_KHS_old", "optic_KHS_tan", "optic_SOS_khk_F", "optic_LRPS_tna_F", "optic_LRPS_ghex_F"
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
			"muzzle_snds_H", "muzzle_snds_M", "muzzle_snds_L", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_m_khk_F",
			"muzzle_snds_m_snd_F", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F", "muzzle_snds_65_TI_ghex_F"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_B", "muzzle_snds_acp", "muzzle_snds_58_blk_F", "muzzle_snds_58_wdm_F", "muzzle_snds_58_ghex_F", "muzzle_snds_58_hex_F",
			"muzzle_snds_65_TI_blk_F", "muzzle_snds_65_TI_hex_F"
			
		],
		// captain muzzles
		[
			"muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand", "muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"
		],
		// major muzzles
		[
			"muzzle_snds_H_MG", "muzzle_snds_H_MG_blk_F", "muzzle_snds_H_MG_khk_F"
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
			"CUP_hgun_SA61", "CUP_U_B_GER_Tropentarn_2", "CUP_U_B_GER_Flecktarn_1", "CUP_U_B_GER_Flecktarn_2", "CUP_U_B_USArmy_Base", "CUP_U_B_USArmy_TwoKnee",
			"CUP_U_B_USArmy_UBACS", "CUP_U_B_USArmy_Soft"
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
			"CUP_arifle_AK47", "CUP_arifle_AK74", "CUP_arifle_AK74M", "CUP_arifle_AKS74", "CUP_arifle_AKS74U", "CUP_arifle_AKM", "CUP_arifle_AKS",
			"CUP_arifle_RPK74", "CUP_arifle_RPK74M", "CUP_smg_bizon", "CUP_lmg_PKM"
		],
		// corporal rifles (gets added to private rifles)
		[
			"CUP_arifle_AK74M_GL", "CUP_arifle_AK107", "CUP_arifle_AK74_GL", "CUP_arifle_RPK74_45", "CUP_lmg_Pecheneg"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"CUP_arifle_AK107_GL"
		],
		// lieutenant rifles (gets added to...)
		[
			"CUP_sgun_Saiga12K"
		],
		// captain rifles (gets added...)
		[
			"CUP_srifle_VSSVintorez"
		],
		// major rifles (gets...)
		[
			"CUP_srifle_LeeEnfield", "CUP_srifle_LeeEnfield_rail", "CUP_srifle_SVD", "CUP_srifle_SVD_des"
		],
		// colonel rifles (...)
		[
			"CUP_srifle_ksvk", "CUP_glaunch_6G30", "CUP_arifle_AKS_Gold"
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
		],
		// lieutenant launchers
		[
			"CUP_launch_M47"
		],
		// capain launchers
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
		],
		// corporal pistols
		[
			"CUP_hgun_Makarov"
		],
		// sergeant pistols
		[
		],
		// lieutenant pistols
		[
			"CUP_hgun_PB6P9"
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
			"acc_flashlight_smg_01", "optic_Holosight_smg_blk_F", "optic_Holosight_smg_khk_F"
		],
		// corporal optics
		[
			"optic_Holosight", "acc_pointer_IR", "optic_Aco", "optic_ERCO_blk_F", "optic_ERCO_khk_F", "optic_ERCO_snd_F", "optic_Holosight_blk_F",
			"optic_Holosight_khk_F"
		],
		// sergeant optics
		[
			"acc_flashlight", "optic_Holosight_smg", "acc_flashlight_pistol"
		],
		// lieutenant optics
		[
			 "optic_MRD", "optic_MRCO", "optic_Yorris"
		],
		// captain optics
		[
			"optic_ACO_grn", "optic_Arco", "optic_Hamr", "optic_Arco_blk_F", "optic_Arco_ghex_F", "optic_Hamr_khk_F"
		],
		// major optics
		[
			"LaserDesignator", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_DMS", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_DMS_ghex_F"
			
		],
		// colonel optics
		[
			"optic_SOS", "optic_NVS", "optic_Nightstalker", "optic_LRPS", "optic_tws", "optic_tws_mg", "optic_KHS_blk", "optic_KHS_hex",
			"optic_KHS_old", "optic_KHS_tan", "optic_SOS_khk_F", "optic_LRPS_tna_F", "optic_LRPS_ghex_F"
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
			"muzzle_snds_H", "muzzle_snds_M", "muzzle_snds_L", "muzzle_snds_H_khk_F", "muzzle_snds_H_snd_F", "muzzle_snds_m_khk_F",
			"muzzle_snds_m_snd_F", "muzzle_snds_B_khk_F", "muzzle_snds_B_snd_F", "muzzle_snds_65_TI_ghex_F"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_B", "muzzle_snds_acp", "muzzle_snds_58_blk_F", "muzzle_snds_58_wdm_F", "muzzle_snds_58_ghex_F", "muzzle_snds_58_hex_F",
			"muzzle_snds_65_TI_blk_F", "muzzle_snds_65_TI_hex_F"
			
		],
		// captain muzzles
		[
			"muzzle_snds_338_black", "muzzle_snds_338_green", "muzzle_snds_338_sand", "muzzle_snds_93mmg", "muzzle_snds_93mmg_tan"
		],
		// major muzzles
		[
			"muzzle_snds_H_MG", "muzzle_snds_H_MG_blk_F", "muzzle_snds_H_MG_khk_F"
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
			"H_Cap_blu", "H_Cap_headphones", "H_Cap_red", "H_HelmetB", "H_Booniehat_khk", "H_HelmetB_paint", "H_MilCap_mcamo",
			"U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_vest", "U_B_GhillieSuit",
			"U_B_Wetsuit", "V_RebreatherB", "V_Rangemaster_belt", "V_BandollierB_khk", "V_BandollierB_cbr", "V_BandollierB_rgr",
			"V_PlateCarrier1_rgr", "V_PlateCarrier2_rgr", "V_PlateCarrierGL_rgr", "V_TacVest_khk", "V_TacVest_brn",
			"V_TacVest_oli", "V_TacVest_blk", "U_B_CombatUniform_mcam_worn", "U_B_CombatUniform_wdl", "U_B_CombatUniform_wdl_tshirt",
			"U_B_CombatUniform_wdl_vest", "U_B_CombatUniform_sgg", "U_B_CombatUniform_sgg_tshirt", "U_B_CombatUniform_sgg_vest", "U_B_SpecopsUniform_sgg"
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

#include "i_weapons_base.sqf";
