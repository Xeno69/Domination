// by Xeno
//#define __DEBUG__
//#include "..\x_macros.sqf"

private _dragee = player getVariable "xr_cursorTarget";

if (isNull _dragee || {!alive player}) exitWith {};

player setVariable ["xr_pisinaction", true];
player setVariable ["xr_is_dragging", true];

private _unit = player;
private _name_dragee = [_dragee] call d_fnc_gethpname;
if (isNil "_name_dragee" || {_name_dragee isEqualTo ""}) then {_name_dragee = name _dragee};

_dragee setVariable ["xr_dragged", true, true];
 
sleep 2;

[_dragee, 5] remoteExecCall ["d_fnc_swm"];

_dragee attachto [_unit, [0, 2, 0]];
sleep 0.02;
_dragee remoteExecCall ["d_fnc_sd180"];

xr_drag = true;

if (xr_dropAction != -3333) then {player removeAction xr_dropAction;xr_dropAction = -3333};
xr_dropAction = player addAction [format["<t color='#FF0000'>%2 %1</t>",_name_dragee, localize "STR_DOM_MISSIONSTRING_1733"], {call xr_fnc_drop_body}, [_dragee, 1], 0, false, true];
xr_dragprone_key_ar = actionKeys "moveForward" + actionKeys "moveFastForward";
xr_dragprone_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", {((_this # 1) in xr_dragprone_key_ar)}];
sleep 0.5;

private _found_anim = false;

private _pullanims = ["amovppnemstpsraswrfldnon","amovppnemrunslowwrfldf","amovppnemsprslowwrfldfl","amovppnemsprslowwrfldfr","amovppnemrunslowwrfldb","amovppnemsprslowwrfldbl","amovppnemsprslowwrfldr","amovppnemstpsraswrfldnon_turnl","amovppnemstpsraswrfldnon_turnr","amovppnemrunslowwrfldl","amovppnemrunslowwrfldr","amovppnemsprslowwrfldb","amovppnemrunslowwrfldbl","amovppnemsprslowwrfldl","amovppnemsprslowwrfldbr","amovppnemsprslowwrfldf"];

while {xr_drag} do {
	if (!_found_anim && {animationState player in _pullanims}) then {
		_found_anim = true;
	};
	if (!alive _dragee || {!(_dragee getVariable ["xr_pluncon", false])}) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		detach _dragee;
		sleep 0.5;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		sleep 1;
		xr_drag = false;
	};
	
	if (_found_anim && {!((animationState _unit) in _pullanims)}) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		detach _dragee;
		sleep 0.5;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		sleep 1;
		xr_drag = false;
	};

	if (!alive _unit) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		detach _unit;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		sleep 1;
		xr_drag = false;
	};
	
	if (isNull _dragee) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		detach _unit;
		sleep 1;
		xr_drag = false;
	};
	
	sleep 0.1;
};

player setVariable ["xr_pisinaction", false];
player setVariable ["xr_is_dragging", false];
_dragee setVariable ["xr_dragged", nil, true];

(findDisplay 46) displayRemoveEventHandler ["KeyDown", xr_dragprone_keyDownEHId];

if (xr_dropAction != -3333) then {
	player removeAction xr_dropAction;
	xr_dropAction = -3333;
};