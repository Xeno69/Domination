//Land_i_Stone_Shed_01_c_raw_F
private _h=_this;

private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _bucket=createSimpleObject["Land_Bucket_F",[0,0,0]];
private _chair=createSimpleObject["Land_CampingChair_V1_F",[0,0,0]];
private _towels=createSimpleObject["Land_Tableware_01_stackOfNapkins_F",[0,0,0]];
private _trash=createSimpleObject["Land_Garbage_square3_F",[0,0,0]];

_blanket attachTo[_h,[-.5,3.3,.3]];
_bucket attachTo[_h,[-.8,2,.41]];_bucket setDir 90;
_towels attachTo[_h,[-.55,1.9,.3]];_towels setDir(random 359);
_trash attachTo[_h,[2,2,.3]];_trash setDir(random 359);
_chair attachTo[_h,[5.7,4,.75]];_chair setDir 45;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};