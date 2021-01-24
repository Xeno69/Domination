// by Xeno
#define THIS_FILE "fn_kbunits.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if ((_this # 1) getFriend side (group player) < 0.6) exitWith {};
private _strp = ["dplayerstr", getPlayerUID player] select isMultiplayer;
(missionNamespace getVariable (_this # 0)) kbAddTopic["PL" + _strp, "bikb\domkba3.bikb"];
