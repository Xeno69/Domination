// by Xeno
#include "..\x_setup.sqf"

if (!isServer) exitWith {};

// create random position
private _posi = [d_old_target_pos, d_old_radius] call d_fnc_getranpointcircle;
while {_posi isEqualTo []} do {
	_posi = [d_old_target_pos, d_old_radius] call d_fnc_getranpointcircle;
	sleep 0.04;
};

if (_posi isNotEqualTo []) then {
	private _flag = createVehicle [d_flag_pole, _posi, [], 0, "NONE"];
	_flag setFlagTexture
#ifdef __OWN_SIDE_BLUFOR__
	d_flag_str_blufor;
#endif
#ifdef __OWN_SIDE_OPFOR__
	d_flag_str_opfor;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	d_flag_str_independent;
#endif
#ifdef __TT__
	d_flag_str_independent;
#endif

	private _ma = [format ["d_paraflag%1", count d_resolved_targets], _flag, "ICON", "ColorYellow", [0.5, 0.5], ["Vehicle", "Parajump"] select (d_jumpflag_vec isEqualTo ""), 0, "mil_flag"] call d_fnc_CreateMarkerGlobal;
	
	if (d_WithJumpFlags == 1) then {
		[_flag, _ma] remoteExecCall ["d_fnc_newflagclient", [0, -2] select isDedicated];
	};
	private _nt = ["NewJumpVehFlag", "NewJumpFlag"] select (d_jumpflag_vec isEqualTo "");
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, _nt, d_kbtel_chan];
#else
	d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W", _nt, "SIDE"];
	d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E", _nt, "SIDE"];
#endif
	
	_flag setVariable ["d_is_jf", true, true];
};