// by Xeno
#include "..\x_setup.sqf"

private _e_ari_avail = true;
private _nextaritime = 0;

private _man_type = format ["Soldier%1B", d_enemy_side_short];

sleep 10.123;
while {d_nr_observers > 0} do {
	if (_e_ari_avail) then {
		{
			if (alive _x) then {
				private _enemy = _x findNearestEnemy _x;
				// AI with awareness - if (isvisible enemy)
				// AI without awareness (default) - if (knowsAbout enemy and distance to enemy < 500)
				if (!isNull _enemy && {alive _enemy && {!((vehicle _enemy) isKindOf "Air") && {((d_ai_awareness_rad > 0) && [_enemy, _x] call d_fnc_isvisible) || {!(d_ai_awareness_rad > 0) && _x knowsAbout _enemy >= 1.5 && {_x distance2D _enemy < 500}}}}}) then {
					if ((_enemy nearEntities [_man_type, 30]) isEqualTo []) then {
						_e_ari_avail = false;
						if (d_cas_plane_ai != "") then {
							if (selectRandom [0, 1] == 0 && {d_no_more_observers < 1}) then {
								_nextaritime = time + 240 + (random 120);
								[getPosWorld _enemy, floor (random 2)] spawn d_fnc_shootari;
							} else {
								_nextaritime = time + 380 + (random 120);
								[getPosWorld _enemy, _x, 2, _enemy] spawn d_fnc_moduleCASAI;
#ifndef __TT__
								if (d_searchintel # 1 == 1 || { d_tell_arty_cas == 1 }) then {
#else
								if (floor random 3 == 0) then {
#endif
									[getPosWorld _enemy, 1] remoteExecCall ["d_fnc_doarti", [0, -2] select isDedicated];
								};
							};
						} else {
							_nextaritime = time + 240 + (random 120);
							[getPosWorld _enemy, floor (random 2)] spawn d_fnc_shootari;
						};
					} else {
						_e_ari_avail = false;
						_nextaritime = time + 240 + (random 120);
						if (random 100 < 15) then {// 1 to 6 chance for smoke
							[getPosWorld _enemy, 2] spawn d_fnc_shootari;
						};
					};
				};
			};
			sleep 2.321;
		} forEach (d_obs_array select {alive _x});
	};
	sleep 8.123;
	if (!_e_ari_avail && {time > _nextaritime}) then {_e_ari_avail = true};
};

d_handleobservers_handle = nil;