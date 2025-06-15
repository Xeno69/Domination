// by Moerderhoschi
// see also:
// MDH RAGDOLL AI UNITS GET MORE DAMAGE AT HIT & AI UNITS GET RAGDOLL EFFECT AT HIT(by Moerderhoschi) - v2025-04-14
// github: https://github.com/Moerderhoschi/arma3_mdhRagdoll
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3387437564

#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_u"];
if (!alive _u) exitWith {};
_u addForce [[0,0,0], [0,0,0], false]; // reduce warping on ground
sleep 3;
if (!alive _u) exitWith {};
_u setUnconscious true;

if (0.4 > random 1) then {
	__TRACE("lower than 0.2")
	private _w = "";
	private _t = primaryWeapon _u;
	if (secondaryWeapon _u != "") then  {
		_w = "Weapon_Empty" createVehicle [500, 500, 500];
		_u actionNow ["DropWeapon", _w, secondaryWeapon _u];
		private _p = getPosWorld _u;
		_w setpos [(_p#0) + 0.3, _p#1, 0];
	};
	if (primaryWeapon _u != "") then  {
		_w = "Weapon_Empty" createVehicle [500, 500, 500];
		_u actionNow ["DropWeapon", _w, primaryWeapon _u];
		private _p = getPosWorld _u;
		_w setpos [_p#0, _p#1, 0];
	};
	sleep 10 + (random 5);
	if (!alive _u) exitWith {};
	_u setUnconscious false;
	if (_t != "") then {
		_u actionNow ["TakeWeapon", _w, _t];
		_u selectWeapon primaryWeapon _u;
	};
	sleep 5;
	if (!alive _u) exitWith {};
	_u setVariable ["DomEnemyDamageEhForceHit", false];
	_u playMove "AmovPknlMstpSrasWrflDnon";
	_u selectWeapon primaryWeapon _u;
} else {
	__TRACE("greater than 0.2")
	_u disableConversation true;
	_u setvariable ["bis_nocoreconversations",true];											
	_u disableAI "FSM";
	_u disableAI "RADIOPROTOCOL";
	if (secondaryWeapon _u != "") then {
		private _w = "Weapon_Empty" createVehicle [500, 500, 500];
		_u actionNow ["DropWeapon", _w, secondaryWeapon _u];
		private _p = getPosWorld _u;
		_w setpos [(_p#0) + 0.3, _p#1, 0];
	};
	if (primaryWeapon _u != "") then {
		private _w = "Weapon_Empty" createVehicle [500, 500, 500];
		_u actionNow ["DropWeapon", _w, primaryWeapon _u];
		private _p = getPosWorld _u;
		_w setpos [_p#0, _p#1, 0];
	};
	sleep 120 + (random 180);
	if (alive _u) then {
		_u setDamage 1;
	};
};					