//#define __DEBUG__
#include "..\x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom fn_postinit.sqf"];

isNil {call compileScript ["d_init.sqf", false]};

diag_log [diag_frameno, diag_ticktime, time, "Dom fn_postinit.sqf processed"];