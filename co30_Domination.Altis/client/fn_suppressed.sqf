// based on LAxemann, Jokoho482, modified by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_suppressed.sqf"
#include "..\x_setup.sqf"

params ["", "_dist", "_shooter", "_insti", "", "", "_ammoConf"];

__TRACE_1("","_this")

if (!alive player || {player getVariable ["xr_pluncon", false]}) exitWith {};
if (!isNull objectParent player && {!isTurnedOut player}) exitWith {};

if (isNull _insti) then {_insti = UAVControl vehicle _shooter # 0};
if (isNull _insti) exitWith {};

if (_dist > getNumber(_ammoConf>>"suppressionRadiusBulletClose")) exitWith {};

private _cal = getNumber(_ammoConf>>"caliber");
private _f = ((1 /_dist) * _cal) min 1;
__TRACE_3("","_dist","_cal","_f")

d_impactBlur ppEffectAdjust [0.023 * _f, 0.023 * _f, 0.28 * _f, 0.28 * _f];
d_impactBlur ppEffectCommit 0;
d_impactCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0.6 * _f], [1, 1, 1, 1], [1, 1 , 1, 0]];
d_impactCC ppEffectCommit 0;

d_impactBlur ppEffectAdjust [0, 0, 0, 0];
d_impactBlur ppEffectCommit (0.3 + (0.5 * _f));
d_impactCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 0]];
d_impactCC ppEffectCommit (0.25 + (0.4 * _f));

// Makes the player twitch if it's been a while since he was getting shot at
if (time - d_lastshotat >= 30) then {
	addCamShake [3, 0.4, 80];
};

d_lastshotat = time;
