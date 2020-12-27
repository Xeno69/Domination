if(!isServer)exitWith{};
private["_towns","_town","_townName","_townPos","_townX","_townY","_townDir","_tArea"];
PF_WN=worldName;
PF_Houses=[
//Altis, Malden, Stratis
"Land_i_House_Small_01_V1_F",
"Land_i_House_Small_01_V2_F",
"Land_i_House_Small_01_V3_F",
"Land_i_House_Small_01_b_blue_F",
"Land_i_House_Small_01_b_pink_F",
"Land_i_House_Small_01_b_white_F",
"Land_i_House_Small_01_b_whiteblue_F",
"Land_i_House_Small_01_b_brown_F",
"Land_i_House_Small_01_b_yellow_F",
"Land_i_House_Small_02_V1_F",
"Land_i_House_Small_02_V2_F",
"Land_i_House_Small_02_V3_F",
"Land_i_House_Small_03_V1_F",
"Land_Slum_House01_F",
"Land_Slum_House02_F",
"Land_Slum_House03_F",
"Land_i_Stone_Shed_V1_F",
"Land_i_Stone_Shed_V2_F",
"Land_i_Stone_Shed_V3_F",
"Land_i_Stone_HouseSmall_V1_F",
"Land_i_Stone_HouseSmall_V2_F",
"Land_i_Stone_HouseSmall_V3_F",
"Land_Shed_08_brown_F",
"Land_Shed_08_grey_F",
"Land_i_Stone_Shed_01_b_clay_F",
"Land_i_Stone_Shed_01_b_raw_F",
"Land_i_Stone_Shed_01_b_white_F",
"Land_i_Stone_Shed_01_c_clay_F",
"Land_i_Stone_Shed_01_c_raw_F",
"Land_i_Stone_Shed_01_c_white_F",
"Land_Barn_01_brown_F",
"Land_Barn_01_grey_F",
"Land_i_Addon_02_V1_F",
"Land_i_Addon_03_V1_F",
"Land_CarService_F",
"Land_FuelStation_02_workshop_F",
"Land_i_Garage_V1_F",
"Land_i_Garage_V2_F",
"Land_i_Stone_HouseBig_V1_F",
"Land_i_Stone_HouseBig_V2_F",
"Land_i_Stone_HouseBig_V3_F",
"Land_i_Stone_House_Big_01_b_clay_F",
"Land_i_House_Big_01_V1_F",
"Land_i_House_Big_01_V2_F",
"Land_i_House_Big_01_V3_F",
"Land_i_House_Big_01_b_blue_F",
"Land_i_House_Big_01_b_whiteblue_F",
"Land_i_House_Big_01_b_pink_F",
"Land_i_House_Big_01_b_pink_F",
"Land_i_House_Big_01_b_white_F",
"Land_i_House_Big_01_b_brown_F",
"Land_i_House_Big_02_V1_F",
"Land_i_House_Big_02_V2_F",
"Land_i_House_Big_02_V3_F",
"Land_i_House_Big_02_b_blue_F",
"Land_i_House_Big_02_b_pink_F",
"Land_i_House_Big_02_b_white_F",
"Land_i_House_Big_02_b_whiteblue_F",
"Land_i_House_Big_02_b_brown_F",
"Land_i_House_Big_02_b_yellow_F",
"Land_i_Shop_01_V1_F",
"Land_i_Shop_01_V2_F",
"Land_i_Shop_01_V3_F",
"Land_i_Shop_02_V1_F",
"Land_i_Shop_02_V2_F",
"Land_i_Shop_02_V3_F",
"Land_i_Shop_02_b_blue_F",
"Land_i_Shop_02_b_pink_F",
"Land_i_Shop_02_b_white_F",
"Land_i_Shop_02_b_whiteblue_F",
"Land_i_Shop_02_b_brown_F",
"Land_i_Shop_02_b_yellow_F",
"Land_Offices_01_V1_F",

//Tanoa
"Land_House_Big_01_F",
"Land_House_Small_02_F",
"Land_House_Small_03_F",
"Land_Shed_02_F",
"Land_Slum_03_F",
"Land_House_Small_05_F",
"Land_House_Small_06_F"];

PF_Blacklist=[];
{if(!(_x in allMapMarkers))then{PF_BlacklistMkr=PF_BlacklistMkr-[_x];};}count PF_BlacklistMkr;
if(count(PF_BlacklistObj)>0)then{{if(_x in PF_BlacklistObj)then{PF_Houses=PF_Houses-[_x];};}count PF_Houses;};
PF_Blacklist append PF_BlacklistMkr;
PF_Mkrs=[];

_towns=configFile>>"CfgWorlds">>PF_WN>>"Names";

for"_x"from 0 to(count _towns-1)do{
_town=_towns select _x;
_townName=getText(_town>>"name");
if(!(_townName in PF_BlacklistLoc))then{
_townPos=[0,0,0];
_townX=0;
_townY=0;
_tArea=0;


switch(PF_WN)do{
	case"Malden":{switch(getText(_town>>"name"))do{
		case"Dourdan":{_townPos=[7035.72,7108.35,0];_townX=200;_townY=200;};
		case"Girna":{_townPos=[2000.04,2730.52,0.000465393];_townX=150;_townY=100;}:
		default{_townPos=getArray(_town>>"position");_townX=getNumber(_town>>"radiusA");_townY=getNumber(_town>>"radiusB");};};};

	case"Stratis":{switch(getText(_town>>"name"))do{
		case"Agia Marina":{_townPos=[2999.09,6004.84,0.00143862];_townX=200;_townY=200;};
		case"Girna":{_townPos=[2000.04,2730.52,0.000465393];_townX=150;_townY=100;}:
		default{_townPos=getArray(_town>>"position");_townX=getNumber(_town>>"radiusA");_townY=getNumber(_town>>"radiusB");};};
		};

	case"Tanoa":{switch(getText(_town>>"name"))do{
		case"Georgetown":{_townPos=[5882.32,10286.2,14.9347];_townX=500;_townY=500;};
		case"Georgetown Bay":{_townPos=[5097.57,9812.7,7.23615];_townX=295;_townY=250;}:
		default{_townPos=getArray(_town>>"position");_townX=getNumber(_town>>"radiusA");_townY=getNumber(_town>>"radiusB");};};
		};

	default{_townPos=getArray(_town>>"position");_townX=getNumber(_town>>"radiusA");_townY=getNumber(_town>>"radiusB");};
};
if(_townX>_townY)then{_tArea=_townX;_tArea}else{_tArea=_townY;_tArea};
_townDir=getNumber(_town>>"angle");

	if(count(nearestObjects[_townPos,PF_Houses,_tArea])>0)then{
	if(PF_Dbug)then{
	private _m=createMarker[format["m--%1",_townPos],_townPos];
	_m setMarkerShape"RECTANGLE";
	_m setMarkerBrush"SolidBorder";
	_m setMarkerSize[_tArea,_tArea];
	//_m setMarkerAlpha 0.4;
	_m setMarkerAlpha 0;
	_m setMarkerColor"ColorCiv";
	_m setMarkerDir _townDir;
	PF_Mkrs pushBack _m;};
	
	_t=createTrigger["EmptyDetector",_townPos,false];
	_t setTriggerArea[_tArea,_tArea,_townDir,true,99];
	_t setTriggerTimeout[2,2,2,true];
	_t setTriggerActivation["ANYPLAYER","PRESENT",TRUE];

sleep .02;

	_t setTriggerStatements[
	//TRIGGER CONDITION
	"{isPlayer _x}count thisList>0",

	//TRIGGER ACTIVATION
	"if(PF_Dbug)then{systemChat'Trigger Activated';};
	private _tPos=getPosASL thisTrigger;
	
	private _nearH=nearestObjects[_tPos,PF_Houses,((triggerArea thisTrigger)select 0)+40,true];
	if(PF_Dbug)then{systemChat format['%1 houses found',count _nearH];{if(getMarkerPos _x distance _tPos<=5)then{_x setMarkerAlpha 1;};}forEach PF_Mkrs;};

		{if(PF_Chance>floor random 100)then{
		if((isObjectHidden _x)||(damage _x>0.5))exitWith{};

		_isBL=false;
		if(!(PF_Blacklist isEqualTo[])||{(PF_Blacklist isEqualTo[''])})then{_h=_x;{_isBL=_h inArea _x;if(_isBL)exitWith{_nearH=_nearH-[_H];};}count PF_Blacklist;};
		if(_isBL)exitWith{};
		_hPads=_x nearObjects['Land_HelipadEmpty_F',2];
		if(count _hPads>0)exitWith{};
		private _H=createVehicle['Land_HelipadEmpty_F',getPosATL _x,[],0,'can_collide'];
		_H setDir(getDir _x);
		if(PF_Optimize)then{_H setVariable['PF',true,true];}else{_H setVariable['PF',true,false];};
		[_H,_x]call PF_spawn;};
		}forEach _nearH;",

	//TRIGGER DEACTIVATION
	"private _tPos=getPosASL thisTrigger;
	if(PF_Dbug)then{systemChat'Trigger Deactivated';{if(getMarkerPos _x distance _tPos<=5)then{_x setMarkerAlpha 0.4;};}forEach PF_Mkrs;};
	{	_isBL2=false;
		if(!(PF_Blacklist isEqualTo[])||{(PF_Blacklist isEqualTo[''])})then{_furn=_x;{_isBL2=_furn inArea _x;if(_isBL2)exitWith{};}count PF_Blacklist;};
		if(_isBL2)exitWith{};
		
		if(typeOf _x in['FirePlace_burning_F','Land_FirePlace_F','MetalBarrel_burning_F'])then{deleteVehicle _x;};
		if((typeOf _x isEqualTo'Land_HelipadEmpty_F')&&{(_x getVariable'PF')})then{{deleteVehicle _x}count attachedObjects _x;deleteVehicle _x;};

	}forEach nearestObjects[_tPos,['Land_HelipadEmpty_F','Fireplace_burning_F','MetalBarrel_burning_F'],((triggerArea thisTrigger)select 0)+40,true];"];
		};
	};
};

addMissionEventHandler["buildingChanged",{
private _b=_this select 1;
if(!(typeOf _b in["House_F","HouseBase","House_EP1"]))exitWith{};
if(count(_b buildingPos -1)<2)exitWith{};
private _pad=(_b nearObjects["Land_HelipadEmpty_F",2])select 0;
if(_pad getVariable'PF')then{{deleteVehicle _x}forEach attachedObjects _pad;deleteVehicle _pad;};}];