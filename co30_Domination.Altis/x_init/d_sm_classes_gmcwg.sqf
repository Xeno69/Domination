d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "gm_gc_pol_officer_80_blu";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_bgs_ural4320_cargo_win"
			};
			"gm_gc_bgs_ural4320_cargo"
		};
	};
	case "W": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_kat1_454_win"
			};
			"gm_ge_army_kat1_454_cargo"
		};
	};
	case "G": {"I_Truck_02_box_F"};
};
//d_sm_hangar = "Land_TentHangar_V1_F"; // Land_TentHangar_V1_F creates 3 objects and adding a killed eh makes it useless as the correct object might never get destroyed
d_sm_hangar = "Land_Hangar_F";
d_sm_tent = "Land_TentA_F";

d_sm_land_tankbig = "Land_dp_bigTank_F";
d_sm_land_transformer = "Land_dp_transformer_F";
d_sm_barracks = "Land_i_Barracks_V2_F";
d_sm_land_tanksmall = "Land_dp_smallTank_F";
d_sm_land_factory = "Land_u_Barracks_V2_F";
d_sm_small_radar = "Land_Radar_Small_F";

d_soldier_officer = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_officer_pm_80_win"
			};
			"gm_gc_army_officer_pm_80_str"
		};
	};
	case "W": {"gm_ge_army_officer_p1_80_oli"};
	case "G": {"I_officer_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_rifleman_mpiak74n_80_win"
			};
			"gm_gc_army_rifleman_mpiak74n_80_str"
		};
	};
	case "W": {"B_sniper_F"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_arty_F"};
	case "W": {"B_MBT_01_arty_F"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"O_Plane_CAS_02_F"};
	case "W": {"B_Plane_CAS_01_F"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_t55a_win"
			};
			"gm_gc_army_t55a"
		};
	};
	case "W": {"B_MBT_01_cannon_F"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_btr60pu12_win"
			};
			"gm_gc_army_btr60pu12"
		};
	};
	case "W": {"B_MRAP_01_gmg_F"};
	case "G": {"I_MRAP_03_hmg_F"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"O_Heli_Attack_02_black_F"};
	case "W": {"B_Heli_Attack_01_F"};
	case "G": {"I_Heli_light_03_F"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"B_Helipilot_F"};
	case "W": {"O_helipilot_F"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"Land_UWreck_Heli_Attack_02_F"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_ural4320_reammo_win"
			};
			"gm_gc_army_ural4320_reammo"
		};
	};	
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_army_ural4320_cargo_win"
			};
			"gm_gc_army_ural4320_cargo"
		};
	};
	case "W": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_kat1_454_cargo_win"
			};
			"gm_ge_army_kat1_454_cargo"
		};
	};
	case "G": {"I_Truck_02_covered_F"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_bgs_ural375d_refuel_win"
			};
			"gm_gc_bgs_ural375d_refuel"
		};
	};
	case "W": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_kat1_451_refuel_win"
			};
			"gm_ge_army_kat1_451_refuel"
		};
	};	
	case "G": {"I_Truck_02_fuel_F"};
};
d_sm_camo_net = call {
   if (d_enemy_side_short == "W") exitWith {"CamoNet_BLUFOR_big_F"};
   if (d_enemy_side_short == "E") exitWith {"CamoNet_OPFOR_big_F"};
   "CamoNet_INDP_big_F"
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_gc_bgs_ural375d_medic_win"
			};
			"gm_gc_bgs_ural375d_medic"
		};
	};
	case "W": {
		call {
			if (d_gmcwgwinter) exitWith {
				"gm_ge_army_u1300l_medic_win"
			};
			"gm_ge_army_u1300l_medic"
		};
	};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {
		call {
			if (d_gmcwgwinter) exitWith {
				["gm_ge_army_u1300l_repair_win", "gm_ge_army_kat1_451_reammo_win", "gm_ge_army_kat1_451_refuel_win", "gm_ge_army_u1300l_medic_win"]
			};
			["gm_ge_army_u1300l_repair", "gm_ge_army_kat1_451_reammo", "gm_ge_army_kat1_451_refuel", "gm_ge_army_u1300l_medic"]
		};
	};
	case "W": {
		call {
			if (d_gmcwgwinter) exitWith {
				["gm_gc_bgs_ural4320_repair_win", "gm_gc_army_ural4320_reammo_win", "gm_gc_bgs_ural375d_refuel_win", "gm_gc_bgs_ural375d_medic_win"]
			};
			["gm_gc_bgs_ural4320_repair", "gm_gc_army_ural4320_reammo", "gm_gc_bgs_ural375d_refuel", "gm_gc_bgs_ural375d_medic"]
		};
	};	
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "I_Truck_03_fuel_F", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"gm_gc_army_bmp1sp2"};
	case "W": {"gm_ge_army_m113a1g_apc_milan"};
	case "G": {"I_APC_tracked_03_cannon_F"};
};
