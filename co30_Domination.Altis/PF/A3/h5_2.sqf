//Land_i_Stone_HouseBig_V1_F
private _h=_this;

private _axe=createSimpleObject["Land_Axe_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket1=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket1 enableSimulationGlobal false;
private _blanket2=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket2 enableSimulationGlobal false;
private _blanket3=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket3 enableSimulationGlobal false;
private _chair1=createSimpleObject["Land_CampingChair_V1_F",[0,0,0]];
private _chair2=createSimpleObject["Land_CampingChair_V1_F",[0,0,0]];
private _graf=selectRandom["Land_Graffiti_01_F","Land_Graffiti_02_F","Land_Graffiti_03_F","Land_Graffiti_04_F"];
private _graf1=createVehicle[_graf,[0,0,0],[],0,"can_collide"];_graf1 enableSimulationGlobal false;
private _graf2=createVehicle[_graf,[0,0,0],[],0,"can_collide"];_graf2 enableSimulationGlobal false;
private _log1=createSimpleObject["Land_WoodenLog_F",[0,0,0]];
private _log2=createSimpleObject["Land_WoodenLog_F",[0,0,0]];
private _log3=createSimpleObject["Land_WoodenLog_F",[0,0,0]];
private _logs=createVehicle["Land_WoodPile_F",[0,0,0],[],0,"can_collide"];_logs enableSimulationGlobal false;
private _stool=createSimpleObject["Land_Bench_F",[0,0,0]];
private _stump=createSimpleObject["Land_WoodenLog_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_large_F",[0,0,0]];

_blanket1 attachTo[_h,[-1.1,-1.2,3]];_blanket1 setDir 270;
_blanket2 attachTo[_h,[-1,.3,3.03]];_blanket2 setDir 250;
_blanket3 attachTo[_h,[-1.6,2.7,3.04]];_blanket3 setDir 0;
_table attachTo[_h,[-1.05,-1,0.5]];_table setDir 270;
_stool attachTo[_h,[-1.05,-0.1,0.4]];_stool setDir 90;
_log1 attachTo[_h,[1,3.2,1.52]];_log1 setDir(random 359);
_log2 attachTo[_h,[0.45,3.45,1.52]];_log2 setDir(random 359);
_log3 attachTo[_h,[0.7,3.3,2.05]];_log3 setDir(random 359);
_stump attachTo[_h,[-.3,3.5,.425]];_stump setDir 90;_stump setVectorUp[0,1,0];
_logs attachTo[_h,[3.7,3.5,0.45]];_logs setDir 90;
_axe attachTo[_h,[0.4,3,1.27]];_axe setDir 40;
_graf1 attachTo[_h,[-2.17,.1,4]];_graf1 setDir 270;
_graf2 attachTo[_h,[0,3.825,4]];
_chair1 attachTo[_h,[4.7,-1.2,3.5]];_chair1 setDir(random 40)+90;
_chair2 attachTo[_h,[4.7,-0.1,3.5]];_chair2 setDir(random 40)+50;

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _fire1=createVehicle["Fireplace_burning_F",[0,0,0],[],0,"can_collide"];
	_fire1 attachTo[_h,[0.47,3.05,.35]];
	sleep .5;
	detach _fire1;
	};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};