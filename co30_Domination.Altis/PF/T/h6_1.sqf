//Land_House_Small_06_F
private _H=_this;

private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _boxes=createSimpleObject["Land_CratesShabby_F",[0,0,0]];
private _chair1=createSimpleObject["Land_CampingChair_V2_F",[0,0,0]];
private _chair2=createSimpleObject["Land_CampingChair_V1_F",[0,0,0]];
private _desk1=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _desk2=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _desk3=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _desk4=createSimpleObject["OfficeTable_01_new_F",[0,0,0]];
private _microW=createSimpleObject["Land_Microwave_01_F",[0,0,0]];
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _pcCase=createSimpleObject["Land_PCSet_01_case_F",[0,0,0]];
private _pcKey=createSimpleObject["Land_PCSet_01_keyboard_F",[0,0,0]];
private _pcMouse=createSimpleObject["Land_PCSet_01_mouse_F",[0,0,0]];
private _pcScreen=createSimpleObject["Land_PCSet_01_screen_F",[0,0,0]];
private _sack=createSimpleObject["Land_Sack_F",[0,0,0]];
private _sink=createSimpleObject["Land_Sink_F",[0,0,0]];
private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;

_bed attachTo[_H,[-3.6,1.8,.45]];
_sack attachTo[_H,[-2.2,1.9,.82]];_sack setDir 270;
_blanket attachTo[_H,[-3.6,1.8,0.87]];_blanket setDir 270;
_fridge attachTo[_H,[1.4,-4.95,.91]];_fridge setDir 180;
_boxes attachTo[_H,[2.1,-4.9,.91]];_boxes setDir 0;
_desk1 attachTo[_H,[.2,-4.95,.7]];_desk1 setDir 180;
_desk2 attachTo[_H,[-1.56,-4.95,.7]];_desk2 setDir 180;
_sink attachTo[_H,[-3.5,-4.95,1]];_sink setDir 0;
_desk3 attachTo[_H,[-1.3,-4.9,0.6999]];_desk3 setDir 0;
_basket attachTo[_H,[-1.3,-4.9,1.46]];_basket setDir(random 359);
_microW attachTo[_H,[0.3,-4.9,1.2]];_microW setDir 190;
_desk4 attachTo[_H,[2.11,0,.815]];_desk4 setDir 90;
_pcScreen attachTo[_H,[2.3,0.2,1.475]];_pcScreen setDir 90;
_pcKey attachTo[_H,[2.1,0.25,1.23]];_pcKey setDir 85;
_pcMouse attachTo[_H,[2.04,-.05,1.245]];_pcMouse setDir 90;
_pcCase attachTo[_H,[2,1,0.65]];_pcCase setDir 90;
_chair1 attachTo[_H,[1.5,.2,.9]];_chair1 setDir 270;
_chair2 attachTo[_H,[-3.7,2.8,.91]];_chair2 setDir 180;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};