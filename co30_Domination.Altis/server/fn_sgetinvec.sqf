// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sgetinvec.sqf"
#include "..\x_setup.sqf"

private _ma = (_this # 0) getVariable "d_abandoned_ma";
if (!isNil "_ma") then {
	deleteMarker _ma;
	(_this # 0) setVariable ["d_abandoned_ma", nil];
};
#ifdef __TT__
private _jid = (_this # 0) getVariable "d_bandoned_ma_jipid";
if (!isNil "_jid") then {
	remoteExecCall ["", _jid];
};
#endif