// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_serverrules.sqf"
#include "..\x_setup.sqf"

"Welcome to Domination!" hintC [
    parseText 
	"
	<br/><t align='center'>Domination</t>
	<br/><t align='center'><t size='0.9'>Server Rules</t></t>
	<br/>
	<br/><t size='0.9'> 
	1) Shooting at base is not allowed<br/>
	2) Destroying objects and vehicles at base is not allowed<br/>
	3) Intentional teamkilling is not tolerated<br/>
	4) VOIP in Global\Faction channel is not allowed<br/>
	5) Verbal abuse is not tolerated<br/>
	6) Recruiting\Spamming is not allowed<br/>
	7) Respect and teamplay! </t><br/>
	<br/>
	<br/>
	<t align='right'><t size='0.9'>
	Domination Steam Page : <a underline='true' color='#00ff4c' href='https://steamcommunity.com/sharedfiles/filedetails/?id=332088703'>Domination On Steam</a><br/>
	<br/></t></t>
	"
];

d_hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
	0 = _this spawn {
		scriptName "spawn_serverrules";
		_this select 0 displayRemoveEventHandler ["unload", d_hintC_EH];
		d_hintC_EH = nil;
		hintSilent "";
	};
}];