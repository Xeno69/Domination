// by Xeno modified by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_setenemycount.sqf"
#include "..\x_setup.sqf"

// set global arrays that determine which enemies are present at the maintarget
// _enemyMode
//   0 Normal
//   1 Less
//   2 None
//   -1 Random, enemy mode is randomly chosen [0,1,2] each time a maintarget is created

__TRACE_1("","_this")

params ["_enemyMode"];

if (_enemyMode == -1) then {
	d_enemy_mode_current_maintarget = selectRandom [0, 1, 2];
	_enemyMode = d_enemy_mode_current_maintarget;
};

// first element (array. for example: [2,1]): number of vehicle groups that will get spawned, the first number is the max number that will get spawned,
// the second one the minimum. So [2,0] means, there can be no vehicle groups at all or a maximum of 2 groups of this kind
// second element: maximum number of vehicles in group; randomly chosen
switch (_enemyMode) do {
	case 0: {
		d_vec_numbers_guard = [
			[[1,0], 1], // tanks
			[[1,0], 1], // tracked apc
			[[1,1], 1], // wheeled apc
			[[1,1], 1], // jeep with mg
			[[1,0], 1] // jeep with gl
		];
		d_vec_numbers_guard_static = [
			[[1,1], 1], // tanks
			[[1,1], 1], // tracked apc
			[[1,1], 1] // aa
		];
		d_vec_numbers_patrol = [
#ifndef __TT__
			[[1,1], 1], // tanks
			[[1,1], 1], // tracked apc
			[[1,1], 1], // wheeled apc
			[[1,1], 1], // jeep with mg
			[[1,1], 1], // jeep with gl
			[[1,1], 1]  // uav
#else
			[[1,1], 1], // tanks
			[[2,1], 1], // tracked apc
			[[2,1], 1], // wheeled apc
			[[2,1], 1], // jeep with mg
			[[1,1], 1], // jeep with gl
			[[1,1], 1]  // uav
#endif
		];

		// almost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
#ifndef __TT__
			[1,1], // basic groups
			[1,1] // specop groups
#else
			[2,1], // basic groups
			[2,1] // specop groups
#endif
		];
		d_footunits_patrol = [
#ifndef __TT__
			[2,2], // basic groups
			[2,2] // specop groups
#else
			[6,3], // basic groups
			[5,3] // specop groups
#endif
		];
		d_footunits_guard_static = [
			[1,1], // basic groups
			[1,0] // specop groups
		];
		d_footunits_attack = [
			[1,1], // basic groups
			[1,1] // specop groups
		];
		d_vec_numbers_attack = [
			[[1,1], 1], // tanks
			[[1,1], 1], // tracked apc
			[[1,1], 1], // wheeled apc
			[[1,1], 1], // jeep with mg
			[[1,1], 1], // jeep with gl
			[[1,1], 1] // aa
		];
	};
	case 1: {
		d_vec_numbers_guard = [
			[[1,0], 1], // tanks
			[[1,0], 1], // tracked apc
			[[1,0], 1], // wheeled apc
			[[1,1], 1], // jeep with mg
			[[1,1], 1] // jeep with gl
		];
		d_vec_numbers_guard_static = [
			[[1,0], 1], // tanks
			[[1,0], 1], // tracked apc
			[[1,0], 1] // aa
		];
		d_vec_numbers_patrol = [
			[[1,0], 1], // tanks
			[[1,0], 1], // tracked apc
			[[1,0], 1], // wheeled apc
			[[1,0], 1], // jeep with mg
			[[1,1], 1], // jeep with gl
			[[1,1], 1]  // uav
		];

		// almost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
			[2,1], // basic groups
			[2,1] // specop groups
		];
		d_footunits_patrol = [
			[4,2], // basic groups
			[4,2] // specop groups
		];
		d_footunits_guard_static = [
			[2,1], // basic groups
			[2,1] // specop groups
		];
		d_footunits_attack = [
			[2,1], // basic groups
			[2,1] // specop groups
		];
		d_vec_numbers_attack = [
			[[1,0], 1], // tanks
			[[1,0], 1], // tracked apc
			[[1,0], 1], // wheeled apc
			[[1,1], 1], // jeep with mg
			[[1,1], 1], // jeep with gl
			[[1,0], 1] // aa
		];
	};
	case 2: {
		d_vec_numbers_guard = [
			[[0,0], 1], // tanks
			[[0,0], 1], // tracked apc
			[[0,0], 1], // wheeled apc
			[[2,1], 1], // jeep with mg
			[[2,1], 1] // jeep with gl
		];
		d_vec_numbers_guard_static = [
			[[0,0], 1], // tanks
			[[0,0], 1], // tracked apc
			[[0,0], 1] // aa
		];
		d_vec_numbers_patrol = [
			[[0,0], 1], // tanks
			[[0,0], 1], // tracked apc
			[[0,0], 1], // wheeled apc
			[[2,1], 1], // jeep with mg
			[[2,1], 1], // jeep with gl
			[[1,1], 1]  // uav
		];

		// almost the same like above
		// first element the max number of ai "foot" groups that will get spawned, second element minimum number (no number for vehicles in group necessary)
		d_footunits_guard = [
			[3,1], // basic groups
			[3,1] // specop groups
		];
		d_footunits_patrol = [
			[6,2], // basic groups
			[4,2] // specop groups
		];
		d_footunits_guard_static = [
			[3,1], // basic groups
			[2,1] // specop groups
		];
		d_footunits_attack = [
			[4,1], // basic groups
			[4,1] // specop groups
		];
		d_vec_numbers_attack = [
			[[0,0], 1], // tanks
			[[0,0], 1], // tracked apc
			[[0,0], 1], // wheeled apc
			[[2,1], 1], // jeep with mg
			[[2,1], 1], // jeep with gl
			[[1,0], 1] // aa
		];
	};
};
