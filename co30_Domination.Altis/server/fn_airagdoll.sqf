// by Moerderhoschi
// see also:
// MDH RAGDOLL AI UNITS GET MORE DAMAGE AT HIT & AI UNITS GET RAGDOLL EFFECT AT HIT(by Moerderhoschi) - v2025-04-14
// github: https://github.com/Moerderhoschi/arma3_mdhRagdoll
// steam mod version: https://steamcommunity.com/sharedfiles/filedetails/?id=3387437564

//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_u", "_selection"];

if (_selection == "body" && {isNull objectParent _u && {(_this # 8) && {alive _u && {lifeState _u != "INCAPACITATED"}}}}) then {
	if !(_u getVariable ["DomEnemyDamageEhForceHit", false]) then {
		_u setVariable ["DomEnemyDamageEhForceHit", true];
		_u spawn d_fnc_airddo;
	};
};
