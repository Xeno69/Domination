class CfgVehicles {
	class Default {
		class TransportPylons {
			excludeMagazines[] = {};
		};
	};

	class O_Heli_Light_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire"};
		};
    };

	class O_Heli_Attack_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_20Rnd_Rocket_03_HE_F","PylonMissile_1Rnd_BombCluster_02_F"};
		};
    };

	class O_Heli_Attack_02_dynamicLoadout_black_F: O_Heli_Attack_02_dynamicLoadout_F {};

	class O_Plane_CAS_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_20Rnd_Rocket_03_HE_F","PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_19Rnd_Rocket_Skyfire","PylonMissile_1Rnd_BombCluster_02_cap_F"};
		};
	};

	class O_Plane_Fighter_02_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonMissile_1Rnd_BombCluster_02_cap_F"};
		};
	};

	class O_Plane_Fighter_02_Stealth_F: O_Plane_Fighter_02_F {};

	class O_T_VTOL_02_infantry_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons{
			excludeMagazines[] = {"PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_20Rnd_Rocket_03_HE_F","PylonMissile_1Rnd_BombCluster_02_cap_F"};
		};
	};

	class O_T_VTOL_02_vehicle_dynamicLoadout_F: O_T_VTOL_02_infantry_dynamicLoadout_F {};

	class O_UAV_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
#ifndef __TT__
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles"};
#else
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonRack_1Rnd_AAA_missiles"};
#endif
		};
	};

	class B_Heli_Light_01_dynamicLoadout_F: Default {};

	class B_Heli_Attack_01_dynamicLoadout_F: Default {};

	class B_Plane_CAS_01_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
#ifndef __TT__
			excludeMagazines[] = {"PylonRack_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_03_F"};
#else
			excludeMagazines[] = {"PylonRack_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_03_F","PylonRack_1Rnd_AAA_missiles"};
#endif
		};
	};

	class B_Plane_Fighter_01_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_2Rnd_BombCluster_03_F","PylonRack_2Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_03_F","PylonMissile_1Rnd_BombCluster_01_F"};
		};
	};

	class B_Plane_Fighter_01_Stealth_F: B_Plane_Fighter_01_F {};

	class B_UAV_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
#ifndef __TT__
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles"};
#else
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonRack_1Rnd_AAA_missiles"};
#endif
		};
	};

	class B_UAV_05_F: Default {};

	class B_T_UAV_03_dynamicLoadout_F: Default {};

	class I_Heli_light_03_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire"};
		};
    };

	class I_Plane_Fighter_03_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
			excludeMagazines[] = {"PylonRack_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonRack_2Rnd_BombCluster_03_F","PylonRack_2Rnd_BombCluster_01_F","PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonMissile_1Rnd_BombCluster_01_F","PylonMissile_1Rnd_BombCluster_03_F"};
		};
	};

	class I_Plane_Fighter_04_F: I_Plane_Fighter_03_dynamicLoadout_F {};

	class I_UAV_02_dynamicLoadout_F: Default {
		class TransportPylons: TransportPylons {
#ifndef __TT__
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles"};
#else
			excludeMagazines[] = {"PylonRack_19Rnd_Rocket_Skyfire","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_missiles","PylonRack_1Rnd_AAA_missiles"};
#endif
		};
	};
};

class d_excludemag_gen {
	excludeMagazines[] = {"FIR_GBU24A_BLU118_P_1rnd_M", "FIR_GBU24A_P_1rnd_M", "FIR_GBU24A_BLU109_P_1rnd_M", "FIR_CBU97_P_1rnd_M", "FIR_CBU97_P_BRU57_2rnd_M", "FIR_CBU97_P_TripleRack_2rnd_M", "FIR_CBU105_P_1rnd_M", "FIR_CBU105_P_BRU57_2rnd_M", "FIR_CBU105_P_TripleRack_2rnd_M "};
};
