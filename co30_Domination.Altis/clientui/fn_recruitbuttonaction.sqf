// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (player getVariable "d_recdbusy") exitWith {};

disableSerialization;

player setVariable ["d_recdbusy", true];

private _max_ai = [round linearConversion [0, 20, 21 - count d_allplayers, 0, d_max_ai, true], d_max_ai] select !d_ai_dyn_recruit;

if (d_current_ai_num >= _max_ai) exitWith {
	[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_694", _max_ai];
	player setVariable ["d_recdbusy", false];
};

if (player != leader (group player)) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_695");
	player setVariable ["d_recdbusy", false];
};

d_current_ai_num = d_current_ai_num + 1;
__TRACE_1("","d_current_ai_num")

private _exitj = false;
if (d_with_ranked) then {
	private _rank = rank player;
	if (_rank == "PRIVATE") exitWith {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_696");
		_exitj = true;
	};

	if (score player < ((d_points_needed # 0) + (d_ranked_a # 3))) exitWith {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_697", score player, d_ranked_a # 3];
		_exitj = true;
	};

	private _max_rank_ai = switch (_rank) do {
		case "CORPORAL": {3};
		case "SERGEANT": {4};
		case "LIEUTENANT": {5};
		case "CAPTAIN": {6};
		case "MAJOR": {7};
		case "COLONEL": {8};
	};
	if (d_current_ai_num >= _max_rank_ai) exitWith {
		[playerSide, "HQ"] sideChat format [localize "STR_DOM_MISSIONSTRING_698", _max_rank_ai];
		_exitj = true;
	};
	// each AI soldier costs score points
	[player, 0] remoteExecCall ["d_fnc_ascfc", 2];
};

if (_exitj) exitWith {
	player setVariable ["d_recdbusy", false];
	d_current_ai_num = d_current_ai_num - 1;
};

private _dispx = uiNamespace getVariable "d_AIRecruitDialog";
private _idx = lbCurSel (_dispx displayCtrl 1000);
if (_idx == -1) exitWith {
	player setVariable ["d_recdbusy", false];
	d_current_ai_num = d_current_ai_num - 1;
};

private _grp = group player;
private _spawnpos = [];
if (player distance2D d_AI_HUT < 20) then {
	if (!isNil "d_AISPAWN" && {!isNull d_AISPAWN}) then {
		_spawnpos = getPosATL d_AISPAWN;
	} else {
		_spawnpos = player modelToWorldVisual [0, -15, 0];
	};
} else {
	if (!isNil "d_additional_recruit_buildings") then {
		private _har = d_additional_recruit_buildings select {!isNil "_x" && {!isNull _x && {player distance2D _x < 20}}};
		if (_har isNotEqualTo []) then {
			_spawnpos = player modelToWorldVisual [0,-15,0];
		};
	};
};
if (_spawnpos isEqualTo []) exitWith {
	player setVariable ["d_recdbusy", false];
	d_current_ai_num = d_current_ai_num - 1;
};

private _torecruit = d_UnitsToRecruit # _idx;
private _unit = _grp createUnit [_torecruit, _spawnpos, [], 0, "NONE"];
[_unit] join _grp;
if (surfaceIsWater _spawnpos) then {
	_unit setPosASL [_spawnpos # 0, _spawnpos # 1, (getPosASL d_FLAG_BASE) # 2];
};
_unit setSkill 1;
_unit setRank "PRIVATE";
if (!d_with_ace && {d_with_ranked || {d_database_found}}) then {
	_unit addEventHandler ["handleHeal", {call d_fnc_handleheal}];
};
if (d_WithRevive == 0 && {_unit getUnitTrait "Medic"}) then {
	[_unit] execFSM "fsms\fn_AIRevive.fsm";
};

d_current_ai_units pushBack _unit;

_unit call d_fnc_removenvgoggles_fak;

_unit enableDynamicSimulation false;
_unit triggerDynamicSimulation true;

if (!d_with_ace) then {
	_unit addEventhandler ["handleDamage", {call d_fnc_handledamageai}];
};

if (d_current_ai_num == _max_ai) then {
	(_dispx displayCtrl 1010) ctrlShow false;
};

private _ctrl = _dispx displayCtrl 1011;
if (!ctrlShown _ctrl) then {
	_ctrl ctrlShow true;
};
_ctrl = _dispx displayCtrl 1012;
if (!ctrlShown _ctrl) then {
	_ctrl ctrlShow true;
};

private _control = _dispx displayCtrl 1001;
private _ipic = getText (configFile>>"cfgVehicles">>_torecruit>>"icon");
__TRACE_2("","_torecruit","_ipic")
private _pic = if (_ipic == "") then {
	"#(argb,8,8,3)color(1,1,1,0)"
} else {
	getText(configFile>>"CfgVehicleIcons">>_ipic)
};
__TRACE_1("","_pic")
private _index = _control lbAdd ([_torecruit, "CfgVehicles"] call d_fnc_GetDisplayName);
_control lbSetPicture [_index, _pic];
_control lbSetColor [_index, [1, 1, 0, 0.8]];

(_dispx displayCtrl 1030) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_693", d_current_ai_num, _max_ai];

if (!d_with_ranked) then {
	private _code = if (!d_with_ace) then {
		{["Open", [true, nil, _this # 0]] call bis_fnc_arsenal}
	} else {
		{[_this # 0, _this # 0, true] call ace_arsenal_fnc_openBox}
	};
	_unit addAction [localize "STR_DOM_MISSIONSTRING_1585", _code, [], -1, false, true, "", "true", 3];
};

[_unit] remoteExecCall ["d_fnc_addceo", 2];
addToRemainsCollector [_unit];

_unit addEventhandler ["getInMan", {call d_fnc_getinmanai}];

if (d_ai_silent == 1) then {
	[_unit, "NoVoice"] remoteExecCall ["setSpeaker", -2, false];
	
	_unit disableAI "RADIOPROTOCOL";
};

player setVariable ["d_recdbusy", false];
