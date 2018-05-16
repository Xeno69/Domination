// by Xeno
#define THIS_FILE "fn_kbunits.sqf"
#include "..\..\x_setup.sqf"

if ((_this select 1) getFriend side (group player) < 0.6) exitWith {};
(missionNamespace getVariable (_this select 0)) kbAddTopic["PL" + str player, "x_bikb\domkba3.bikb"];
