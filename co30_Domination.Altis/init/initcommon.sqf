// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom initcommon.sqf"];

if (isNil "paramsArray") then {
	if (hasInterface) then {
		diag_log "CfgParams";
	};
	if (isClass (getMissionConfig "Params")) then {
		private _conf = getMissionConfig "Params";
		private ["_paramName", "_paramval"];
		for "_i" from 0 to (count _conf - 1) do {
			_paramName = configName (_conf select _i);
			_paramval = getNumber (_conf>>_paramName>>"default");
			if (_paramval != -66) then {
				missionNamespace setVariable [_paramName, _paramval];
				if (hasInterface) then {
					diag_log [_paramName, _paramval];
				};
			};
		};
	};
} else {
	private "_paramval";
	if (hasInterface) then {
		diag_log "CfgParams";
	};
	for "_i" from 0 to (count paramsArray - 1) do {
		_paramval = paramsArray select _i;
		if (_paramval != -66) then {
			missionNamespace setVariable [configName ((getMissionConfig "Params") select _i), _paramval];
			if (hasInterface) then {
				diag_log [configName ((getMissionConfig "Params") select _i), _paramval];
			};
		};
	};
};

d_no_ranked_weapons = d_with_ranked == 2;
d_with_ranked = d_with_ranked == 0 || {d_with_ranked == 2};
#ifndef __TT__
d_ai_no_statics = d_with_ai == 2 || {d_with_ai == 4};
d_ai_dyn_recruit = d_with_ai == 3 || {d_with_ai == 4};
d_with_ai = d_with_ai == 0 || {d_with_ai > 1};
#else
d_with_ai = false;
d_with_ai_features = 1;
d_WithJumpFlags = 1;
d_MaxNumAmmoboxes = d_MaxNumAmmoboxes * 2;
d_pilots_only = 1;
#endif
d_no_ai = !d_with_ai && {d_with_ai_features == 1};
d_enemy_mode_current_maintarget = nil; // nil unless d_WithLessArmor is set to random

if (d_with_ace && {d_ACEMedicalR == 1}) then {
	d_WithRevive = 1;
	ace_medical_enableRevive = 1;
	ace_medical_maxReviveTime = 300;
	ace_medical_amountOfReviveLives = -1;
};

if (d_WithRevive == 0 && {hasInterface}) then {
	xr_pl_can_revive = true;
	xr_uncon_units = [];
};

if (d_sub_kill_points != 0 && {d_sub_kill_points > 0}) then {
	d_sub_kill_points = d_sub_kill_points * -1;
};

if (d_with_ace) then {
	d_pylon_lodout = 1;
};

if (isServer) then {
	skipTime d_TimeOfDay;

#ifdef __UNSUNG__
	d_WithLessArmor = 1;
	d_WithLessArmor_side = 1;
#endif
#ifdef __VN__
	d_WithLessArmor = 1;
	d_WithLessArmor_side = 1;
#endif

	// set enemy mode
	d_WithLessArmor call d_fnc_setenemymode;

	// enemy ai skill: [base skill, random value (random 0.3) that gets added to the base skill]
	d_skill_array = [[0.15,0.1], [0.2,0.1], [0.4,0.2], [0.6,0.3], [0.65,0.3]] select d_EnemySkill;
	
	if (isNil "d_addscore_a") then {
		d_addscore_a = [
			5, // 1 - barracks building destroyed at main target
			5, // 2 - mobile HQ building destroyed at main target
			5, // 3 - radio tower destroyed at main target
			5, // 4 - player has taken camp
			5, // 5 - player has resolved main target mission
			30, // 6 - extra points seizing the main target
			10, // 7 - points for reviving another player
			10, // 8 - points for helping solving the sidemission
			[3,2,1,0], // 9 - points for repairing/refueling a vehicle
			5, // 10 - points for healing another unit
			3, // 11 - points for another player healing at a player mash
			1, // 12 - points for another player spawning at squad leader
			1, // 13 - points for transporting another player in a vehicle
			20 // 14 - points for bringing a wreck to the wreck repair point
		];
	};
};

if (isNil "d_ranked_a") then {
	d_ranked_a = [
		20, // points that an engineer must have to repair/refuel a vehicle
		[3,2,1,0], // points engineers get for repairing an air vehicle, tank, car, other
		10, // points an artillery operator needs for a strike
		3, // points in the AI version for recruiting one soldier
		10, // points a player needs for an AAHALO parajump
		10, // points that get subtracted for creating a vehicle at a MHQ
		20, // points needed to create a vehicle at a MHQ
		3, // points a medic gets if someone heals at his Mash
		["Corporal","Sergeant","Lieutenant","Lieutenant","Sergeant","Corporal"], // Ranks needed to drive different vehicles, starting with: kindof wheeled APC, kindof Tank, kindof Helicopter (except the inital 4 helis), Plane, Ships/Boats, StaticWeapon
		30, // points that get added if a player is xxx m in range of a main target when it gets cleared
		400, // range the player has to be in to get the main target extra points
		10, // points that get added if a player is xxx m in range of a sidemission when the sidemission is resolved
		200, // range the player has to be in to get the sidemission extra points
		20, // points needed for an egineer to rebuild the support buildings at base
		10, // not used anymore !!! Was points needed to build MG Nest before
		5, // points needed in AI Ranked to call in an airtaxi
		20, // points needed to call in an air drop
		4, // points a medic gets when he heals another unit
		1, // points that a player gets when transporting others
		20, // points needed for activating satellite view
		20, // points needed to build a FARP (engineer)
		10, // points a player gets for reviving another player
		20, // points a Squad Leader needs for CAS
		20  // points a player gets for bringing a wreck to the repair point
	];
} else {
	if (count d_ranked_a < 24) then {
		if (count d_ranked_a == 22) then {
			d_ranked_a append [20, 20];
		} else {
			if (count d_ranked_a == 23) then {
				d_ranked_a pushBack 20;
			};
		};
	};
};

if (isServer) then {
	d_sc_hash = createHashMapFromArray [
		[0, (d_ranked_a # 3) * -1],
		[1, (d_ranked_a # 2) * -1],
		[2, (d_ranked_a # 15) * -1],
		[3, (d_ranked_a # 5) * -1],
		[4, (d_ranked_a # 16) * -1],
		[5, d_ranked_a # 17],
		[6, (d_ranked_a # 19) * -1],
		[7, d_ranked_a # 17],
		[8, (d_ranked_a # 4) * -1],
		[9, (d_ranked_a # 19) * -1],
		[10, (d_ranked_a # 20) * -1]
	];
};

// chopper varname, type (0 = lift chopper, 1 = wreck lift chopper, 2 = normal chopper), marker name, unique number (same as in d_init.sqf), marker type, marker color, marker text, chopper string name
#ifndef __TT__
d_choppers = [
	["D_HR1",0,"d_chopper1",3001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"n_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"n_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"n_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"n_air","ColorWhite","6",""]
];
#else
d_choppers_blufor = [
	["D_HR1",0,"d_chopper1",3001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"n_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"n_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"n_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"n_air","ColorWhite","6",""]
];
d_choppers_opfor = [
	["D_HRO1",0,"d_choppero1",4001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HRO2",2,"d_choppero2",4002,"n_air","ColorWhite","2",""],
	["D_HRO3",2,"d_choppero3",4003,"n_air","ColorWhite","3",""], ["D_HRO4",1,"d_choppero4",4004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HRO5",2,"d_choppero5",4005,"n_air","ColorWhite","5",""], ["D_HRO6",2,"d_choppero6",4006,"n_air","ColorWhite","6",""]
];
#endif

// vehicle varname, unique number (same as in d_init.sqf), marker name, marker type, marker color, marker text, vehicle string name
#ifndef __TT__
d_p_vecs = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","R1",""],
	["D_TR2",201,"d_truck2","n_support","ColorGreen","F1",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","A1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","R2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","F2",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","A2",""],["D_TR7",300,"d_truck7","n_service","ColorGreen","E1",""],
	["D_TR8",301,"d_truck8","n_service","ColorGreen","E2",""],["D_TR9",400,"d_truck9","n_support","ColorGreen","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorGreen","T1",""]
];
if (d_ifa3lite) then {
	d_p_vecs pushBack ["D_TR11",500,"d_truck11","n_support","ColorGreen","W1",""];
};
if (d_gmcwg) then {
	d_p_vecs append [
		["D_TR11",500,"d_truck11","n_support","ColorGreen","W1",""],
		["D_TR12",501,"d_truck11","n_support","ColorGreen","W2",""],
		["D_TR13",502,"d_truck12","n_support","ColorGreen","W3",""],
		["D_TR14",503,"d_truck13","n_support","ColorGreen","W4",""],
		["D_TR15",504,"d_truck14","n_support","ColorGreen","W5",""],
		["D_TR16",505,"d_truck15","n_support","ColorGreen","W6",""],
		["D_TR17",506,"d_truck16","n_support","ColorGreen","W7",""]
	];
};
#else
d_p_vecs_blufor = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","R1",""],
	["D_TR2",201,"d_truck2","n_support","ColorGreen","F1",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","A1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","R2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","F2",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","A2",""],["D_TR7",300,"d_truck7","n_service","ColorGreen","E1",""],
	["D_TR8",301,"d_truck8","n_service","ColorGreen","E2",""],["D_TR9",400,"d_truck9","n_support","ColorGreen","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorGreen","T1",""]
];
d_p_vecs_opfor = [
	["D_MRRO1",1000,"d_mobilerespawno1","o_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRRO2",1001,"d_mobilerespawno2","o_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVECO",1100,"d_medveco","n_med","ColorGreen","M",""],["D_TRO1",1200,"d_trucko1","n_maint","ColorGreen","R1",""],
	["D_TRO2",1201,"d_trucko2","n_support","ColorGreen","F1",""],["D_TRO3",1202,"d_trucko3","n_support","ColorGreen","A1",""],
	["D_TRO6",1203,"d_trucko4","n_maint","ColorGreen","R2",""],["D_TRO5",1204,"d_trucko5","n_support","ColorGreen","F2",""],
	["D_TRO4",1205,"d_trucko6","n_support","ColorGreen","A2",""],["D_TRO7",1300,"d_trucko7","n_service","ColorGreen","E1",""],
	["D_TRO8",1301,"d_trucko8","n_service","ColorGreen","E2",""],["D_TRO9",1400,"d_trucko9","n_support","ColorGreen","T2",""],
	["D_TRO10",1401,"d_trucko10","n_support","ColorGreen","T1",""]
];
#endif


if (hasInterface) then {
	if (d_with_ai) then {d_current_ai_num = 0};

	// distance a player has to transport others to get points
	d_transport_distance = 500;

	// rank needed to fly the wreck lift chopper
	d_wreck_lift_rank = "CAPTAIN";

	d_disable_viewdistance = d_ViewdistanceChange == 1;
	
	d_mob_respawns = [];
#ifndef __TT__
	{
		d_mob_respawns pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs select {_x # 1 < 100});
#else
	d_mob_respawns_blufor = [];
	{
		d_mob_respawns_blufor pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs_blufor select {_x # 1 < 100});
	d_mob_respawns_opfor = [];
	{
		d_mob_respawns_opfor pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs_opfor select {_x # 1 < 1100});
#endif

	if (d_with_ai) then {
		// additional AI recruit buildings
		// these have to be placed in the editor, give them a var name in the editor
		// only client handling means, no damage handling done for those buildings (contrary to the standard AI hut)
		// example:
		// d_additional_recruit_buildings = [my_ai_building1, my_ai_building2];
		d_additional_recruit_buildings = [];
	};
};

diag_log [diag_frameno, diag_ticktime, time, "Dom initcommon.sqf processed"];
