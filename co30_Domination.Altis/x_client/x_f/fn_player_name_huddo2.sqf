// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_player_name_huddo2.sqf"
#include "..\..\x_setup.sqf"

d_pnhuddo2_frskip = d_pnhuddo2_frskip + 1;
if (d_pnhuddo2_frskip == 4) exitWith {
	d_pnhuddo2_frskip = 0;
};
disableSerialization;
if (!d_show_pname_hud && {!visibleMap && {isNil "d_is_sat_on"}}) then {
	private _ct = cursorObject;
	if (alive _ct && {_ct isKindOf "CAManBase" && {!(player getVariable ["xr_pluncon", false]) && {!(player getVariable ["ace_isunconscious", false]) && {_ct != player && {(positionCameraToWorld [0,0,0]) distance _ct <= (d_dist_pname_hud / 2) && {side (group _ct) getFriend d_player_side >= 0.6}}}}}}) then { // && {isPlayer _ct}
		d_pnhuddo2_endtime = time + 0.8;
		if (!d_showPlayerNameRSC_shown) then {
			"d_showPlayerNameRsc" cutRsc ["d_showPlayerNameRsc", "PLAIN"];
			d_showPlayerNameRSC_shown = true;
			0 spawn d_fnc_dosshowhuddo2spawn;
		};
		
		private _name = [(_ct call d_fnc_getplayername) + d_phud_loc883, [getText(configFile>>"CfgVehicles">>typeOf _ct>>"displayName") ,_ct call d_fnc_getplayername] select (isPlayer _ct)] select !(_ct getVariable ["xr_pluncon", false]);
		private _icon = getText(configFile>>"CfgVehicles">>typeOf _ct>>"Icon");
		if (_icon != "") then {
			_icon = getText(configFile>>"CfgVehicleIcons">>_icon);
		};
		private _ctrtxt = [
			format ["<img color='#FFFFFF' size='1.0' image='%1'/><t color='#b5f279' size='1.2'> %2</t><img color='#FFFFFF' size='1.0' image='%3'/><br/>",
				(rank _ct) call d_fnc_getrankpic,
				_name,
				_icon
			],
			format ["<img color='#FFFFFF' size='1.0' image='%1'/><t color='#b5f279' size='1.2'> %2</t><img color='#FFFFFF'size='1.0' image='%3'/><br/><t color='#b5f279' size='0.8'>Damage: </t><t color='#FFFFFF' size='0.8'>%4</t>",
				(rank _ct) call d_fnc_getrankpic,
				_name,
				_icon,
				str(round ((damage _ct) * 90))
			]
		] select (d_no_ai && {player getUnitTrait "Medic"});
		((uiNamespace getVariable "d_showPlayerNameRsc") displayCtrl 1000) ctrlSetStructuredText parseText _ctrtxt;
	};
} else {
	if (d_show_pname_hud) then {
		["itemRemove", ["dom_player_hud2"]] call bis_fnc_loop;
	};
};