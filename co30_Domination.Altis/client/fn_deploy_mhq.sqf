// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_deploy_mhq.sqf"
#include "..\x_setup.sqf"

__TRACE("Starting")

if (!hasInterface || {!alive player || {isNil "d_curvec_dialog" || {isNull d_curvec_dialog || {!alive d_curvec_dialog}}}}) exitWith {
	__TRACE("Exiting deply_mhq 1")
};

private _mhq = objNull;
private _dd = 599;
{
	private _distt = _x distance2D player;
	if (_distt < _dd) then {
		_mhq = _x;
		_dd = _distt;
	};
} forEach ((player nearEntities [["LandVehicle", "Air", "Ship"], 10]) select {!isNull _x && {!(_x isKindOf "ParachuteBase") && {(_x getVariable ["d_vec_type", ""]) == "MHQ"}}});

if (isNull _mhq) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_1451")};

#ifndef __TT__
if (_mhq inArea d_base_array || {!(d_curvec_dialog isKindOf "Ship") && {surfaceIsWater (getPosATLVisual d_curvec_dialog)}}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_213")};
#else
if (_mhq inArea (d_base_array # 0) || {_mhq inArea (d_base_array # 1) || {!(d_curvec_dialog isKindOf "Ship") && {surfaceIsWater (getPosATLVisual d_curvec_dialog)}}}) exitWith {systemChat (localize "STR_DOM_MISSIONSTRING_213")};
#endif

if ((_mhq getVariable ["d_MHQ_Depltime", -1]) > time) exitWith {
	systemChat (format [localize "STR_DOM_MISSIONSTRING_214", abs round (time - (_mhq getVariable ["d_MHQ_Depltime", -1]))])
};

__TRACE("Before reading deploy var")

disableSerialization;
private _disp = uiNamespace getVariable "d_VecDialog";

if !(_mhq getVariable ["d_MHQ_Deployed", false]) then {
	__TRACE("MHQ not deployed")
	if ((crew _mhq) findIf {alive _x} > -1) then {
		{moveOut _x} forEach (crew _mhq);
		//systemChat (localize "STR_DOM_MISSIONSTRING_215");
		__TRACE("MHQ not empty")
	};

	if (d_with_mhq_camo == 0 && {d_deploy_mhq_camo && {!(_mhq isKindOf "Air") && {!(_mhq isKindOf "Ship")}}}) then {
		_mhq remoteExecCall ["d_fnc_mhq_net", 2];
	};
	_mhq setVariable ["d_MHQ_Deployed", true, true];
	[_mhq, true] remoteExecCall ["d_fnc_mhqdepls", 2];
	_mhq setVariable ["d_MHQ_Depltime", time + 10, true];
	[_mhq, false] remoteExecCall ["engineOn", _mhq];
	
	(_disp displayCtrl 44453) ctrlEnable true;
	if (!d_ifa3lite && {!d_gmcwg && {!d_unsung}}) then {
		(_disp displayCtrl 44459) ctrlEnable true;
		(_disp displayCtrl 44460) ctrlEnable true;
	};
	(_disp displayCtrl 44462) ctrlSetText (localize "STR_DOM_MISSIONSTRING_610");
	(_disp displayCtrl 44449) ctrlEnable true;
	(_disp displayCtrl 44451) ctrlEnable true;
} else {
	__TRACE("MHQ deployed")
	private _camo = _mhq getVariable ["d_MHQ_Camo", objNull];
	if (!isNull _camo) then {deleteVehicle _camo};
	_mhq setVariable ["d_MHQ_Deployed", nil, true];
	[_mhq, false] remoteExecCall ["d_fnc_mhqdepls", 2];
	_mhq setVariable ["d_MHQ_Depltime", time + 10, true];
	
	(_disp displayCtrl 44453) ctrlEnable false;
	if (!d_ifa3lite && {!d_gmcwg && {!d_unsung}}) then {
		(_disp displayCtrl 44459) ctrlEnable false;
		(_disp displayCtrl 44460) ctrlEnable false;
	};
	(_disp displayCtrl 44462) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1328");
	(_disp displayCtrl 44449) ctrlEnable false;
	(_disp displayCtrl 44451) ctrlEnable false;
};

__TRACE("End")