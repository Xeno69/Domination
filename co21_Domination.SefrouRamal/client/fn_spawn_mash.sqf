// by Xeno
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
if (_d_medtent isNotEqualTo []) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_281")};

_d_medtent = player modelToWorldVisual [0,1,0];
_d_medtent set [2,0];

if (surfaceIsWater [_d_medtent # 0, _d_medtent # 1]) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_282");
	d_commandingMenuIniting = false;
};

if ([_d_medtent, 3] call d_fnc_getslope > 0.5) exitWith {
    systemChat (localize "STR_DOM_MISSIONSTRING_246");
    d_commandingMenuIniting = false;
};

player setVariable ["d_isinaction", true];

player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 1;
waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!d_player_canu}};
d_commandingMenuIniting = false;
if (!d_player_canu) exitWith {
	systemChat (localize "STR_DOM_MISSIONSTRING_247");
	player setVariable ["d_isinaction", false];
};

private _obj = objNull;
_obj = createSimpleObject ["Land_ClutterCutter_medium_F", AGLtoASL _d_medtent];
sleep 0.2;
private _medic_tent = createVehicle [d_mash, _d_medtent, [], 0, "NONE"];
_medic_tent setDir (getDirVisual player - 180);
_medic_tent setPosATL _d_medtent;
if (([_d_medtent, 1] call d_fnc_getslope) > 0.29) then {
	_medic_tent setVectorUp surfaceNormal _d_medtent;
} else {
	_medic_tent setVectorUp [0,0,1];
};
call {
	if (d_gmcwg) exitWith {
		_medic_tent addItemCargoGlobal ["gm_ge_army_gauzeBandage", 25];
		_medic_tent addItemCargoGlobal ["gm_ge_army_burnBandage", 25];
	};
	if (d_vn) exitWith {
		_medic_tent addItemCargoGlobal ["vn_b_item_firstaidkit", 25];
	};
	_medic_tent addItemCargoGlobal ["FirstAidKit", 25];
};
player reveal _medic_tent;
if (d_with_ranked || {d_database_found}) then {
	_medic_tent setVariable ["d_mplayer", player, true];
};

private _medtent_content = _medic_tent getVariable ["d_objcont", []];
_medtent_content pushBack _obj;
_medic_tent setVariable ["d_objcont", _medtent_content, true];

player setVariable ["d_medic_tent", _medic_tent];

_d_medtent = getPosATL _medic_tent;
player setVariable ["d_medtent", _d_medtent];

d_mashes pushBack _medic_tent;
publicVariable "d_mashes";

systemChat (localize "STR_DOM_MISSIONSTRING_285");

#ifndef __TT__
["a", d_player_uid, [_medic_tent, "d_Mash " + (netId player), d_name_pl, player, d_player_side]] remoteExecCall ["d_fnc_p_o_ar", 2];
#else
private _mbegin = ["d_Mash_opf ", "d_Mash_blu "] select (d_player_side == blufor);
["a", d_player_uid, [_medic_tent, _mbegin + (netId player), d_name_pl, player, d_player_side]] remoteExecCall ["d_fnc_p_o_ar", 2];
#endif

_medic_tent setVariable ["d_owner", player, true];

_medic_tent addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_286"], {
	call { // workaround to avoid exitWith problems here
		if (isNil {player getVariable "d_medic_tent"}) exitWith {};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic" || {!d_player_canu}};
		if (!d_player_canu) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_315")};

		d_mashes = d_mashes - [player getVariable "d_medic_tent"];
		publicVariable "d_mashes";

		private _medtent_content = (player getVariable "d_medic_tent") getVariable ["d_objcont", []];
		if (_medtent_content isNotEqualTo []) then {
			{deleteVehicle _x} forEach _medtent_content;
		};
		deleteVehicle (player getVariable "d_medic_tent");
		player setVariable ["d_medic_tent", objNull];

		systemChat (localize "STR_DOM_MISSIONSTRING_318");
		player setVariable ["d_medtent", []];
		["ar", d_player_uid, "d_Mash " + (netId player)] remoteExecCall ["d_fnc_p_o_ar", 2];
	};
}, [], -1, false, true, "", "isNull objectParent player", 10];

player setVariable ["d_isinaction", false];
