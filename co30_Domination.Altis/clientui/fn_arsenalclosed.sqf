// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_arsenalclosed.sqf"
#include "..\x_setup.sqf"

d_arsenal_opened = false;

__TRACE_1("","d_arsenal_opened")

if !((d_remove_from_arsenal # 3) isEqualTo []) then {
	private _unip = uniform player;
	if (_unip != "") then {
		private _resg = (d_remove_from_arsenal # 3) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _bp call _x;
			} else {
				if (_bp == _x) then {
					_res = true;
				};
			};
			_res
		};
		if (_resg != -1) then {
			removeUniform player;
		};
	};
};

if !((d_remove_from_arsenal # 4) isEqualTo []) then {
	private _unip = vest player;
	if (_unip != "") then {
		private _resg = (d_remove_from_arsenal # 4) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _bp call _x;
			} else {
				if (_bp == _x) then {
					_res = true;
				};
			};
			_res
		};
		if (_resg != -1) then {
			removeVest player;
		};
	};
};

if (d_no_mortar_ar == 1) then {
	if !((d_remove_from_arsenal # 5) isEqualTo []) then {
		private _bp = backpack player;
		private _resg = (d_remove_from_arsenal # 5) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _bp call _x;
			} else {
				if (_bp == _x) then {
					_res = true;
				};
			};
			_res
		};
		if (_resg != -1) then {
			removeBackpack player;
		};
	};
};

if !((d_remove_from_arsenal # 6) isEqualTo []) then {
	private _unip = headgear player;
	if (_unip != "") then {
		private _resg = (d_remove_from_arsenal # 6) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _bp call _x;
			} else {
				if (_bp == _x) then {
					_res = true;
				};
			};
			_res
		};
		if (_resg != -1) then {
			removeHeadgear player;
		};
	};
};

call d_fnc_save_respawngear;
call d_fnc_save_layoutgear;
[player, getUnitLoadout player, d_player_side] remoteExecCall ["d_fnc_storeploadout", 2];
if (!isNil "d_arsenal_nvg_used") then {
	d_arsenal_nvg_used = nil;
	camUseNVG false;
};
if (d_with_ranked) then {
	call d_fnc_store_rwitems;
};
if (player getVariable ["d_currentvisionmode", 0] == 1 && {player call d_fnc_hasnvgoggles}) then {
	player action ["NVGoggles", player];
};