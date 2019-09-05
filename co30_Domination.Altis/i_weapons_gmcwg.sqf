// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_gmcwg.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"gm_g3a3_oli", "gm_g3a3_grn"
		],
		// corporal rifles (gets added to private rifles)
		[
			"gm_mp2a1_blk"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"gm_g3a4_oli", "gm_g3a4_grn"
		],
		// lieutenant rifles (gets added to...)
		[
		],
		// captain rifles (gets added...)
		[
			"gm_g3a3_oli_blk"
		],
		// major rifles (gets...)
		[
			"gm_g3a4_blk"
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
			"gm_pzf44_2_oli", "gm_pzf44_2_win"
		],
		// corporal launchers
		[
		],
		// sergeant launchers
		[
		],
		// lieutenant launchers
		[
			"gm_pzf84_oli", "gm_pzf84_win"
		],
		// capain launchers
		[
		],
		// major launchers
		[
		],
		// colonel launchers
		[
			"gm_p2a1_launcher_blk"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"PISTOLS",
		// private pistols
		[
			"gm_p2a1_blk"
		],
		// corporal pistols
		[
			"gm_p1_blk"
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
			"gm_feroz2x17_pzf44_2_blk"
		],
		// corporal optics
		[
			"gm_feroz24_blk"
		],
		// sergeant optics
		[
		],
		// lieutenant optics
		[
			"gm_feroz2x17_pzf84_blk"
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
			"gm_dk_army_uniform_soldier_84_m84", "gm_dk_army_uniform_soldier_84_oli", "gm_dk_army_uniform_soldier_84_win", "gm_ge_army_uniform_crew_80_oli", "gm_ge_army_uniform_soldier_80_oli",
			"gm_ge_army_uniform_soldier_80_ols", "gm_ge_army_uniform_soldier_parka_80_oli", "gm_ge_army_uniform_soldier_parka_80_ols", "gm_ge_army_uniform_soldier_parka_80_win", "gm_ge_bgs_uniform_soldier_80_smp",
			"gm_ge_civ_uniform_blouse_80_gry", "gm_ge_dbp_uniform_suit_80_blu", "gm_ge_ff_uniform_man_80_orn", "gm_ge_pol_uniform_blouse_80_blk",

			"gm_dk_army_vest_54_crew", "gm_dk_army_vest_54_machinegunner", "gm_dk_army_vest_54_rifleman", "gm_ge_army_vest_80_bag", "gm_ge_army_vest_80_belt", "gm_ge_army_vest_80_crew", "gm_ge_army_vest_80_demolition",
			"gm_ge_army_vest_80_leader", "gm_ge_army_vest_80_machinegunner", "gm_ge_army_vest_80_medic", "gm_ge_army_vest_80_mp_wht", "gm_ge_army_vest_80_officer", "gm_ge_army_vest_80_rifleman", "gm_ge_bgs_vest_80_rifleman",
			"gm_ge_pol_vest_80_wht",

			"gm_dk_headgear_m52_net_oli", "gm_dk_headgear_m52_net_win", "gm_dk_headgear_m52_oli", "gm_ge_bgs_headgear_m35_53_blk", "gm_ge_bgs_headgear_m35_53_net_blk", "gm_ge_dbp_headgear_cap_80_blu",
			"gm_ge_ff_headgear_m35_53_tan", "gm_ge_headgear_beret_bdx", "gm_ge_headgear_beret_red", "gm_ge_headgear_beret_grn", "gm_ge_headgear_beret_bdx_armyaviation", "gm_ge_headgear_beret_bdx_lrrp",
			"gm_ge_headgear_beret_bdx_paratrooper", "gm_ge_headgear_beret_bdx_specop", "gm_ge_headgear_beret_blk_antitank", "gm_ge_headgear_beret_blk_armor", "gm_ge_headgear_beret_blk_armorrecon",
			"gm_ge_headgear_beret_blk_recon", "gm_ge_headgear_beret_blu_medical", "gm_ge_headgear_beret_crew_bdx_paratrooper", "gm_ge_headgear_beret_crew_blk_antitank", "gm_ge_headgear_beret_crew_blk_armor",
			"gm_ge_headgear_beret_crew_blk_armorrecon", "gm_ge_headgear_beret_crew_blk_recon", "gm_ge_headgear_beret_crew_grn_mechinf", "gm_ge_headgear_beret_crew_red_antiair", "gm_ge_headgear_beret_crew_red_artillery",
			"gm_ge_headgear_beret_crew_red_engineer", "gm_ge_headgear_beret_crew_red_maintenance", "gm_ge_headgear_beret_crew_red_militarypolice", "gm_ge_headgear_beret_crew_red_nbc", "gm_ge_headgear_beret_crew_red_opcom",
			"gm_ge_headgear_beret_crew_red_signals", "gm_ge_headgear_beret_crew_red_supply", "gm_ge_headgear_beret_grn_guardbtl", "gm_ge_headgear_beret_grn_infantry", "gm_ge_headgear_beret_grn_mechinf", "gm_ge_headgear_beret_grn_music",
			"gm_ge_headgear_beret_mrb", "gm_ge_headgear_beret_red_antiair", "gm_ge_headgear_beret_red_artillery", "gm_ge_headgear_beret_red_engineer", "gm_ge_headgear_beret_red_geoinfo", "gm_ge_headgear_beret_red_maintenance",
			"gm_ge_headgear_beret_red_militarypolice", "gm_ge_headgear_beret_red_nbc", "gm_ge_headgear_beret_red_opcom", "gm_ge_headgear_beret_red_signals", "gm_ge_headgear_beret_red_supply", "gm_ge_headgear_beret_un",
			"gm_ge_headgear_crewhat_80_blk", "gm_ge_headgear_hat_80_gry", "gm_ge_headgear_hat_80_m62_oli", "gm_ge_headgear_hat_80_oli", "gm_ge_headgear_headset_crew_oli", "gm_ge_headgear_m62",
			"gm_ge_headgear_m62_cover_blu", "gm_ge_headgear_m62_cover_win", "gm_ge_headgear_m62_net", "gm_ge_headgear_m62_win_pap_01", "gm_ge_headgear_winterhat_80_oli"
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
			"gm_ferod16_oli", "gm_ferod16_win", "MineDetector",
			(if (d_no_faks == 1) then {"gm_ge_army_gauzeCompress"} else {""}), "gm_ge_army_medkit_80", "gm_ge_army_gauzeBandage", "gm_ge_army_burnBandage",
			"gm_repairkit_01", "gm_watch_kosei_80"
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
		],
		// corporal rifles (gets added to private rifles)
		[
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
		],
		// lieutenant rifles (gets added to...)
		[
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
		"LAUNCHERS",
		// private launchers
		[
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
			"gm_ferod16_oli", "gm_ferod16_win", "MineDetector",
			(if (d_no_faks == 1) then {"gm_ge_army_gauzeCompress"} else {""}), "gm_ge_army_medkit_80", "gm_ge_army_gauzeBandage", "gm_ge_army_burnBandage",
			"gm_repairkit_01", "gm_watch_kosei_80"
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
