d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "C_Nikos_aged";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_MAZ_ammo"};
	case "W": {"B_Truck_01_box_F"};
	case "G": {"PRACS_M250_Supply"};
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
	case "E": {"O_Officer_Parade_Veteran_F"};
	case "W": {"B_Officer_Parade_Veteran_F"};
	case "G": {"PRACS_Infantry_CO_Dress"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"O_sniper_F"};
	case "W": {"B_sniper_F"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_2S3"};
	case "W": {"B_MBT_01_arty_F"};
	case "G": {"PRACS_M109A6"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_MiG27"};
	case "W": {"B_Plane_CAS_01_F"};
	case "G": {"PRACS_F16CJR"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_T80U"};
	case "W": {"B_MBT_01_cannon_F"};
	case "G": {"PRACS_M1A1_AIM"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_Mi24V_UPK"};
	case "W": {"B_Heli_Attack_01_F"};
	case "G": {"PRACS_AH1S"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"PRACS_F16_pilot"};
	case "W": {"O_helipilot_F"};
	case "G": {"PRACS_SLA_Aircraft_pilot"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"Land_UWreck_Heli_Attack_02_F"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_MAZ_ammo"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"PRACS_M250_Ammo"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"PRACS_SLA_MAZ_ammo"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"PRACS_M250_Ammo"};
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_Ural_AMB"};
	case "W": {"B_Truck_01_medical_F"};
	case "G": {"PRACS_M250_AMB"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["PRACS_M250_Repair", "PRACS_M250_Ammo", "PRACS_M250_fuel", "PRACS_M250_AMB"]};
	case "W": {["PRACS_SLA_URAL_Repair", "PRACS_SLA_Ural_Ammo", "PRACS_SLA_URAL_Fuel", "PRACS_SLA_Ural_AMB"]};
	case "G": {["PRACS_SLA_URAL_Repair", "PRACS_SLA_Ural_Ammo", "PRACS_SLA_URAL_Fuel", "PRACS_SLA_Ural_AMB"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"PRACS_SLA_BTR80A"};
	case "W": {"CUP_B_M2A3Bradley_USA_W"};
	case "G": {"PRACS_BMR_A3_GA1"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"PRACS_SLA_BTR80A"};
	case "W": {"CUP_B_M2A3Bradley_USA_W"};
	case "G": {"PRACS_BMR_A3_GA1"};
};