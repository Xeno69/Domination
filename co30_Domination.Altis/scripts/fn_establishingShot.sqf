//#define __DEBUG__
#include "..\x_setup.sqf"
/*
	Author: Thomas Ryan
	Modified by Xeno

	Description:
	Play a fake UAV observational sequence which serves as an establishing shot.

	Parameters:
		_this select 0: OBJECT or ARRAY - Target position/object
		_this select 1: STRING - Text to display
		_this select 2 (Optional): NUMBER - Altitude (in meters)
		_this select 3 (Optional): NUMBER - Radius of the circular movement (in meters)
		_this select 4 (Optional): NUMBER - Viewing angle (in degrees)
		_this select 5 (Optional): NUMBER - Direction of camera movement (0: anti-clockwise, 1: clockwise, default: random)
		_this select 6 (Optional): ARRAY -	Objects/positions/groups to display icons over
							Syntax: [[icon, color, target, size X, size Y, angle, text, shadow]]
		_this select 7 (Optional): NUMBER - Mode (0: normal (default), 1: world scenes)
*/

private _tgt = [_this, 0, objNull, [objNull, []]] call BIS_fnc_param;
private _txt = [_this, 1, "", [""]] call BIS_fnc_param;
private _alt = [_this, 2, 500, [500]] call BIS_fnc_param;
private _rad = [_this, 3, 200, [200]] call BIS_fnc_param;
private _ang = [_this, 4, random 360, [0]] call BIS_fnc_param;
private _dir = [_this, 5, round random 1, [0]] call BIS_fnc_param;

private _mode = [_this, 7, 0, [0]] call BIS_fnc_param;

d_is_sat_on = true;
BIS_fnc_establishingShot_fakeUAV = nil;

_txt = format ["%1 %2", localize "STR_DOM_MISSIONSTRING_1515", str _tgt];
if (count _tgt == 2) then {_tgt pushBack 0};

["BIS_fnc_establishingShot",false] call BIS_fnc_blackOut;

BIS_fnc_establishingShot_icons = [
	[getText(configFile>>"CfgVehicleIcons">>getText(configFile>>"CfgVehicles">>(typeOf player)>>"icon")), [255,255,255,1], player, 1, 1, 0, d_name_pl, 0]
];

_colortouse = d_player_side call BIS_fnc_sideColor;
{
	BIS_fnc_establishingShot_icons pushBack [getText(configFile>>"CfgVehicleIcons">>getText(configFile>>"CfgVehicles">>(typeOf _x)>>"icon")), _colortouse, _x, 0.8, 0.8, 0, name _x, 1];
} forEach ((allPlayers - entities "HeadlessClient_F") select {alive _x && {!(_x isKindOf "VirtualMan_F") && {d_player_side getFriend side (group _x) >= 0.6 && {!(_x getVariable ["xr_pluncon", false]) && {!(_x getVariable ["ace_isunconscious", false])}}}}});

// Create fake UAV
if (isNil "BIS_fnc_establishingShot_fakeUAV") then {
	BIS_fnc_establishingShot_fakeUAV = "Camera" camCreate [10,10,10];
};

BIS_fnc_establishingShot_fakeUAV cameraEffect ["INTERNAL", "BACK"];

cameraEffectEnableHUD true;

private _pos = if (_tgt isEqualType objNull) then {position _tgt} else {_tgt};
private _coords = _pos getPos [_rad, _ang];
_coords set [2, _alt];

BIS_fnc_establishingShot_fakeUAV camPrepareTarget _tgt;
BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
BIS_fnc_establishingShot_fakeUAV camPrepareFOV 0.700;
BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;

// Timeout the preload after 3 seconds
BIS_fnc_establishingShot_fakeUAV camPreload 3;

// Apply post-process effects
private _ppColor = ppEffectCreate ["colorCorrections", 1999];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
_ppColor ppEffectCommit 0;

private _ppGrain = ppEffectCreate ["filmGrain", 2012];
_ppGrain ppEffectEnable true;
_ppGrain ppEffectAdjust [0.1, 1, 1, 0, 1];
_ppGrain ppEffectCommit 0;

// Disable stuff after simulation starts
0 spawn {
	scriptName "spawn_stablishingshot";
	waitUntil {time > 0};
	showCinemaBorder false;
	enableEnvironment [false ,false];
};

private _SITREP = [];

if (_mode == 1) then {
	optionsMenuOpened = {
		disableSerialization;
		{_x cutText ["", "PLAIN"]} forEach ["BIS_layerStatic", "BIS_layerInterlacing"];
	};
} else {
	// Compile SITREP text

	private _month = if (date # 1 < 10) then {format ["0%1", str (date # 1)]} else {str (date # 1)};
	private _day = if (date # 2 < 10) then {format ["0%1", str (date # 2)]} else {str (date # 2)};
	private _hour = if (date # 3 < 10) then {format ["0%1", str (date # 3)]} else {str (date # 3)};
	private _minute = if (date # 4 < 10) then {format ["0%1", str (date # 4)]} else {str (date # 4)};

	private _time = format ["%1%2", _hour, _minute];
	private _date = format ["%1/%2/%3", _day, _month, str (date # 0)];

	//_SITREP = format [localize "STR_A3_BIS_fnc_establishingShot_SITREP" + "||%1|%2||" + localize "STR_A3_BIS_fnc_establishingShot_Time", toUpper _txt, _date, _time];

	_SITREP = [
		[_date + " ", ""],
		[_time, "font = 'PuristaMedium'"],
		["", "<br/>"],
		[toUpper _txt, ""]
	];

	disableSerialization;

	waitUntil {!isNull (findDisplay 46)};

	// Remove eventhandler if it exists (only happens when restarting)
	if (!isNil {uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"}) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"];
		uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", nil];
	};

	// Add skipping eventhandler
	d_cur_fake_uav_timode = -1;
	"d_sat_timode" cutRsc ["d_sat_timode","PLAIN"];
	((uiNamespace getVariable "d_sat_timode") displayCtrl 50) ctrlSetText "Off";
	private _skipEH = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		if (_this # 1 == 57) then {
			(findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"];
			uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", nil];

			playSound ["click", true];

			BIS_fnc_establishingShot_skip = true;
		} else {
			if (_this # 1 == 0x31) then { // N
				d_cur_fake_uav_timode = d_cur_fake_uav_timode + 1;
				if (d_cur_fake_uav_timode > 7) then {d_cur_fake_uav_timode = -1};
				playSound ["click", true];
				if (d_cur_fake_uav_timode > -1) then {
					true setCamUseTi d_cur_fake_uav_timode;
				} else {
					false setCamUseTi 0;
				};
				disableSerialization;
				((uiNamespace getVariable "d_sat_timode") displayCtrl 50) ctrlSetText (["Off","WHOT","BHOT","HOT","HOT","RBHOT","BRHOT","WHOT","THERMAL"] select (d_cur_fake_uav_timode + 1));
			};
		};

		(_this # 1 != 1);
	}];

	uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", _skipEH];

	// Create vignette & tiles
	"BIS_layerEstShot" cutRsc ["RscEstablishingShot", "PLAIN"];

	// Remove effects if video options opened
	optionsMenuOpened = {
		disableSerialization;
		{_x cutText ["", "PLAIN"]} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];
	};

	optionsMenuClosed = {
		disableSerialization;
		"BIS_layerEstShot" cutRsc ["RscEstablishingShot", "PLAIN"];
	};

	waitUntil {!isNull (uiNamespace getVariable "RscEstablishingShot")};
};

__TRACE("After waitUntil 1")

// Wait for the camera to load
waitUntil {camPreloaded BIS_fnc_establishingShot_fakeUAV || {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};
__TRACE("After waitUntil 2")

private _drawEH = -1;

if (isNil "BIS_fnc_establishingShot_skip") then {
	__TRACE("After isnil BIS_fnc_establishingShot_skip")
	BIS_fnc_establishingShot_playing = true;

	// Create logic to play sounds
	BIS_fnc_establishingShot_logic_group = createGroup sideLogic;
	BIS_fnc_establishingShot_logic1 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
	BIS_fnc_establishingShot_logic2 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];
	BIS_fnc_establishingShot_logic3 = BIS_fnc_establishingShot_logic_group createUnit ["Logic", [10,10,10], [], 0, "NONE"];

	0 spawn {
		scriptName "BIS_fnc_establishingShot: UAV sound loop";

		// Determine duration
		private _sound = "UAV_loop";
		private _duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

		while {!isNull BIS_fnc_establishingShot_logic1} do {
			BIS_fnc_establishingShot_logic1 say _sound;
			sleep _duration;

			if (!isNull BIS_fnc_establishingShot_logic2) then {
				BIS_fnc_establishingShot_logic2 say _sound;
				sleep _duration;
			};
		};
	};

	0 spawn {
		scriptName "BIS_fnc_establishingShot: random sounds control";

		while {!isNull BIS_fnc_establishingShot_logic3} do {
			// Choose random sound
			private _sound = format ["UAV_0%1", round (1 + random 8)];
			private _duration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");

			BIS_fnc_establishingShot_logic3 say _sound;

			sleep (_duration + (5 + random 5));
		};
	};

	// Move camera in a circle
	[_pos, _alt, _rad, _ang, _dir] spawn {
		scriptName "BIS_fnc_establishingShot: camera control";

		params ["_pos", "_alt", "_rad", "_ang", "_dir"];

		d_do_end_rose = false;
		d_cam_rose_target_obj = BIS_fnc_establishingShot_fakeUAV;
		0 spawn d_fnc_cam_rose;
		while {isNil "BIS_fnc_establishingShot_skip" && {d_player_canu}} do {
			_ang = _ang - 0.5;
			if (_ang < 0) then {_ang = _ang + 360};

			private _coords = [_pos, _rad, if (_dir == 0) then {_ang} else {_ang * -1}] call BIS_fnc_relPos;
			_coords set [2, _alt];

			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0.5;

			waitUntil {camCommitted BIS_fnc_establishingShot_fakeUAV || {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};

			BIS_fnc_establishingShot_fakeUAV camPreparePos _coords;
			BIS_fnc_establishingShot_fakeUAV camCommitPrepared 0;
			sleep 0.01;
		};
		d_do_end_rose = nil;
	};

	sleep 1;
	__TRACE("After sleep 1")
	if (isNil "BIS_fnc_establishingShot_skip" && {d_player_canu}) then {
		enableEnvironment [false, true];
		2 fadeSound 1;

		// Static fade-in
		"BIS_layerStatic" cutRsc ["RscStatic", "PLAIN"];
		waitUntil {!isNull (uiNamespace getVariable ["RscStatic_display", displayNull]) || {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};
		waitUntil {isNull (uiNamespace getVariable ["RscStatic_display", displayNull])  || {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};

		if (isNil "BIS_fnc_establishingShot_skip" && {d_player_canu}) then {
			// Show interlacing
			"BIS_layerInterlacing" cutRsc ["RscInterlacing", "PLAIN"];

			// Show screen
			"BIS_fnc_blackOut" cutText ["", "PLAIN", 10e10];

			// Add interlacing to optionsMenuClosed
			optionsMenuClosed = if (_mode == 0) then {
				{
					"BIS_layerEstShot" cutRsc ["RscEstablishingShot", "PLAIN"];
					"BIS_layerInterlacing" cutRsc ["RscInterlacing", "PLAIN"];
				};
			} else {
				{
					"BIS_layerInterlacing" cutRsc ["RscInterlacing", "PLAIN"];
				};
			};

			// Show icons
			if (BIS_fnc_establishingShot_icons isNotEqualTo []) then {
				_drawEH = addMissionEventHandler [
					"Draw3D",
					{
						{
							private _icon = [_x, 0, "", [""]] call BIS_fnc_param;
							private _color = [_x, 1, [], [[]]] call BIS_fnc_param;
							private _target = [_x, 2, [], [[], objNull, grpNull]] call BIS_fnc_param;
							private _sizeX = [_x, 3, 1, [1]] call BIS_fnc_param;
							private _sizeY = [_x, 4, 1, [1]] call BIS_fnc_param;
							private _angle = [_x, 5, random 360, [0]] call BIS_fnc_param;
							private _text = [_x, 6, "", [""]] call BIS_fnc_param;
							private _shadow = [_x, 7, 0, [0]] call BIS_fnc_param;

							// Determine condition and position
							private _condition = true;
							private _position = _target;

							switch (typeName _target) do {
								// Object
								case typeName objNull: {
									_condition = alive _target;
									_position = getPosATLVisual _target;
								};

								// Group
								case typeName grpNull: {
									_condition = (units _target) findIf {alive _x} > -1;
									_position = getPosATLVisual leader _target;
								};
							};

							// Draw icon
							if (_condition) then {
								drawIcon3D [_icon, _color, _position, _sizeX, _sizeY, _angle, _text, _shadow];
							};
						} forEach BIS_fnc_establishingShot_icons;
					}
				];
			};

			if (_mode == 0) then {
				// Spawn instructions separately to allow for no delay in skipping
				0 spawn {
					scriptName "BIS_fnc_establishingShot: instructions control";

					disableSerialization;

					if (isNil "BIS_fnc_establishingShot_skip" && {d_player_canu}) then {
						// Display instructions
						"BIS_layerTitlecard" cutRsc ["RscDynamicText", "PLAIN"];

						private _dispText = uiNamespace getVariable "BIS_dynamicText";
						private _ctrlText = _dispText displayCtrl 9999;

						_ctrlText ctrlSetPosition [
							0 * safeZoneW + safeZoneX,
							0.8 * safeZoneH + safeZoneY,
							safeZoneW,
							safeZoneH
						];

						// Determine appropriate key highlight
						private _keyColor = format [
							"<t color = '%1'>",
							(["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML
						];
						private _skipText = format [
							localize "STR_DOM_MISSIONSTRING_1512",
							"<t size = '0.75'>",
							_keyColor,
							"</t>",
							"</t>"
						];

						_ctrlText ctrlSetStructuredText parseText _skipText;
						_ctrlText ctrlSetFade 1;
						_ctrlText ctrlCommit 0;

						_ctrlText ctrlSetFade 0;
						_ctrlText ctrlCommit 1;

						// Wait for video to finish
						waitUntil {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}};

						// Remove instructions
						_ctrlText ctrlSetFade 1;
						_ctrlText ctrlCommit 0;
					};
				};

				sleep 1;

				if (isNil "BIS_fnc_establishingShot_skip" && {d_player_canu}) then {
					/*((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetPosition [
						(((safeZoneW / safeZoneH) min 1.2) / 40) + safeZoneX,
						((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) + safeZoneY,
						safeZoneW,
						safeZoneH
					];

					((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;

					// Split text to individual characters
					private _SITREPArray = toArray _SITREP;
					{_SITREPArray set [_forEachIndex, toString [_x]]} forEach _SITREPArray;

					private _scrollIn = _SITREPArray spawn {
						disableSerialization;

						private _SITREPArray = _this;

						private ["_SITREPCompile", "_SITREPString", "_SITREPParsed"];
						_SITREPCompile = "";

						// Make text scroll in
						for "_i" from 0 to (count _SITREPArray - 1) do {
							private ["_character", "_delay"];
							_character = _SITREPArray # _i;
							_delay = if (_character == "|") then {_character = "<br/>"; 1} else {0.01};

							_SITREPCompile = _SITREPCompile + _character;

							private [];
							_SITREPString = "<t align = 'left' shadow = '1' font = 'EtelkaMonospacePro'>" + _SITREPCompile + "_</t>";
							_SITREPParsed = parseText _SITREPString;

							if (!isNull (uiNamespace getVariable "RscEstablishingShot")) then {
								((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetStructuredText _SITREPParsed;
								((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;
							};

							sleep _delay;
						};

						if (!isNull (uiNamespace getVariable "RscEstablishingShot")) then {
							_SITREPString = "<t align = 'left' shadow = '1' font = 'EtelkaMonospacePro'>" + _SITREPCompile + "</t>";
							_SITREPParsed = parseText _SITREPString;

							((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetStructuredText _SITREPParsed;
						};

						sleep 8;
					};
					waitUntil {scriptDone _scrollIn || {!isNil "BIS_fnc_establishingShot_skip"} || {player getVariable "xr_pluncon"} || {!alive player}};
					*/
					// Display SITREP
					BIS_fnc_establishingShot_SITREP = [
						_SITREP,
						0.015 * safeZoneW + safeZoneX,
						0.015 * safeZoneH + safeZoneY,
						false,
						"<t align = 'left' size = '1.0' font = 'PuristaLight'>%1</t>"
					] spawn BIS_fnc_typeText2;

					waitUntil {scriptDone BIS_fnc_establishingShot_SITREP || {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};

					private _time = time + 2;
					waitUntil {time >= _time || {isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}}};

					if (isNil "BIS_fnc_establishingShot_skip") then {
						// Register the UAV finished
						BIS_fnc_establishingShot_UAVDone = true;
					};
				};
			};
		};
	};
};

if (_mode == 0) then {
	__TRACE("Before waitUntil 4")
	waitUntil {!isNil "BIS_fnc_establishingShot_skip" || {!d_player_canu}};
	__TRACE("After waitUntil 4")

	// Remove skipping eventhandler if it wasn't removed already
	if (!isNil {uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"}) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_fnc_establishingShot_skipEH"];
		uiNamespace setVariable ["BIS_fnc_establishingShot_skipEH", nil];
	};

	// Static fade-out
	2 fadeSound 0;

	"BIS_layerStatic" cutRsc ["RscStatic", "PLAIN"];
	waitUntil {!isNull (uiNamespace getVariable ["RscStatic_display", displayNull])};
	waitUntil {isNull (uiNamespace getVariable ["RscStatic_display", displayNull])};

	// Delete sound logics and group
	{if (!isNil _x) then {deleteVehicle (missionNamespace getVariable _x)}} forEach ["BIS_fnc_establishingShot_logic1", "BIS_fnc_establishingShot_logic2", "BIS_fnc_establishingShot_logic3"];
	if (!isNil "BIS_fnc_establishingShot_logic_group") then {deleteGroup BIS_fnc_establishingShot_logic_group};

	// Remove HUD
	optionsMenuOpened = nil;
	optionsMenuClosed = nil;

	if (!isNil "_drawEH") then {
		removeMissionEventHandler ["Draw3D", _drawEH];
	};

	if (!isNull (uiNamespace getVariable "RscEstablishingShot")) then {
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlSetFade 1;
		((uiNamespace getVariable "RscEstablishingShot") displayCtrl 2500) ctrlCommit 0;
	};

	{
		_x cutText ["", "PLAIN"];
	} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];
	
	enableEnvironment [false, true];
	"BIS_fnc_blackOut" cutText ["", "BLACK FADED", 10e10];

	sleep 1;

	BIS_fnc_establishingShot_fakeUAV cameraEffect ["TERMINATE", "BACK"];

	ppEffectDestroy _ppColor;
	ppEffectDestroy _ppGrain;

	// Clear existing global variables
	BIS_fnc_establishingShot_icons = nil;
	BIS_fnc_establishingShot_spaceEH = nil;
	BIS_fnc_establishingShot_skip = nil;

	"d_sat_timode" cutFadeOut 0;
	d_do_end_rose = nil;
	["BIS_fnc_establishingShot"] call BIS_fnc_blackIn;

	d_cur_fake_uav_timode = nil;
	BIS_fnc_establishingShot_playing = false;
};
d_is_sat_on = nil;
false setCamUseTi 0;

if (d_earplugs_fitted) then {
	0 fadeSound 1;
	0 fadeSound 0.2;
};

true