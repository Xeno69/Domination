// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mhq_net.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")
private _camo = createVehicle [d_vec_camo_net, getPos _this, [], 0, "NONE"];
_camo setDir getDir _this;
_camo setVectorUp (vectorUp _this);
_camo setPosASL (getPosASL _this);		
_this setVariable ["d_MHQ_Camo", _camo, true];
_camo addEventhandler ["killed", {deleteVehicle (param [0])}];