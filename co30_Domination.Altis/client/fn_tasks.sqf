// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_tasks.sqf"
#include "..\x_setup.sqf"

if (isNil "d_MaxNumAmmoboxes") then {
	waitUntil {!isNil "d_MaxNumAmmoboxes"};
};

#define __BR "<br/>"
#define __BRBR "<br/><br/>"
#define __BRBRBR "<br/><br/><br/>"

private _bar = [
	localize "STR_DOM_MISSIONSTRING_23", __BR,
	"<font face='RobotoCondensed' size=52 color='#ffffff'>Domination! 4</font>", __BRBR,
	"Check out the Domination Wiki for more information: https://github.com/Xeno69/Domination/wiki", __BRBR,
	"Domination is also available on Discord: https://discordapp.com/invite/vYVNKV2", __BRBR,
	"<font size=22>PLEASE NOTE THAT NEITHER THE DOMINATION GIT PAGE NOR THE DOMINATION DISCORD SERVER IS THE RIGHT PLACE TO ASK FOR SERVER BANS, YOU HAVE TO FIND THE SERVER DISCORD OR WEB PAGE AS ANYBODY CAN RUN DOMNINATION!!!!</font>", __BRBR,
	localize "STR_DOM_MISSIONSTRING_24", __BR,
	localize "STR_DOM_MISSIONSTRING_25", __BRBRBR,
	localize "STR_DOM_MISSIONSTRING_26", __BRBR,
	localize "STR_DOM_MISSIONSTRING_27", __BRBR,
	localize "STR_DOM_MISSIONSTRING_28", __BRBR,
	localize "STR_DOM_MISSIONSTRING_29", __BR,
	localize "STR_DOM_MISSIONSTRING_30", __BR,
#ifndef __TT__
	format [localize "STR_DOM_MISSIONSTRING_31", d_MaxNumAmmoboxes], __BR,
#else
	format [localize "STR_DOM_MISSIONSTRING_39", d_MaxNumAmmoboxes], __BR,
#endif
	localize "STR_DOM_MISSIONSTRING_32", __BR,
	localize "STR_DOM_MISSIONSTRING_33", __BRBR,
	localize "STR_DOM_MISSIONSTRING_34", __BR,
	localize "STR_DOM_MISSIONSTRING_35", __BR,
	localize "STR_DOM_MISSIONSTRING_36", __BR,
	localize "STR_DOM_MISSIONSTRING_37", __BRBR,
	localize "STR_DOM_MISSIONSTRING_40", __BRBR,
	localize "STR_DOM_MISSIONSTRING_41", __BR,
	localize "STR_DOM_MISSIONSTRING_42", __BRBR,
	localize "STR_DOM_MISSIONSTRING_43", __BRBR,
	localize "STR_DOM_MISSIONSTRING_44", __BR,
	localize "STR_DOM_MISSIONSTRING_46", __BRBR,
	localize "STR_DOM_MISSIONSTRING_48", __BRBR,
	localize "STR_DOM_MISSIONSTRING_51", __BR,
	localize "STR_DOM_MISSIONSTRING_52", __BR,
	localize "STR_DOM_MISSIONSTRING_54", __BRBR,
	localize "STR_DOM_MISSIONSTRING_55", __BR,
	localize "STR_DOM_MISSIONSTRING_58", __BRBR,
	localize "STR_DOM_MISSIONSTRING_61", __BRBR,
	"Thanks to all people who donate, you guys are great :-)", __BRBR
];

player createDiaryRecord ["Diary", ["Briefing", _bar joinString ""]];

player createDiarySubject ["dLicense","License"];
player createDiaryRecord ["dLicense", ["License", "
Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)<br/><br/>
http://creativecommons.org/licenses/by-nc-nd/4.0/<br/><br/>
You are free to:<br/><br/>
Share - copy and redistribute the material in any medium or format<br/><br/>
The licensor cannot revoke these freedoms as long as you follow the license terms.<br/><br/><br/>
Under the following terms:<br/><br/>
Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner,<br/>
but not in any way that suggests the licensor endorses you or your use.<br/><br/>
NonCommercial - You may not use the material for commercial purposes.<br/><br/>
NoDerivatives - If you remix, transform, or build upon the material, you may not distribute the modified material.<br/><br/><br/>
No additional restrictions - You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
"]];

if (d_database_found && {getClientStateNumber < 10}) then {
	if (!isNil "d_db_savegames" && {serverCommandAvailable "#shutdown" || {isServer}}) then {
		player createDiarySubject ["dDBLoad", localize "STR_DOM_MISSIONSTRING_1750"];
		private _helperar = [];
		{
			_helperar pushBack format ["<execute expression='%1 call d_fnc_db_load_savegame'>%2</execute><br/>", _forEachIndex, _x];
		} forEach d_db_savegames;
		player createDiaryRecord ["dDBLoad", [localize "STR_DOM_MISSIONSTRING_1750", format [localize "STR_DOM_MISSIONSTRING_1751", "<br/><br/>", _helperar joinString ""]]];
	};
};

waitUntil {!isNil "d_current_target_index"};

private _tstate = ["Succeeded", "Assigned"] select (d_current_target_index == -1);
[true, "d_obj00", [localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62"], getPosWorld player, _tstate, 2, false, "Defend", false] call d_fnc_taskcreate;

d_obj00_task = true;
