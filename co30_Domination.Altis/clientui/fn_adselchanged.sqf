// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#define __CTRL2(A) ((uiNamespace getVariable "d_AdminDialog") displayCtrl A)

disableSerialization;

if (!d_pisadminp && {isMultiplayer}) exitWith {
	[player, d_name_pl, 3] remoteExecCall ["d_fnc_KickPlayerBS", 2];
};

params ["_selection"];

private _selIdx = _selection # 1;
if (_selIdx == -1) exitWith {};

_selection params ["_control"];
_control ctrlEnable false;
private _unit = missionNamespace getVariable (_control lbData _selIdx);
d_a_d_cur_uid = getPlayerUID _unit;
d_a_d_cur_unit_name = name _unit;
d_a_d_netid = netId _unit;
__TRACE_1("adselchanged","_unit")
d_u_r_inf = nil;
d_a_d_cur_name = _control lbText _selIdx;
private _ctrlinfo = __CTRL2(1002);
_ctrlinfo ctrlSetText format [localize "STR_DOM_MISSIONSTRING_689", d_a_d_cur_name];
d_a_d_cur_uid remoteExecCall ["d_fnc_GetAdminArray", 2];

["d_admin_marker", [0,0,0],"ICON","ColorBlack",[1,1],"",0,"hd_dot"] call d_fnc_CreateMarkerLocal;
"d_admin_marker" setMarkerTextLocal d_a_d_cur_name;
private _posunit = visiblePositionASL _unit;
"d_admin_marker" setMarkerPosLocal _posunit;

private _ctrl = __CTRL2(11010);
_ctrl ctrlmapanimadd [0.0, 1.00, getPosWorld (vehicle player)];
_ctrl ctrlmapanimadd [1.2, 1.00, _posunit];
_ctrl ctrlmapanimadd [0.5, 0.30, _posunit];
ctrlmapanimcommit _ctrl;

private _endtime = time + 30;
waitUntil {!isNil "d_u_r_inf" || {!d_admin_dialog_open || {!alive player || {time > _endtime}}}};

if ((!isNil "d_u_r_inf" && {d_u_r_inf isEqualTo []}) || {!d_admin_dialog_open || {!alive player || {time > _endtime}}}) exitWith {};

_control ctrlEnable true;

if (!isNil "d_u_r_inf" && {d_u_r_inf isEqualTo []}) exitWith {_ctrlinfo ctrlSetText format [localize "STR_DOM_MISSIONSTRING_690", d_a_d_cur_name]};

_ctrlinfo ctrlSetText format [localize "STR_DOM_MISSIONSTRING_691", d_a_d_cur_name];

__CTRL2(1003) ctrlSetText d_a_d_cur_name;
__CTRL2(1004) ctrlSetText d_a_d_cur_uid;
__CTRL2(1005) ctrlSetText str _unit;

private _sel = 7;
__CTRL2(1006) ctrlSetText str(d_u_r_inf # _sel);
__CTRL2(1009) ctrlSetText str(score _unit);
__CTRL2(1007) ctrlEnable ((d_u_r_inf # _sel) >= 1);
__CTRL2(1008) ctrlEnable (d_a_d_cur_name != d_name_pl);
__CTRL2(1010) ctrlEnable (d_a_d_cur_name != d_name_pl);
