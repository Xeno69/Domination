// by Xeno
//#define __DEBUG__
#define THIS_FILE "i_weapons_csla.sqf"
#include "x_setup.sqf"

// please note that in the non ranked version all weapons and items are available, no matter which rank the player has

__TRACE("i_weapons.sqf")

private _all_weapons_items_blufor = [
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
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"US85_M16A2", "US85_M60", "CSLA_Sa58P", "CSLA_Sa58V", "CSLA_UK59L"
		],
		// corporal rifles (gets added to private rifles)
		[
			"US85_M16A2CAR", "US85_M16A2GL", "US85_MPVN", "CSLA_VG70", "CSLA_rSa61"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"US85_M16A2CARGL", "US85_M249"
		],
		// lieutenant rifles (gets added to...)
		[
			"US85_FAL", "US85_FALf", "US85_MPVSD"
		],
		// captain rifles (gets added...)
		[
			"CSLA_HuntingRifle"
		],
		// major rifles (gets...)
		[
			"US85_M21_Base", "CSLA_OP63_Base"
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
			"CSLA_9K32", "US85_Stinger", "US85_M136", "CSLA_RPG7"
		],
		// corporal launchers
		[
			"US85_LAW72", "CSLA_RPG75"
		],
		// sergeant launchers
		[
			"US85_M47"
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
			"US85_MAAWS"
		],
		// major launchers
		[
			"US85_SMAW"
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
			"CSLA_Pi52"
		],
		// corporal pistols
		[
		],
		// sergeant pistols
		[
			"US85_M9","CSLA_Pi82"
		],
		// lieutenant pistols
		[
			"US85_1911"
		],
		// captain pistols
		[
		],
		// major pistols
		[
			"CSLA_Sa61"
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
