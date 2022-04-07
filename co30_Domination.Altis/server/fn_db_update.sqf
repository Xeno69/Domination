// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (_this # 1 == 0) exitWith {
	call {
		if (d_db_type == 0) exitWith {
			"extdb3" callExtension format ["1:dom:revivesAdd:%1", _this # 0];
		};
		if (d_db_type == 1) exitWith {
			["revivesAdd", [_this # 0]] call d_fnc_queryconfigasync;
		};
		if (d_db_type == 2) exitWith {
			private _tmphash = missionProfileNamespace getVariable "d_player_hashmap";
			if (!isNil "_tmphash") then {
				private _tmpar = _tmphash get (_this # 0);
				if (!isNil "_tmpar") then {
					_tmpar set [13, (_tmpar # 13) + 1];
				};
			};
		};
	};
};
