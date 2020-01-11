// by Xeno
#define THIS_FILE "fn_removelinebreak.sqf"
#include "..\x_setup.sqf"

private _ar = [];
for "_i" from 0 to count _this - 1 do {
	if (_this select [_i, 2] == "\n") then {
		_ar pushBack " ";
		_i = _i + 1;
	} else {
		_ar pushBack (_this select [_i, 1]);
	};
};

_ar joinString ""