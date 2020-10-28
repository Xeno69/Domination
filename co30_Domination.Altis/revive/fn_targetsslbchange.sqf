// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_targetsslbchange.sqf"
#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

disableSerialization;
private _selIdx = _this select 1;
if (_selIdx == -1) exitWith {};
private _data = lbData [1000, _selIdx];
__TRACE_1("","_data")
if (_data == xr_spectcamtargetstr) exitWith {};
private _unit = objectFromNetId _data;
if (isNil "_unit" || {isNull _unit}) exitWith {};
__TRACE_1("","_unit")
xr_spectcamtargetstr = _data;
xr_spectcamtarget = _unit;
private _posunit = ASLToATL (visiblePositionASL (vehicle _unit));
_posunit set [2, 2];
xr_spectcam camSetTarget xr_spectcamtarget;
xr_spectcam camSetPos _posunit;
xr_spectcam cameraEffect ["INTERNAL", "Back"];
xr_spectcam camCommit 0;
ctrlSetText [1010, lbText [1000, _selIdx]];