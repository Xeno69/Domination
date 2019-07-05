// by Xeno
#define THIS_FILE "fn_removelinebreak.sqf"
#include "..\x_setup.sqf"

private _msg_chat_a = toArray _this;
for "_i" from 0 to (count _msg_chat_a - 2) do {
	if (_msg_chat_a # _i == 92) then {
		if ((_msg_chat_a # (_i + 1)) in [78,110]) then {
			_msg_chat_a set [_i, 32];
			_i = _i + 1;
			_msg_chat_a set [_i, -1];
		};
	};
};
toString (_msg_chat_a - [-1])
