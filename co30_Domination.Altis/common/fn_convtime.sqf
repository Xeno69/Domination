// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

private _ars = [];
private _res = round (_this / 86400);
if (_res < 100) then {_ars pushBack "0"};
if (_res < 10) then {_ars pushBack "0"};
_ars pushBack (str (floor _res));
_ars pushBack "d";
private _rest = _this mod 86400;
if (_rest > 0) then {
	_res = round (_rest / 3600);
	if (_res < 10) then {_ars pushBack "0"};
	_ars pushBack (str (floor _res));
	_ars pushBack "h";
	_rest = _rest mod 3600;
	if (_rest > 0) then {
		_res = round (_rest / 60);
		if (_res < 10) then {_ars pushBack "0"};
		_ars pushBack (str (floor _res));
		_ars pushBack "m";
	} else {
		_ars pushBack "00m";
	};
} else {
	_ars pushBack "00h";
	_ars pushBack "00m";
};
(_ars joinString "")
