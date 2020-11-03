//Land_Shed_08_grey_F
private _h=_this;

private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _box1=createVehicle["Land_PaperBox_01_small_destroyed_brown_F",[0,0,0],[],0,"can_collide"];_box1 enableSimulationGlobal false;
private _box2=createVehicle["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0],[],0,"can_collide"];_box2 enableSimulationGlobal false;
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _rack=createSimpleObject["Land_OfficeCabinet_02_F",[0,0,0]];
private _sack=createSimpleObject["Land_Sack_F",[0,0,0]];
private _sacks=createSimpleObject["Land_Sacks_goods_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];
private _trash=createSimpleObject["Land_Garbage_square5_F",[0,0,0]];
private _trashPile=createSimpleObject["Land_GarbageBags_F",[0,0,0]];
private _graf=selectRandom["Land_Graffiti_01_F","Land_Graffiti_02_F","Land_Graffiti_03_F","Land_Graffiti_04_F"];
private _graf=createVehicle[_graf,[0,0,0],[],0,"can_collide"];_graf enableSimulationGlobal false;

_table attachTo[_h,[-4.45,-2.2,.5]];_table setDir 90;
_chair1 attachTo[_h,[-4.5,-1.8,.07]];_chair1 setDir 0;
_chair2 attachTo[_h,[-3.8,-2.3,.07]];_chair2 setDir(random 25)+90;
_rack attachTo[_h,[-1.9,2.95,.88]];_rack setDir 0;
_sack attachTo[_h,[-1.35,-2.36,.5]];_sack setDir 45;
_sacks attachTo[_h,[0,-1.7,.54]];_sacks setDir 40;
_basket attachTo[_h,[0.6,-.95,.41]];_basket setDir(random 359);
_blanket attachTo[_h,[-1.5,-1,.1]];_blanket setDir 180;
_graf attachTo[_h,[-5.37,1,1.5]];_graf setDir 270;
_trash attachTo[_h,[2.5,0,0.1]];_trash setDir(random 359);
_trashPile attachTo[_h,[4,-1.2,0.2]];_trashPile setDir(random 359);
_box1 attachTo[_h,[5,1.5,0.3]];_box1 setDir(random 359);
_box2 attachTo[_h,[4,0.6,0.3]];_box2 setDir(random 359);

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light=createVehicle["MetalBarrel_burning_F",[0,0,0],[],0,"can_collide"];
	_light setDir(random 359);
	_light attachTo[_h,[5.15,-2.4,0.5]];
	sleep .5;
detach _light;};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};