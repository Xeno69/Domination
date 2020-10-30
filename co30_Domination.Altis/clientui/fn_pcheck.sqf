// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_pcheck.sqf"
#include "..\x_setup.sqf"

if (!d_with_ranked) then {
	private _prw = player getVariable "d_pprimweap";
	private _primweap = primaryWeapon player;
	__TRACE_2("","_prw","_primweap")
	if (_primweap != "" && {_prw != _primweap}) then {
		private _origprimw = _primweap;
		
		_primweap = _primweap call d_fnc_correctwname;
		
		if ((bis_fnc_arsenal_data # 0) find _primweap == -1) then {
			__TRACE("Prim weap not found")
			player removeWeapon _origprimw;
			player addWeapon _prw;
			
			private _secits = player getVariable "d_pprimweapitems";
			if !(primaryWeaponItems player isEqualTo _secits) then {
				removeAllPrimaryWeaponItems player;
				{player addPrimaryWeaponItem _x} forEach (_secits select {_x != ""});
			};
		};
	};

	private _psw = player getVariable "d_psecweap";
	private _secweap = secondaryWeapon player;
	__TRACE_2("","_psw","_secweap")
	if (_secweap != "" && {_psw != _secweap}) then {
		__TRACE("in sec")
		private _origsw = _secweap;
		
		_secweap = _secweap call d_fnc_correctwname;
		
		if ((bis_fnc_arsenal_data # 1) find _secweap == -1) then {
			__TRACE("Sec weap not found")
			player removeWeapon _origsw;
			player addWeapon _psw;
			
			private _secits = player getVariable "d_psecweapitems";
			if !(secondaryWeaponItems player isEqualTo _secits) then {
				{
					player removeSecondaryWeaponItem _x;
				} forEach (secondaryWeaponItems player);
				{player addSecondaryWeaponItem _x} forEach (_secits select {_x != ""});
			};
		};
	};

	private _phw = player getVariable "d_phandgweap";
	private _hgweap = handgunWeapon player;
	__TRACE_2("","_phw","_hgweap")
	if (_hgweap != "" && {_phw != _hgweap}) then {
		private _orighgw = _hgweap;
		
		_hgweap = _hgweap call d_fnc_correctwname;
		
		if ((bis_fnc_arsenal_data # 2) find _hgweap == -1) then {
			__TRACE("Handgun weap not found")
			player removeWeapon _orighgw;
			player addWeapon _phw;
			
			private _secits = player getVariable "d_phandgweapitems";
			if !(handgunItems player isEqualTo _secits) then {
				removeAllHandgunItems player;
				{player addHandgunItem _x} forEach (_secits select {_x != ""});
			};
		};
	};

	call d_fnc_store_rwitems;
};

// uniform
if !((bis_fnc_arsenal_data # 3) isEqualTo []) then {
	private _unip = uniform player;
	__TRACE_1("","_unip")
	if (_unip != "") then {
		if ((bis_fnc_arsenal_data # 3) find _unip == -1) then {
			private _ounip = player getVariable "d_uniformp";
			__TRACE_1("","_ounip")		
			if (!isNil "_ounip") then {
				__TRACE("removing uniform")
				if (_ounip == _unip || {_ounip == ""}) exitWith {};
				removeUniform player;
				player addUniform _ounip;
			};
		};
	};
};
// vest
if !((bis_fnc_arsenal_data # 4) isEqualTo []) then {
	private _vest = vest player;
	__TRACE_1("","_vest")
	if (_vest != "") then {
		if ((bis_fnc_arsenal_data # 4) find _vest == -1) then {
			private _ovestp = player getVariable "d_vestp";
			__TRACE_1("","_ovestp")		
			if (!isNil "_ovestp") then {
				__TRACE("removing vest")
				if (_ovestp == _vest || {_ovestp == ""}) exitWith {};
				removeVest player;
				player addVest _ovestp;
			};
		};
	};
};
// headgear
if !((bis_fnc_arsenal_data # 6) isEqualTo []) then {
	private _headg = headgear player;
	__TRACE_1("","_headg")
	if (_headg != "") then {
		if ((bis_fnc_arsenal_data # 6) find _headg == -1) then {
			private _ohgp = player getVariable "d_headgearp";
			__TRACE_1("","_ohgp")		
			if (!isNil "_ohgp") then {
				__TRACE("removing headgear")
				if (_ohgp == _headg || {_ohgp == ""}) exitWith {};
				removeHeadgear player;
				player addHeadgear _ohgp;
			};
		};
	};
};
// backpack
if !((bis_fnc_arsenal_data # 5) isEqualTo []) then {
	private _bpp = backpack player;
	__TRACE_1("","_bpp")
	if (_bpp != "") then {
		if ((bis_fnc_arsenal_data # 5) find _bpp == -1) then {
			private _obpp = player getVariable "d_backpackp";
			__TRACE_1("","_obpp")		
			if (!isNil "_obpp") then {
				__TRACE("removing backpack")
				if (_obpp == _bpp || {_obpp == ""}) exitWith {};
				removeBackpack player;
				player addBackpack _obpp;
			};
		};
	};
};
// goggles
private _goggs = goggles player;
__TRACE_1("","_goggs")
if (_goggs != "") then {
	if ((bis_fnc_arsenal_data # 7) isEqualTo []) then {
		removeGoggles player;
	};
	if ((bis_fnc_arsenal_data # 7) find _goggs == -1) then {
		removeGoggles player;
		private _ogoggs = player getVariable "d_gogglesp";
		__TRACE_1("","_ogoggs")
		if (!isNil "_ogoggs" && {_goggs != _ogoggs && {_ogoggs != ""}}) then {
			player addGoggles _ogoggs;
		};
	};
};
// hmd
private _phmd = hmd player;
if (_phmd != "") then {
	if ((bis_fnc_arsenal_data # 8) isEqualTo []) exitWith {
		player unlinkItem _phmd;
	};
	if ((bis_fnc_arsenal_data # 8) find _phmd == -1) then {
		private _ophmd = player getVariable "d_hmdp";
		if (!isNil "_ophmd" && {_phmd != _ophmd && {_ophmd != ""}}) then {
			player linkItem _ophmd;
		};
	};
};
// binoculars
private _pbino = binocular player;
if (_pbino != "") then {
	if ((bis_fnc_arsenal_data # 9) isEqualTo []) exitWith {
		player removeWeapon _pbino;
	};
	if ((bis_fnc_arsenal_data # 9) find _pbino == -1) then {
		player removeWeapon _pbino;
		private _obino = player getVariable "d_binocularp";
		if (!isNil "_obino" && {_pbino != _obino && {_obino != ""}}) then {
			player addWeapon _obino;
		};
	};
};

// todo -> Move through optics