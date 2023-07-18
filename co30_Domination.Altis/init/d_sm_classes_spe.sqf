d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "C_Nikos_aged";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_box_F"};
	case "W": {"SPE_ST_OpelBlitz"};
	case "G": {"SPE_FFI_OpelBlitz"};
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
	case "E": {"O_Officer_Parade_Veteran_F"};
	case "W": {"SPE_GER_oberst"};
	case "G": {"SPE_US_Pilot_Unequipped"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"O_sniper_F"};
	case "W": {"SPE_GER_scout_sniper"};
	case "G": {"SPE_US_Rangers_sniper"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_arty_F"};
	case "W": {"SPE_leFH18"};
	case "G": {"SPE_M4A1_T34_Calliope"};
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"O_Plane_CAS_02_F"};
	case "W": {"SPE_FW190F8"};
	case "G": {"SPE_P47"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"O_MBT_02_cannon_F"};
	case "W": {"SPE_PzKpfwVI_H1"};
	case "G": {"SPE_M4A1_76"};
};
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {"O_MRAP_02_gmg_F"};
	case "W": {"SPE_SdKfz250_1"};
	case "G": {"SPE_US_M3_Halftrack"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {""};
	case "W": {""};
	case "G": {""};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"B_Helipilot_F"};
	case "W": {"SPE_GER_pilot"};
	case "G": {"SPE_US_Pilot_2"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"SPE_FW190F8_MRWreck"};
	case "G": {"SPE_P47_MRWreck"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_Ammo_F"};
	case "W": {"SPE_OpelBlitz_Ammo"};
	case "G": {"SPE_US_M3_Halftrack_Ammo"};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {["O_APC_Tracked_02_cannon_F","O_T_APC_Tracked_02_cannon_ghex_F"] select (d_tanoa || {d_livonia})};
	case "W": {"SPE_SdKfz250_1"};
	case "G": {"SPE_US_M3_Halftrack"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {["O_Truck_03_covered_F","O_T_Truck_03_covered_ghex_F"] select (d_tanoa || {d_livonia})};
	case "W": {"SPE_OpelBlitz"};
	case "G": {"SPE_FFI_OpelBlitz"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {["O_Truck_03_fuel_F", "O_T_Truck_03_fuel_ghex_F"] select (d_tanoa || {d_livonia})};
	case "W": {"SPE_OpelBlitz_Fuel"};
	case "G": {"SPE_US_M3_Halftrack_Fuel"};
};
d_sm_camo_net = call {
   if (d_enemy_side_short == "W") exitWith {"CamoNet_BLUFOR_big_F"};
   if (d_enemy_side_short == "E") exitWith {"CamoNet_OPFOR_big_F"};
   "CamoNet_INDP_big_F"
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_medical_F"};
	case "W": {"SPE_OpelBlitz_Ambulance"};
	case "G": {"SPE_US_M3_Halftrack_Ambulance"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["B_Truck_01_Repair_F", "B_Truck_01_ammo_F", "B_Truck_01_fuel_F", "B_Truck_01_medical_F"]};
	case "W": {["SPE_US_M3_Halftrack_Repair", "SPE_US_M3_Halftrack_Ammo", "SPE_US_M3_Halftrack_Fuel", "SPE_US_M3_Halftrack_Ambulance"]};
	case "G": {["SPE_OpelBlitz_Repair", "SPE_OpelBlitz_Ammo", "SPE_OpelBlitz_Fuel", "SPE_OpelBlitz_Ambulance"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["SPE_BasicWeaponsBox_GER", "SPE_BasicWeaponsBox_US", "SPE_AmmoCrate_VehicleAmmo_US"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["SPE_BasicWeaponsBox_GER", "SPE_BasicWeaponsBox_US", "SPE_AmmoCrate_VehicleAmmo_US"]};
};
