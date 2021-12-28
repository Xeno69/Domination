d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_C_Offroad_02_AT_F"]};
	case "WEST": {
		call {
			if (d_gmcwgwinter) exitWith {
				["gm_ge_army_iltis_milan_win","gm_ge_army_fuchsa0_engineer_win","gm_ge_army_fuchsa0_reconnaissance_win"]
			};
			["gm_ge_army_iltis_milan","gm_ge_army_fuchsa0_engineer","gm_ge_army_fuchsa0_reconnaissance"]
		};
	};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_LSV_02_AT_F"]};
};
