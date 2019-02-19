// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ai_loop.sqf"
#include "..\..\x_setup.sqf"

private _cur_state = call d_fnc_nightfograin;

#ifndef __DEBUG__
sleep 300;
#else
sleep 5;
#endif

while {true} do {
	private _new_state = call d_fnc_nightfograin;
	if (_cur_state != _new_state) then {
		_cur_state = _new_state;
		
		{
			private _objp = objectParent _x;
			if (isNull _objp || {driver _objp != _x && {gunner _objp != _x}}) then {
				[_x, _new_state] call d_fnc_changeskill;
			};
			sleep 0.1;
		} forEach (allUnits select {!isPlayer _x});
	};
#ifndef __DEBUG__
	sleep 300;
#else
	sleep 5;
#endif	
};