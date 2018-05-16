// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_vdsliderchanged.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;
private _newvd = round (_this select 1);
((uiNamespace getVariable "D_StatusDialog") displayCtrl 1999) ctrlSetText format [localize "STR_DOM_MISSIONSTRING_358", _newvd];
setViewDistance _newvd;
setObjectViewDistance _newvd + 100;