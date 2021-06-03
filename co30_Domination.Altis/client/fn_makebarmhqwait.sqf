// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Start")

if (!hasInterface) exitWith {};

if (isNil "d_mt_barmhq_ar") then {
	waitUntil {sleep 0.1; !isNil "d_mt_barmhq_ar"};
};

if (d_mt_barmhq_ar isEqualTo []) then {
	waitUntil {sleep 0.1; d_mt_barmhq_ar isNotEqualTo []};
};

d_client_barmhqtrigs = [];

__TRACE("d_mt_barmhq_ar not equal []")

{
	private _trig = [_x, [10, 10, 0, false, 10], ["ANYPLAYER", "PRESENT", true], ["vehicle player in thislist", format ["d_barmhqctrigbool_%1 = true; 0 = [thisTrigger, %1] spawn d_fnc_barmhqcounter", _forEachIndex], format ["d_barmhqctrigbool_%1 = false", _forEachIndex]]] call d_fnc_createtriggerlocal;
	_trig setVariable ["d_vec", _x];
	d_client_barmhqtrigs pushBack _trig;
} forEach d_mt_barmhq_ar;