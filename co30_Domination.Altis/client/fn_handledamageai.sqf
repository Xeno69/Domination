// by Xeno
#include "..\x_setup.sqf"

if (d_player_in_base && {player inArea d_base_array}) then {
	private _shooter = _this # 6;
	if (!isNil "_shooter" && {!isNull _shooter && {isPlayer [_shooter]}}) then {
		0
	} else {
		_this # 2
	};
} else {
	_this # 2;
};