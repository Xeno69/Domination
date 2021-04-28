// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"vn_m45", "vn_m45_camo", "vn_m45_fold", "vn_m16", "vn_m16_camo", "vn_m3a1", "vn_m60", "vn_mc10"
		],
		// corporal rifles (gets added to private rifles)
		[
			"vn_izh54", "vn_m2carbine", "vn_m1carbine", "vn_m60_shorty", "vn_m60_shorty_camo", "vn_m79", "vn_sten"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"vn_izh54_shorty", "vn_m1carbine_gl", "vn_m16_xm148", "vn_m2carbine_gl", "vn_m63a", "vn_xm177_short"
		],
		// lieutenant rifles (gets added to...)
		[
			"vn_m14", "vn_m14_camo", "vn_xm177", "vn_xm177_camo", "vn_xm177_fg", "vn_xm177_stock", "vn_xm177_stock_camo"
		],
		// captain rifles (gets added...)
		[
			"vn_m40a1", "vn_m40a1_camo", "vn_xm177_xm148", "vn_xm177_xm148_camo"
		],
		// major rifles (gets...)
		[
			"vn_m4956", "vn_m4956_gl"
		],
		// colonel rifles (...)
		[
			"vn_m3carbine"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"vn_sa7", "vn_m127", "vn_m72"
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
			"vn_p38s", "vn_m1911"
		],
		// corporal pistols
		[
			"vn_mx991_m1911", "vn_mx991", "vn_mx991_red"
		],
		// sergeant pistols
		[
			"vn_izh54_p"
		],
		// lieutenant pistols
		[
			"vn_m79_p"
		],
		// captain pistols
		[
		],
		// major pistols
		[
			"vn_welrod"
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
	// no longer used!
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[]
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
	// no longer used!
	[
		0,  // 0 = always added for each rank in the ranked version
		"ITEMS",
		// weapons
		[
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
