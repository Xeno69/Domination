// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_allplayers.sqf"
#include "..\..\x_setup.sqf"

while {true} do {
	d_allplayers = (allPlayers - entities "HeadlessClient_F") select {!isNull _x && {d_player_side getFriend side (group _x) >= 0.6}};
	if (d_showallnearusermarkers) then {
		sleep 0.1;
		d_allnearusermarkers = [];
		d_allnearusermarkers resize 16;
		d_allnearusermarkers = d_allnearusermarkers apply {[]};
		{	
			private _split_ar = _x splitString "#/";
			if (_split_ar # 3 != "" && {_split_ar # 1 != ""}) then {
#ifndef __DEBUG__
				private _unit = objectFromNetId (_split_ar # 1);
				if (!isNull "_unit" && {d_player_side getFriend side (group _unit) >= 0.6}) then {
#endif
					private _chan = parseNumber (_split_ar # 3);
					if (_chan > 0) then {
						(d_allnearusermarkers # _chan) pushBack _x;
					};
#ifndef __DEBUG__
				};
#endif
			};
		} forEach (allMapMarkers select {_x select [0, 15] == "_USER_DEFINED #" && {markerPos _x distance2D player < 1000}});
	};
	sleep 2;
};