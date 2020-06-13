// by Xeno

{d_misc_store setVariable [_x, []]} forEach ["PRIVATE_RIFLES","CORPORAL_RIFLES","SERGEANT_RIFLES","LIEUTENANT_RIFLES","CAPTAIN_RIFLES","MAJOR_RIFLES","COLONEL_RIFLES",
	"PRIVATE_LAUNCHERS","CORPORAL_LAUNCHERS","SERGEANT_LAUNCHERS","LIEUTENANT_LAUNCHERS","CAPTAIN_LAUNCHERS","MAJOR_LAUNCHERS","COLONEL_LAUNCHERS",
	"PRIVATE_PISTOLS","CORPORAL_PISTOLS","SERGEANT_PISTOLS","LIEUTENANT_PISTOLS","CAPTAIN_PISTOLS","MAJOR_PISTOLS","COLONEL_PISTOLS",
	"PRIVATE_OPTICS","CORPORAL_OPTICS","SERGEANT_OPTICS","LIEUTENANT_OPTICS","CAPTAIN_OPTICS","MAJOR_OPTICS","COLONEL_OPTICS",
	"PRIVATE_MUZZLES","CORPORAL_MUZZLES","SERGEANT_MUZZLES","LIEUTENANT_MUZZLES","CAPTAIN_MUZZLES","MAJOR_MUZZLES","COLONEL_MUZZLES",
	"PRIVATE_UNIFORMS","CORPORAL_UNIFORMS","SERGEANT_UNIFORMS","LIEUTENANT_UNIFORMS","CAPTAIN_UNIFORMS","MAJOR_UNIFORMS","COLONEL_UNIFORMS",
	"PRIVATE_ITEMS","CORPORAL_ITEMS","SERGEANT_ITEMS","LIEUTENANT_ITEMS","CAPTAIN_ITEMS","MAJOR_ITEMS","COLONEL_ITEMS"
];

{d_misc_store setVariable [_x, []]} forEach ["PRIVATE_ONED","CORPORAL_ONED","SERGEANT_ONED","LIEUTENANT_ONED","CAPTAIN_ONED","MAJOR_ONED","COLONEL_ONED"];

private _dd_add_gearf = {
	params ["_ranks", "_curarx", "_typeu"];

	private _arw = (_curarx select {!(_x isEqualTo "")}) apply {toLowerANSI _x};
	__TRACE_1("_dd_add_gearf","_arw")

	if !(_arw isEqualTo []) then {
		{
			(d_misc_store getVariable format ["%1_%2", _x, _typeu]) append _arw;
			(d_misc_store getVariable (_x + "_ONED")) append _arw;
		} forEach _ranks;
	};
};

{
	__TRACE_1("","_x")
	private _typeu = _x # 1;
	__TRACE_1("","_typeu")
	if (_x # 0 == 1) then {
		for "_i" from 2 to 8 do {
			__TRACE_1("","_i")
			private _ranks = switch (_i - 2) do {
				case 0: {["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]};
				case 1: {["CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]};
				case 2: {["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]};
				case 3: {["LIEUTENANT","CAPTAIN","MAJOR","COLONEL"]};
				case 4: {["CAPTAIN","MAJOR","COLONEL"]};
				case 5: {["MAJOR","COLONEL"]};
				case 6: {["COLONEL"]};
			};
			[_ranks, _x # _i, _typeu] call _dd_add_gearf;
		};
	} else {
		[["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"], _x # 2, _typeu] call _dd_add_gearf;
	};
} forEach _all_weapons_items;
