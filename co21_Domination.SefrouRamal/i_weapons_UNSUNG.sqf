// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"

// Could be better

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"uns_ak47","uns_aks47","uns_aks47f","uns_uzif","uns_uzi","uns_ak47_49","uns_ak47_52","uns_akm","uns_akms","uns_akmsf","uns_DP28_base","uns_f1_smg","uns_m60grip","uns_m60shorty","uns_m60support",
			"uns_m60","uns_m45","uns_mp40","uns_thompson","uns_thompsonvc","uns_RPK_40","uns_m16A1_camo","uns_M16_dm","uns_m16","uns_m16_camo","uns_M16A1","uns_sks",
			"uns_mac10","uns_sten","uns_owen","uns_m50","uns_m50f",
			"uns_m3a1","uns_pm63f","uns_pm63","uns_sa61f","uns_sa61","uns_mat49","uns_type100","uns_PPS43","uns_PPS43f",
			"uns_PPS52","uns_ppsh41","uns_type50","uns_ithaca37","uns_ithaca37_grip","uns_m1897","uns_m1897riot","uns_model12","uns_baikal",
			"uns_baikal_sawnoff","uns_m870","uns_m870_mk1","uns_STG_44",
			"uns_m3carbine","uns_m1903","uns_model70_iron",
			"uns_type56","uns_sa58p","uns_sa58p_camo","uns_sa58v","uns_sa58vf",
			"uns_M63a_AR_base","uns_M63a_LMG","uns_m63asupport",
			"uns_rpd","uns_RPDsupport","uns_rpdsog","uns_PK",
			"uns_ukvz59"
		],
		// corporal rifles (gets added to private rifles)
		[
			"uns_xm177e1","uns_xm177e1_dm","uns_xm177e1_m203","uns_xm177e1_xm148","uns_xm177e2","uns_xm177e2_grip","uns_xm177e2_short","uns_xm177e2_stock","uns_xm177e2_xm148",
			"uns_akm_drum","uns_type99","uns_k50m","uns_bar","uns_m45f","uns_Sterling","uns_Sterling_f","uns_SterlingSD","uns_SterlingSD_f","uns_m1garand","uns_PKsupport"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"uns_m14","uns_m1carbine","uns_m1carbine_pouch","uns_xm177e2_m203","uns_akms_drum","uns_akmsf_drum","uns_m2carbine","uns_m2carbine_shorty","uns_m16a1_m203","uns_RPK_drum",
			"uns_M16A1_HBAR","uns_m16a1_xm148","uns_m16_m203","uns_m16_xm148","uns_m16_xm148_camo","uns_m1garand_gl","uns_M63a_drum"
		],
		// lieutenant rifles (gets added to...)
		[
			"uns_t233","uns_type99_gl","uns_k50mdrum","uns_l2a1","uns_l2a1_shorty","uns_smle","uns_m2carbine_gl","uns_MG42","uns_mg42_bakelite","uns_MG42support",
			"uns_mas36","uns_mas36_gl","uns_mas36short","uns_mas36short_gl","uns_mas4956","uns_mas4956_gl"
		],
		// captain rifles (gets added...)
		[
			"uns_m1carbine_gl","uns_m1carbine_pouch_gl","uns_l1a1_enfield","uns_l1a1_blk","uns_l1a1","uns_mosin","uns_kar98k","uns_svt","uns_svd_base","uns_SVD_CAMO_base","uns_M40_base"
		],
		// major rifles (gets...)
		[
			"uns_ex41","uns_l1a1gl","uns_m1919a6"
		],
		// colonel rifles (...)
		[
			"uns_smle_sniper","uns_m79"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"uns_m127a1_flare","uns_m72","uns_m72used","uns_rpg2","uns_B40","uns_rpg7","uns_m20_bazooka","uns_sa7","uns_sa7b"
		],
		// corporal launchers
		[
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
			"uns_ppk","uns_Ruger","uns_38spec","uns_sw_m10","uns_357m","uns_nagant_m1895","uns_m2carbine_shorty_p","uns_coltcmdr","uns_bhp",
			"uns_m1911","uns_MX991_m1911_base","uns_MX991_m1911SD_base","uns_MX991_w_base","uns_MX991_r","uns_MX991_g","uns_mkvFlarePistol",
			"uns_makarov","uns_p64","uns_tt30","uns_Tt33","uns_APS","uns_pm63p","uns_mat49p","uns_sa61_p","uns_m79p"
		],
		// corporal pistols
		[
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
		],
		// sergeant optics
		[
		],
		// lieutenant optics
		[
		],
		// captain optics
		[
		],
		// major optics
		[
		],
		// colonel optics
		[
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
		],
		// lieutenant muzzles
		[
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
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
			"U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_T_Soldier_F", "U_B_T_Soldier_AR_F",
			"U_B_T_Soldier_SL_F", "U_B_Wetsuit",

			"H_HelmetB", "H_HelmetB_camo", "H_HelmetB_light", "H_HelmetB_grass", "H_HelmetB_snakeskin", "H_HelmetB_desert", "H_HelmetB_black", "H_HelmetB_sand",
			"H_HelmetB_light_grass", "H_HelmetB_light_snakeskin", "H_HelmetB_light_desert", "H_HelmetB_light_black", "H_HelmetB_light_sand", "H_HelmetB_TI_tna_F", "H_HelmetB_tna_F",
			"H_HelmetB_Enh_tna_F","H_HelmetB_Light_tna_F", "H_HelmetSpecB", "H_HelmetSpecB_paint1", "H_HelmetSpecB_paint2", "H_HelmetSpecB_blk", "H_HelmetSpecB_snakeskin",
			"H_HelmetSpecB_sand", "H_Cap_tan_specops_US", "H_HelmetCrew_B", "H_PilotHelmetFighter_B", "H_PilotHelmetHeli_B", "H_CrewHelmetHeli_B",
			"H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_mcamo", "H_Booniehat_tan", "H_Booniehat_dgtl", "H_Booniehat_khk_hs", "H_Bandanna_surfer", "H_Bandanna_khk",
			"H_Bandanna_khk_hs", "H_Bandanna_cbr", "H_Bandanna_sgg", "H_Bandanna_sand", "H_Bandanna_surfer_blk", "H_Bandanna_surfer_grn", "H_Bandanna_gry", "H_Bandanna_blu",
			"H_Bandanna_camo", "H_Bandanna_mcamo", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Beret_blk", "H_Beret_02", "H_Beret_Colonel",
			"H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_khk", "H_Watchcap_camo", "H_Booniehat_tna_F"
		],
		// corporal uniforms
		[
			"U_B_CTRG_2", "U_B_CTRG_3", "U_B_CTRG_1"
		],
		// sergeant uniforms
		[
			"U_B_CTRG_Soldier_urb_1_F", "U_B_CTRG_Soldier_urb_3_F", "U_B_CTRG_Soldier_urb_2_F", "U_B_CTRG_Soldier_F", "U_B_CTRG_Soldier_3_F", "U_B_CTRG_Soldier_2_F"
		],
		// lieutenant uniforms
		[
			"U_B_CombatUniform_mcam_worn", "U_B_HeliPilotCoveralls", "U_B_PilotCoveralls"
		],
		// captain uniforms
		[
			"U_B_survival_uniform"
		],
		// major uniforms
		[
		],
		// colonel uniforms
		[
			"U_B_T_Sniper_F", "U_B_GhillieSuit", "U_B_T_FullGhillie_tna_F", "U_B_FullGhillie_lsh", "U_B_FullGhillie_sard", "U_B_FullGhillie_ard"
		]
	],
	// additional weapons and items, no rank
	// no longer used!
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
			"uns_ak47", "arifle_Katiba_C_F", "arifle_AKM_F", "arifle_AKS_F", "arifle_CTAR_blk_F", "arifle_CTAR_hex_F", "arifle_SDAR_F",
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
			"U_O_CombatUniform_ocamo", "U_O_CombatUniform_oucamo", "U_O_T_Soldier_F", "U_O_Wetsuit",

			"H_HelmetCrew_O", "H_PilotHelmetFighter_O", "H_PilotHelmetHeli_O", "H_CrewHelmetHeli_O", "H_HelmetO_ocamo", "H_HelmetLeaderO_ocamo", "H_MilCap_ocamo",
			"H_HelmetO_oucamo", "H_HelmetLeaderO_oucamo", "H_HelmetSpecO_ocamo", "H_HelmetSpecO_blk", "H_HelmetSpecO_ghex_F", "H_HelmetLeaderO_ghex_F",
			"H_HelmetO_ghex_F", "H_HelmetCrew_O_ghex_F",
			"H_Booniehat_khk", "H_Booniehat_oli", "H_Booniehat_mcamo", "H_Booniehat_tan", "H_Booniehat_dgtl", "H_Booniehat_khk_hs", "H_Bandanna_surfer", "H_Bandanna_khk",
			"H_Bandanna_khk_hs", "H_Bandanna_cbr", "H_Bandanna_sgg", "H_Bandanna_sand", "H_Bandanna_surfer_blk", "H_Bandanna_surfer_grn", "H_Bandanna_gry", "H_Bandanna_blu",
			"H_Bandanna_camo", "H_Bandanna_mcamo", "H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_khk", "H_ShemagOpen_tan", "H_Beret_blk", "H_Beret_02", "H_Beret_Colonel",
			"H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_khk", "H_Watchcap_camo", "H_Booniehat_tna_F"
		],
		// corporal uniforms
		[
		],
		// sergeant uniforms
		[
			"U_O_SpecopsUniform_ocamo"
		],
		// lieutenant uniforms
		[
			"U_O_officer_noInsignia_hex_F", "U_O_OfficerUniform_ocamo", "U_O_T_Officer_F", "U_O_PilotCoveralls"
		],
		// captain uniforms
		[
		],
		// major uniforms
		[
		],
		// colonel uniforms
		[
			"U_O_T_Sniper_F", "U_O_GhillieSuit", "U_O_T_FullGhillie_tna_F", "U_O_FullGhillie_sard", "U_O_FullGhillie_lsh", "U_O_FullGhillie_ard",
			"H_HelmetO_ViperSP_ghex_F", "H_HelmetO_ViperSP_hex_F"
		]
	],
	// additional weapons and items, no rank
	// no longer used!
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
			"MineDetector", "Binocular", (if (d_no_faks == 1) then {"FirstAidKit"} else {""}), "Medikit",
			(if (d_without_nvg == 1) then {"NVGoggles_OPFOR"} else {""}),
			"ToolKit", "O_UavTerminal"
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
