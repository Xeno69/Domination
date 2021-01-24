// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_serverrules.sqf"
#include "..\x_setup.sqf"

"Welcome to Domination!" hintC [
    parseText 
	"
	<img size='10' align='center' image='pics\domls.paa'/>
	<br/><t align='center'><t size='1.2'><t color='#FF0000'>SERVER RULES</t><br/>
	<br/><t align='left'><t size='1'>
	1) Shooting at base is not allowed<br/>
	2) Destroying objects and vehicles at base is not allowed<br/>
	3) Intentional teamkilling is not tolerated<br/>
	4) VOIP in Global\Faction channel is not allowed<br/>
	5) Verbal abuse is not tolerated<br/>
	6) Recruiting\Spamming is not allowed<br/>
	7) Respect and teamplay! </t><br/>
	<br/>
	The punishment for each specific violation is determined by the present representative of the administration independently, depending on the specific situation.<br/>
	Punishment for violation of these rules is imposed on the player by blocking his access to the server.</t><br/>
	<br/>
	<t align='left'><t size='1'>
	Domination Steam Page (not for server related questions): <a underline='true' color='#00ff4c' href='https://steamcommunity.com/sharedfiles/filedetails/?id=332088703'>Domination On Steam</a><br/>
	Domination on Discord (not for server related questions): <a underline='true' color='#00ff4c' href='https://discordapp.com/invite/vYVNKV2'>Domination</a><br/>
	<br/></t></t>
	"
];

d_hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
	0 = _this spawn {
		scriptName "spawn_serverrules";
		_this # 0 displayRemoveEventHandler ["unload", d_hintC_EH];
		d_hintC_EH = nil;
		hintSilent "";
	};
}];
