//Land_i_Addon_02_V1_F
private _h=_this;

private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _chair=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _cup=createSimpleObject["Land_Tableware_01_cup_F",[0,0,0]];
private _desk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
private _laptop=createSimpleObject["Land_Laptop_02_unfolded_F",[0,0,0]];
private _rack1=createSimpleObject["Land_OfficeCabinet_02_F",[0,0,0]];
private _rack2=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];

_desk attachTo[_h,[0,0.07,0.704]];_desk setDir 180;
_rack1 attachTo[_h,[1.1,-0.04,1.06]];_rack1 setDir 180;
_chair attachTo[_h,[0.2,0.25,0.28]];
_laptop attachTo[_h,[0.2,0.2,1.24]];_Laptop setDir 180;
_cup attachTo[_h,[0,0.3,1.16]];
_rack2 attachTo[_h,[3,4.1,0.78]];_rack2 setDir 90;
_blanket attachTo[_h,[-2.3,3.9,.31]];_blanket setDir 270;

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",4];
	if(count _guyHome>0)then{
	private _fire1=createVehicle["MetalBarrel_burning_F",[0,0,0],[],0,"can_collide"];
	_fire1 attachTo[_h,[-3.05,.1,.7]];_fire1 setDir(random 359);
	sleep .5;
detach _fire1;};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};