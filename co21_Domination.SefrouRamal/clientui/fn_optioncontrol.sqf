// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

while {true} do {
	waitUntil {uiSleep 0.2; !isNull findDisplay 4};
	waitUntil {uiSleep 0.2; isNull findDisplay 4};
	d_ak_earplugs = actionKeys d_earplugs_userakey_str;
	d_ak_3dtoggle = actionKeys d_3dmarker_userakey_str;
	d_ak_getover = actionKeys "GetOver";
	d_ak_teamswitch = actionKeys "TeamSwitch";
	d_ak_hra = actionKeys "HeliRopeAction";
	d_ak_hslm = actionKeys "HeliSlingLoadManager";
};