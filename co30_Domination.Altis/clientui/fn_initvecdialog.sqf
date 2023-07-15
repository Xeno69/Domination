// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

disableSerialization;

private _vec = d_curvec_dialog;
private _caller = d_curcaller_dialog;

private _disp = uiNamespace getVariable "d_VecDialog";

if (getText ((configOf _vec)>>"picture") != "picturestaticobject") then {
	(_disp displayCtrl 44444) ctrlSetText getText ((configOf _vec)>>"picture");
} else {
	(_disp displayCtrl 44444) ctrlSetText "";
};

private _vec_name = _vec getVariable "d_vec_name";
if (isNil "_vec_name") then {
	_vec_name = localize "STR_DOM_MISSIONSTRING_11";
} else {
	if (_vec_name == "") then {_vec_name = localize "STR_DOM_MISSIONSTRING_11"};
};

(_disp displayCtrl 44446) ctrlSetText getText(configFile>>"CfgVehicleIcons">>getText (configFile>>"CfgVehicles">>d_the_box>>"icon"));
(_disp displayCtrl 44445) ctrlSetText _vec_name;

private _hasbox = _vec getVariable ["d_ammobox", false];
private _ttyp = toLowerANSI (typeOf _vec);

private _canloadunloadbox = _vec getVariable ["d_canloadbox", false];
if (_canloadunloadbox) then {
	if (_hasbox) then {
		(_disp displayCtrl 44447) ctrlSetText "pics\objective_complete_ca.paa";
		(_disp displayCtrl 44452) ctrlEnable false;
	} else {
		(_disp displayCtrl 44447) ctrlSetText "pics\objective_incomplete_ca.paa";
		(_disp displayCtrl 44448) ctrlEnable false;
	};
} else {
	(_disp displayCtrl 44452) ctrlEnable false;
	(_disp displayCtrl 44448) ctrlEnable false;
};

private _move_controls = false;

private _ismhq = _vec getVariable ["d_vec_type", ""] == "MHQ";

//__TRACE_1("","_ismhq")
//__TRACE_2("","_caller","currentPilot _vec")

if (_caller != currentPilot _vec) then {
	if (_ismhq) then {
		if !(_caller in _vec) then {
			lbClear 44449;
			{
				private _index = (_disp displayCtrl 44449) lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
				(_disp displayCtrl 44449) lbSetPicture [_index, getText(configFile>>"cfgVehicles">>_x>>"picture")];
				(_disp displayCtrl 44449) lbSetColor [_index, [1, 1, 0, 0.5]];
			} forEach d_create_bike;

			(_disp displayCtrl 44449) lbSetCurSel 0;
		} else {
			_move_controls = true;
		};
	};
} else {
	_move_controls = true;
};

//__TRACE_1("1","_move_controls")
if (!_move_controls && {!isNil {_vec getVariable "d_choppertype"}}) then {_move_controls = true};
//__TRACE_1("2","_move_controls")

if (d_WithMHQTeleport == 1) then {
	(_disp displayCtrl 44453) ctrlShow false;
};

if (_move_controls) then {
	(_disp displayCtrl 44453) ctrlShow false;
	(_disp displayCtrl 44449) ctrlShow false;
	(_disp displayCtrl 44451) ctrlShow false;
	(_disp displayCtrl 44450) ctrlShow false;
	(_disp displayCtrl 44459) ctrlShow false;
	(_disp displayCtrl 44460) ctrlShow false;
	(_disp displayCtrl 44462) ctrlShow false;
	(_disp displayCtrl 44467) ctrlShow false;

	private _control = _disp displayCtrl 44454;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.14);
	_control ctrlCommit 0;

	_control = _disp displayCtrl 44446;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = _disp displayCtrl 44447;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = _disp displayCtrl 44448;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = _disp displayCtrl 44452;
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;
} else {
	if (_vec getVariable ["d_MHQ_Deployed", false] || {_ismhq && {_vec isKindOf "Ship"}}) then {
		(_disp displayCtrl 44462) ctrlSetText (localize "STR_DOM_MISSIONSTRING_610");
		if (_hasbox) then {
			(_disp displayCtrl 44448) ctrlEnable true;
			(_disp displayCtrl 44452) ctrlEnable false;
		} else {
			(_disp displayCtrl 44448) ctrlEnable false;
			(_disp displayCtrl 44452) ctrlEnable true;
		};
		(_disp displayCtrl 44464) ctrlShow false;
		(_disp displayCtrl 44466) ctrlShow false;
	} else {
		(_disp displayCtrl 44453) ctrlEnable false;
		(_disp displayCtrl 44459) ctrlEnable false;
		(_disp displayCtrl 44451) ctrlEnable false;
		(_disp displayCtrl 44449) ctrlEnable false;
		(_disp displayCtrl 44460) ctrlEnable false;
		(_disp displayCtrl 44467) ctrlEnable false;
		if (_ismhq) then {
			if (d_with_mhq_camo == 0 && {!(_vec isKindOf "Air") && {!(_vec isKindOf "Ship")}}) then {
				(_disp displayCtrl 44464) cbSetChecked d_deploy_mhq_camo;
				(_disp displayCtrl 44464) ctrlAddEventHandler ["CheckedChanged", {
					d_deploy_mhq_camo = !d_deploy_mhq_camo;
				}];
			} else {
				(_disp displayCtrl 44464) ctrlShow false;
				(_disp displayCtrl 44466) ctrlShow false;
			};
			if (d_enable_extra_cas == 0) then {
				(_disp displayCtrl 44467) ctrlShow false;
			};
		} else {
			(_disp displayCtrl 44464) ctrlShow false;
			(_disp displayCtrl 44466) ctrlShow false;
			(_disp displayCtrl 44467) ctrlShow false;
		};
	};
};

if (d_ifa3 || {d_gmcwg || {d_unsung || {d_vn || {d_spe}}}}) then {
	(_disp displayCtrl 44459) ctrlShow false;
	(_disp displayCtrl 44460) ctrlShow false;
	(_disp displayCtrl 44467) ctrlShow false;
};

if (_vec isKindOf "Ship") then {
	if (ctrlShown (_disp displayCtrl 44452)) then {
		(_disp displayCtrl 44452) ctrlEnable false;
	};
	if (ctrlShown (_disp displayCtrl 44462)) then {
		(_disp displayCtrl 44462) ctrlEnable false;
	};
};

0 spawn {
	scriptName "spawn_initvecdialog";
	waitUntil {!isNil "d_vec_dialog_open" && {!d_vec_dialog_open || {!d_player_canu}}};

	if (d_vec_dialog_open) then {closeDialog 0};
};