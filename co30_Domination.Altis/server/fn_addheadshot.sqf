// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pl"];

if (isNil "_pl" || {isNull _pl}) exitWith {};

if (d_database_found) then {
	private _p = d_player_hash getOrDefault [getPlayerUID _pl, -1];
	if (_p isEqualType []) then {
		_p set [16, (_p # 16) + 1];
		__TRACE_2("","_p","_this")
	};
};

if (d_show_headshots > 0) then {
	private _distance_fired = _pl distance2D (_this # 1);
	[_distance_fired] remoteExecCall ["d_fnc_headshot_notify", owner _pl];

	if (d_show_headshots == 2 && {!(d_force_isstreamfriendlyui == 1)}) then {
		d_kb_logic1 kbTell [
			d_kb_logic2,
			d_kb_topic_side,
			"MTHeadshot",
			["1", "", name _pl, []],
			["2", "", str(floor _distance_fired), []],
			"GROUP"
		];
	};

	if (d_show_headshots == 3 && {!(d_force_isstreamfriendlyui == 1)}) then {
		d_kb_logic1 kbTell [
			d_kb_logic2,
			d_kb_topic_side,
			"MTHeadshot",
			["1", "", name _pl, []],
			["2", "", str(floor _distance_fired), []],
			d_kbtel_chan
		];
	};
};
