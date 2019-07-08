// by Xeno
#define THIS_FILE "fn_mash.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (player getVariable "d_isinaction") exitWith {
	d_commandingMenuIniting = false;
};

if (player distance2D d_FLAG_BASE < 30) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_246");
	d_commandingMenuIniting = false;
};

if ((player call d_fnc_GetHeight) > 5) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_241");
	d_commandingMenuIniting = false;
};

private _d_medtent = player getVariable "d_medtent";
if !(_d_medtent isEqualTo []) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_281")};

_d_medtent = player modelToWorldVisual [0,5,0];
_d_medtent set [2,0];

if (surfaceIsWater [_d_medtent # 0, _d_medtent # 1]) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_282");
	d_commandingMenuIniting = false;
};

private _helper1 = d_HeliHEmpty createVehicle [10, 10, 10];
_helper1 setPos [_d_medtent # 0, (_d_medtent # 1) + 4, 0];
private _helper2 = d_HeliHEmpty createVehicle [10, 10, 10];
_helper2 setPos [_d_medtent # 0, (_d_medtent # 1) - 4, 0];
private _helper3 = d_HeliHEmpty createVehicle [10, 10, 10];
_helper3 setPos [(_d_medtent # 0) + 4, _d_medtent # 1, 0];
private _helper4 = d_HeliHEmpty createVehicle [10, 10, 10];
_helper4 setPos [(_d_medtent # 0) - 4, _d_medtent # 1, 0];

private _exit_it = false;
if ((abs (((getPosASL _helper1) # 2) - ((getPosASL _helper2) # 2)) > 2) || {(abs (((getPosASL _helper3) # 2) - ((getPosASL _helper4) # 2)) > 2)}) then {
	systemChat (localize "STR_DOM_MISSIONSTRING_246");
	_exit_it = true;
};
{
	deleteVehicle _x;
} forEach [_helper1, _helper2, _helper3, _helper4];

if (_exit_it) exitWith {
	d_commandingMenuIniting = false;
};

player setVariable ["d_isinaction", true];

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 1;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}};
d_commandingMenuIniting = false;
if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_247");
	player setVariable ["d_isinaction", false];
};

private _medic_tent = createVehicle [d_mash, _d_medtent, [], 0, "NONE"];
_medic_tent setDir (getDirVisual player - 180);
_medic_tent setPos _d_medtent;
[_medic_tent, 0] call d_fnc_SetHeight;
_medic_tent_flag = createVehicle [d_mash_flag, _d_medtent,[],0,"CAN_COLLIDE"];
[_medic_tent_flag, -3] call d_fnc_SetHeight;
private _medtent_content = _medic_tent getVariable ["d_objcont", []];
_medtent_content pushBack _medic_tent_flag;
_medic_tent setVariable ["d_objcont", _medtent_content, true];

player setVariable ["d_medic_tent", _medic_tent];
player reveal _medic_tent;
_d_medtent = getPosATL _medic_tent;
player setVariable ["d_medtent", _d_medtent];

d_mashes pushBack _medic_tent;
publicVariable "d_mashes";

systemChat (localize "STR_DOM_MISSIONSTRING_285");

["a", d_string_player, [_medic_tent, "Mash " + d_string_player, d_name_pl, player, d_player_side]] remoteExecCall ["d_fnc_p_o_ar", 2];
if (isMultiplayer) then {
	[_medic_tent, player] remoteExecCall ["d_fnc_m_a_h_a", d_player_side];
} else {
	[_medic_tent, player] call d_fnc_m_a_h_a;
};

_medic_tent setVariable ["d_owner", player, true];

_medic_tent addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_286"], {
	_this call { // workaround to avoid exitWith problems here
		if (isNil {player getVariable "d_medic_tent"}) exitWith {};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}}};
		if (!alive player || {player getVariable ["xr_pluncon", false] || {player getVariable ["ace_isunconscious", false]}}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_315")};

		d_mashes = d_mashes - [player getVariable "d_medic_tent"];
		publicVariable "d_mashes";
		
		private _medtent_content = (player getVariable "d_medic_tent") getVariable ["d_objcont", []];
		if !(_medtent_content isEqualTo []) then {
			{deleteVehicle _x} forEach _medtent_content;
		};
		deleteVehicle (player getVariable "d_medic_tent");
		player setVariable ["d_medic_tent", objNull];

		systemChat (localize "STR_DOM_MISSIONSTRING_318");
		player setVariable ["d_medtent", []];
		["r", d_string_player, "Mash " + d_string_player] remoteExecCall ["d_fnc_p_o_ar", 2];
	};
}];

player setVariable ["d_isinaction", false];
