// by Xeno
#define THIS_FILE "fn_scoreaddqeue.sqf"
#include "..\x_setup.sqf"

disableSerialization;

while {!(d_scoreadd_qeue isEqualTo [])} do {
	private _nextele = d_scoreadd_qeue # 0;
	d_scoreadd_qeue deleteAt 0;
	
	private _ctrl = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
	_ctrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.45, 0.5, 0.4];
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;
	_ctrl ctrlSetStructuredText parseText format ["<t size='1.3' color='#C07F7F7F'>+ %1 </t><t size='1' color='#C0ffffff'> %2</t>", _nextele # 1, _nextele # 0];
	_ctrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.6, 0.5, 0.4];
	_ctrl ctrlSetFade 0;
	_ctrl ctrlCommit 0.4;
	sleep 2.5;
	_ctrl ctrlSetPosition [safeZoneX + 0.1, safeZoneY + safeZoneH - 0.75, 0.5, 0.4];
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0.3;
	_ctrl spawn {
		disableSerialization;
		sleep 1;
		ctrlDelete _this;
	};
};
