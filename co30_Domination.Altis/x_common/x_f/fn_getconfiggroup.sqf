// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getconfiggroup.sqf"
#include "..\..\x_setup.sqf"

"true" configClasses(configFile>>"CfgGroups">>(_this select 0)>>(_this select 1)>>(_this select 2)>>(_this select 3)) apply {getText (_x>>"vehicle")}
