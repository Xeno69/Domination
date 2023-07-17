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
			"SPE_MP40", "SPE_K98", "SPE_K98_Late"
		],
		// corporal rifles (gets added to private rifles)
		[
			"SPE_K98_Bayonet", "SPE_K98_GW", "SPE_K98_Late_Bayonet", "SPE_K98_Late_GW", "SPE_MG34"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"SPE_G43", "SPE_MG42"
		],
		// lieutenant rifles (gets added to...)
		[
		],
		// captain rifles (gets added...)
		[
			"SPE_STG44"
		],
		// major rifles (gets...)
		[
			"SPE_Flammenwerfer41"
		],
		// colonel rifles (...)
		[
			"SPE_K98ZF39"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"SPE_PzFaust_30m", "SPE_Faustpatrone"
		],
		// corporal launchers
		[
		],
		// sergeant launchers
		[
			"SPE_PzFaust_60m"
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
			"SPE_P08"
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
		]
	]
];

private _all_weapons_items_indep = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"SPE_Sten_Mk2", "SPE_M1903A3_Springfield"
		],
		// corporal rifles (gets added to private rifles)
		[
			"SPE_M3_GreaseGun", "SPE_M1903A3_Springfield_M1_Bayonet", "SPE_M1_Garand", "SPE_M1919A4"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"SPE_M1A1_Thompson", "SPE_M1_Garand_Bayonet", "SPE_M1903A3_Springfield_M1905_Bayonet", "SPE_M1_Garand_M1905_Bayonet", "SPE_M1918A2_BAR"
		],
		// lieutenant rifles (gets added to...)
		[
			"SPE_Sten_Mk2_Suppressed", "SPE_M1_Carbine", "SPE_M1903A3_Springfield_M1_GL", "SPE_M1_Garand_M7", "SPE_M1_Carbine_M8", "SPE_FM_24_M29", "SPE_M1919A6"
		],
		// captain rifles (gets added...)
		[
			"SPE_M3_GreaseGun_Suppressed"
		],
		// major rifles (gets...)
		[
			"SPE_M2_Flamethrower"
		],
		// colonel rifles (...)
		[
			"SPE_M1903A4_Springfield"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"SPE_M1A1_Bazooka"
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
			"SPE_M1911"
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
		]
	]
];

private "_all_weapons_items";
if (!d_tt_ver) then {
#ifdef __OWN_SIDE_BLUFOR__
	_all_weapons_items = _all_weapons_items_blufor;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	_all_weapons_items = _all_weapons_items_indep;
#endif
} else {
	if (side (group player) == blufor) then {
		__TRACE("Player is blufor")
		_all_weapons_items = _all_weapons_items_blufor;
	} else {
		__TRACE("Player is independent")
		_all_weapons_items = _all_weapons_items_indep;
	};
};

#include "i_weapons_base.sqf"
