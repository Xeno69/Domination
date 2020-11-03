//Land_Slum_House02_F
private _h=_this;

private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _blanket=createVehicle[(selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"]),[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _boxes=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes enableSimulationGlobal false;
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];
private _trash=createVehicle["Land_Garbage_square3_F",[0,0,0],[],0,"can_collide"];

_boxes attachTo[_h,[2.95,3.25,.84]];
_basket attachTo[_h,[2.32,3.54,.42]];_basket setDir(random 359);
_table attachTo[_h,[2.58,-1.18,.5]];_table setDir 90;
_chair attachTo[_h,[2.6,-.77,.07]];
_can attachTo[_h,[1.67,-1.5,.41]];
_blanket attachTo[_h,[2.9,1.6,.1]];_blanket setDir 3;
_trash attachTo[_h,[1.6,1,.12]];_trash setDir(random 359);

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};