// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_default.sqf"
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
			["arifle_MX_F",1], ["arifle_MX_Black_F",1], ["hgun_PDW2000_F",1], ["arifle_Katiba_F",1], ["arifle_Katiba_C_F",1], ["arifle_Mk20_F",1], ["arifle_Mk20_plain_F",1],
			["arifle_Mk20C_F",1], ["arifle_Mk20_F",1], ["arifle_Mk20C_plain_F",1]
		],
		// corporal rifles (gets added to private rifles)
		[
			["arifle_MX_GL_F",1], ["arifle_MX_GL_Black_F",1], ["arifle_Katiba_GL_F",1], ["arifle_Mk20_GL_F",1], ["arifle_Mk20_GL_plain_F",1]
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			["arifle_SDAR_F",1], ["arifle_MXC_F",1], ["arifle_Mk20C_F",1], ["arifle_MXC_Black_F", 1]
		],
		// lieutenant rifles (gets added to...)
		[
			["arifle_TRG20_F",1], ["arifle_TRG21_F",1],["arifle_TRG21_GL_F",1], ["arifle_Mk20_GL_F",1]
		],
		// captain rifles (gets added...)
		[
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
			["arifle_MXM_F",1], ["arifle_MXM_Black_F",1]
		],
		// lieutenant sniper rifles
		[
			["srifle_EBR_F",1]
		],
		// captain sniper rifles
		[
			["srifle_DMR_01_F",1]
		],
		// major sniper rifles
		[
			["srifle_DMR_02_F",1], ["srifle_DMR_02_camo_F",1], ["srifle_DMR_02_sniper_F",1]
		],
		// colonel sniper rifles
		[
			["srifle_LRR_F",1], ["srifle_GM6_F",1], ["srifle_GM6_camo_F",1], ["srifle_LRR_camo_F",1], ["srifle_DMR_03_F",1], ["srifle_DMR_03_khaki_F",1],
			["srifle_DMR_03_tan_F",1], ["srifle_DMR_03_multicam_F",1], ["srifle_DMR_03_woodland_F",1], ["srifle_DMR_04_F",1], ["srifle_DMR_04_Tan_F",1], ["srifle_DMR_05_blk_F",1],
			["srifle_DMR_05_hex_F",1], ["srifle_DMR_05_tan_f",1], ["srifle_DMR_06_camo_F",1], ["srifle_DMR_06_olive_F",1], ["srifle_LRR_tna_F",1], ["srifle_GM6_ghex_F",1]
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
			["arifle_MX_SW_F",1], ["arifle_MX_SW_Black_F",1], ["arifle_MX_SW_khk_F",1]
		],
		// sergeant MG
		[
			["LMG_Mk200_F",1], ["LMG_Zafir_F",1], ["LMG_03_F",1], ["arifle_CTARS_blk_F",1], ["arifle_CTARS_hex_F",1], ["arifle_CTARS_ghex_F",1]
		],
		// lieutenant MG
		[
			["LMG_Mk200_BI_F",1, ["arifle_SPAR_02_blk_F",1], ["arifle_SPAR_02_khk_F",1], ["arifle_SPAR_02_snd_F",1]
		],
		// captain MG
		[
			["MMG_01_hex_F",1], ["MMG_01_tan_F",1], "MMG_02_camo_F",1], ["MMG_02_black_F",1], ["MMG_02_sand_F",1]
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
			["launch_Titan_F",1], ["launch_RPG7_F",1]
		],
		// corporal launchers
		[
			["launch_RPG32_F",1], ["launch_NLAW_F",1], ["launch_RPG32_ghex_F",1]
		],
		// sergeant launchers
		[
			["launch_MRAWS_olive_F",1], ["launch_MRAWS_green_rail_F",1], ["launch_MRAWS_sand_rail_F",1]
		],
		// lieutenant launchers
		[
			["launch_O_Vorona_brown_F",1], ["launch_O_Vorona_green_F",1]
		],
		// capain launchers
		[
		],
		// major launchers
		[
			["launch_Titan_short_F",1]
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
			["hgun_P07_F",1], ["hgun_ACPC2_F",1]
		],
		// sergeant pistols
		[
			["hgun_Rook40_F",1], ["hgun_Pistol_Signal_F",1]
		],
		// lieutenant pistols
		[
			["hgun_P07_snds_F",1], ["hgun_Rook40_snds_F",1]
		],
		// captain pistols
		[
			["hgun_Pistol_heavy_02_F",1]
		],
		// major pistols
		[
			["hgun_Pistol_heavy_01_F",1], ["hgun_Pistol_heavy_02_Yorris_F",1]
		],
		// colonel pistols
		[
			["hgun_Pistol_heavy_01_snds_F",1], ["hgun_Pistol_heavy_01_MRD_F",1]
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
			["muzzle_snds_B",1,true]
		],
		// lieutenant muzzles
		[
			["muzzle_snds_H",1,true],["muzzle_snds_L",1,true], ["muzzle_snds_M",1,true], ["muzzle_snds_acp", 1,true]
		],
		// captain muzzles
		[
		],
		// major muzzles
		[
			["muzzle_snds_H_MG",1,true]
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
#endif

// only a BLUFOR and OPFOR version exists, therefore nothing defined in INDEPENDENT
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
			["arifle_MX_F",1], ["arifle_MX_Black_F",1], ["hgun_PDW2000_F",1], ["arifle_Katiba_F",1], ["arifle_Katiba_C_F",1], ["arifle_Mk20_F",1], ["arifle_Mk20_plain_F",1],
			["arifle_Mk20C_F",1], ["arifle_Mk20_F",1], ["arifle_Mk20C_plain_F",1]
		],
		// corporal rifles (gets added to private rifles)
		[
			["arifle_MX_GL_F",1], ["arifle_MX_GL_Black_F",1], ["arifle_Katiba_GL_F",1], ["arifle_Mk20_GL_F",1], ["arifle_Mk20_GL_plain_F",1]
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			["arifle_SDAR_F",1], ["arifle_MXC_F",1], ["arifle_Mk20C_F",1], ["arifle_MXC_Black_F", 1]
		],
		// lieutenant rifles (gets added to...)
		[
			["arifle_TRG20_F",1], ["arifle_TRG21_F",1],["arifle_TRG21_GL_F",1], ["arifle_Mk20_GL_F",1]
		],
		// captain rifles (gets added...)
		[
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
			["arifle_MXM_F",1], ["arifle_MXM_Black_F",1]
		],
		// lieutenant sniper rifles
		[
			["srifle_EBR_F",1]
		],
		// captain sniper rifles
		[
			["srifle_DMR_01_F",1],
		],
		// major sniper rifles
		[
			["srifle_DMR_02_F",1], ["srifle_DMR_02_camo_F",1], ["srifle_DMR_02_sniper_F",1]
		],
		// colonel sniper rifles
		[
			["srifle_LRR_F",1], ["srifle_GM6_F",1], ["srifle_GM6_camo_F",1], ["srifle_LRR_camo_F",1], ["srifle_DMR_03_F",1], ["srifle_DMR_03_khaki_F",1],
			["srifle_DMR_03_tan_F",1], ["srifle_DMR_03_multicam_F",1], ["srifle_DMR_03_woodland_F",1], ["srifle_DMR_04_F",1], ["srifle_DMR_04_Tan_F",1], ["srifle_DMR_05_blk_F",1],
			["srifle_DMR_05_hex_F",1], ["srifle_DMR_05_tan_f",1], ["srifle_DMR_06_camo_F",1], ["srifle_DMR_06_olive_F",1], ["srifle_LRR_tna_F",1], ["srifle_GM6_ghex_F",1]
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
			["arifle_MX_SW_F",1], ["arifle_MX_SW_Black_F",1], ["arifle_MX_SW_khk_F",1]
		],
		// sergeant MG
		[
			["LMG_Mk200_F",1], ["LMG_Zafir_F",1], ["LMG_03_F",1], ["arifle_CTARS_blk_F",1], ["arifle_CTARS_hex_F",1], ["arifle_CTARS_ghex_F",1]
		],
		// lieutenant MG
		[
			["LMG_Mk200_BI_F",1, ["arifle_SPAR_02_blk_F",1], ["arifle_SPAR_02_khk_F",1], ["arifle_SPAR_02_snd_F",1]
		],
		// captain MG
		[
			["MMG_01_hex_F",1], ["MMG_01_tan_F",1], "MMG_02_camo_F",1], [, ["MMG_02_black_F",1], ["MMG_02_sand_F",1]
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
			["launch_Titan_F",1], ["launch_RPG7_F",1]
		],
		// corporal launchers
		[
			["launch_RPG32_F",1], ["launch_NLAW_F",1], ["launch_RPG32_ghex_F",1]
		],
		// sergeant launchers
		[
			["launch_MRAWS_olive_F",1], ["launch_MRAWS_green_rail_F",1], ["launch_MRAWS_sand_rail_F",1]
		],
		// lieutenant launchers
		[
			["launch_O_Vorona_brown_F",1], ["launch_O_Vorona_green_F",1]
		],
		// capain launchers
		[
		],
		// major launchers
		[
			["launch_Titan_short_F",1]
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
			["hgun_P07_F",1], ["hgun_ACPC2_F",1]
		],
		// sergeant pistols
		[
			["hgun_Rook40_F",1], ["hgun_Pistol_Signal_F",1]
		],
		// lieutenant pistols
		[
			["hgun_P07_snds_F",1], ["hgun_Rook40_snds_F",1]
		],
		// captain pistols
		[
			["hgun_Pistol_heavy_02_F",1]
		],
		// major pistols
		[
			["hgun_Pistol_heavy_01_F",1], ["hgun_Pistol_heavy_02_Yorris_F",1]
		],
		// colonel pistols
		[
			["hgun_Pistol_heavy_01_snds_F",1], ["hgun_Pistol_heavy_01_MRD_F",1]
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

private ["_all_weapons_items"];
if (side (group player) == blufor) then {
	__TRACE("Player is blufor")
	_all_weapons_items = _all_weapons_items_blufor;
} else {
	__TRACE("Player is opfor")
	_all_weapons_items = _all_weapons_items_opfor;
};
#endif

#include "i_weapons_base.sqf";
