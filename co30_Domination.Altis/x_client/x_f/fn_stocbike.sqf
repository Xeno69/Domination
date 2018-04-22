// by Xeno
#define THIS_FILE "fn_stocbike.sqf"
#include "..\..\x_setup.sqf"

private _vec = _this;
player reveal _vec;
player moveInDriver _vec;

if (_vec isKindOf "Quadbike_01_Base_F") then {
	_vec addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_162"], {(param [0]) setVectorUp [0,0,1]}, 0, -1, false, false, "", "!(player in _target) && {((vectorUpVisual _target) # 2) < 0.6}"];
};

if (player getVariable "d_bike_b_mode" == 1) then {
	_vec spawn {
		scriptName "spawn_x_bike_1";
		private _vec = _this;
		waitUntil {sleep 0.412;!alive player || {!alive _vec}};
		sleep 10.123;
		while {true} do {
			if ((crew _vec) findIf {alive _x} == -1) exitWith {deleteVehicle _vec};
			sleep 15.123;
		};
	};
} else {
	d_flag_vec = _vec;
	d_flag_vec addEventHandler ["killed", {
		(param [0]) spawn {
			private _vec = _this;
			sleep 10.123;
			while {true} do {
				if (isNull _vec || {(crew _vec) findIf {alive _x} == -1}) exitWith {deleteVehicle _vec};
				sleep 15.123;
			};
			d_flag_vec = objNull;
		}
	}];
	d_player_vecs pushBack d_flag_vec;
	d_flag_vec setVariable ["d_fl_v_kc", 0];
};