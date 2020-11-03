//Land_House_Small_05_F
private _H=_this;

private _bed=createSimpleObject["Land_WoodenBed_01_F",[0,0,0]];
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair3=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair4=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _desk=createSimpleObject["OfficeTable_01_new_F",[0,0,0]];
private _plant=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _pot1=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _pot2=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _shelf=createSimpleObject["OfficeCabinet_01_new_F",[0,0,0]];
private _table1=createSimpleObject["Land_RattanTable_01_F",[0,0,0]];
private _table2=createSimpleObject["Land_TablePlastic_01_F",[0,0,0]];

_bed attachTo[_H,[-3,4.2,.62]];
_table1 attachTo[_H,[0,4.8,.56]];
_desk attachTo[_H,[-2.2,-1.1,.58]];_desk setDir 180;
_plant attachTo[_H,[-2.6,-1,1.785]];_plant setDir(random 359);
_chair1 attachTo[_H,[-2,-.65,.15]];_chair1 setDir 0;
_shelf attachTo[_H,[-3.56,-1.22,.94]];_shelf setDir 180;
_pot1 attachTo[_H,[-0.56,-1.7,.285]];_pot1 setDir(random 359);
_pot2 attachTo[_H,[-0.9,-1.7,.285]];_pot2 setDir(random 359);
_table2 attachTo[_H,[-2.7,-3.3,.6]];_table2 setDir 0;
_chair2 attachTo[_H,[-3.7,-3.3,.6]];_chair2 setDir 0;
_chair3 attachTo[_H,[-1.3,-3.3,.6]];_chair3 setDir 180;
_chair4 attachTo[_H,[-2.6,-3.72,.6]];_chair4 setDir 270;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};