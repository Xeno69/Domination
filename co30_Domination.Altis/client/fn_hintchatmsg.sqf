// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hintchatmsg.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

// displays a hint and a chat message, \n get removed for the chat text
// parameters: text (with \n for hints), type of chat ("HQ","SIDE","GLOBAL" or "GROUP")
// example: ["My nice text\n\nHello World", "HQ"] call d_fnc_HintChatMsg;
params ["_msg", "_type_chat", ["_docut", false]];

if (count _msg < 2) exitWith {};

private _ar = _msg splitString d_cr;

hintSilent parseText format ["<t color='#34ebe8' size='1.3' align='center'>%1</t>", _ar joinString "<br/>"];
private _msg_chat = _ar joinString " ";

private _lowc = toLowerANSI _type_chat;
call {
	if (_lowc == "hq") exitWith {[playerSide, "HQ"] sideChat _msg_chat};
	if (_lowc == "side") exitWith {player sideChat _msg_chat};
	if (_lowc == "global") exitWith {systemChat _msg_chat};
	if (_lowc == "group") exitWith {player groupChat _msg_chat};
};

if (_docut) then {
	"d_hc_msg" cutText [format ["<t color='#ff0000' size='2'>%1</t>", _msg_chat], "PLAIN DOWN", -1, true, true];
};