//Land_Slum_03_F
private _H=_this;

private _barrel=createSimpleObject["Land_BarrelEmpty_grey_F",[0,0,0]];
private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _bucket1=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
private _bucket2=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
private _rack1=createSimpleObject["Land_Rack_F",[0,0,0]];
private _rack2=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _rack3=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _boxes1=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes1 enableSimulationGlobal false;
private _boxes2=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes2 enableSimulationGlobal false;
private _pBoxes=createVehicle["Land_CratesPlastic_F",[0,0,0],[],0,"can_collide"];_pBoxes enableSimulationGlobal false;
private _sack=createVehicle["Land_Sacks_F",[0,0,0],[],0,"can_collide"];_sack enableSimulationGlobal false;
private _sacks1=createVehicle["Land_Sacks_heap_F",[0,0,0],[],0,"can_collide"];_sacks1 enableSimulationGlobal false;
private _sacks2=createVehicle["Land_Sacks_goods_F",[0,0,0],[],0,"can_collide"];_sacks2 enableSimulationGlobal false;
private _wBarrel=createSimpleObject["Land_BarrelWater_F",[0,0,0]];
private _trash=createVehicle["Land_Garbage_square5_F",[0,0,0],[],0,"can_collide"];_trash enableSimulationGlobal false;
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket1=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket1 enableSimulationGlobal false;
private _blanket2=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket2 enableSimulationGlobal false;

_boxes1 attachTo[_H,[5.4,4.3,1.385]];
_boxes2 attachTo[_H,[5.35,3.44,1.385]];_boxes2 setDir 270;
_sack attachTo[_H,[5.5,7.45,1.04]];
_sacks1 attachTo[_H,[1.4,7.15,1]];
_rack2 attachTo[_H,[.93,4,1.1]];
_rack1 attachTo[_H,[.93,2.7,1.1]];
_rack3 attachTo[_H,[2.41,-1.3,1.1]];
_sacks2 attachTo[_H,[-.12,-1,1.1]];_sacks2 setDir 40;
_basket attachTo[_H,[.23,1.65,.95]];_basket setDir(random 359);
_pBoxes attachTo[_H,[-.6,1.65,.85]];_pBoxes setDir 180;
_bucket1 attachTo[_H,[-3.5,2.3,.84]];_bucket1 setDir(random 359);
_bucket2 attachTo[_H,[-3.9,2.5,.84]];_bucket2 setDir(random 359);
_wBarrel attachTo[_H,[-4.96,2.35,1.02]];_wBarrel setDir(random 359);
_barrel attachTo[_H,[-4.35,2.38,1.02]];_barrel setDir(random 359);
_blanket1 attachTo[_H,[0,3.2,.65]];_blanket1 setDir 180;
_blanket2 attachTo[_H,[-1.5,3.2,.65]];_blanket2 setDir(random 40)+180;
_trash attachTo[_H,[-2.3,5,.66]];_trash setDir(random 359);

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};