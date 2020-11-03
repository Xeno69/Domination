//Land_i_House_Small_02_V1_F
private _h=_this;

private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair3=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _desk1=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _desk2=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _desk3=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _microW=createSimpleObject["Land_Microwave_01_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow=createSimpleObject[_pillow,[0,0,0]];
private _plant=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _rack=createSimpleObject["Land_OfficeCabinet_01_F",[0,0,0]];
private _sofa1=createSimpleObject["Land_ArmChair_01_F",[0,0,0]];
private _sofa2=createSimpleObject["Land_Sofa_01_F",[0,0,0]];
private _table1=createSimpleObject["Land_RattanTable_01_F",[0,0,0]];
private _table2=createSimpleObject["Land_TableSmall_01_F",[0,0,0]];
private _table3=createSimpleObject["Land_TableBig_01_F",[0,0,0]];
private _TV=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
private _sink=createSimpleObject["Land_Sink_F",[0,0,0]];

_sofa1 attachTo[_H,[7.03,-1.5,.88]];_sofa1 setDir 270;
_sofa2 attachTo[_H,[5.5,-2.85,.88]];
_table1 attachTo[_H,[7.15,-2.6,.76]];
_plant attachTo[_H,[7.1,-2.5,1.95]];_plant setDir(random 359);
_rack attachTo[_H,[3.5,2.67,1.16]];
_bed attachTo[_H,[6.6,2.5,.41]];_bed setDir 180;
_blanket attachTo[_H,[6.6,2.5,.83]];_blanket setDir 90;
_pillow attachTo[_H,[7.3,2.5,.86]];
_table2 attachTo[_H,[5,-.5,.6]];_table2 setDir 90;
_TV attachTo[_H,[5,-.5,1.122]];_TV setDir -25;
_table3 attachTo[_H,[1.56,-1,0.82]];_table3 setDir 90;
_chair1 attachTo[_H,[1.5,-1.89,0.38]];_chair1 setDir 180;
_chair2 attachTo[_H,[1.86,-1.3,0.38]];_chair2 setDir 90;
_chair3 attachTo[_H,[1.86,-.5,0.38]];_chair3 setDir 90;
_sink attachTo[_H,[-1.1,-3,1]];
_desk1 attachTo[_H,[.38,-3,.67]];_desk1 setDir 90;
_desk2 attachTo[_H,[.38,-1.24,.67]];_desk2 setDir 90;
_desk3 attachTo[_H,[.34,-1.5,.669]];_desk3 setDir 270;
_fridge attachTo[_H,[.38,-.04,.89]];_fridge setDir 90;
_microW attachTo[_H,[.4,-1.5,1.17]];_microW setDir 90;

if((dayTime<18)&&{(dayTime>5)})then{_TV setObjectTextureGlobal[0,(selectRandom["\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_pills_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_supermarket_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_maskrtnik_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_bluking_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_wine_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_plane_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_action_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_getlost_co.paa"])];};
if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};