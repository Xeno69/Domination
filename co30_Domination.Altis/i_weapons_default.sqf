// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_default.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"arifle_MX_F", "arifle_MX_Black_F", "hgun_PDW2000_F", "arifle_Katiba_F", "arifle_Katiba_C_F", "arifle_Mk20_F", "arifle_Mk20_plain_F",
			"arifle_Mk20C_F", "arifle_Mk20_F", "arifle_Mk20C_plain_F"
		],
		// corporal rifles (gets added to private rifles)
		[
			"arifle_MX_GL_F", "arifle_MX_GL_Black_F", "arifle_Katiba_GL_F", "arifle_Mk20_GL_F", "arifle_Mk20_GL_plain_F","arifle_MX_SW_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_khk_F"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"arifle_SDAR_F", "arifle_MXC_F", "arifle_Mk20C_F", "arifle_MXC_Black_F", "arifle_MXM_F", "arifle_MXM_Black_F",
			"LMG_Mk200_F", "LMG_Zafir_F", "LMG_03_F", "arifle_CTARS_blk_F", "arifle_CTARS_hex_F", "arifle_CTARS_ghex_F"
		],
		// lieutenant rifles (gets added to...)
		[
			"arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_Mk20_GL_F", "srifle_EBR_F",
			"LMG_Mk200_BI_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F"
		],
		// captain rifles (gets added...)
		[
			"srifle_DMR_01_F", "MMG_01_hex_F", "MMG_01_tan_F", "MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F"
		],
		// major rifles (gets...)
		[
			"srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"
		],
		// colonel rifles (...)
		[
			"srifle_LRR_F", "srifle_GM6_F", "srifle_GM6_camo_F", "srifle_LRR_camo_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F",
			"srifle_DMR_03_tan_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_woodland_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_05_blk_F",
			"srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_LRR_tna_F", "srifle_GM6_ghex_F"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"launch_Titan_F", "launch_RPG7_F"
		],
		// corporal launchers
		[
			"launch_RPG32_F", "launch_NLAW_F", "launch_RPG32_ghex_F"
		],
		// sergeant launchers
		[
			"launch_MRAWS_olive_F", "launch_MRAWS_green_rail_F", "launch_MRAWS_sand_rail_F"
		],
		// lieutenant launchers
		[
			"launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"
		],
		// capain launchers
		[
		],
		// major launchers
		[
			"launch_Titan_short_F"
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
			"hgun_P07_F", "hgun_ACPC2_F"
		],
		// sergeant pistols
		[
			"hgun_Rook40_F", "hgun_Pistol_Signal_F"
		],
		// lieutenant pistols
		[
			"hgun_P07_snds_F", "hgun_Rook40_snds_F"
		],
		// captain pistols
		[
			"hgun_Pistol_heavy_02_F"
		],
		// major pistols
		[
			"hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_Yorris_F"
		],
		// colonel pistols
		[
			"hgun_Pistol_heavy_01_snds_F", "hgun_Pistol_heavy_01_MRD_F"
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
			"optic_Holosight", "acc_pointer_IR"
		],
		// sergeant optics
		[
			"acc_flashlight", "optic_Holosight_smg"
		],
		// lieutenant optics
		[
			 "optic_MRD", "optic_MRCO"
		],
		// captain optics
		[
			"optic_Aco", "optic_ACO_grn", "optic_Arco", "optic_Hamr"
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
		],
		// corporal muzzles
		[
		],
		// sergeant muzzles
		[
			"muzzle_snds_B"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_M", "muzzle_snds_acp"
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
			"arifle_MX_F", "arifle_MX_Black_F", "hgun_PDW2000_F", "arifle_Katiba_F", "arifle_Katiba_C_F", "arifle_Mk20_F", "arifle_Mk20_plain_F",
			"arifle_Mk20C_F", "arifle_Mk20_F", "arifle_Mk20C_plain_F"
		],
		// corporal rifles (gets added to private rifles)
		[
			"arifle_MX_GL_F", "arifle_MX_GL_Black_F", "arifle_Katiba_GL_F", "arifle_Mk20_GL_F", "arifle_Mk20_GL_plain_F","arifle_MX_SW_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_khk_F"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"arifle_SDAR_F", "arifle_MXC_F", "arifle_Mk20C_F", "arifle_MXC_Black_F", "arifle_MXM_F", "arifle_MXM_Black_F",
			"LMG_Mk200_F", "LMG_Zafir_F", "LMG_03_F", "arifle_CTARS_blk_F", "arifle_CTARS_hex_F", "arifle_CTARS_ghex_F"
		],
		// lieutenant rifles (gets added to...)
		[
			"arifle_TRG20_F", "arifle_TRG21_F", "arifle_TRG21_GL_F", "arifle_Mk20_GL_F", "srifle_EBR_F",
			"LMG_Mk200_BI_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F"
		],
		// captain rifles (gets added...)
		[
			"srifle_DMR_01_F", "MMG_01_hex_F", "MMG_01_tan_F", "MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F"
		],
		// major rifles (gets...)
		[
			"srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F"
		],
		// colonel rifles (...)
		[
			"srifle_LRR_F", "srifle_GM6_F", "srifle_GM6_camo_F", "srifle_LRR_camo_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F",
			"srifle_DMR_03_tan_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_woodland_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_05_blk_F",
			"srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_LRR_tna_F", "srifle_GM6_ghex_F"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"launch_Titan_F", "launch_RPG7_F"
		],
		// corporal launchers
		[
			"launch_RPG32_F", "launch_NLAW_F", "launch_RPG32_ghex_F"
		],
		// sergeant launchers
		[
			"launch_MRAWS_olive_F", "launch_MRAWS_green_rail_F", "launch_MRAWS_sand_rail_F"
		],
		// lieutenant launchers
		[
			"launch_O_Vorona_brown_F", "launch_O_Vorona_green_F"
		],
		// capain launchers
		[
		],
		// major launchers
		[
			"launch_Titan_short_F"
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
			"hgun_P07_F", "hgun_ACPC2_F"
		],
		// sergeant pistols
		[
			"hgun_Rook40_F", "hgun_Pistol_Signal_F"
		],
		// lieutenant pistols
		[
			"hgun_P07_snds_F", "hgun_Rook40_snds_F"
		],
		// captain pistols
		[
			"hgun_Pistol_heavy_02_F"
		],
		// major pistols
		[
			"hgun_Pistol_heavy_01_F", "hgun_Pistol_heavy_02_Yorris_F"
		],
		// colonel pistols
		[
			"hgun_Pistol_heavy_01_snds_F", "hgun_Pistol_heavy_01_MRD_F"
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
			"optic_Holosight", "acc_pointer_IR"
		],
		// sergeant optics
		[
			"acc_flashlight", "optic_Holosight_smg"
		],
		// lieutenant optics
		[
			 "optic_MRD", "optic_MRCO"
		],
		// captain optics
		[
			"optic_Aco", "optic_ACO_grn", "optic_Arco", "optic_Hamr"
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
		],
		// corporal muzzles
		[
		],
		// sergeant muzzles
		[
			"muzzle_snds_B"
		],
		// lieutenant muzzles
		[
			"muzzle_snds_H", "muzzle_snds_L", "muzzle_snds_M", "muzzle_snds_acp"
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
