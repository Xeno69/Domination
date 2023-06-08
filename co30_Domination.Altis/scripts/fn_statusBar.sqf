//#define __DEBUG__
#include "..\x_setup.sqf"

disableSerialization;
/*
	Author: Osef
	Edited by: [Babayka]
	Improved by: Xeno
*/

#ifndef __TT__
private _formatstr = "
	<t align='center'>
	<img size='1.0' image='pics\players.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1981") + ": %1  
	<img size='1.0' image='pics\summ.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1223") + ": %2  
	<img size='1.0' image='pics\star.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1982") + ": %3  
	<img size='1.0' image='pics\flag.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1983") + ": %4 / %5  
	<img size='1.0' image='pics\bomb.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1984") + ": %6 / %7
	<img size='1.0' image='pics\bomb.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1984a") + ": %8</t>";
#else
private _formatstr = "
	<t align='center'>
	<img size='1.0' image='pics\players.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1981") + ": %1  
	<img size='1.0' image='pics\summ.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1223") + ": %2  
	<img size='1.0' image='pics\star.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1982") + ": %3  
	<img size='1.0' image='pics\flag.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1983") + ": %4 / %5  
	<img size='1.0' image='pics\bomb.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1984") + ": %6 / %7  
	<img size='1.0' image='\A3\Data_F\Flags\Flag_blue_CO.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1985") + ": %8  
	<img size='1.0' image='\A3\Data_F\Flags\Flag_red_CO.paa'/> " + (localize "STR_DOM_MISSIONSTRING_1985") + ": %9</t>";
#endif

"d_infobar" cutRsc ["d_infobar", "PLAIN"];

if (isNil "d_mission_is_now_over") then {
	d_mission_is_now_over = false;
};



while {!d_mission_is_now_over} do {
	private _disp = uiNamespace getVariable "d_infobar";
	if (isNil "_disp" || {isNull _disp}) then {
		"d_infobar" cutRsc ["d_infobar", "PLAIN"];
		_disp = uiNamespace getVariable "d_infobar";
	};
	sleep 0.1;
	if (d_player_canu) then {
#ifndef __TT__
		(_disp displayCtrl 1102) ctrlSetStructuredText parseText format[
			_formatstr,
			count (allPlayers - entities "HeadlessClient_F"),
			score player,
			rank player,
			d_campscaptured,
			d_numcamps, 
			d_num_barracks_objs,
			d_num_barracks_tt,
			["1", "0"] select d_mt_mobile_hq_down
		];
#else
		if (d_player_side == opfor) then {
			(_disp displayCtrl 1102) ctrlSetStructuredText parseText format[
				_formatstr,
				count (allPlayers - entities "HeadlessClient_F"),
				score player,
				rank player,
				d_campscaptured_e,
				d_numcamps, 
				d_num_barracks_objs,
				d_num_barracks_tt,
				scoreSide west, 
				scoreSide east
			];
		} else {
			(_disp displayCtrl 1102) ctrlSetStructuredText parseText format[
				_formatstr,
				count (allPlayers - entities "HeadlessClient_F"),
				score player,
				rank player,
				d_campscaptured_w,
				d_numcamps, 
				d_num_barracks_objs,
				d_num_barracks_tt,
				scoreSide west, 
				scoreSide east
			];
		};
#endif
		sleep 0.1;
		private _timeend = time + 2;
		while {time < _timeend && {d_player_canu}} do {
			sleep 0.3;
		};
	} else {
		(_disp displayCtrl 1102) ctrlSetStructuredText text "";
		waitUntil {
			sleep 0.3;
			d_player_canu
		};
	};
};
