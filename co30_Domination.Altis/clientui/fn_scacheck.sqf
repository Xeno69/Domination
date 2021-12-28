// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

//__TRACE("SCAcheck")

d_pisadminp = (isMultiplayer && {serverCommandAvailable "#exec"}) || {isServer};
