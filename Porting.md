# Porting 

The Domination mission may be modified in Eden editor.

All maps supported by Domination are released as PBOs.  However you can use any PBO tool to modify and bundle your own mission modifications.  Choose `co30_Domination.Altis` as the PBO source to bundle the default map (Altis).

If you want to bundle or modify maps other than Altis follow these steps:

* delete `co30_Domination.Altis/mission.sqm`
* copy the appropriate `mission.sqm` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `mission.sqm`
* delete `co30_Domination.Altis/x_setup.sqf`
* copy the appropriate `x_setup.sqf` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `x_setup.sqf`
* rename `co30_Domination.Altis` folder to `co30_Domination.NewMap` (for example `co30_Domination.Malden`)
* run your preferred PBO tool with PBO source folder `co30_Domination.Malden`

Remember that your modifications can only be shared with the community if you contribute your work back to the source repository.


explanation: **_1-X** means **_1** **_2** ... **_X**
e.g. `sample_1-#` #1-3 => `sample_1`,`sample_2`,`sample_3`
## Markers
### neddded for gameplay
- `base_spawn_1` spwan point if revived
- `d_camstart` for intro
- `d_player_ammobox_pos_1-X`	amoboxes
- `d_pos_aihut`	hire AI if enabled
- `d_flag_bb` jump flag  "d_flag_base"
- `respawn_east, respawn_guerrila, respawn_west`	somewhere
- `xr_center`	put it somewhere in the middle, direction for fining the beach if died in water??
- `xr_playerparkmarker`	where the player will end if he has no live left
- `xr_resp_marker` 	put on a small island at the edge of map
- `d_farp_marker_l-..`	where FARPs placed
- `d_runwaymarker` green
- `d_enemy_base` rot

### Mapmarkers for info
- `Start`
- `d_boats` etc	put a marker where you have plced boats

### Additional vehicles/helis
- `d_base_anti_air_1-X`
- `d_base_tank_1-..`
- `d_base_apc_1-..`


### Special places
- Ammunition 
	- helipad `D_AMMOLOAD` simulation on, show modell 
- Heli/UAV repair
	- `helipad `d_chopper_trigger_1-X`
	- `d_base_chopper_sb`	places a shelter
- Wreck repair
	- helipad `d_wreck_rep`
	- `d_base_wreck_sb` places a shelter
- Vehicle/UAV repair
	- helipad `d_vecre_trigger_1-X`
- Jet/plane repair
	- helipad `d_jet_trigger_1-X`
	- `d_base_jet_sb` places a shelter
- All
	- helipad `d_serviceall_trigger_1-X`


	
-

### Side Mission Markers
- `d_sm_loga`		where to deliver prisioners and other 
#### Bonus delivery
- `bonus_air`	text marker
	- `d_bonus_air_positions_1-4`	e.g d_bonus_air_positions_3
	- `d_bonus_air_positions_carrier_1-4` e.g d_bonus_air_positions_carrier_1
- `bonus_vehicles` text marker	
	- `d_bonus_vec_positions_1-8`	e.g d_bonus_vec_positions_7
#### Unvisible Markers with mission definition 
see missions\fn_create_sm_bymarkers.sqf and  ./fn_getbymarkersm.sqf
- Syntax ***d_smm|N1|Mission|...*** example: d_smm|21|stealflag|flag|1|smarmor|1|2|1|1|400|true|sminf|1|2|300|false
	- ***N1 number must be uniqe***
	- ***Mission - some have sub parameters*** 
		- `convoy|stop/start` (rem)
			- ***d_smm|32|convoy|start*** - Start point
			- ***d_smm|32|convoy|stop*** - End point
		- `stealflag|flag|#` (rem) - flag postion, one flag selected by random
		- `tankdepot|tank|#` (rem) - tank postions
		- `arrest` - a person
		- `deliver` (rem) - a person to base
		- `artibase` (rem) - anti air
		- `evac|time|#` (rem) - timer in minutes to solve the  mission
		- `radiotower` - destroy
		- `prisoners` (rem) - bring to base
		- `stealchopper` - bring to base
		- `stealtank` - bring to base
		- `stealapc` - bring to base
		- `stealplane` - bring to base
		- `specops|radius|#` (rem) - kill specops, positioned within radius
		- `eliminateofficer` - kill
		- `eliminategovmember` - kill
		- `eliminatesniper` (rem) - kill
		- `fuelstation` - destroy
		- `transformer` - destroy
		- `barracks` - destroy
		- `hangar` - destroy
		- `cargotruck` - destroy
		- `minesland` - destroy
		- `minesnaval` - destroy
		- `artycannon` - destroy
		- `dataterminal` - destroy
		- `device` - destroy
		- `sam` - destroy
		- `cache` - destroy
		- `trucks` - destroy
		- `gleak` - destroy gas leaking tank
		- `farp` - destroy
		- `scud` - destroy
	- *** additional troups and vehiclesl
		- (rem) not for : convoy, stealflag, tankdepot, artibase, deliver, evac, prisoners, specops, eliminatesniper
		- `smarmor|N1|N2|N3|N4|N5|B6` or `smarmor|no`
			1. N1 number of "aa"
			2. N2 number of "tracked_apc"
			3. N3 number of "tank", 
			4. N4 multiple teams of aa/tracked_apc/tank) X4
			5. N5 number placement radius 
			6. B6 bolean do patrol
		- `sminf|N1|N2|N3|B4` or `sminf|no`
			1. N1 number of "specops"
			2. N2 number of "allmen"
			3. N3 number placement radius 
			4. B4 bolean do patrol 

## Areas - neddded for gameplay
- `d_whole_island`	whole island, to define the mid
- `d_base_marker`	trigger for enemy at base
- `d_runwaymarker` 	green, turns red if occupied
- `d_isledefense_marker`	troups arround this area spawned if island defense is enabled

## Systems - neddded for gameplay
- `d_zeus`,`HC_D_UNIT`, `Server`	put elsewhere e.g. corner of map
- `d_target_XX`	domination targets, must be near towns - the main missons

## Vehicle/heli placed in the base as head quarters
### neddded for gameplay
The vehicle must supoort vehicle-in-vehicle transport and other features, e.g. WY-55 Hellcat or CRV6e Bobcat
- `d_vec_mhq_1` 
- `d_vec_mhq_2`
### optional additional HQs
- `d_mhq_add_1-#` 
### additional vehicles
d_add_vec_
d_chopper
d_the_carrier

d_bar_x_1-3

farp d_flag_bb

## Hint for testing
If you like to test from the beginning or you get errors, delete database entries on `server` or `../Documents/Arma 3/[your player name]/DominationMissionGroup.vars`.
See: `missionNamespace`, `serverNamespace` on [Arma 33 documentation](https://community.bistudio.com/wiki/Category:Arma_3)
