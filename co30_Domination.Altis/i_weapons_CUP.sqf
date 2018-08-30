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
			"arifle_MX_F", "arifle_MX_Black_F", "arifle_MX_khk_F", "arifle_SDAR_F", "hgun_PDW2000_F", "SMG_05_F", "SMG_01_F"
		],
		// corporal rifles (gets added to private rifles)
		[
			"arifle_MX_GL_F", "arifle_MX_GL_Black_F", "arifle_MX_SW_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_khk_F", "arifle_MX_GL_khk_F"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"arifle_MXC_F", "arifle_Mk20C_F", "arifle_MXC_Black_F", "arifle_MXM_F", "arifle_MXM_Black_F",
			"LMG_Mk200_F"
		],
		// lieutenant rifles (gets added to...)
		[
			"arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_Mk20_GL_F", "srifle_EBR_F",
			"LMG_Mk200_BI_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F", "arifle_SPAR_01_blk_F", "arifle_SPAR_01_khk_F", "arifle_SPAR_01_snd_F"
		],
		// captain rifles (gets added...)
		[
			"MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F", "arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F",
			"arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F"
		],
		// major rifles (gets...)
		[
			"srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F"
		],
		// colonel rifles (...)
		[
			"srifle_LRR_F", "srifle_LRR_camo_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F",
			"srifle_DMR_03_tan_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_woodland_F", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_LRR_tna_F"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"launch_B_Titan_F", "launch_RPG7_F"
		],
		// corporal launchers
		[
			"launch_RPG32_F", "launch_NLAW_F", "launch_RPG32_ghex_F"
		],
		// sergeant launchers
		[
			"launch_MRAWS_olive_F", "launch_MRAWS_green_rail_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_sand_F"
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
		],
		// major launchers
		[
			"launch_B_Titan_short_F"
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
			"hgun_P07_khk_F", "hgun_P07_F"
		],
		// sergeant pistols
		[
			"hgun_ACPC2_F"
		],
		// lieutenant pistols
		[
			"hgun_Pistol_heavy_01_F"
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

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"arifle_Katiba_F", "arifle_Katiba_C_F", "arifle_AKM_F", "arifle_AKS_F", "arifle_CTAR_blk_F", "arifle_CTAR_hex_F", "arifle_SDAR_F",
			"SMG_02_F"
		],
		// corporal rifles (gets added to private rifles)
		[
			"arifle_Katiba_GL_F", "arifle_AK12_GL_F", "arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_hex_F", "arifle_CTAR_GL_ghex_F"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"LMG_Mk200_F", "LMG_Zafir_F", "arifle_CTARS_blk_F", "arifle_CTARS_hex_F", "arifle_CTARS_ghex_F", "arifle_AK12_F"
		],
		// lieutenant rifles (gets added to...)
		[
			"arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_Mk20_GL_F",
			"LMG_Mk200_BI_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F"
		],
		// captain rifles (gets added...)
		[
			"srifle_DMR_01_F", "MMG_01_hex_F", "MMG_01_tan_F"
		],
		// major rifles (gets...)
		[
			"arifle_ARX_blk_F", "arifle_ARX_ghex_F", "arifle_ARX_hex_F"
		],
		// colonel rifles (...)
		[
			"srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_05_blk_F",
			"srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_GM6_ghex_F",
			"srifle_DMR_07_blk_F", "srifle_DMR_07_hex_F", "srifle_DMR_07_ghex_F"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"launch_O_Titan_F", "launch_RPG7_F"
		],
		// corporal launchers
		[
			"launch_RPG32_F", "launch_RPG32_ghex_F"
		],
		// sergeant launchers
		[
			"launch_MRAWS_olive_F", "launch_MRAWS_green_rail_F", "launch_MRAWS_sand_rail_F", "launch_MRAWS_olive_rail_F", "launch_MRAWS_green_F", "launch_MRAWS_sand_F"
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
		],
		// major launchers
		[
			"launch_O_Titan_short_F"
		],
		// colonel launchers
		[
			"launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"
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
			"hgun_Rook40_F"
		],
		// sergeant pistols
		[
			"hgun_ACPC2_F"
		],
		// lieutenant pistols
		[
			"hgun_Pistol_heavy_02_F"
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
