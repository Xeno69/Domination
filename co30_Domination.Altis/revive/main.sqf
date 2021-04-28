// by Xeno
//#define __DEBUG__
#include "..\x_macros.sqf"

if (isNil "xr_with_marker") then {
	xr_with_marker = true;
};

xr_moansoundsar = [
    [
	    "A3\Dubbing_Radio_F_Enoch\data\RUS\",
        [
	       "Male01RUS\Normal\140_Com_Status\",
	       "Male02RUS\Normal\140_Com_Status\",
	       "Male03RUS\Normal\140_Com_Status\",
	       "Male01RUS\Normal\140_Com_Status\",
	       "Male02RUS\Normal\140_Com_Status\",
	       "Male03RUS\Normal\140_Com_Status\"		   
	    ]
	],
    [
	    "A3\Dubbing_Radio_F\data\ENG\",
        [
	       "Male01ENG\RadioProtocolENG\Normal\140_Com_Status\",
	       "Male02ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male03ENG\RadioProtocolENG\Normal\140_Com_Status\",
	       "Male04ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male05ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male06ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male07ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male08ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male09ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male10ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male11ENG\RadioProtocolENG\Normal\140_Com_Status\",
		   "Male12ENG\RadioProtocolENG\Normal\140_Com_Status\"
	    ]
	],
    [
	    "A3\Dubbing_Radio_F\data\GRE\",
        [
	       "Male01GRE\RadioProtocolGRE\Normal\140_Com_Status\",
	       "Male02GRE\RadioProtocolGRE\Normal\140_Com_Status\",
	       "Male03GRE\RadioProtocolGRE\Normal\140_Com_Status\",
		   "Male04GRE\RadioProtocolGRE\Normal\140_Com_Status\",
		   "Male05GRE\RadioProtocolGRE\Normal\140_Com_Status\",
		   "Male06GRE\RadioProtocolGRE\Normal\140_Com_Status\"
	    ]
	],	
	[
	  "HealthINeedHelpNow.ogg",
	  "HealthIAmBadlyHurt.ogg",
	  "HealthINeedSomeHelpHere.ogg",
	  "HealthNeedMedicNow.ogg",
	  "HealthIAmWounded.ogg",
	  "CriticalDamage_1.ogg",
	  "CriticalDamage_2.ogg"
	]
];

if (!hasInterface) exitWith {};

if (isNil "xr_respawn_available_after") then {xr_respawn_available_after = 120};
if (isNil "xr_lifetime") then {xr_lifetime = 300};

xr_dropAction = -3333;
if (isNil "xr_phd_invulnerable") then {xr_phd_invulnerable = false};

xr_respawn_available = false;

xr_plsayer = call {
    if (d_own_side == "EAST") exitWith {0};
	if (d_own_side == "WEST") exitWith {1};
	2
};
private _num = floor (random (count ((xr_moansoundsar # xr_plsayer) # 1)));
xr_voicetype = (((xr_moansoundsar # xr_plsayer) # 1) # _num);
