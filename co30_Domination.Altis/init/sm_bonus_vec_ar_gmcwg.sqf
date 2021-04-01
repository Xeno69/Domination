d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F","I_LT_01_AT_F","I_LT_01_cannon_F","I_LT_01_scout_F","I_Plane_Fighter_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"]};
	case "WEST": {
		call {
			if (d_gmcwgwinter) exitWith {
				["gm_ge_army_marder1a1a_win","gm_ge_army_marder1a1plus_win","gm_ge_army_marder1a2_win","gm_ge_army_gepard1a1_win","gm_ge_army_Leopard1a1a1_win","gm_ge_army_Leopard1a1a2_win","gm_ge_army_Leopard1a1a3_win","gm_ge_army_Leopard1a1a4_win","gm_ge_army_Leopard1a3_win","gm_ge_army_Leopard1a3a1_win","gm_ge_army_Leopard1a3a2_win","gm_ge_army_Leopard1a3a3_win","gm_ge_army_m113a1g_apc_win","gm_ge_army_m113a1g_apc_milan_win","gm_dk_army_Leopard1a3_win","gm_ge_army_luchsa1_win","gm_ge_army_luchsa2_win","gm_ge_army_bo105p_pah1a1_un","gm_ge_army_bo105p_pah1_un"]
			};
			["gm_ge_army_marder1a1a","gm_ge_army_marder1a1plus","gm_ge_army_marder1a2","gm_ge_army_gepard1a1","gm_ge_army_Leopard1a1a1","gm_ge_army_Leopard1a1a2","gm_ge_army_Leopard1a1a3","gm_ge_army_Leopard1a1a4","gm_ge_army_Leopard1a3","gm_ge_army_Leopard1a3a1","gm_ge_army_Leopard1a3a2","gm_ge_army_Leopard1a3a3","gm_ge_army_m113a1g_apc","gm_ge_army_m113a1g_apc_milan","gm_dk_army_Leopard1a3","gm_ge_army_luchsa1","gm_ge_army_luchsa2","gm_ge_army_bo105p_pah1","gm_ge_army_bo105p_pah1a1"]
		};
	};
	case "EAST": {["O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_MBT_04_cannon_F","O_MBT_04_command_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F","O_Plane_CAS_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_F"]};
};
