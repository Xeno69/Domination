//#define __DEBUG__
#define THIS_FILE "animateLetter2.sqf"
#include "..\x_setup.sqf"

disableSerialization;
params ["_ctrl"];

__TRACE_1("","_this")

d_animL_controls = d_animL_controls - [_ctrl];
_ctrl ctrlSetTextColor d_intro_color;
_ctrl ctrlSetText (param [1]);

private _rdmX = -1;
private _rdmY = -1;
private _quadrant = random 4;
_quadrant = _quadrant - (_quadrant % 1);
switch (_quadrant) do {
	case 0: {
		_rdmX = -0.1;
		_rdmY = (random 1);
	};
	case 1: {
		_rdmX = (random 1);
		_rdmY = -0.1;
	};
	case 2: {
		_rdmX = 1.1;
		_rdmY = (random 1);
	};
	case 3: {
		_rdmX = (random 1);
		_rdmY = 1.1;
	};
	default {};			
};
_ctrl ctrlSetPosition [_rdmX, _rdmY];
_ctrl ctrlSetFade 0;
_ctrl ctrlSetScale 1.2;
_ctrl ctrlCommit 0;
_ctrl ctrlSetPosition [((param [2]) * 0.025) + 0.13,0.05 + (param [3]) / 330];
_ctrl ctrlCommit 0.5;
sleep 15;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 1;
sleep 2;
d_animL_controls pushBack _ctrl;

true