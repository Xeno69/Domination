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
	if (_unip != "") then {
		if ((bis_fnc_arsenal_data # 3) find _unip == -1) then {
			removeUniform player;
			private _ounip = player getVariable "d_uniformp";
			if (!isNil "_ounip" && {_unip != _ounip && {_ounip != ""}}) then {
				player addUniform _ounip;
			};
		};
	};
};
// vest
if !((bis_fnc_arsenal_data # 4) isEqualTo []) then {
	private _vest = vest player;
	if (_vest != "") then {
		if ((bis_fnc_arsenal_data # 4) find _vest == -1) then {
			removeVest player;
			private _ovestp = player getVariable "d_vestp";
			if (!isNil "_ovestp" && {_vest != _ovestp && {_ovestp != ""}}) then {
				player addVest _ovestp;
			};
		};
	};
};
// headgear
if !((bis_fnc_arsenal_data # 6) isEqualTo []) then {
	private _headg = headgear player;
	if (_headg != "") then {
		if ((bis_fnc_arsenal_data # 6) find _headg == -1) then {
			removeHeadgear player;
			private _ohgp = player getVariable "d_headgearp";
			if (!isNil "_ohgp" && {_headg != _ohgp && {_ohgp != ""}}) then {
				player addHeadgear _ohgp;
			};
		};
	};
};
// backpack
if !((bis_fnc_arsenal_data # 5) isEqualTo []) then {
	private _bpp = backpack player;
	if (_bpp != "") then {
		if ((bis_fnc_arsenal_data # 5) find _bpp == -1) then {
			removeBackpack player;
			private _obpp = player getVariable "d_backpackp";
			if (!isNil "_obpp" && {_bpp != _obpp && {_obpp != ""}}) then {
				player addBackpack _obpp;
			};
		};
	};
};
// goggles
private _goggs = goggles player;
if (_goggs != "") then {
	if ((bis_fnc_arsenal_data # 7) isEqualTo []) then {
		removeGoggles player;
	};
	if ((bis_fnc_arsenal_data # 7) find _goggs == -1) then {
		removeGoggles player;
		private _ogoggs = player getVariable "d_gogglesp";
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