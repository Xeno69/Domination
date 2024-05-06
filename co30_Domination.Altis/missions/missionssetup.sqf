// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

// I'm using x_mXX.sqf for the mission filename where XX (index number) has to be added to d_sm_array
d_sm_fname = "x_m";

// d_sm_array contains the indices of the sidemissions (it gets shuffled later)
// to remove a specific side mission just remove the index from d_sm_array
#ifdef __ALTIS__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
	41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
	61,62,63,64,65,66,67,68,69,70,71,72,73,74,100,101,102,103,104,105,106];
#endif
#ifdef __CUP_CHERNARUS__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,31,32,33,34,36,37,38,39,40,
	41,42,44,45,46,47,49,50,51,52];
	
if (worldName != "cup_chernarus_A3") then {
	d_sm_array pushBack 48;
};
#endif
#ifdef __CUP_TAKISTAN__
d_sm_array =
	[0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,31,32,33,36,
	40,41,42,44,46,47,49,50,51,52];
#endif
#ifdef __CUP_SARA__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
	40,41,42,44,45,46,47,48,49,50,51,52];
#endif
#ifdef __TTALTIS__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
	41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
	61,62,63,64,65,66,67,68,69,70,71,72,73,74];
#endif
#ifdef __TTTANOA__
d_sm_array =
		[0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,
		20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
		40,41,42,44,47,48,49,50,51,52,53,64];
#endif
#ifdef __TTMALDEN__
d_sm_array = [];
#endif
#ifdef __TANOA__
d_sm_array =
	[0,1,2,3,4,5,6,7,15,16,17,19,
	20,21,22,30,31,32,33,35,39,
	40,41,42,44,49,50,51,52,53,64,106];
#endif
#ifdef __STRATIS__
d_sm_array =
	[0,1,3,4,6,8,9,11,12,14,19,20,23,29,31,32,36,40,42,44,51,52];
#endif
#ifdef __GMCWG__
	d_sm_array = [];
#endif
#ifdef __LIVONIA__
	d_sm_array = [];
#endif
#ifdef __MALDEN__
d_sm_array =
	[
		1,3,4,5,6,7, //arrest an officer
		15,16,17,18, //artillery base
		19,20,21,22, //stop a convoy
		30,31,32,33,35, //deliver a truck/troops
		39,40,41,42,44,45, //evac crew/sops
		49,50,51,52, //destroy factory
		53,54,55,56, //capture the flag
		61,62,63,64,65,
		69,70,71, //clear naval/land mines
		77,78,79,80,81,82, //rescue prisoners
		88,89,90,91,92,93, //clear specops camp
		94,95,97,98, // 106,108, // steal the vehicle 106 and 108 removed for now
		110,111,112,113, //tank depot
		114,115,116,117, //destroy supply trucks
		// 118,119,120, //destroy cargo box -> TODO
		123,124,125, //destroy arty vec
		127,128,129,130,131,132,133, //kill the officer
		138,139,140,141,142, //kill the sniper
		//143,144,145, //find and destroy lost uav  -> TODO
		148,149,150,151,152,153,154,155//, //destroy radio tower
		//166,167,168,169, //sabotage ship
		//170,171 //rescue in sea
];
#endif
#ifdef __IFA3__
d_sm_array =
	[0,1,3,4,6,8,9,12,14,19,20,23,29,31,32,36,40,42,44];
#endif
#ifdef __UNSUNG__
d_sm_array = [];
#endif
#ifdef __CSLA__
d_sm_array = [];
#endif
#ifdef __VN__
d_sm_array = [];
#endif
#ifdef __WS__
d_sm_array = [];
#endif
#ifdef __SPE__
	d_sm_array = [];
#endif
#ifdef __JSDF__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
	41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
	61,62,63,64,65,66,67,68,69,70,71,72,73,74,100,101,102,103,104,105,106];
#endif

call d_fnc_create_sm_bymarkers;

__TRACE_1("","d_sm_array")

d_number_side_missions = count d_sm_array;

if (isServer) then {		
	// these vehicles get spawned in a convoy sidemission. Be aware that it is the best to use a wheeled vehicle first as leader.
	// at least wheeled AI vehicles try to stay on the road somehow
#ifdef __ALTIS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_CHERNARUS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_GAZ_Vodnik_PK_RU","CUP_O_BTR90_RU", "CUP_O_BRDM2_RUS", "CUP_O_Ural_Repair_RU", "CUP_O_Ural_Refuel_RU", "CUP_O_Ural_Reammo_RU", "CUP_O_BTR90_RU"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_TAKISTAN__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_BTR60_TK","CUP_O_BRDM2_TKA", "CUP_O_BTR60_TK", "CUP_O_Ural_Repair_TKA", "CUP_O_Ural_Refuel_TKA", "CUP_O_Ural_Reammo_TKA", "CUP_O_Ural_ZU23_TKA"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_SARA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["CUP_O_BTR60_SLA","CUP_O_BRDM2_SLA", "CUP_O_BRDM2_ATGM_SLA", "CUP_O_Ural_Repair_SLA", "CUP_O_Ural_Refuel_SLA", "CUP_O_Ural_Reammo_SLA", "CUP_O_BTR60_SLA"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __TTALTIS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F", "I_MRAP_03_gmg_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_Wheeled_03_cannon_F"]};
	};
#endif
#ifdef __TTMALDEN__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F", "I_MRAP_03_gmg_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_Wheeled_03_cannon_F"]};
	};
#endif
#ifdef __TTTANOA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_T_MRAP_02_gmg_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F", "O_T_MBT_02_cannon_ghex_F", "O_T_Truck_03_covered_ghex_F", "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_ammo_ghex_F", "O_T_APC_Tracked_02_AA_ghex_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_hmg_F","I_APC_Wheeled_03_cannon_F", "I_MRAP_03_gmg_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_Wheeled_03_cannon_F"]};
	};
#endif
#ifdef __TANOA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_T_MRAP_02_hmg_ghex_F","O_T_APC_Wheeled_02_rcws_v2_ghex_F", "O_T_MRAP_02_gmg_ghex_F", "O_T_Truck_03_covered_ghex_F", "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_ammo_ghex_F", "O_T_APC_Wheeled_02_rcws_v2_ghex_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __LIVONIA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_T_MRAP_02_hmg_ghex_F","O_T_APC_Wheeled_02_rcws_v2_ghex_F", "O_T_MRAP_02_gmg_ghex_F", "O_T_Truck_03_covered_ghex_F", "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_ammo_ghex_F", "O_T_APC_Wheeled_02_rcws_v2_ghex_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __STRATIS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __MALDEN__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __IFA3__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["LIB_SdKfz251","LIB_SdKfz_7_AA", "LIB_SdKfz251", "LIB_opelblitz_parm", "LIB_opelblitz_fuel", "LIB_opelblitz_ammo", "LIB_SdKfz251_FFV"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __RHS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["rhs_btr80a_vdv","rhs_btr80a_vdv", "rhs_btr70_vdv", "RHS_Ural_Repair_VDV_01", "RHS_Ural_Fuel_VDV_01", "RHS_Ural_VDV_01", "RHS_Ural_Zu23_VDV_01"]};
		case "W": {["rhsusf_M1117_D","RHS_M6", "RHS_M2A3_BUSKIII", "rhsusf_M977A4_REPAIR_usarmy_d", "rhsusf_M977A4_AMMO_usarmy_d", "rhsusf_M978A4_usarmy_d", "RHS_M2A2_BUSKI"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __GMCWG__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {
			call {
				if (d_gmcwgwinter) exitWith {
					["gm_gc_army_btr60pb_win","gm_gc_army_brdm2_win", "gm_gc_army_btr60pb_win", "gm_gc_army_ural4320_repair_win", "gm_gc_army_ural375d_refuel_win", "gm_gc_army_ural4320_reammo_win", "gm_gc_army_brdm2_win"]
				};
				["gm_gc_army_btr60pb","gm_gc_army_brdm2", "gm_gc_army_btr60pb", "gm_gc_army_ural4320_repair", "gm_gc_army_ural375d_refuel", "gm_gc_army_ural4320_reammo", "gm_gc_army_brdm2"]
			};
		};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __UNSUNG__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["uns_BTR152_DSHK","uns_BTR152_ZPU", "uns_Type55_RR57", "uns_nvatruck_reammo", "uns_nvatruck_refuel", "uns_nvatruck_repair", "uns_nvatruck_zu23"]};
		case "W": {["rhsusf_M1117_D","RHS_M6", "RHS_M2A3_BUSKIII", "rhsusf_M977A4_REPAIR_usarmy_d", "rhsusf_M977A4_AMMO_usarmy_d", "rhsusf_M978A4_usarmy_d", "RHS_M2A2_BUSKI"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CSLA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["US85_LAV25","US85_LAV25", "US85_M998SFGT", "US85_M923r", "US85_M923f", "US85_M923r", "US85_M1025_M60"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	}; 
#endif
#ifdef __VN__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["vn_o_wheeled_btr40_mg_01_nvam","vn_o_wheeled_btr40_mg_02_nvam", "vn_o_wheeled_btr40_mg_03_nvam", "vn_o_wheeled_z157_ammo_nvam", "vn_o_wheeled_z157_fuel_nvam", "vn_o_wheeled_z157_repair_nvam", "vn_o_wheeled_btr40_mg_02_nvam"]};
		case "W": {["rhsusf_M1117_D","RHS_M6", "RHS_M2A3_BUSKIII", "rhsusf_M977A4_REPAIR_usarmy_d", "rhsusf_M977A4_AMMO_usarmy_d", "rhsusf_M978A4_usarmy_d", "RHS_M2A2_BUSKI"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __WS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_SFIA_Offroad_armed_lxWS","O_Tura_Offroad_armor_armed_lxWS", "O_SFIA_Offroad_armed_lxWS", "O_SFIA_Truck_02_box_lxWS", "O_SFIA_Truck_02_fuel_lxWS", "O_SFIA_Truck_02_Ammo_lxWS", "O_SFIA_Truck_02_aa_lxWS"]};
		case "W": {["B_MRAP_01_hmg_F","B_APC_Wheeled_01_cannon_F", "B_MRAP_01_gmg_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Wheeled_01_cannon_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __SPE__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_hmg_F","O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_Truck_03_repair_F", "O_Truck_03_fuel_F", "O_Truck_03_ammo_F", "O_APC_Wheeled_02_rcws_F"]};
		case "W": {["SPE_SdKfz250_1","SPE_ST_SdKfz250_1", "SPE_OpelBlitz_Flak38", "SPE_OpelBlitz_Repair", "SPE_OpelBlitz_Fuel", "SPE_OpelBlitz_Ammo", "SPE_SdKfz250_1"]};
		case "G": {["SPE_US_M16_Halftrack","SPE_US_M3_Halftrack", "SPE_US_M16_Halftrack", "SPE_US_M3_Halftrack_Repair", "SPE_US_M3_Halftrack_Fuel", "SPE_US_M3_Halftrack_Ammo", "SPE_US_M3_Halftrack"]};
	};
#endif
#ifdef __JSDF__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["rhs_btr80a_vdv","rhs_btr80a_vdv", "rhs_btr70_vdv", "RHS_Ural_Repair_VDV_01", "RHS_Ural_Fuel_VDV_01", "RHS_Ural_VDV_01", "RHS_Ural_Zu23_VDV_01"]};
		case "W": {["Sparky_JSDF_Overhaul_JSDF_JGSDF_RCV","Sparky_JSDF_Overhaul_JSDF_JGSDF_Type89IFV", "Sparky_JSDF_Overhaul_JSDF_JGSDF_87SPAAG", "Sparky_JSDF_Overhaul_gac_JGSDF_35t_resupply", "Sparky_JSDF_Overhaul_gac_JGSDF_35t_fuel", "Sparky_JSDF_Overhaul_gac_JGSDF_35t_resupply", "Sparky_JSDF_Overhaul_gac_JGSDF_WAPC_GMG"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
};

#ifdef __CUP_CHERNARUS__
d_sm_folder = "m";
#endif
#ifdef __CUP_TAKISTAN__
d_sm_folder = "moa";
#endif
#ifdef __CUP_SARA__
d_sm_folder = "msara";
#endif
#ifdef __TTTANOA__
d_sm_folder = "ma3t";
#endif
#ifdef __TANOA__
d_sm_folder = "ma3t";
#endif
#ifdef __STRATIS__
d_sm_folder = "ma3s";
#endif
#ifdef __MALDEN__
d_sm_folder = "ma3m";
#endif
#ifdef __TTMALDEN__
d_sm_folder = "ma3m";
#endif
#ifdef __IFA3__
d_sm_folder = "mifa3";
#endif

if (isNil "d_sm_folder") then {
	d_sm_folder = "ma3a";
};

// Instead of a random vehicle chosen for winning a side mission you can setup it in the mission yourself now
// Add d_current_sm_bonus_vec to the beginning of a sidemission script with a vehicle class string and that vehicle gets chosen instead of a random one.
// Examples:
// d_current_sm_bonus_vec = "B_MBT_01_cannon_F";
// DON'T CHANGE IT HERE IN MISSIONSETUP.SQF!!!!!!!!!!!!!!!!!!!!!!!!!
if (isServer) then {
#ifndef __TT__
	d_current_sm_bonus_vec = "";
#else
	d_current_sm_bonus_vec = ["", ""];
#endif
};
