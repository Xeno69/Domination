// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

// displays a hint and a chat message, \n get removed for the chat text
// parameters: text (with \n for hints), type of chat ("HQ","SIDE","GLOBAL" or "GROUP")
// example: ["My nice text\n\nHello World", "HQ"] call d_fnc_HintChatMsg;
params ["_msg", "_type_chat", ["_docut", false]];

if (count _msg < 2) exitWith {};

private _arh = [];
private _arc = [];

for "_i" from 0 to count _msg - 1 do {
	if (_msg select [_i, 2] == "\n") then {
		_arh pushBack "<br/>";
		_arc pushBack " ";
		_i = _i + 1;
	} else {
		_arh pushBack (_msg select [_i, 1]);
		_arc pushBack (_msg select [_i, 1]);
	};
};

private _msg_struct = _arh joinString "";
hintSilent parseText format ["<t color='#34ebe8' size='1.3' align='center'>%1</t>", _msg_struct];
private _msg_chat = _arc joinString "";

call {
	if (_type_chat == "hq") exitWith {[playerSide, "HQ"] sideChat _msg_chat};
	if (_type_chat == "side") exitWith {player sideChat _msg_chat};
	if (_type_chat == "global") exitWith {systemChat _msg_chat};
	if (_type_chat == "group") exitWith {player groupChat _msg_chat};
};

if (_docut) then {
	"d_hc_msg" cutText [format ["<t color='#ff0000' size='2'>%1</t>", _msg_struct], "PLAIN DOWN", -1, true, true];
};