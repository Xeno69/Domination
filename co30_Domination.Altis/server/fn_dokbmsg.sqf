// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dokbmsg.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

__TRACE_1("","owner d_kb_logic1");
__TRACE_1("","owner d_kb_logic2");

params ["_num", ["_val1", ""], ["_val2", ""]];

call (d_kb_hash get _num);
