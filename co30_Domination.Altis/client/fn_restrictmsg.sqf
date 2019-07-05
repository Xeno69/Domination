// by Xeno
#define THIS_FILE "fn_restrictmsg.sqf"
#include "..\x_setup.sqf"

sleep 20;
while {true} do {
	sleep (280 + random 280);
	"d_restrict" cutRsc ["d_restrict", "PLAIN"];
};