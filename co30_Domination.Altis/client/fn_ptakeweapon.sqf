// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_unit", "_obj"];
if (_unit != player) exitWith {};

private _item = _this # 2;

if (d_without_nvg != 1 && {_item call d_fnc_isnvgoggles}) then {
	_unit unlinkItem _item;
};

if (!d_with_ranked || {d_no_ranked_weapons}) exitWith {
	__TRACE("No rank, safety pcheck")
	call d_fnc_pcheck;
};

#ifdef __DEBUG__
_eee = _obj isKindOf "WeaponHolderSimulated";
__TRACE_2("","_eee","typeOf _obj")
#endif

if (!isNull _obj && {_obj getEntityInfo 0 || {_obj isKindOf "WeaponHolderSimulated"}}) exitWith {
	__TRACE_1("","_obj")
};

_item = toLowerANSI _item;

private _cfgi = configFile>>"CfgWeapons">>_item;

if (!isClass(_cfgi)) exitWith {
	__TRACE_1("not of type weapon","_item")
};

if (_item in d_non_check_items) exitWith {
	__TRACE_1("item is in d non check items","_item")
};

private _rank = rank player;
__TRACE_1("","_rank")
private _isvalid = _item in (d_misc_hash get (_rank + "_ONED"));

private _exit_it = false;
if (!_isvalid) then {
	private _prw = player getVariable "d_pprimweap";
	if (_prw != primaryWeapon player) then {
		player removeWeapon (primaryWeapon player);
		player addWeapon _prw;
		
		private _secits = player getVariable "d_pprimweapitems";
		if (primaryWeaponItems player isNotEqualTo _secits) then {
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
			if (secondaryWeaponItems player isNotEqualTo _secits) then {
				// removeAllSecondaryWeaponItems player; // this command does not exist in A3 even after 3 years...
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
				if (handgunItems player isNotEqualTo _secits) then {
					removeAllHandgunItems player;
					{player addHandgunItem _x} forEach (_secits select {_x != ""});
				};
				
				_exit_it = true;
			};
		};
	};
};

if (_exit_it) exitWith {
	(_this # 1) addItemCargo [_item, 1];
	systemChat format [localize "STR_DOM_MISSIONSTRING_1564", _rank, getText(_cfgi>>"displayname")];
};

call d_fnc_store_rwitems;
