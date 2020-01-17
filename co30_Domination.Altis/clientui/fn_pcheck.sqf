// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pcheck.sqf"
#include "..\x_setup.sqf"

if !((d_remove_from_arsenal # 3) isEqualTo []) then {
	private _unip = uniform player;
	if (_unip != "") then {
		private _resg = (d_remove_from_arsenal # 3) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _unip call _x;
			} else {
				if (_unip == _x) then {
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
	private _vestp = vest player;
	if (_vestp != "") then {
		private _resg = (d_remove_from_arsenal # 4) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _vestp call _x;
			} else {
				if (_vestp == _x) then {
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
		if (_bp != "") then {
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
};

if !((d_remove_from_arsenal # 6) isEqualTo []) then {
	private _hgp = headgear player;
	if (_hgp != "") then {
		private _resg = (d_remove_from_arsenal # 6) findIf {
			private _res = false;
			if (_x isEqualType {}) then {
				_res = _hgp call _x;
			} else {
				if (_hgp == _x) then {
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
