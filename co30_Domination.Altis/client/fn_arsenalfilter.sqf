// by Xeno
#define THIS_FILE "fn_arsenalfilter.sqf"
#include "..\x_setup.sqf"

// TODO
// Das ganze eigene Einlesen der Waffen ist gar nicht notwendig.
// Die Klassen sind doch alle in bis_fnc_arsenal_data

// scopes with optics
//"getNumer (_x>>'scope') == 2 && {isClass (_x>>'ItemInfo') && {inheritsFrom (_x>>'ItemInfo') == configFile>>'CfgWeapons'>>'InventoryOpticsItem_Base_F')}}" configClasses (configFile >> "CfgWeapons")

//private _weaponsar = "getNumber (_x>>'scope') == 2 && {getNumber (_x>>'ballisticsComputer') == 0}" configClasses (configFile >> "CfgWeapons");

private _cfgw = configFile>>"CfgWeapons";

private _weaponsar = "getNumber (_x>>'scope') == 2 &&
{!(configName _x isEqualTo 'Zasleh2') &&
{!isClass (_x>>'LinkedItems') &&
{!isClass (_x>>'LinkedItemsMuzzle') &&
{!isClass (_x>>'LinkedItemsAcc') &&
{configName _x isKindOf ['RifleCore', configFile >> 'CfgWeapons'] ||
{configName _x isKindOf ['PistolCore', configFile >> 'CfgWeapons'] || 
{configName _x isKindOf ['DetectorCore', configFile >> 'CfgWeapons'] ||
{configName _x isKindOf ['Binocular', configFile >> 'CfgWeapons'] ||
{configName _x isKindOf ['Launcher', configFile >> 'CfgWeapons'] ||
{configName _x isKindOf ['ItemCore', configFile >> 'CfgWeapons'] ||
{configName _x isKindOf ['InventoryItem_Base_F', configFile >> 'CfgWeapons']
}}}}}}}}}}}" configClasses _cfgw;

private _glassesar = "getNumber (_x>>'scope') == 2 &&" configClasses (configFile>>"CfgGlasses");

diag_log "configClasses done...";

_glassesar = _glassesar apply {configName _x};

diag_log "##################################";
diag_log "Glasses";
{
	diag_log _x;
} forEach _glassesar;

diag_log "##################################";

private _gogglesar = [];
private _binoar = [];
private _launcherar = [];
private _uniformsar = [];
private _vestsar = [];
private _itemsar = [];
private _helemtsar = [];
private _opticsar = [];
private _bipodsar = [];
private _muzzlesar = [];
private _flashlightar = [];
private _uavterminalar = [];
private _pistolar = [];
private _riflear = [];
private _minedetectorar = [];
private _mapsar = [];
private _compassar = [];
private _radioar = [];
private _watchar = [];

{
	private _n = configName _x;
	private _cfgo = _x;
	__TRACE_1("","_n")
	call {
		if (_n isKindOf ["RifleCore", _cfgw]) exitWith {
			_riflear pushBack _n;
			private _cu = getText(_cfgo>>"cursor"),
			if (_cu == "arifle") then {
				// assault rifle
				__TRACE_1("is assault rifle","_n")
				
				private _muzzles = getArray (_cfgo>>"muzzles");
				if (_muzzles findIf {_cfgo>>_x>>"cursorAim" == "gl"}) then {
					//has grenade launcher
					__TRACE_1("has underbarrel grenade launcher","_n")
				} else {
					_muzzles = _muzzles apply {toLowerANSI _x}
					if ("secondary" in _muzzles) then {
						// has secondary rifle like arifle_ARX_base_F
					};
				};
			} else {
				if (_cu == "srifle") then {
					// sniper rifle
				} else {
					if (_cu == "mg") then {
						// mg
					} else {
						if (_cu == "hgun") then {
							// handgun
						} else {
							if (_cu == "smg") then {
								// submachinegun
							} else {
								if (_cu == "gl") then {
									// grenade launcher
								};
							};
						};
					};
				};
			};
		};
		if (_n isKindOf ["Launcher", _cfgw]) exitWith {
			_launcherar pushBack _n;
		};
		if (_n isKindOf ["PistolCore", _cfgw]) exitWith {
			_pistolar pushBack _n;
		};
		if (_n isKindOf ["NVGoggles", _cfgw]) exitWith {
			_gogglesar pushBack _n;
		};
		if (_n isKindOf ["Binocular", _cfgw]) exitWith {
			_binoar pushBack _n;
		};
		if (_n isKindOf ["Uniform_Base", _cfgw]) exitWith {
			_uniformsar pushBack _n;
		};
		if (_n isKindOf ["Vest_Camo_Base", _cfgw] || {_n isKindOf ["Vest_NoCamo_Base", _cfgw]}) exitWith {
			_vestsar pushBack _n;
		};
		if (isClass (_cfgo>>"ItemInfo">>"HitpointsProtectionInfo">>"Head")) exitWith {
			_helemtsar pushBack _n;
		};
		if (isClass (_cfgo>>"ItemInfo">>"OpticsModes")) exitWith {
			_opticsar pushBack _n;
		};
		if (isClass (_cfgo>>"ItemInfo">>"MuzzleCoef")) exitWith {
			_muzzlesar pushBack _n;
		};
		if (isClass (_cfgo>>"ItemInfo">>"FlashLight")) exitWith {
			_flashlightar pushBack _n;
		};
		if (getNumber (_cfgo>>"ItemInfo">>"hasBipod") == 1) exitWith {
			_bipodsar pushBack _n;
		};
		if (_n isKindOf ["UavTerminal_base", _cfgw] || {getText (_cfgo>>"simulation") == "ItemCompass"}) exitWith {
			_uavterminalar pushBack _n;
		};
		if (_n isKindOf ["DetectorCore", _cfgw]) exitWith {
			_minedetectorar pushBack _n;
		};
		if (getText (_cfgo>>"simulation") == "ItemMap") exitWith {
			_mapsar pushBack _n;
		};
		if (getText (_cfgo>>"simulation") == "ItemCompass") exitWith {
			_compassar pushBack _n;
		};
		if (getText (_cfgo>>"simulation") == "ItemRadio") exitWith {
			_radioar pushBack _n;
		};
		if (getText (_cfgo>>"simulation") == "ItemWatch") exitWith {
			_watchar pushBack _n;
		};
		if (_n isKindOf ["ItemCore", _cfgw]) exitWith {
			_itemsar pushBack _n;
		};
	};
} forEach _weaponsar;

diag_log "forEach _weaponsar done...";

diag_log "##################################";
diag_log "Rifles...";
{
	diag_log _x;
} forEach _riflear;
diag_log "##################################";
diag_log "Pistols...";
{
	diag_log _x;
} forEach _pistolar;
diag_log "##################################";
diag_log "Goggles...";
{
	diag_log _x;
} forEach _gogglesar;
diag_log "##################################";
diag_log "Binoculars...";
{
	diag_log _x;
} forEach _binoar;
diag_log "##################################";
diag_log "Launchers...";
{
	diag_log _x;
} forEach _launcherar;
diag_log "##################################";
diag_log "Optics...";
{
	diag_log _x;
} forEach _opticsar;
diag_log "##################################";
diag_log "Uniforms...";
{
	diag_log _x;
} forEach _uniformsar;
diag_log "##################################";
diag_log "Vests...";
{
	diag_log _x;
} forEach _vestsar;
diag_log "##################################";
diag_log "Helmets...";
{
	diag_log _x;
} forEach _helemtsar;
diag_log "##################################";
diag_log "Bipods...";
{
	diag_log _x;
} forEach _bipodsar;
diag_log "##################################";
diag_log "Muzzles...";
{
	diag_log _x;
} forEach _muzzlesar;
diag_log "##################################";
diag_log "Flashlights...";
{
	diag_log _x;
} forEach _flashlightar;
diag_log "##################################";
diag_log "UAV Terminals...";
{
	diag_log _x;
} forEach _uavterminalar;
diag_log "##################################";
diag_log "Mine Detectors...";
{
	diag_log _x;
} forEach _minedetectorar;
diag_log "##################################";
diag_log "Maps...";
{
	diag_log _x;
} forEach _mapsar;
diag_log "##################################";
diag_log "Compass...";
{
	diag_log _x;
} forEach _compassar;
diag_log "##################################";
diag_log "Radios...";
{
	diag_log _x;
} forEach _radioar;
diag_log "##################################";
diag_log "Watches...";
{
	diag_log _x;
} forEach _watchar;
diag_log "##################################";
diag_log "Items...";
{
	diag_log _x;
} forEach _itemsar;


diag_log "##################################";
diag_log ["Count _weaponsar", count _weaponsar];
diag_log ["Count other arrays", (count _gogglesar) + (count _binoar) + (count _launcherar) + (count _opticsar) + (count _uniformsar) + (count _vestsar) + (count _helemtsar) + (count _itemsar) + (count _bipodsar) + (count _muzzlesar) + (count _flashlightar) + (count _uavterminalar) + (count _pistolar) + (count _riflear) + (count _minedetectorar) + (count _mapsar) + (count _compassar) + (count _radioar) + (count _watchar)];

_weaponsar = _weaponsar apply {configName _x};

_weaponsar = _weaponsar - _gogglesar - _binoar - _launcherar - _uniformsar - _vestsar - _itemsar - _helemtsar - _opticsar - _bipodsar - _muzzlesar - _flashlightar - _uavterminalar - _pistolar - _riflear - _minedetectorar - _mapsar - _compassar - _radioar - _watchar;

diag_log ["Rest:", _weaponsar];


/*d_remove_from_arsenal = [
		[], // rifles
		[], // launchers
		[], // handguns
		[], // uniforms
		[], // vests
		[], // backpacks
		[], // headgear
		[], // glasses
		[], // goggles
		[], // binoculars
		[], // ItemMap
		[], // ItemGPS, UAV Terminal
		[], // ItemRadio
		[], // ItemCompass
		[], // ItemWatch
		[], // Heads
		[], // Language?
		[], // signs
		[],
		[],
		[],
		[],
		[], // Grenades
		["APERSMineDispenser_Mag"], // Charges
		[], // MineDector, FirstAidkit, MediKit
		[],
		[] // magazines
	];*/
	
/*// >> "type"
#define WeaponNoSlot            0       // dummy weapons
#define WeaponSlotPrimary       1       // primary weapons
#define WeaponSlotSecondary     4       // secondary weapons
#define WeaponSlotHandGun       2       // HandGun
#define WeaponSlotHandGunItem   16      // HandGun magazines
#define WeaponSlotItem          256     // items
#define WeaponSlotBinocular     4096    // binocular
#define WeaponHardMounted       65536   //vehicle weapons
#define WeaponSlotInventory     131072  // inventory items

// >> "itemInfo" >> "type"
#define DEFAULT_SLOT        0
#define MUZZLE_SLOT         101
#define OPTICS_SLOT         201
#define FLASHLIGHT_SLOT     301
#define BIPOD_SLOT          302
#define FIRSTAIDKIT_SLOT    401
#define FINS_SLOT           501
#define BREATHINGBOMB_SLOT  601
#define NVG_SLOT            602
#define GOGGLE_SLOT         603
#define SCUBA_SLOT          604
#define HEADGEAR_SLOT       605
#define FACTOR_SLOT         607
#define RADIO_SLOT          611
#define HMD_SLOT            616
#define BINOCULAR_SLOT      617
#define MEDIKIT_SLOT        619
#define TOOLKIT_SLOT        620
#define VEST_SLOT           701
#define UNIFORM_SLOT        801
#define BACKPACK_SLOT       901

Then also for weapons you can filter them by cursor or cursorAim.

//Stolen from BIS_fnc_itemType

case "arifle": {"AssaultRifle"};
case "bomb": {"BombLauncher"};
case "cannon": {"Cannon"};
case "gl": {"GrenadeLauncher"};
case "laserdesignator": {"LaserDesignator"};
case "mg": {"MachineGun"};
case "missile": {"MissileLauncher"};
case "mortar": {"Mortar"};
case "rocket": {"RocketLauncher"};
case "sgun": {"Shotgun"};
case "throw": {"Throw"};
case "smg": {"SubmachineGun"};
case "srifle": {"SniperRifle"};

As well as BIS_fnc_itemType another good place to look at is BIS_fnc_loadInventory for some ideas on filtering. 
/*)