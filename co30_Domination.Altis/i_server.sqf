// d_init include server
#ifndef __XSETUP_INCL__
#define THIS_FILE "i_server.sqf"
#include "x_setup.sqf"
#endif

private _allmapmarkers = allMapMarkers select {_x select [0, 8] isEqualTo "d_bonus_"};
#ifndef __TT__
d_bap_counter = 0;
d_bacp_counter = 0;
d_bonus_create_pos = markerPos "d_bonus_create_pos";
deleteMarker "d_bonus_create_pos";
d_bonus_air_positions = [];
d_bonus_air_positions_carrier = [];
private _rem = [];
{
	d_bonus_air_positions_carrier pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
	_rem pushBack _x;
} forEach (_allmapmarkers select {_x select [0, 30] isEqualTo "d_bonus_air_positions_carrier_"});
_allmapmarkers = _allmapmarkers - _rem;
_rem = [];
{
	d_bonus_air_positions pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
	_rem pushBack _x;
} forEach (_allmapmarkers select {_x select [0, 22] isEqualTo "d_bonus_air_positions_"});
_allmapmarkers = _allmapmarkers - _rem;
d_bvp_counter = 0;
d_bonus_vec_positions = [];
{
	d_bonus_vec_positions pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
} forEach (_allmapmarkers select {_x select [0, 22] isEqualTo "d_bonus_vec_positions_" && {([_x select [22, 23]] call BIS_fnc_parseNumber) != -1}});
if (!isNil "d_the_carrier") then {
	private _nobs = nearestObjects [d_the_carrier, ["FlagCarrier"], 200];
	if !(_nobs isEqualTo []) then {
		d_the_carrier setVariable ["d_asl_height", (getPosASL (_nobs # 0) # 2) + 0.01];
	};
};
#else
d_bonus_create_pos_w = markerPos "d_bonus_create_pos_w";
d_bap_counter_w = 0;
d_bonus_air_positions_w = [];
{
	d_bonus_air_positions_w pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
} forEach (_allmapmarkers select {_x select [0, 24] isEqualTo "d_bonus_air_positions_w_"});

d_bonus_create_pos_e = markerPos "d_bonus_create_pos_e";
d_bap_counter_e = 0;
d_bonus_air_positions_e = [];
{
	d_bonus_air_positions_e pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
} forEach (_allmapmarkers select {_x select [0, 24] isEqualTo "d_bonus_air_positions_e_"});

d_bvp_counter_w = 0;
d_bonus_vec_positions_w = [];
{
	d_bonus_vec_positions_w pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
} forEach (_allmapmarkers select {_x select [0, 24] isEqualTo "d_bonus_vec_positions_w_"});

d_bvp_counter_e = 0;
d_bonus_vec_positions_e = [];
{
	d_bonus_vec_positions_e pushBack [markerPos _x, markerDir _x];
	deleteMarker _x;
} forEach (_allmapmarkers select {_x select [0, 24] isEqualTo "d_bonus_vec_positions_e_"});
#endif

// add some random patrols on the island
// if the array is empty, no patrols
// simply place a rectangular marker called "d_isledefense_marker", marker text = number of patrols
if (isServer) then {
	if (d_WithIsleDefense == 0) then {
		private _mna = "d_isledefense_marker";
		if (markerPos _mna isEqualTo [0,0,0]) exitWith {
			d_with_isledefense = [];
		};
		private _msize = markerSize _mna;
		d_with_isledefense = [markerPos _mna, _msize # 0, _msize # 1, markerDir _mna, parseNumber (markerText _mna)];
	} else {
		d_with_isledefense = [];
	};
	publicVariable "d_with_isledefense";
	deleteMarker "d_isledefense_marker";
};
__TRACE_1("","d_with_isledefense")

#ifndef __TT__
if (isServer) then {
	if (d_MissionType != 2) then {
		0 spawn {
			scriptName "spawn_ServicePoint_Building";
			private _stype = [d_servicepoint_building] call BIS_fnc_simpleObjectData;

			if !((d_service_buildings # 0) isEqualTo []) then {
				private _pos = (d_service_buildings # 0) # 0;
				_pos set [2, 3.3];
				private _fac = createSimpleObject [_stype # 1, _pos];
				_fac setDir ((d_service_buildings # 0) # 1);
				_fac setPos _pos;
			};

			if !((d_service_buildings # 1) isEqualTo []) then {
				private _pos = (d_service_buildings # 1) # 0;
				_pos set [2, 3.3];
				private _fac = createSimpleObject [_stype # 1, _pos];
				_fac setDir ((d_service_buildings # 1) # 1);
				_fac setPos _pos;
			};

			if !((d_service_buildings # 2) isEqualTo []) then {
				private _pos = (d_service_buildings # 2) # 0;
				_pos set [2, 3.3];
				private _fac = createSimpleObject [_stype # 1, _pos];
				_fac setDir ((d_service_buildings # 2) # 1);
				_fac setPos _pos;
			};
		};
	};

	if (d_with_ai) then {
		d_pos_ai_hut = [markerPos "d_pos_aihut", markerDir "d_pos_aihut"];
		d_AI_HUT = createVehicle ["Land_CashDesk_F", d_pos_ai_hut # 0, [], 0, "NONE"];
		d_AI_HUT setDir (d_pos_ai_hut # 1);
		if (!d_carrier) then {
			d_AI_HUT setPos (d_pos_ai_hut # 0);
		} else {
			d_AI_HUT setPosASL [(d_pos_ai_hut # 0) # 0, (d_pos_ai_hut # 0) # 1, (getPosASL d_FLAG_BASE) # 2];
		};
		d_AI_HUT enableSimulationGlobal false;
		d_AI_HUT addEventHandler ["handleDamage", {0}];
		publicVariable "d_AI_HUT";
		["d_RecruitB_100010000", d_AI_HUT, "ICON","ColorYellow", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_313", 0, "mil_dot"] call d_fnc_CreateMarkerGlobal;
		deleteMarker "d_pos_aihut";
		if (d_with_dynsim == 0) then {
			d_AI_HUT enableDynamicSimulation true;
		};
	};
};
#endif

if (!isServer) exitWith {};

#ifdef __OWN_SIDE_BLUFOR__
blufor setFriend [opfor, 0];
opfor setFriend [blufor, 0];
blufor setFriend [independent, 1];
independent setFriend [blufor, 1];
opfor setFriend [independent, 0];
independent setFriend [opfor, 0];
#endif

#ifdef __OWN_SIDE_OPFOR__
if (!d_ifa3lite) then {
	blufor setFriend [opfor, 0];
	opfor setFriend [blufor, 0];
	blufor setFriend [independent, 0];
	independent setFriend [blufor, 0];
	opfor setFriend [independent, 1];
	independent setFriend [opfor, 1];
} else {
	blufor setFriend [opfor, 0];
	opfor setFriend [blufor, 0];
	independent setFriend [blufor, 0];
	blufor setFriend [independent, 0];
	opfor setFriend [independent, 1];
	independent setFriend [opfor, 1];
};
#endif

#ifdef __OWN_SIDE_INDEPENDENT__
blufor setFriend [opfor, 0];
opfor setFriend [blufor, 0];
independent setFriend [blufor, 0];
independent setFriend [opfor, 0];
blufor setFriend [independent, 0];
opfor setFriend [independent, 0];
#endif

#ifdef __TT__
blufor setFriend [independent, 0.1];
independent setFriend [blufor, 0.1];
opfor setFriend [independent, 0.1];
independent setFriend [opfor, 0.1];
#endif
