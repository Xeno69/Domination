// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_xdelct.sqf"
#include "..\x_setup.sqf"

#ifdef __TT__
deleteVehicle d_current_triggerTT;
#endif
deleteVehicle d_current_trigger;
if (!isNil "d_f_check_trigger") then {
	deleteVehicle d_f_check_trigger;
};

if (!isNil "d_handleobservers_handle" && {!isNull d_handleobservers_handle}) then {terminate d_handleobservers_handle};
