// by Xeno
#define THIS_FILE "fn_gimmick.sqf"
#include "..\x_setup.sqf"

#ifdef __OWN_SIDE_BLUFOR__
	
private _objs = (allMissionObjects "HBarrier_base_F") select {"d_bar_x_" in (str _x)};

if (_objs isEqualTo []) exitWith {};

sleep 1;

private _cnames = ["B_MBT_01_TUSK_F", "B_MBT_01_cannon_F", "B_APC_Tracked_01_AA_F", "B_APC_Tracked_01_rcws_F", "B_APC_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_cannon_F", "B_AFV_Wheeled_01_up_cannon_F", "B_Plane_Fighter_01_F", "B_Plane_Fighter_01_Stealth_F",
	"B_Plane_CAS_01_dynamicLoadout_F", "B_Heli_Light_01_dynamicLoadout_F", "B_Heli_Attack_01_dynamicLoadout_F"];
	
private _objsar = [];
	
while {true} do {
	private _cnamesew =+ _cnames;
	{deleteVehicle _x} forEach _objsar;
	_objsar = [];
	{
		private _curname = selectRandom _cnamesew;
		private _obj = createSimpleObject [_curname, [0,0,0], true];
		_obj attachTo [_x, [0,0,[0.9, 0.85] select (_curname isKindOf "Air")]];
		_obj setObjectScale 0.1;
		_cnamesew = _cnamesew - [_curname];
		_objsar pushBack _obj;
	} forEach _objs;
	
	sleep 600;
};

#endif
