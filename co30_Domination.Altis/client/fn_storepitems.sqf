// by Xeno
#define THIS_FILE "fn_storepitems.sqf"
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

player setVariable ["d_uniformp", uniform player];
player setVariable ["d_vestp", vest player];
player setVariable ["d_backpackp", backpack player];
player setVariable ["d_headgearp", headgear player];
player setVariable ["d_gogglesp", goggles player];
player setVariable ["d_hmdp", hmd player];
player setVariable ["d_binocularp", binocular player];
