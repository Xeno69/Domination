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

PF_Dbug=FALSE;										//TRUE enables debug mode, FALSE disables it

PF_Chance=99;										//% Chance for furniture to spawn per house

PF_Optimize=TRUE;								//TRUE enables hiding all furniture until player is within XXX meters, FALSE disables it

PF_OptimizeDistance=70;								//in meters, if PF_Optimize is TRUE then items outside of this radius are hidden (default: 150)

//DON'T EDIT BELOW
publicVariable"PF_Optimize";
publicVariable"PF_OptimizeDistance";