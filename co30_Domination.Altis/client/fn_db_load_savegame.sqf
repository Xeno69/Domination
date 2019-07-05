// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_db_load_savegame.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!isNil "d_db_load_done" || {getClientStateNumber > 9}) exitWith {};
d_db_load_done = true;

[d_db_savegames select _this, player] remoteExecCall ["d_fnc_db_loadsavegame_server", 2];
