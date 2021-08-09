// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!d_player_canu || {!isNil "d_is_sat_on"}) exitWith {false};

private _pin_v = false;
private _ct = if (isNull objectParent player) then {
	cursorObject
} else {
	_pin_v = true;
	vehicle player
};

__TRACE_2("","_ct","_pin_v")

if (!alive _ct) exitWith {false};

if (!_pin_v && {_ct distance2D player > 20 || {!(_ct isKindOf "Car") && {!(_ct isKindOf "Tank") && {!(_ct isKindOf "Air")}} || {_ct isKindOf "ParachuteBase" || {unitIsUAV _ct || {(crew _ct) findIf {alive _x} == -1}}}}}) exitWith {false};
if ((crew _ct) findIf {alive _x && {d_player_side getFriend side (group _x) >= 0.6}} == -1) exitWith {false};

private _fc = fullCrew _ct;

__TRACE_1("","_fc")

if (_fc isEqualTo []) exitWith {false};

private _s_p = [];
private _s_ai = [];

{
	_x params ["_uni", "_role"];
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
		_s_p pushBack format ["%1<img color='#FFFFFF' image='%2'/> <br/>", name _uni, _rpic];
	} else {
		_s_ai pushBack format ["%1 (AI)<img color='#FFFFFF' image='%2'/> <br/>", name _uni, _rpic];
	};
} forEach (_fc select {alive (_x # 0)});
if (_s_ai isNotEqualTo []) then {
	_s_ai pushBack "</t>";
} else {
	_s_p pushBack "</t>";
};

__TRACE_1("","_s_p")
__TRACE_1("","_s_ai")

private _t = format ["<t color='#FFFFFF' size='0.8'><t align='right'>%1 %2:<br/>%3%4", localize "STR_DOM_MISSIONSTRING_538", [_ct] call d_fnc_GetDisplayName, _s_p joinString "", _s_ai joinString ""];
__TRACE_1("","_t")
disableSerialization;
private _disp = uiNamespace getVariable "d_rscCrewText";
if (isNil "_disp" || {isNull _disp}) then {
	__TRACE("disp is null")
	"d_rscCrewText" cutRsc ["d_rscCrewText", "PLAIN"];
	_disp = uiNamespace getVariable "d_rscCrewText";
};
__TRACE_1("","_disp")
private _ctrl = _disp displayCtrl 9999;
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