// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

while {true} do {
#ifndef __TT__
	d_allplayers = (allPlayers - entities "HeadlessClient_F") select {!isNull _x && {!(_x isKindOf "VirtualMan_F")}};
#else
	d_allplayers = (allPlayers - entities "HeadlessClient_F") select {!isNull _x && {!(_x isKindOf "VirtualMan_F") && {d_player_side getFriend side (group _x) >= 0.6}}};
#endif
	d_allplayermapd = d_allplayers select {!(_x getVariable "xr_pluncon") && {!(_x getVariable ["xr_plno3dd", false])}};
	if (d_with_ai) then {
		sleep 0.2;
		private _tmpgrps = [];
		{
			_tmpgrps pushBackUnique (group _x);
		} forEach d_allplayers;
		sleep 0.1;
		d_allplayerai = [];
		{
			d_allplayerai append ((units _x) select {alive _x && {!(isPlayer _x)}});
		} forEach _tmpgrps;
	};
	if (!d_tt_ver && {d_showallnearusermarkers}) then {
		sleep 0.1;
		d_allnearusermarkers = [];
		d_allnearusermarkers resize 16;
		d_allnearusermarkers = d_allnearusermarkers apply {[]};
		{	
			private _split_ar = _x splitString "#/";
			if ((_split_ar # 3) isNotEqualTo "") then {
				private _chan = parseNumber (_split_ar # 3);
				if (_chan > 0) then {
					(d_allnearusermarkers # _chan) pushBack _x;
				};
			};
		} forEach (allMapMarkers select {_x find "_USER_DEFINED #" == 0 && {markerPos _x distance2D player < 800}});
	};
	sleep 2;
};