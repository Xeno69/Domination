// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mousewheelrec.sqf"
#include "..\x_setup.sqf"

if (!isNil "d_is_sat_on" || {!d_player_canu}) exitWith {false};

private _pin_v = false;
private _ct = if (isNull objectParent player) then {
	cursorObject
} else {
	_pin_v = true;
	vehicle player
};

if (!alive _ct) exitWith {false};

if (!_pin_v && {_ct distance2D player > 20 || {!(_ct isKindOf "Car") && {!(_ct isKindOf "Tank") && {!(_ct isKindOf "Air")}} || {_ct isKindOf "ParachuteBase" || {_ct isKindOf "UAV_01_base_F" || {_ct isKindOf "UGV_01_base_F" || {_ct isKindOf "UAV_02_base_F" || {(crew _ct) findIf {alive _x} == -1}}}}}}}) exitWith {false};
private _crewct = crew _ct;
if (_crewct findIf {alive _x && {d_player_side getFriend side (group _x) >= 0.6}} == -1) exitWith {false};

_fc = fullCrew _ct;

if (count _fc == 0) exitWith {false};

private _s_p = [];
private _s_ai = [];

{
	_x params ["_uni"];
	if (alive _uni) then {
		private _role = _x # 1;
		private _rpic = call {
			if (_role == "commander") exitWith {
				"\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa";
			};
			if (_role == "driver") exitWith {
				"\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa";
			};
			if (_role == "gunner" || {_role == "turret"}) exitWith {
				"\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa"
			};
			"\A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa"
		};
		if (_uni call d_fnc_isplayer) then {
			_s_p pushBack format ["%1<img color='#FFFFFF' image='%2'/> <br/>", [_uni] call d_fnc_gethpname, _rpic];
		} else {
			_s_ai pushBack format ["%1 (AI)<img color='#FFFFFF' image='%2'/> <br/>", name _uni, _rpic];
		};
	};
} forEach _fc;
if (_s_ai isNotEqualTo []) then {
	_s_ai pushBack "</t>";
} else {
	_s_p pushBack "</t>";
};

private _t = format ["<t color='#FFFFFF' size='0.8'><t align='right'>%1 %2:<br/>%3%4", localize "STR_DOM_MISSIONSTRING_538", [_ct] call d_fnc_GetDisplayName, _s_p joinString "", _s_ai joinString ""];
"d_rscCrewText" cutRsc ["d_rscCrewText", "PLAIN"];
disableSerialization;
private _ctrl = (uiNamespace getVariable "d_rscCrewText") displayCtrl 9999;
_ctrl ctrlSetStructuredText parseText _t;
_ctrl ctrlCommit 0;
private _dospawn = d_rscCrewTextShownTimeEnd == -1;
d_rscCrewTextShownTimeEnd = time + 5;
if (_dospawn) then {
	0 spawn {
		scriptName "spawn_crewrsc";
		private _vecp = vehicle player;
		while {true} do {
			sleep 0.221;
			if (time > d_rscCrewTextShownTimeEnd || {!d_player_canu || {vehicle player != _vecp}}) exitWith {};
		};
		"d_rscCrewText" cutFadeOut 0;
		d_rscCrewTextShownTimeEnd = -1;
	};
};