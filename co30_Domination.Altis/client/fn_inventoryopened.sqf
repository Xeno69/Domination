// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_inventoryopened.sqf"
#include "..\x_setup.sqf"

if (!hasInterface || {d_inventory_blocked}) exitWith {
	true
};

__TRACE_1("","_this")
private _box = _this select 1;

if (!isNil {_box getVariable "d_islocked"} && {_box getVariable "d_islocked" != player}) exitWith {
	hintSilent (localize "STR_DOM_MISSIONSTRING_1945");
	true
};

if (_box getVariable ["d_player_ammobox", false]) then {
	private _canopen = true;
	private _perc = _box getVariable "d_abox_perc";
	if (!isNil "_perc") then {
		__TRACE("Calling sub box")
		_box remoteExecCall ["d_fnc_sub_box", 2];
		if (_perc == 0) then {
			_canopen = false;
		};		
	};
	if (_canopen) then {
		_box spawn {
			scriptName "spawn_inventoryopened1";
			if (!d_with_ranked) then {
				if (!d_with_ace) then {
					["Open", true] call bis_fnc_arsenal;
				} else {
					[player, player, true] call ace_arsenal_fnc_openBox;
				};
			} else {
				["Open", [nil, player]] call bis_fnc_arsenal;
			};
		};
	};
	true
} else {
	if (!d_with_ace && {_this select 0 == player}) then {
		0 spawn {
			scriptName "spawn_inventoryopened2";
			private _disp = displayNull;
			waitUntil {_disp = findDisplay 602;!isNull _disp || {!alive player || {player getVariable ["xr_pluncon", false]}}};

			if (!alive player || {player getVariable ["xr_pluncon", false]}) exitWith {};

			private _ctrl = _disp ctrlCreate ["RscButtonMenu", 12000];

			private _sfwh = (safezoneW / safezoneH) min 1.2;
			private _xpos = 14.6 * (_sfwh / 40) + (safezoneX + (safezoneW - _sfwh) / 2);
			private _ypos = 24.3 * ((_sfwh / 1.2) / 25) + (safezoneY + (safezoneH - (_sfwh / 1.2)) / 2);
			private _w = 9.6 * (_sfwh / 40);
			private _h = 1.2 * ((_sfwh / 1.2) / 25);

			_ctrl ctrlSetPosition [_xpos, _ypos, _w, _h];

			_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_1940");

			_ctrl ctrlAddEventHandler ["ButtonClick", {
				hintSilent parseText format ["<t color='#00ff00' size='1.5' align='center'>%1</t>", localize "STR_DOM_MISSIONSTRING_1941"];
				(findDisplay 602) closeDisplay 1;
				0 spawn d_fnc_repack_mags;
			}];

			_ctrl ctrlCommit 0;

			_ctrl = _disp ctrlCreate ["RscButtonMenu", 12001];

			_xpos = 25.6 * (_sfwh / 40) + (safezoneX + (safezoneW - _sfwh) / 2);
			_ypos = 24.3 * ((_sfwh / 1.2) / 25) + (safezoneY + (safezoneH - (_sfwh / 1.2)) / 2);
			_w = 9.6 * (_sfwh / 40);
			_h = 1.2 * ((_sfwh / 1.2) / 25);

			_ctrl ctrlSetPosition [_xpos, _ypos, _w, _h];

			_ctrl ctrlAddEventHandler ["ButtonClick", {
				private _bpc = backpackContainer player;
				if (!isNil {_bpc getVariable "d_islocked"}) then {
					_bpc setVariable ["d_islocked", nil, true];
					(_this select 0) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1943");
				} else {
					_bpc setVariable ["d_islocked", player, true];
					(_this select 0)  ctrlSetText (localize "STR_DOM_MISSIONSTRING_1944");
				};
			}];

			_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_1943");

			if (!isNull backpackContainer player) then {
				if (!isNil {(backpackContainer player) getVariable "d_islocked"}) then {
					_ctrl ctrlSetText (localize "STR_DOM_MISSIONSTRING_1944");
				};
			} else {
				_ctrl ctrlEnable false;
			};
			_ctrl ctrlCommit 0;

			uiNamespace setVariable ["d_bplock_button", _ctrl];
			d_inventory_open = true;

			0 spawn {
				scriptName "spawn_inventoryopened5";

				private _ctrl = uiNamespace getVariable "d_bplock_button";
				private _prevcontainer = backpackContainer player;

				while {!isNil "d_inventory_open"} do {
					if (_prevcontainer != backpackContainer player) then {
						_prevcontainer = backpackContainer player;
						if (isNull _prevcontainer) then {
							_ctrl ctrlEnable false;
						} else {
							_ctrl ctrlEnable true;
						};
					};
					sleep 0.2;
				};
				__TRACE("stopped")
			};
		};
	};
	false
};
