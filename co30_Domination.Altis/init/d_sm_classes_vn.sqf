d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "vn_c_men_01";
d_fuel_station = "Land_vn_fuelstation_build_02_f";//
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_02"};
	case "W": {"vn_b_wheeled_m54_01"};
	case "G": {"vn_i_wheeled_m54_01"};
};
//d_sm_hangar = "Land_TentHangar_V1_F"; // Land_TentHangar_V1_F creates 3 objects and adding a killed eh makes it useless as the correct object might never get destroyed
//d_sm_hangar = "Land_vn_usaf_hangar_01"; // doesn't work, yet another SOG object which can't be destroyed
d_sm_hangar = "Land_Hangar_F";
d_sm_tent = "Land_TentA_F";

d_sm_land_tankbig = "Land_vn_dp_bigtank_f";
d_sm_land_transformer = "Land_vn_dpp_01_transformer_f";
d_sm_barracks = "Land_vn_i_barracks_v2_f";
d_sm_land_tanksmall = "Land_vn_dp_smalltank_f";
d_sm_land_factory = "Land_u_Barracks_V2_F";
d_sm_small_radar = "Land_vn_radar_small_f";

d_soldier_officer = switch (d_enemy_side_short) do {
	case "E": {"vn_o_men_nva_01"};
	case "W": {"vn_b_men_sog_01"};
	case "G": {"vn_i_men_army_01"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"vn_o_men_nva_10"};
	case "W": {"vn_b_men_sog_12"};
	case "G": {"vn_i_men_army_10"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"vn_o_nva_static_d44_01"};
	case "W": {"vn_b_army_static_m101_01"};
	case "G": {"vn_i_static_m101_01"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"vn_o_air_mig19_cas"};
	case "W": {"vn_b_air_f4b_usmc_cas"};
	case "G": {"vn_b_air_f4b_usmc_cas"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"vn_o_armor_m41_01"};
	case "W": {"vn_b_armor_m67_01_01"};
	case "G": {"vn_i_armor_m67_01_01"};
};
d_sm_tank_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_armor_m41_01"};
	case "W": {"vn_b_armor_m67_01_01"};
	case "G": {"vn_i_armor_m67_01_01"};
};
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01_nvam"};
	case "W": {"vn_b_wheeled_m151_mg_02"};
	case "G": {"vn_i_wheeled_m151_mg_01"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"vn_o_air_mi2_03_05"};
	case "W": {"vn_b_air_ch34_01_01"};
	case "G": {"vn_i_air_ch34_01_02"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"vn_b_men_aircrew_05"};
	case "W": {"I_helipilot_F"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"vn_air_mi2_01_wreck"};
	case "W": {"vn_air_uh1d_01_wreck"};
	case "G": {"vn_air_ch34_01_wreck"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_ammo_nvam"};
	case "W": {"vn_b_wheeled_m54_ammo"};
	case "G": {"vn_i_wheeled_m54_ammo"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_wheeled_z157_ammo_nvam"};
	case "W": {"vn_b_wheeled_m54_ammo"};
	case "G": {"vn_i_wheeled_m54_ammo"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_02_nvam"};
	case "W": {"vn_b_wheeled_m54_01"};
	case "G": {"vn_i_wheeled_m54_01"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_fuel_nvam"};
	case "W": {"vn_b_wheeled_m54_fuel"};
	case "G": {"vn_i_wheeled_m54_fuel"};
};
d_sm_camo_net = call {
   if (d_enemy_side_short == "W") exitWith {"Land_vn_camonetb_nato"};
   if (d_enemy_side_short == "E") exitWith {"Land_vn_camonetb_east"};
   "CamoNet_INDP_big_F"
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_btr40_02"};
	case "W": {"uns_M577_amb"};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["vn_o_wheeled_z157_repair", "vn_o_wheeled_z157_ammo_nvam", "vn_o_wheeled_z157_fuel_nvam", "vn_o_wheeled_z157_02_nvam"]};
	case "W": {["vn_b_wheeled_m54_repair", "vn_b_wheeled_m54_ammo", "vn_b_wheeled_m54_fuel", "vn_b_wheeled_m54_01_sog"]};
	case "G": {["vn_i_wheeled_m54_repair", "vn_i_wheeled_m54_ammo", "vn_i_wheeled_m54_fuel", "vn_i_wheeled_m54_01"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Land_vn_pavn_weapons_cache", "Land_vn_pavn_launchers", "Land_vn_pavn_weapons_wide"]};
	case "E": {["Land_vn_pavn_weapons_cache", "Land_vn_pavn_launchers", "Land_vn_pavn_weapons_wide"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01"};
	case "W": {"vn_b_armor_m132_01"};
	case "G": {"vn_i_armor_m132_01"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01"};
	case "W": {"vn_b_armor_m132_01"};
	case "G": {"vn_i_armor_m132_01"};
};
d_sm_scud = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_04"};
	case "W": {""};
	case "G": {""};
};
