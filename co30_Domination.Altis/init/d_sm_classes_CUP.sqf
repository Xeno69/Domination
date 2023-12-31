d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "CUP_C_C_Functionary_01";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_box_F"};
	case "W": {"B_Truck_01_box_F"};
	case "G": {"I_Truck_02_box_F"};
};
//d_sm_hangar = "Land_TentHangar_V1_F"; // Land_TentHangar_V1_F creates 3 objects and adding a killed eh makes it useless as the correct object might never get destroyed
d_sm_hangar = "Land_Hangar_F";
d_sm_tent = "Land_TentA_F";

d_sm_land_tankbig = "Land_dp_bigTank_F";
d_sm_land_transformer = if (worldName != "cup_chernarus_A3") then {"Land_dp_transformer_F"} else {"Land_Trafostanica_mala"};
d_sm_barracks = "Land_i_Barracks_V2_F";
d_sm_land_tanksmall = "Land_dp_smallTank_F";
d_sm_land_factory = "Land_u_Barracks_V2_F";
d_sm_small_radar = "Land_Radar_Small_F";

d_soldier_officer = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_RU_Officer_EMR"};
	case "W": {"B_officer_F"};
	case "G": {"I_officer_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_RU_Sniper_KSVK_EMR"};
	case "W": {"B_sniper_F"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_arty_F"};
	case "W": {"B_MBT_01_arty_F"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_SU34_AGM_SLA"};
	case "W": {"B_Plane_CAS_01_F"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_T90_RU"};
	case "W": {"CUP_B_M1A1_Woodland_US_Army"};
	case "G": {"CUP_I_M60A3_RACS"};
};
d_sm_tank_own_side = switch (d_own_side_short) do {
	case "E": {"CUP_O_T90_RU"};
	case "W": {"CUP_B_M1A1_Woodland_US_Army"};
	case "G": {"CUP_I_T72_NAPA"};
};
d_sm_tank_special_own_side = switch (d_own_side_short) do {
	case "E": {"CUP_O_ZSU23_TK"};
	case "W": {"CUP_B_M1A_TUSK_NATO_T"};
	case "G": {"CUP_I_ZSU23_Afghan_AAF"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_Ka52_Blk_RU"};
	case "W": {"B_Heli_Attack_01_F"};
	case "G": {"I_Heli_light_03_F"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"CUP_B_US_Pilot"};
	case "W": {"O_helipilot_F"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"Land_UWreck_Heli_Attack_02_F"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_Ammo_F"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"O_Truck_02_Ammo_F"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_medical_F"};
	case "W": {"B_Truck_01_medical_F"};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["CUP_B_MTVR_Repair_USA", "CUP_B_MTVR_Ammo_USA", "CUP_B_MTVR_Refuel_USA", "CUP_B_HMMWV_Ambulance_USA"]};
	case "W": {["CUP_O_Ural_Repair_RU", "CUP_O_Ural_Reammo_RU", "CUP_O_Ural_Refuel_RU", "CUP_O_GAZ_Vodnik_MedEvac_RU"]};
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "CUP_O_Ural_Refuel_RU", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"CUP_O_BMP3_RU"};
	case "W": {"CUP_B_M2A3Bradley_USA_W"};
	case "G": {"CUP_I_BMP_HQ_NAPA"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"CUP_O_BMP3_RU"};
	case "W": {"CUP_B_M2A3Bradley_USA_W"};
	case "G": {"CUP_I_BMP_HQ_NAPA"};
};