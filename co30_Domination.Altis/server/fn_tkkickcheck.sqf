// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tkkickcheck.sqf"
#include "..\x_setup.sqf"

private _tk = _this select 2;
_tk addScore (d_sub_tk_points * -1);
private _uid = getPlayerUID _tk;
__TRACE_2("TKKickCheck","_tk","_uid")
private _p = d_player_store getVariable _uid;
if (!isNil "_p") then {
	private _numtk = (_p # 7) + 1;
	_p set [7, _numtk];
	if (_numtk >= d_maxnum_tks_forkick) exitWith {
		private _pna = _p # 6;
		diag_log format ["Player %1 was kicked automatically because of teamkilling, # team kills: %3, ArmA 3 Key: %2", _pna, _uid, _numtk];
		[20, _pna, _numtk] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
		"LOSER" remoteExecCall ["endMission", _tk];
		if (d_database_found) then {
#ifndef __INTERCEPTDB__
			"extdb3" callExtension format ["1:dom:teankillsAdd:%1", _uid];
#else
			if (d_interceptdb) then {
				["teankillsAdd", [_uid]] call dsi_fnc_queryconfigasync;
			};
#endif
		};
	};
};