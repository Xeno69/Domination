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
			"LIB_K98"
		],
		// corporal rifles (gets added to private rifles)
		[
			"LIB_MP38", "LIB_M38", "LIB_MG34"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"LIB_MP40", "LIB_K98_Late2", "LIB_MG34_PT", "LIB_G3340"
		],
		// lieutenant rifles (gets added to...)
		[
			"LIB_M44", "LIB_MP44"
		],
		// captain rifles (gets added...)
		[
			"LIB_FG42G", "LIB_G41"
		],
		// major rifles (gets...)
		[
			"LIB_G43", "LIB_K98ZF39"
		],
		// colonel rifles (...)
		[
			"LIB_MG42"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"LIB_Faustpatrone", "LIB_PzFaust_30m"
		],
		// corporal launchers
		[
		],
		// sergeant launchers
		[
			"LIB_PzFaust_60m"
		],
		// lieutenant launchers
		[
		],
		// capain launchers
		[
			"LIB_RPzB", "LIB_RPzB_w"
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
			"LIB_P08", "LIB_P38"
		],
		// sergeant pistols
		[
			"LIB_WaltherPPK"
		],
		// lieutenant pistols
		[
			"LIB_FLARE_PISTOL"
		],
		// captain pistols
		[
			"LIB_M1896"
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
			"U_LIB_FSJ_Soldier", "U_LIB_FSJ_Soldier_camo", "U_LIB_FSJ_Soldier_dak", "U_LIB_FSJ_Soldier_dak_camo", "U_LIB_ST_Soldier_E44", "U_LIB_ST_MGunner_E44",
			"U_LIB_ST_Medic_E44", "U_LIB_ST_Unterofficier_E44", "U_LIB_ST_Soldier_E44_Camo", "U_LIB_ST_Soldier_E44_Camo2", "U_LIB_ST_Soldier_Camo",
			"U_LIB_ST_Soldier_Camo2", "U_LIB_ST_Sniper", "U_LIB_ST_Sniper2", "U_LIB_GER_Tank_crew_private", "U_LIB_GER_Tank_crew_unterofficer", "U_LIB_GER_Tank_crew_leutnant",
			"U_LIB_GER_Spg_crew_private", "U_LIB_GER_Spg_crew_unterofficer", "U_LIB_GER_Spg_crew_leutnant", "U_LIB_GER_Soldier2", "U_LIB_GER_Soldier3", "U_LIB_GER_Schutze",
			"U_LIB_GER_Schutze_HBT", "U_LIB_GER_Soldier_camo", "U_LIB_GER_Soldier_camo2", "U_LIB_GER_Soldier_camo3", "U_LIB_GER_Soldier_camo4", "U_LIB_GER_Soldier_camo5",
			"U_LIB_GER_Pionier", "U_LIB_GER_LW_pilot", "U_LIB_GER_Funker", "U_LIB_GER_Art_schutze", "U_LIB_GER_Oberschutze", "U_LIB_GER_Gefreiter", "U_LIB_GER_Unterofficer",
			"U_LIB_GER_Unterofficer_HBT", "U_LIB_GER_Art_unterofficer", "U_LIB_GER_Recruit", "U_LIB_GER_Medic", "U_LIB_GER_Leutnant", "U_LIB_GER_Art_leutnant",
			"U_LIB_GER_Oberleutnant", "U_LIB_GER_Hauptmann", "U_LIB_GER_Oberst", "U_LIB_GER_Scharfschutze", "U_LIB_GER_MG_schutze", "U_LIB_GER_MG_schutze_HBT",
			"U_LIB_DAK_Soldier", "U_LIB_DAK_Soldier_2", "U_LIB_DAK_Soldier_3", "U_LIB_DAK_Sentry", "U_LIB_DAK_Sentry_2", "U_LIB_DAK_Medic", "U_LIB_DAK_NCO", "U_LIB_DAK_NCO_2",
			"U_LIB_DAK_lieutenant", "U_LIB_DAK_Spg_crew_private", "U_LIB_DAK_Spg_crew_unterofficer", "U_LIB_DAK_Spg_crew_leutnant", "U_LIB_GER_Soldier3_w", "U_LIB_GER_Soldier_camo_w",
			"U_LIB_GER_Scharfschutze_w", "U_LIB_GER_Scharfschutze_2_w",

			"V_LIB_GER_FSJ_VestKar98", "V_LIB_GER_FSJ_VestKar98_Camo", "V_LIB_GER_FSJ_VestKar98_DAK", "V_LIB_GER_TankPrivateBelt", "V_LIB_GER_VestMP40", "V_LIB_GER_VestSTG",
			"V_LIB_GER_VestKar98", "V_LIB_GER_VestG43", "V_LIB_GER_SniperBelt", "V_LIB_GER_VestMG", "V_LIB_GER_VestUnterofficer", "V_LIB_GER_FieldOfficer", "V_LIB_GER_OfficerVest",
			"V_LIB_GER_OfficerBelt", "V_LIB_GER_PrivateBelt", "V_LIB_GER_PioneerVest", "V_LIB_WP_MP40Vest", "V_LIB_WP_STGVest", "V_LIB_WP_Kar98Vest", "V_LIB_WP_G43Vest",
			"V_LIB_WP_SniperBela", "V_LIB_WP_MGVest", "V_LIB_WP_OfficerVest", "V_LIB_DAK_VestMP40", "V_LIB_DAK_VestSTG", "V_LIB_DAK_VestKar98", "V_LIB_DAK_VestG43",
			"V_LIB_DAK_SniperBelt", "V_LIB_DAK_VestMG", "V_LIB_DAK_VestUnterofficer", "V_LIB_DAK_FieldOfficer", "V_LIB_DAK_OfficerVest", "V_LIB_DAK_OfficerBelt",
			"V_LIB_DAK_PrivateBelt", "V_LIB_DAK_PioneerVest",

			"H_LIB_GER_FSJ_M38_Helmet", "H_LIB_GER_FSJ_M38_Helmet_os", "H_LIB_GER_FSJ_M38_Helmet_grey", "H_LIB_GER_FSJ_M38_Helmet_grey_os", "H_LIB_GER_FSJ_M38_Helmet_DAK",
			"H_LIB_GER_FSJ_M38_Helmet_Cover", "H_LIB_GER_FSJ_M44_Helmet", "H_LIB_GER_FSJ_M44_Helmet_os", "H_LIB_GER_FSJ_M44_HelmetCamo1", "H_LIB_GER_FSJ_M44_HelmetCamo2",
			"H_LIB_GER_FSJ_M44_Helmet_Medic", "H_LIB_GER_FSJ_M44_Helmet_Winter", "H_LIB_GER_FSJ_M44_HelmetUtility", "H_LIB_ST_Helmet", "H_LIB_ST_Helmet2", "H_LIB_GER_Fieldcap",
			"H_LIB_GER_Fieldcap2", "H_LIB_GER_Fieldcap_w", "H_LIB_GER_TankOfficerCap", "H_LIB_GER_TankOfficerCap2", "H_LIB_GER_TankPrivateCap", "H_LIB_GER_TankPrivateCap2",
			"H_LIB_GER_SPGPrivateCap", "H_LIB_GER_Helmet", "H_LIB_GER_Helmet_net", "H_LIB_GER_Helmet_ns", "H_LIB_GER_Helmet_os", "H_LIB_GER_Helmet_Medic", "H_LIB_GER_Helmet_painted",
			"H_LIB_GER_Helmet_net_painted", "H_LIB_GER_Helmet_ns_painted", "H_LIB_GER_Helmet_os_painted", "H_LIB_GER_Helmet_Glasses", "H_LIB_GER_HelmetUtility",
			"H_LIB_GER_HelmetUtility_Grass", "H_LIB_GER_HelmetUtility_Oak", "H_LIB_GER_HelmetCamo", "H_LIB_GER_HelmetCamo2", "H_LIB_GER_HelmetCamo3", "H_LIB_GER_HelmetCamo4",
			"H_LIB_GER_OfficerCap", "H_LIB_GER_Cap", "H_LIB_GER_LW_PilotHelmet", "H_LIB_GER_Ushanka", "H_LIB_DAK_PithHelmet", "H_LIB_DAK_Helmet", "H_LIB_DAK_Helmet_2",
			"H_LIB_DAK_Helmet_net", "H_LIB_DAK_Helmet_net_2", "H_LIB_DAK_Helmet_ns", "H_LIB_DAK_Helmet_ns_2", "H_LIB_DAK_Helmet_Glasses", "H_LIB_DAK_OfficerCap", "H_LIB_DAK_Cap",
			"H_LIB_GER_Helmet_w", "H_LIB_GER_Helmet_net_w", "H_LIB_GER_Helmet_ns_w", "H_LIB_GER_HelmetCamo_w", "H_LIB_GER_HelmetCamob_w", "H_LIB_GER_HelmetCamo2_w",
			"H_LIB_GER_HelmetCamo2b_w", "H_LIB_GER_HelmetCamo4_w", "H_LIB_GER_Helmet_Glasses_w"
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
			"Binocular", (if (d_no_faks == 1) then {"FirstAidKit"} else {""}), "Medikit", "ToolKit",
			"G_LIB_Binoculars",
			"G_LIB_Dienst_Brille", "G_LIB_Dienst_Brille2", "G_LIB_Dust_Goggles", "G_LIB_GER_Headset", "G_LIB_GER_Gloves1", "G_LIB_GER_Gloves2", "G_LIB_GER_Gloves3",
			"G_LIB_GER_Gloves4", "G_LIB_GER_Gloves5", "G_LIB_Headwrap", "G_LIB_Scarf_G", "G_LIB_Scarf_B", "G_LIB_Scarf2_G", "G_LIB_Scarf2_B", "G_LIB_Headwrap_gloves", "G_LIB_Watch1", "G_LIB_Watch2"
		]
	]
];

private _all_weapons_items_opfor = [
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"RIFLES",
		// private rifles
		[
			"LIB_M9130", "LIB_M1903A3_Springfield"
		],
		// corporal rifles (gets added to private rifles)
		[
			"LIB_M3_GreaseGun", "LIB_DP28", "LIB_DT"
		],
		// sergeant rifles (gets added to corporal and private rifles)
		[
			"LIB_PPSh41_m", "LIB_M1_Garand", "LIB_M1919A4", "LIB_M1928_Thompson"
		],
		// lieutenant rifles (gets added to...)
		[
			"LIB_M1_Carbine", "LIB_DELISLE", "LIB_M1919A6", "LIB_M1928A1_Thompson"
		],
		// captain rifles (gets added...)
		[
			"LIB_M1A1_Thompson", "LIB_M1918A2_BAR", "LIB_M1A1_Carbine"
		],
		// major rifles (gets...)
		[
			"LIB_SVT_40", "LIB_M2_Flamethrower", "LIB_M9130PU", "LIB_M1903A4_Springfield"
		],
		// colonel rifles (...)
		[
			"LIB_PTRD", "LIB_DT_OPTIC"
		]
	],
	[
		1, // 1 = will only be added for a specific rank in the ranked version
		"LAUNCHERS",
		// private launchers
		[
			"LIB_M1A1_Bazooka"
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
			"LIB_TT33"
		],
		// sergeant pistols
		[
			"LIB_Colt_M1911", "LIB_M1895"
		],
		// lieutenant pistols
		[
			"LIB_FLARE_PISTOL"
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
			"U_LIB_WP_Soldier_camo_1", "U_LIB_WP_Soldier_camo_2", "U_LIB_WP_Soldier_camo_3", "U_LIB_SOV_Strelok", "U_LIB_SOV_Strelok_summer", "U_LIB_SOV_Strelokart",
			"U_LIB_SOV_Tank_private_field", "U_LIB_SOV_Starshina", "U_LIB_SOV_Efreitor", "U_LIB_SOV_Efreitor_summer", "U_LIB_SOV_Sergeant", "U_LIB_SOV_Sergeant_inset_pocket",
			"U_LIB_SOV_Stsergeant", "U_LIB_SOV_Leutenant", "U_LIB_SOV_Pilot", "U_LIB_SOV_Leutenant_inset_pocket", "U_LIB_SOV_Artleutenant", "U_LIB_SOV_Stleutenant",
			"U_LIB_SOV_Kapitan", "U_LIB_SOV_Kapitan_summer", "U_LIB_SOV_Razvedchik_am", "U_LIB_SOV_Razvedchik_lis", "U_LIB_SOV_Razvedchik_mix", "U_LIB_SOV_Razvedchik_autumn",
			"U_LIB_SOV_Sniper", "U_LIB_SOV_Sniper_spring", "U_LIB_SOV_Sniper_autumn", "U_LIB_SOV_Tank_ryadovoi", "U_LIB_SOV_Tank_sergeant", "U_LIB_SOV_Tank_leutenant",
			"U_LIB_SOV_Tank_kapitan", "U_LIB_US_AB_Uniform_M42", "U_LIB_US_AB_Uniform_M42_Medic", "U_LIB_US_AB_Uniform_M42_506", "U_LIB_US_AB_Uniform_M42_Gas",
			"U_LIB_US_AB_Uniform_M42_FC", "U_LIB_US_AB_Uniform_M42_corporal", "U_LIB_US_AB_Uniform_M42_NCO", "U_LIB_US_AB_Uniform_M43", "U_LIB_US_AB_Uniform_M43_Medic",
			"U_LIB_US_AB_Uniform_M43_Flag", "U_LIB_US_AB_Uniform_M43_FC", "U_LIB_US_AB_Uniform_M43_corporal", "U_LIB_US_AB_Uniform_M43_NCO", "U_LIB_US_Pilot", "U_LIB_US_Pilot_2",
			"U_LIB_US_Bomber_Pilot", "U_LIB_US_Bomber_Crew", "U_LIB_US_Private", "U_LIB_US_Private_1st", "U_LIB_US_Corp", "U_LIB_US_Sergant", "U_LIB_US_Eng", "U_LIB_US_Med",
			"U_LIB_US_Tank_Crew", "U_LIB_US_Tank_Crew2", "U_LIB_US_NAC_Uniform", "U_LIB_US_NAC_Uniform_2", "U_LIB_US_NAC_Med", "U_LIB_US_Rangers_Uniform",
			"U_LIB_US_Rangers_Private_1st", "U_LIB_US_Rangers_Corp", "U_LIB_US_Rangers_Sergant", "U_LIB_US_Rangers_Eng", "U_LIB_US_Rangers_Med", "U_LIB_NKVD_Efreitor",
			"U_LIB_NKVD_Strelok", "U_LIB_NKVD_Starshina", "U_LIB_NKVD_Sergeant", "U_LIB_NKVD_Leutenant", "U_LIB_NKVD_StLeutenant", "U_LIB_SOV_Strelok_w", "U_LIB_SOV_Strelok_2_w",
			"U_LIB_SOV_Sniper_w", "U_LIB_US_Private_w", "U_LIB_US_AB_Uniform_M42_W", "U_LIB_US_AB_Uniform_M43_W",

			"V_LIB_SOV_IShBrVestMG", "V_LIB_SOV_IShBrVestPPShMag", "V_LIB_SOV_IShBrVestPPShDisc", "V_LIB_SOV_RA_OfficerVest", "V_LIB_SOV_RA_SniperVest", "V_LIB_SOV_RA_Belt",
			"V_LIB_SOV_RA_TankOfficerSet", "V_LIB_SOV_RA_PPShBelt", "V_LIB_SOV_RA_MosinBelt", "V_LIB_SOV_RA_SVTBelt", "V_LIB_SOV_RA_MGBelt", "V_LIB_SOV_RAZV_SVTBelt",
			"V_LIB_SOV_RAZV_OfficerVest", "V_LIB_SOV_RAZV_MGBelt", "V_LIB_SOV_RAZV_PPShBelt", "V_LIB_US_AB_Vest_Bar", "V_LIB_US_AB_Vest_M1919", "V_LIB_US_AB_Vest_Asst_MG",
			"V_LIB_US_AB_Vest_Carbine", "V_LIB_US_AB_Vest_Carbine_eng", "V_LIB_US_AB_Vest_Carbine_nco", "V_LIB_US_AB_Vest_Carbine_nco_Radio", "V_LIB_US_AB_Vest_Garand",
			"V_LIB_US_AB_Vest_Grenadier", "V_LIB_US_AB_Vest_Thompson", "V_LIB_US_AB_Vest_Thompson_nco", "V_LIB_US_AB_Vest_Thompson_nco_Radio", "V_LIB_US_AB_Vest_45",
			"V_LIB_US_LifeVest", "V_LIB_US_Vest_Bar", "V_LIB_US_Vest_M1919", "V_LIB_US_Vest_Asst_MG", "V_LIB_US_Vest_Carbine", "V_LIB_US_Vest_Carbine_eng",
			"V_LIB_US_Vest_Carbine_nco", "V_LIB_US_Vest_Carbine_nco_Radio", "V_LIB_US_Vest_Garand", "V_LIB_US_Vest_Grenadier", "V_LIB_US_Vest_Medic", "V_LIB_US_Vest_Medic2",
			"V_LIB_US_Vest_Thompson", "V_LIB_US_Vest_Thompson_nco", "V_LIB_US_Vest_Thompson_nco_Radio", "V_LIB_US_Vest_45", "V_LIB_US_Assault_Vest", "V_LIB_US_Assault_Vest_Light",
			"V_LIB_US_Assault_Vest_Thompson", "V_LIB_US_Assault_Vest_dday",

			"H_LIB_ST_Helmet", "H_LIB_ST_Helmet2", "H_LIB_WP_Helmet", "H_LIB_WP_Helmet_camo", "H_LIB_WP_Helmet_med", "H_LIB_WP_Cap", "H_LIB_SOV_RA_PrivateCap",
			"H_LIB_SOV_RA_OfficerCap", "H_LIB_SOV_RA_Helmet", "H_LIB_SOV_TankHelmet", "H_LIB_SOV_PilotHelmet", "H_LIB_SOV_Ushanka", "H_LIB_SOV_Ushanka2", "H_LIB_US_AB_Helmet",
			"H_LIB_US_AB_Helmet_2", "H_LIB_US_AB_Helmet_3", "H_LIB_US_AB_Helmet_4", "H_LIB_US_AB_Helmet_5", "H_LIB_US_AB_Helmet_Jump_1", "H_LIB_US_AB_Helmet_Jump_2",
			"H_LIB_US_AB_Helmet_Clear_1", "H_LIB_US_AB_Helmet_Clear_2", "H_LIB_US_AB_Helmet_Clear_3", "H_LIB_US_AB_Helmet_Medic_1", "H_LIB_US_AB_Helmet_Plain_1",
			"H_LIB_US_AB_Helmet_Plain_2", "H_LIB_US_AB_Helmet_Plain_3", "H_LIB_US_AB_Helmet_NCO_1", "H_LIB_US_AB_Helmet_NCO_2", "H_LIB_US_AB_Helmet_CO_1",
			"H_LIB_US_AB_Helmet_CO_2", "H_LIB_US_Helmet_Pilot", "H_LIB_US_Helmet_Pilot_Glasses_Up", "H_LIB_US_Helmet_Pilot_Glasses_Down", "H_LIB_US_Helmet_Pilot_Respirator",
			"H_LIB_US_Helmet_Pilot_Respirator_Glasses_Up", "H_LIB_US_Helmet_Pilot_Respirator_Glasses_Down", "H_LIB_US_Pilot_Cap", "H_LIB_US_Pilot_Cap_Khaki", "H_LIB_US_Helmet",
			"H_LIB_US_Helmet_ns", "H_LIB_US_Helmet_os", "H_LIB_US_Helmet_Net", "H_LIB_US_Helmet_Net_ns", "H_LIB_US_Helmet_Net_os", "H_LIB_US_Helmet_Med",
			"H_LIB_US_Helmet_Med_ns", "H_LIB_US_Helmet_Med_os", "H_LIB_US_Helmet_Cap", "H_LIB_US_Helmet_CO", "H_LIB_US_Helmet_NCO", "H_LIB_US_Helmet_First_lieutenant",
			"H_LIB_US_Helmet_Second_lieutenant", "H_LIB_US_Helmet_Tank", "H_LIB_US_Rangers_Helmet", "H_LIB_US_Rangers_Helmet_ns", "H_LIB_US_Rangers_Helmet_os",
			"H_LIB_US_Rangers_Helmet_Cap", "H_LIB_US_Rangers_Helmet_First_lieutenant", "H_LIB_US_Rangers_Helmet_Second_lieutenant", "H_LIB_US_Rangers_Helmet_NCO",
			"H_LIB_NKVD_PrivateCap", "H_LIB_NKVD_OfficerCap", "H_LIB_SOV_RA_Helmet_w", "H_LIB_US_Helmet_w", "H_LIB_US_Helmet_Cover_w", "H_LIB_US_Helmet_Net_w",
			"H_LIB_US_Helmet_Med_w", "H_LIB_US_Helmet_Cap_w", "H_LIB_US_Helmet_First_lieutenant_w", "H_LIB_US_Helmet_Second_lieutenant_w"
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
			"Binocular", (if (d_no_faks == 1) then {"FirstAidKit"} else {""}), "Medikit", "ToolKit",
			"G_LIB_Binoculars",
			"G_LIB_Dust_Goggles", "G_LIB_Headwrap", "G_LIB_Mohawk", "G_LIB_Scarf_G", "G_LIB_Scarf_B", "G_LIB_Scarf2_G", "G_LIB_Scarf2_B", "G_LIB_Headwrap_gloves", "G_LIB_Watch1", "G_LIB_Watch2"
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
