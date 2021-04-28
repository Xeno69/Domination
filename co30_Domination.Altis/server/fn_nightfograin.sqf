// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

[0, 1] select (sunOrMoon < 1 || {fog > 0.3 || {rain > 0.49}})
