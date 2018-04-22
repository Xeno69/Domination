// by Xeno
#define THIS_FILE "fn_moveai.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

if (units (group player) findIf {alive _x} > -1) then {
	if (isNil "_this" || {_this isEqualTo []}) then {
		sleep 1;
		private _posasl_p = getPosASL player;
		private _hasunits = false;
		{
			private _np_unit = player getPos [1 + random 3, random 360];
			_x setPosASL [_np_unit # 0, _np_unit # 1, _posasl_p # 2];
			sleep 0.2;
			//_x reveal player;
			_x doFollow player;
			sleep 0.1;
			_hasunits = true;
			sleep 0.1;
		} forEach ((formationMembers player) select {!isPlayer _x && {alive _x && {isNull objectParent _x && {_x distance2D _posasl_p > 500}}}});
		if (_hasunits) then {
			sleep 0.2;
			private _wps = waypoints (group player);
			if !(_wps isEqualTo []) then {
				(_wps # 0) setWPPos (getPos player);
				_wps spawn {
					sleep 0.3;
					{
						deleteWaypoint _x;
						false
					} count _this;
				};
			};
		};
	} else {
		waitUntil {(vehicle player isKindOf "ParachuteBase") || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}};
		if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {};
		private _pos_p = getPos player;
		private _veloc = velocity player;
		private _dir = getDir player;
		{
			private _np_unit = player getPos [20 + random 20, random 360];
			private _z_po = (_pos_p # 2) + 10 + random 10;
			private _obj_para = createVehicle [d_non_steer_para, [0, 0, _z_po], [], 0, "FLY"];
			_obj_para setDir _dir;
			_obj_para setVelocity _veloc;
			_obj_para setPos [_np_unit # 0, _np_unit # 1, _z_po];
			_x moveInDriver _obj_para;
			[_x] spawn {
				scriptName "spawnx_moveai_paraAI";
				params ["_unit"];
				sleep 0.8321;
				waitUntil {sleep 0.111; (isNull objectParent _unit || {!alive _unit})};
				if (alive _unit && {(getPosATL _unit) # 2 > 1}) then {[_unit, 0] call d_fnc_SetHeight};
			};
			false
		} count ((formationMembers player) select {!isPlayer _x && {alive _x && {isNull objectParent _x && {_x distance2D _pos_p > 500}}}});
	};
};