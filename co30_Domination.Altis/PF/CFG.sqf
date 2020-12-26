//PHRONK'S FURNITURE SCRIPT	v0.6


PF_BlacklistMkr=["BLUmkr","BL_Mkr0"];	//List of markers to prevent furniture spawning in them

//List of location names to prevent furniture triggers being created in them
PF_BlacklistLoc=[
//ALTIS
	"airbase","Gravia","military","power plant","Terminal",
//MALDEN
	"Airport","military base","Radio Station","harbor","Les Sables",
//STRATIS
	"airfield","Girna Bay","military range","Stratis Air Base",
//TANOA
	"Blue Pearl industrial port","Comms Bravo"];

PF_BlacklistObj=[];									//List of building classnames to avoid spawning furniture in

//PF_Dbug=TRUE;										//TRUE enables debug mode, FALSE disables it
PF_Dbug=FALSE;										//TRUE enables debug mode, FALSE disables it

PF_Chance=95;										//% Chance for furniture to spawn per house

PF_Optimize=TRUE;								//TRUE enables hiding all furniture until player is within 150m, FALSE disables it

//DON'T EDIT BELOW
publicVariable"PF_Optimize";