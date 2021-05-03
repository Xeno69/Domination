// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (d_gmcwg) exitWith {
	"pilot" in toLowerANSI (uniform player) && {toLowerANSI (headgear player) == "gm_ge_headgear_sph4_oli"}
};
if (d_unsung) exitWith {
	"pilot" in toLowerANSI (uniform player) && {"pilot" in toLowerANSI (headgear player) || {"jp_helmet" in toLowerANSI (headgear player)} || {"hp_helmet" in toLowerANSI (headgear player)}}
};

"pilot" in toLowerANSI (uniform player) && {"pilot" in toLowerANSI (headgear player)}
