// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hasrespirator.sqf"
#include "..\x_setup.sqf"

// sadly there is no better way than putting all class names in here
private _resps = ["g_airpurifyingrespirator_02_olive_f", "g_airpurifyingrespirator_02_sand_f", "g_airpurifyingrespirator_02_black_f", "g_airpurifyingrespirator_01_f", "g_regulatormask_f"];

toLowerANSI (goggles player) in _resps
