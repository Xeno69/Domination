// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hintchatmsg.sqf"
#include "..\..\x_setup.sqf"

if (!hasInterface) exitWith {};

// displays a hint and a chat message, \n get removed for the chat text
// parameters: text (with \n for hints), type of chat ("HQ","SIDE","GLOBAL" or "GROUP")
// example: ["My nice text\n\nHello World", "HQ"] call d_fnc_HintChatMsg;
params ["_msg", "_type_chat"];
hintSilent _msg;
//private _msg_chat = (_msg splitString "\n") joinString " ";
private _msg_chat = _msg call d_fnc_removelinebreak;

switch (toUpper _type_chat) do {
	case "HQ": {[playerSide, "HQ"] sideChat _msg_chat};
	case "SIDE": {player sideChat _msg_chat};
	case "GLOBAL": {systemChat _msg_chat};
	case "GROUP": {player groupChat _msg_chat};
};