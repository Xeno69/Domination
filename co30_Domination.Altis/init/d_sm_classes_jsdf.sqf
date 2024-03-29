d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "C_Nikos_aged";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"rhs_typhoon_vdv"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_35t_truck"};
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
	case "E": {"rhs_vdv_officer"};
	case "W": {"Sparky_JSDF_Overhaul_Officer_JGSDF"};
	case "G": {"I_officer_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"rhs_vdv_marksman"};
	case "W": {"Sparky_JSDF_Overhaul_Sniper_JGSDF"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"rhs_2s3_tv"};
	case "W": {"Sparky_JSDF_Overhaul_Type75_155mm_SPG"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"RHS_T50_vvs_blueonblue"};
	case "W": {"Sparky_JSDF_Overhaul_JSDF_JASDF_F4A"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"rhs_t90a_tv"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_type10_v2"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {"rhsgref_BRDM2_HQ_vmf"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_WAPC_GMG"};
	case "G": {"I_MRAP_03_hmg_F"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"RHS_Ka52_vvsc"};
	case "W": {"Sparky_JSDF_Overhaul_JSDF_JGSDF_AH1S"};
	case "G": {"I_Heli_light_03_F"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"rhs_pilot"};
	case "W": {"Sparky_JSDF_Overhaul_FighterPilot_JASDF"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"Land_rhs_mi28_wreck"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"rhs_gaz66_ammo_vdv"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_35t_resupply"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {"rhs_kamaz5350_msv"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_35t_truck"};
	case "G": {"I_Truck_02_covered_F"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {"RHS_Ural_Fuel_MSV_01"};
	case "W": {"Sparky_JSDF_Overhaul_gac_JGSDF_35t_fuel"};
	case "G": {"I_Truck_02_fuel_F"};
};
d_sm_camo_net = call {
   if (d_enemy_side_short == "W") exitWith {"CamoNet_BLUFOR_big_F"};
   if (d_enemy_side_short == "E") exitWith {"CamoNet_OPFOR_big_F"};
   "CamoNet_INDP_big_F"
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"rhs_gaz66_ap2_vdv"};
	case "W": {"Sparky_JSDF_Overhaul_JSDF_JGSDF_112T_Medical"};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["Sparky_JSDF_Overhaul_gac_JGSDF_35t_resupply", "Sparky_JSDF_Overhaul_gac_JGSDF_35t_fuel", "Sparky_JSDF_Overhaul_gac_JGSDF_35t_truck", "Sparky_JSDF_Overhaul_JSDF_JGSDF_112T_Medical"]};
	case "W": {["RHS_Ural_Repair_VDV_01", "rhs_gaz66_ammo_vdv", "RHS_Ural_Fuel_VDV_01", "rhs_gaz66_ap2_vdv"]};
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "I_Truck_03_fuel_F", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"rhs_t15_tv"};
	case "W": {"Sparky_JSDF_Overhaul_JSDF_JGSDF_Type89IFV"};
	case "G": {"rhsgref_cdf_bmp2k"};
};
