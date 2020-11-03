//Land_House_Small_03_F
private _H=_this;

private _barrel=createSimpleObject["Land_BarrelEmpty_grey_F",[0,0,0]];
private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _crates=createSimpleObject["Land_CratesWooden_F",[0,0,0]];
private _desk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
private _paper=createSimpleObject["Leaflet_05_Old_F",[0,0,0]];
private _pencil=createSimpleObject["Land_PencilYellow_F",[0,0,0]];
private _pBoxes=createVehicle["Land_CratesPlastic_F",[0,0,0],[],0,"can_collide"];_pBoxes enableSimulationGlobal false;
private _rack=createSimpleObject["Land_Rack_F",[0,0,0]];
private _sack=createVehicle["Land_Sacks_F",[0,0,0],[],0,"can_collide"];_sack enableSimulationGlobal false;
private _sacks=createVehicle["Land_Sacks_goods_F",[0,0,0],[],0,"can_collide"];_sacks enableSimulationGlobal false;
private _shelf=createSimpleObject["Land_OfficeCabinet_02_F",[0,0,0]];
private _wBarrel=createSimpleObject["Land_BarrelWater_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];
private _trash1=createVehicle["Land_Garbage_square3_F",[0,0,0],[],0,"can_collide"];_trash1 enableSimulationGlobal false;
private _trash2=createVehicle["Land_Garbage_square5_F",[0,0,0],[],0,"can_collide"];_trash2 enableSimulationGlobal false;
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;

_bed attachTo[_H,[-2.85,-1.4,0.7]];_bed setDir 270;
_blanket attachTo[_H,[-2.85,-1.4,1.12]];_blanket setDir 180;
_table attachTo[_H,[-5.78,-1.73,1.09]];_table setDir 90;
_chair1 attachTo[_H,[-5.75,-1.3,.65]];
_trash1 attachTo[_H,[-4,0,.7]];_trash1 setDir(random 359);
_can attachTo[_H,[-5.5,-2.1,1]];_can setDir 160;
_desk attachTo[_H,[2.53,-2.04,1.08]];_desk setDir 180;
_paper attachTo[_H,[2.7,-1.9,1.49]];_paper setDir(random 10)+80;
_pencil attachTo[_H,[2.65,-1.9,1.49]];_pencil setDir(random 50)+150;
_chair2 attachTo[_H,[2.75,-1.55,.66]];
_rack attachTo[_H,[-.16,-2.075,1.5]];_rack setDir 270;
_crates attachTo[_H,[0.85,4.68,1.4]];_crates setDir 179;
_sack attachTo[_H,[0.54,5.005,1.806]];
_pBoxes attachTo[_H,[0.4,4.3,1.644]];_pBoxes setDir 8;
_shelf attachTo[_H,[2.986,0.53,1.44]];_shelf setDir 90;
_wBarrel attachTo[_H,[2.8,2.2,1.065]];_wBarrel setDir(random 359);
_barrel attachTo[_H,[2.989,2.7,1.065]];_barrel setDir(random 359);
_trash2 attachTo[_H,[0,1,.685]];_trash2 setDir(random 359);
_sacks attachTo[_H,[-5.9,4.51,1.12]];_sacks setDir 70;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};