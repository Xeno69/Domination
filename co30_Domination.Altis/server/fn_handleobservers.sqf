// by Xeno
#define THIS_FILE "fn_handleobservers.sqf"
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
				if (!isNull _enemy && {alive _enemy && {_x knowsAbout _enemy >= 1.5 && {!((vehicle _enemy) isKindOf "Air") && {_x distance2D _enemy < 500}}}}) then {
					if ((_enemy nearEntities [_man_type, 30]) isEqualTo []) then {
						_e_ari_avail = false;
						_nextaritime = time + 120 + (random 120);
						if (d_cas_plane_ai != "") then {
							if (selectRandom [0, 1] == 0 && {d_no_more_observers < 1}) then {
								[getPosWorld _enemy, floor (random 2)] spawn d_fnc_shootari;
							} else {
								[getPosWorld _enemy, _x, 2, _enemy] spawn d_fnc_moduleCASAI;
							};
						} else {
							[getPosWorld _enemy, floor (random 2)] spawn d_fnc_shootari;
						};
					} else {
						_e_ari_avail = false;
						_nextaritime = time + 120 + (random 120);
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