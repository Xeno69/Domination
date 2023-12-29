d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "vn_c_men_01";
d_fuel_station = "Land_vn_fuelstation_build_02_f";//
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_02"};
	case "W": {"rhsusf_M1078A1P2_B_D_CP_fmtv_usarmy"};
	case "G": {"I_Truck_02_box_F"};
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
	case "W": {"rhsusf_army_ocp_officer"};
	case "G": {"I_officer_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"vn_o_men_nva_10"};
	case "W": {"rhsusf_socom_marsoc_sniper_m107"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"vn_o_nva_static_d44_01"};
	case "W": {"rhsusf_m109d_usarmy"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"vn_o_air_mig19_cas"};
	case "W": {"rhsusf_f22"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"vn_o_armor_m41_01"};
	case "W": {"rhsusf_m1a2sep1tuskiid_usarmy"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_tank_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_armor_m41_01"};
	case "W": {"rhsusf_m1a2sep1tuskiid_usarmy"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01_nvam"};
	case "W": {"rhsusf_M1237_M2_usarmy_d"};
	case "G": {"I_MRAP_03_hmg_F"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"vn_o_air_mi2_03_05"};
	case "W": {"RHS_AH64DGrey"};
	case "G": {"I_Heli_light_03_F"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"vn_b_men_aircrew_05"};
	case "W": {"I_helipilot_F"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"vn_air_uh1d_01_wreck"};
	case "W": {"Land_rhs_mi28_wreck"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_ammo_nvam"};
	case "W": {"rhsusf_M977A4_AMMO_usarmy_d"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_wheeled_z157_ammo_nvam"};
	case "W": {"rhsusf_M977A4_AMMO_usarmy_d"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_02_nvam"};
	case "W": {"B_Truck_01_covered_F"};
	case "G": {"I_Truck_02_covered_F"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_fuel_nvam"};
	case "W": {"B_Truck_01_fuel_F"};
	case "G": {"I_Truck_02_fuel_F"};
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
	case "E": {["vn_b_wheeled_m54_repair", "vn_b_wheeled_m54_ammo", "vn_b_wheeled_m54_fuel", "vn_b_wheeled_m54_01_sog"]};
	case "W": {["RHS_Ural_Repair_VDV_01", "rhs_gaz66_ammo_vdv", "RHS_Ural_Fuel_VDV_01", "rhs_gaz66_ap2_vdv"]};
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "I_Truck_03_fuel_F", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Land_vn_pavn_weapons_cache", "Land_vn_pavn_launchers", "Land_vn_pavn_weapons_wide"]};
	case "E": {["Land_vn_pavn_weapons_cache", "Land_vn_pavn_launchers", "Land_vn_pavn_weapons_wide"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01"};
	case "W": {"uns_M113A1_M134"};
	case "G": {"rhsgref_cdf_bmp2k"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"vn_o_wheeled_btr40_mg_01"};
	case "W": {"uns_M113A1_M134"};
	case "G": {"rhsgref_cdf_bmp2k"};
};
d_sm_scud = switch (d_enemy_side_short) do {
	case "E": {"vn_o_wheeled_z157_04"};
	case "W": {""};
	case "G": {""};
};
