// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

// todo - show icon

params ["_distance_fired"];
private _t = format [localize "STR_DOM_MISSIONSTRING_HEADSHOT_CLIENT", _distance_fired];
"d_headshot_txt" cutText [format ["<t color='#ff0000' size='1'>%1</t>", _t], "PLAIN DOWN", 2, true, true];