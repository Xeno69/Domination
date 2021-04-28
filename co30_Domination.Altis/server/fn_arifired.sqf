// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

#ifndef __TT__
d_arty_projectiles pushBack (_this # 6);
#else
if ((_this # 0) getVariable "d_fside" == blufor) then {
	d_arty_projectiles_b pushBack (_this # 6);
} else {
	d_arty_projectiles_o pushBack (_this # 6);
};
#endif