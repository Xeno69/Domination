d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "LIB_CIV_Functionary_1";
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
d_sm_land_transformer = "Land_dp_transformer_F";
d_sm_barracks = "Land_i_Barracks_V2_F";
d_sm_land_tanksmall = "Land_dp_smallTank_F";
d_sm_land_factory = "Land_u_Barracks_V2_F";
d_sm_small_radar = "Land_Radar_Small_F";

d_soldier_officer = switch (d_enemy_side_short) do {
	case "E": {"O_officer_F"};
	case "W": {"LIB_GER_oberst"};
	case "G": {"I_officer_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"O_sniper_F"};
	case "W": {"LIB_GER_scout_sniper"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_arty_F"};
	case "W": {"LIB_Nebelwerfer41"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"O_Plane_CAS_02_F"};
	case "W": {"LIB_FW190F8_Italy"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_cannon_F"};
	case "W": {"LIB_PzKpfwVI_B"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_tank_own_side = switch (d_own_side_short) do {
	case "E": {"O_MBT_02_cannon_F"};
	case "W": {"LIB_PzKpfwVI_B"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_Ammo_F"};
	case "W": {"LIB_opelblitz_ammo"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"O_Truck_02_Ammo_F"};
	case "W": {"LIB_opelblitz_ammo"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_medical_F"};
	case "W": {"LIB_opelblitz_ambulance"};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["LIB_OpelBlitz_Parm", "LIB_OpelBlitz_Ammo", "LIB_OpelBlitz_Fuel", "LIB_OpelBlitz_Ambulance"]};
	case "W": {["LIB_Zis6_Parm", "LIB_US6_Ammo", "LIB_Zis5v_Fuel", "LIB_Zis5v_Med"]};
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "I_Truck_03_fuel_F", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"LIB_SOV_M3_Halftrack"};
	case "W": {"LIB_SdKfz234_4_DLV"};
	case "G": {"LIB_US_M3_Halftrack"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"LIB_SOV_M3_Halftrack"};
	case "W": {"LIB_SdKfz234_4_DLV"};
	case "G": {"LIB_US_M3_Halftrack"};
};
