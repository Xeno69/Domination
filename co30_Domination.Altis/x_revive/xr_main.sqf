// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_revive\xr_main.sqf"
#include "..\x_macros.sqf"

if (isNil "xr_with_marker") then {
	xr_with_marker = true;
};

xr_moansoundsar = [
	[
		"Person0",
		[
			"P0_moan_13_words.wss", "P0_moan_14_words.wss", "P0_moan_15_words.wss", "P0_moan_16_words.wss",
			"P0_moan_17_words.wss", "P0_moan_18_words.wss", "P0_moan_19_words.wss", "P0_moan_20_words.wss"
		]
	],
	[
		"Person1",
		[
			"P1_moan_19_words.wss", "P1_moan_20_words.wss", "P1_moan_21_words.wss", "P1_moan_22_words.wss",
			"P1_moan_23_words.wss", "P1_moan_24_words.wss", "P1_moan_25_words.wss", "P1_moan_26_words.wss",
			"P1_moan_27_words.wss", "P1_moan_28_words.wss", "P1_moan_29_words.wss", "P1_moan_30_words.wss",
			"P1_moan_31_words.wss", "P1_moan_32_words.wss", "P1_moan_33_words.wss"
		]
	],
	[
		"Person2",
		[
			"P2_moan_14_words.wss", "P2_moan_15_words.wss", "P2_moan_16_words.wss", "P2_moan_17_words.wss",
			"P2_moan_18_words.wss", "P2_moan_19_words.wss", "P2_moan_20_words.wss", "P2_moan_21_words.wss"
		]
	],
	[
		"Person3",
		[
			"P3_moan_10_words.wss", "P3_moan_11_words.wss", "P3_moan_12_words.wss", "P3_moan_13_words.wss",
			"P3_moan_14_words.wss", "P3_moan_15_words.wss", "P3_moan_16_words.wss", "P3_moan_17_words.wss",
			"P3_moan_18_words.wss", "P3_moan_19_words.wss", "P3_moan_20_words.wss"
		]
	]
];

if (!hasInterface) exitWith {};

if (isNil "xr_respawn_available_after") then {xr_respawn_available_after = 120};
if (isNil "xr_lifetime") then {xr_lifetime = 300};

xr_dropAction = -3333;
if (isNil "xr_phd_invulnerable") then {xr_phd_invulnerable = false};

xr_respawn_available = false;