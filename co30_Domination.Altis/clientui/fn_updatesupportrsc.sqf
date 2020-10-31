// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_updatesupportrsc.sqf"
#include "..\x_setup.sqf"

if (!hasInterface || isStreamFriendlyUIEnabled || d_force_isstreamfriendlyui == 1) exitWith {};

disableSerialization;

#define __availcol [0,1,0,0.3]
#define __notavailcol [1,0,0,0.2]

private _disp = uiNamespace getVariable "d_RscSupportL";
if (isNil "_disp" || {isNull _disp}) then {
	"d_RscSupportL" cutRsc ["d_RscSupportL", "PLAIN"];
	_disp = uiNamespace getVariable "d_RscSupportL";
};

private _ctrl = _disp displayCtrl 50;
if (d_player_can_call_arti > 0) then {
#ifndef __TT__
	if (d_ari_available) then {
#else
	if (d_player_side == blufor && {d_ari_available_w} || {d_player_side == opfor && {d_ari_available_e}}) then {
#endif
		_ctrl ctrlShow true;
		_ctrl ctrlsettextcolor __availcol;
	} else {
		_ctrl ctrlShow false;
		//_ctrl ctrlsettextcolor __notavailcol;
	};
} else {
	_ctrl ctrlShow false;
};

_ctrl = _disp displayCtrl 51;
if (d_player_can_call_drop > 0) then {
	if (d_para_available) then {
		_ctrl ctrlShow true;
		_ctrl ctrlsettextcolor __availcol;
	} else {
		_ctrl ctrlShow false;
		//_ctrl ctrlsettextcolor __notavailcol;
	};
} else {
	_ctrl ctrlShow false;
};

_ctrl = _disp displayCtrl 52;
if (d_player_can_call_cas > 0) then {
#ifndef __TT__
	if (d_cas_available) then {
#else
	if (d_player_side == blufor && {d_cas_available_w} || {d_player_side == opfor && {d_cas_available_e}}) then {
#endif
		_ctrl ctrlShow true;
		_ctrl ctrlsettextcolor __availcol;
	} else {
		_ctrl ctrlShow false;
		//_ctrl ctrlsettextcolor __notavailcol;
	};
} else {
	_ctrl ctrlShow false;
};
