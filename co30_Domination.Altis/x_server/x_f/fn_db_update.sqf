// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_db_update.sqf"
#include "..\..\x_setup.sqf"

if (_this # 1 == 0) exitWith {
	"extdb3" callExtension format ["1:dom:revivesAdd:%1", _this # 0];
};