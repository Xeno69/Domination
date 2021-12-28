// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (_this < d_points_needed # 0) exitWith {"Private"};
if (_this < d_points_needed # 1) exitWith {"Corporal"};
if (_this < d_points_needed # 2) exitWith {"Sergeant"};
if (_this < d_points_needed # 3) exitWith {"Lieutenant"};
if (_this < d_points_needed # 4) exitWith {"Captain"};
if (_this < d_points_needed # 5) exitWith {"Major"};
if (_this < d_points_needed # 6) exitWith {"Colonel"};
"General"
