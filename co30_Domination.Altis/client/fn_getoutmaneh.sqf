// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getoutmaneh.sqf"
#include "..\x_setup.sqf"

d_player_in_vec = false;
d_vec_role_pl = [];

if (!isNil "d_heli_kh_ro") then {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", d_heli_kh_ro];
	d_heli_kh_ro = nil;
};

if (alive (_this # 2)) then {
	if (!isNil {(_this # 2) getVariable "d_plyonloadoutaction"}) then {
		[(_this # 2), (_this # 2) getVariable "d_plyonloadoutaction"] call bis_fnc_holdActionRemove;
		(_this # 2) setVariable ["d_plyonloadoutaction", nil];
	};
	
	if (!d_with_ace) then {
		private _aidx = (_this # 2) getVariable "d_rappel_self_action";
		if (!isNil "_aidx") then {
			[(_this # 2), _aidx] call bis_fnc_holdActionRemove;
			(_this # 2) setVariable ["d_rappel_self_action", nil];
		};
		if (d_with_ai) then {
			_aidx = (_this # 2) getVariable "d_rappel_ai_action";
			if (!isNil "_aidx") then {
				[(_this # 2), _aidx] call bis_fnc_holdActionRemove;
				(_this # 2) setVariable ["d_rappel_ai_action", nil];
			};
		};
		_aidx = (_this # 2) getVariable "d_rappel_detach_action";
		if (!isNil "_aidx") then {
			[(_this # 2), _aidx] call bis_fnc_holdActionRemove;
			(_this # 2) setVariable ["d_rappel_detach_action", nil];
		};
	};
};

if (getPos player # 2 > 5) then {
	d_player_in_air = true;
	0 spawn {
		scriptName "spawn_getoutmaneh";
		while {alive player && {!(player getVariable ["xr_pluncon", false]) && {getPos player # 2 > 2 && {!(player getVariable ["ace_isunconscious", false])}}}} do {sleep 1};
		d_player_in_air = false;
#ifndef __TT__
		if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {player inArea d_base_array && {!(player getVariable ["ace_isunconscious", false])}}}}) then {
#else
		if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}}}}) then {
#endif
			d_player_in_base = true;
		};			
	};
} else {
#ifndef __TT__
	if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {player inArea d_base_array}}}) then {
#else
	if (alive player && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {player inArea (d_base_array # 0) || {player inArea (d_base_array # 1)}}}}) then {
#endif
		d_player_in_base = true;
	};
};