// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ptakeweapon.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

__TRACE_1("","_this")

params ["_unit"];
if (_unit != player) exitWith {};

private _item = _this select 2;

if (d_without_nvg == 0 && {_item call d_fnc_isnvgoggles}) then {
	_unit unlinkItem _item;
};

if (!d_with_ranked) exitWith {};

private _cfgi = configFile>>"CfgWeapons">>_item;

if (!isClass(_cfgi)) exitWith {
	__TRACE_1("not of type weapon","_item")
};

//_item = toLower _item;
_item = toLowerANSI _item;

private _rank = rank player;
__TRACE_1("","_rank")
private _isvalid = _item in (d_misc_store getVariable (_rank + "_ONED"));

private _exit_it = false;
if (!_isvalid && {!(_item in d_non_check_items)}) then {
	private _prw = player getVariable "d_pprimweap";
	if (_prw != primaryWeapon player) then {
		player removeWeapon (primaryWeapon player);
		player addWeapon _prw;
		
		private _secits = player getVariable "d_pprimweapitems";
		if !(primaryWeaponItems player isEqualTo _secits) then {
			removeAllPrimaryWeaponItems player;
			{player addPrimaryWeaponItem _x} forEach (_secits select {_x != ""});
		};
		
		_exit_it = true;
	} else {
		private _psw = player getVariable "d_psecweap";
		if (_psw != secondaryWeapon player) then {
			player removeWeapon (secondaryWeapon player);
			player addWeapon _psw;
			
			private _secits = player getVariable "d_psecweapitems";
			if !(secondaryWeaponItems player isEqualTo _secits) then {
				// removeAllSecondaryWeaponItems player; // this command does not exist in A3 even after 3 year...
				{
					player removeSecondaryWeaponItem _x;
				} forEach (secondaryWeaponItems player);
				{player addSecondaryWeaponItem _x} forEach (_secits select {_x != ""});
			};
			
			_exit_it = true;
		} else {
			private _phw = player getVariable "d_phandgweap";
			if (_phw != handgunWeapon player) then {
				player removeWeapon (handgunWeapon player);
				player addWeapon _phw;
				
				private _secits = player getVariable "d_phandgweapitems";
				if !(handgunItems player isEqualTo _secits) then {
					removeAllHandgunItems player;
					{player addHandgunItem _x} forEach (_secits select {_x != ""});
				};
				
				_exit_it = true;
			};
		};
	};
};

if (_exit_it) exitWith {
	(_this select 1) addItemCargo [_item, 1];
	systemChat format [localize "STR_DOM_MISSIONSTRING_1564", _rank, getText(_cfgi>>"displayname")];
};

call d_fnc_store_rwitems;
