// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initvecdialog.sqf"
#include "..\x_setup.sqf"

#define __control(numcontrol) (_display displayCtrl numcontrol)

disableSerialization;

private _vec = d_curvec_dialog;
private _caller = d_curcaller_dialog;

private _display = uiNamespace getVariable "d_VecDialog";

if (getText ((configOf _vec)>>"picture") != "picturestaticobject") then {
	__control(44444) ctrlSetText getText ((configOf _vec)>>"picture");
} else {
	__control(44444) ctrlSetText "";
};

private _vec_name = _vec getVariable "d_vec_name";
if (isNil "_vec_name") then {
	_vec_name = localize "STR_DOM_MISSIONSTRING_11";
} else {
	if (_vec_name == "") then {_vec_name = localize "STR_DOM_MISSIONSTRING_11"};
};

__control(44446) ctrlSetText getText(configFile>>"CfgVehicleIcons">>getText (configFile>>"CfgVehicles">>d_the_box>>"icon"));
__control(44445) ctrlSetText _vec_name;

private _hasbox = _vec getVariable ["d_ammobox", false];
private _ttyp = toLowerANSI (typeOf _vec);

private _canloadunloadbox = _vec getVariable ["d_canloadbox", false];
if (_canloadunloadbox) then {
	if (_hasbox) then {
		__control(44447) ctrlSetText "pics\objective_complete_ca.paa";
		__control(44452) ctrlEnable false;
	} else {
		__control(44447) ctrlSetText "pics\objective_incomplete_ca.paa";
		__control(44448) ctrlEnable false;
	};
} else {
	__control(44452) ctrlEnable false;
	__control(44448) ctrlEnable false;
};

private _move_controls = false;

private _ismhq = _vec getVariable ["d_vec_type", ""] == "MHQ";

if (_caller != currentPilot _vec) then {
	if (_ismhq) then {
		if !(_caller in _vec) then {
			lbClear 44449;
			{
				private _index = __control(44449) lbAdd ([_x, "CfgVehicles"] call d_fnc_GetDisplayName);
				__control(44449) lbSetPicture [_index, getText(configFile>>"cfgVehicles">>_x>>"picture")];
				__control(44449) lbSetColor [_index, [1, 1, 0, 0.5]];
			} forEach d_create_bike;

			__control(44449) lbSetCurSel 0;
		} else {
			_move_controls = true;
		};
	};
} else {
	_move_controls = true;
};

if (!_move_controls && {!isNil {_vec getVariable "d_choppertype"}}) then {_move_controls = true};

if (d_WithMHQTeleport == 1) then {
	__control(44453) ctrlShow false;
};

if (_move_controls) then {
	__control(44453) ctrlShow false;
	__control(44449) ctrlShow false;
	__control(44451) ctrlShow false;
	__control(44450) ctrlShow false;
	__control(44459) ctrlShow false;
	__control(44460) ctrlShow false;
	__control(44462) ctrlShow false;

	private _control = __control(44454);
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.14);
	_control ctrlCommit 0;

	_control = __control(44446);
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = __control(44447);
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = __control(44448);
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;

	_control = __control(44452);
	_control ctrlSetPositionX (((ctrlPosition _control) # 0) + 0.17);
	_control ctrlCommit 0;
} else {
	if (_vec getVariable ["d_MHQ_Deployed", false]) then {
		__control(44462) ctrlSetText (localize "STR_DOM_MISSIONSTRING_610");
		if (_hasbox) then {
			__control(44448) ctrlEnable true;
			__control(44452) ctrlEnable false;
		} else {
			__control(44448) ctrlEnable false;
			__control(44452) ctrlEnable true;
		};
		__control(44464) ctrlShow false;
		__control(44466) ctrlShow false;
	} else {
		__control(44453) ctrlEnable false;
		__control(44459) ctrlEnable false;
		__control(44451) ctrlEnable false;
		__control(44449) ctrlEnable false;
		__control(44460) ctrlEnable false;
		if (_ismhq) then {
			if (d_with_mhq_camo == 0 && {!(_vec isKindOf "Air") && {!(_vec isKindOf "Ship")}}) then {
				__control(44464) cbSetChecked d_deploy_mhq_camo;
				__control(44464) ctrlAddEventHandler ["CheckedChanged", {
					d_deploy_mhq_camo = !d_deploy_mhq_camo;
				}];
			} else {
				__control(44464) ctrlShow false;
				__control(44466) ctrlShow false;
			};
		} else {
			__control(44464) ctrlShow false;
			__control(44466) ctrlShow false;
		};
	};
};

if (d_ifa3lite || {d_gmcwg || {d_unsung}}) then {
	__control(44459) ctrlShow false;
	__control(44460) ctrlShow false;
};

if (_vec isKindOf "Ship") then {
	if (ctrlShown __control(44452)) then {
		__control(44452) ctrlEnable false;
	};
	if (ctrlShown __control(44462)) then {
		__control(44462) ctrlEnable false;
	};
};

0 spawn {
	scriptName "spawn_initvecdialog";
	waitUntil {!isNil "d_vec_dialog_open" && {!d_vec_dialog_open || {!d_player_canu}}};

	if (d_vec_dialog_open) then {closeDialog 0};
};