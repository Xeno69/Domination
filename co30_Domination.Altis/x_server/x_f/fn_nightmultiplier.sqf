// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_nightmultiplier.sqf"
#include "..\..\x_setup.sqf"

sleep 20;

while {true} do {
    if (daytime >= 20 && {daytime < 4}) then {
        if (timeMultiplier != 5) then {
			setTimeMultiplier 5;
		};
    } else {
		if (timeMultiplier != 1) then {
			setTimeMultiplier 1;
		};
    };

    uiSleep 120;
};