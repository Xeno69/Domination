// by Xeno
#include "..\x_setup.sqf"

sleep 10;

while {true} do {
	if (!isNull (uiNamespace getVariable "BIS_AAN")) then {
		(uiNamespace getVariable "BIS_AAN") closeDisplay 1;
	};
	sleep 0.1;
	if (!isNull (uiNamespace getVariable "BIS_AAN_news")) then {
		(uiNamespace getVariable "BIS_AAN_news") closeDisplay 1;
	};
	sleep 3;
};