//Land_House_Small_02_F
private _h=_this;

private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _boxes=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes enableSimulationGlobal false;
private _bucket1=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
private _bucket2=createSimpleObject["Land_PlasticBucket_01_closed_F",[0,0,0]];
private _bucket3=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair=createSimpleObject["Land_CampingChair_V2_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow=createSimpleObject[_pillow,[0,0,0]];
private _radio=createSimpleObject["Land_SurvivalRadio_F",[0,0,0]];
private _shelf=createSimpleObject["Land_OfficeCabinet_02_F",[0,0,0]];
private _trash=createVehicle["Land_Garbage_square3_F",[0,0,0],[],0,"can_collide"];_trash enableSimulationGlobal false;

_bed attachTo[_h,[.42,3,0.2]];_bed setDir 270;
_blanket attachTo[_h,[.42,3,0.62]];_blanket setDir 180;
_pillow attachTo[_h,[.42,2.25,0.64]];_pillow setDir 180;
_shelf attachTo[_h,[.42,.4,.91]];_shelf setDir 180;
_basket attachTo[_h,[-4.25,.525,.48]];_basket setDir(random 359);
_trash attachTo[_h,[-2,3,.17]];_trash setDir(random 359);
_can attachTo[_h,[-4.3,-5.93,.4]];_can setDir(random 359);
_boxes attachTo[_h,[.445,-5.71,.896]];_boxes setDir 0;
_bucket1 attachTo[_h,[0,-5.5,.35]];_bucket1 setDir(random 90+270);
_bucket2 attachTo[_h,[-.005,-6,.35]];_bucket2 setDir(random 90+270);
_bucket3 attachTo[_h,[-.005,-5.7,.79]];_bucket3 setDir(random 359);
_chair attachTo[_h,[-4.19,-0.575,.62]];_chair setDir 320;
_radio attachTo[_h,[-4.5,-1.25,.235]];_radio setDir 90;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};