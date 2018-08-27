// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_initpylonloadoutdialog.sqf"
#include "..\..\..\x_setup.sqf"

#define __control(numcontrol) (_display displayCtrl numcontrol)

disableSerialization;

private _vec = d_pylon_vec;

private _display = uiNamespace getVariable "D_PylonLoadoutDialog";

private _cfg = configFile>>"CfgVehicles">>(typeOf _vec)>>"Components">>"TransportPylonsComponent";
__TRACE_1("","_cfg")

#ifdef __DEBUG__
_mmm = getText(_cfg>>"UIPicture");
__TRACE_1("","_mmm")
#endif
__control(1000) ctrlSetText getText(_cfg>>"UIPicture");
__control(1003) ctrlSetText getText(configFile>>"CfgVehicles">>(typeOf _vec)>>"Displayname");

private _pylons = _cfg>>"pylons";
__TRACE_1("","_pylons")

private _pylonmags = getPylonMagazines _vec;
_vec setVariable ["d_startpylongmags", _pylonmags];

__TRACE_1("","_pylonmags")

d_pylondialog_ctrls = [];
d_pylon_mirrormode = false;

private _excludemags = getArray(getMissionConfig "CfgVehicles">>(typeOf _vec)>>"TransportPylons">>"excludeMagazines") apply {toUpper _x};
__TRACE_1("","_excludemags")

for "_i" from 0 to (count _pylons - 1) do {
	private _pylon = _pylons select _i;
	private _ctrl = _display ctrlCreate ["RscUIComboBox2", 5000 + _i];
	d_pylondialog_ctrls pushBack _ctrl;
	private _mirrorpos = getNumber(_pylon>>"mirroredMissilePos");
	if(_mirrorpos > 0) then {
		(d_pylondialog_ctrls select (_mirrorpos - 1)) setVariable ["d_mirrorctrl", _ctrl];
	} else {
		_ctrl ctrlAddEventHandler ["LBSelChanged", {
			if (d_pylon_mirrormode) then {
				params ["_ctrl", "_selIdx"];
				private _mirror = _ctrl getVariable "d_mirrorctrl";
				if (!isNil "_mirror") then {
					_mirror lbSetCurSel _selIdx;
				};
			};
		}];
	};
	private _pos = getArray(_pylon>>"UIposition");
	{
		__TRACE_1("","_x")
		if (_x isEqualType "") then {
			private _arspl = _x splitString "+";
			__TRACE_1("+","_arspl")
			private _numte = 0;
			if (count _arspl > 1) then {
				{
					_numte = _numte + parseNumber _x;
				} forEach _arspl;
			} else {
				_arspl = _x splitString "-";
				__TRACE_1("-","_arspl")
				{
					_numte = _numte + parseNumber _x;
				} forEach _arspl;
			};
			__TRACE_1("","_numte")
			_pos set [_forEachIndex, _numte];
		};
	} forEach _pos;
	_pos pushBack 0.17;
	_pos pushBack 0.032;
	_pos set [0, (_pos select 0) + 0.062];
	_pos set [1, (_pos select 1) + 0.18];
	_ctrl ctrlSetPosition _pos;
	_ctrl ctrlCommit 0;
	private _idx = _ctrl lbAdd ("<" + (localize "STR_empty") + ">");
	_ctrl lbSetData [_idx, ""];
	private _selidx = 0;
	__TRACE_1("","_vec getCompatiblePylonMagazines (configName _pylon)")
	{
		__TRACE_1("33","_x")
		if !(toUpper _x in _excludemags) then {
			__TRACE_1("adding","_x")
			_idx = _ctrl lbAdd getText(configFile>>"CfgMagazines">>_x>>"displayname");
			_ctrl lbSetData [_idx, _x];
			//__TRACE_3("","count _pylonmags","_i","_pylonmags select _i")
			if (_pylonmags select _i == _x) then {
				_selidx = _i;
			};
		};
	} forEach (_vec getCompatiblePylonMagazines (configName _pylon));
	if (_selidx != -1) then {
		_ctrl lbSetCurSel _selidx;
	};
};

private _presets = _cfg>>"Presets";
private _ctrl = _display displayCtrl 1001;
private _idx = _ctrl lbAdd "Custom";

for "_i" from 0 to (count _presets - 1) do {
	private _preset = _presets select _i;
	__TRACE_1("","_preset")
	private _idx = _ctrl lbAdd getText(_preset>>"displayName");
	_ctrl lbSetData [_idx, configName _preset];
};
_ctrl lbSetCurSel 0;