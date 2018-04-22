// by Xeno
#define THIS_FILE "fn_s_b_client.sqf"
#include "..\..\x_setup.sqf"

d_searchbody setVariable ["d_search_id", [
		/* 0 object */						d_searchbody,
		/* 1 action title */				localize "STR_DOM_MISSIONSTRING_518",
		/* 2 idle icon */					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		/* 4 condition to show */			"!alive d_searchbody && {_this distance2D _target <= 5}",
		/* 5 condition for action */		"true",
		/* 6 code executed on start */		{systemChat (localize "STR_DOM_MISSIONSTRING_345")},
		/* 7 code executed per tick */		{},
		/* 8 code executed on completion */	{
			0 spawn {
				remoteExecCall ["d_fnc_rem_sb_id", [0, -2] select isDedicated];
				sleep 0.3;
				d_searchbody = objNull; publicVariable "d_searchbody";

				private _intelnum = d_searchintel call d_fnc_RandomFloorArray;

				if (random 1 < 0.8) then {
					if ((d_searchintel select _intelnum) != 1) then {
						switch (_intelnum) do {
							case 0: {
								systemChat (localize "STR_DOM_MISSIONSTRING_349");
								sleep 2;
								d_searchintel set [1, 1];
								publicVariable "d_searchintel";
								[1, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
							case 1: {
								systemChat (localize "STR_DOM_MISSIONSTRING_350");
								sleep 2;
								d_searchintel set [2, 1];
								publicVariable "d_searchintel";
								[2, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
							case 2: {
								systemChat (localize "STR_DOM_MISSIONSTRING_351");
								sleep 2;
								d_searchintel set [3, 1];
								publicVariable "d_searchintel";
								[3, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
							case 3: {
								systemChat (localize "STR_DOM_MISSIONSTRING_352");
								sleep 2;
								_intelar set [4, 1];
								d_searchintel = _intelar; publicVariable "d_searchintel";
								[4, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
							case 4: {
								systemChat (localize "STR_DOM_MISSIONSTRING_353");
								sleep 2;
								d_searchintel set [5, 1];
								publicVariable "d_searchintel";
								[5, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
							case 5: {
								systemChat (localize "STR_DOM_MISSIONSTRING_354");
								sleep 2;
								d_searchintel set [6, 1];
								publicVariable "d_searchintel";
								[6, d_name_pl] remoteExecCall ["d_fnc_intel_updNet", [0, -2] select isDedicated];
							};
						};
					} else {
						systemChat (localize "STR_DOM_MISSIONSTRING_355");
					};
				} else {
					systemChat (localize "STR_DOM_MISSIONSTRING_356");
				};
			};
		},
		/* 9 code executed on interruption */	{},
		/* 10 arguments */					[d_searchbody],
		/* 11 action duration */			4 + (random 4),
		/* 12 priority */					-1,
		/* 13 remove on completion */		false,
		/* 14 show unconscious */			false
	] call bis_fnc_holdActionAdd
];
