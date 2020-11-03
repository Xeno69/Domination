//Land_i_Addon_03_V1_F
private _H=_this;

private _chair1=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair3=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair4=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair5=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair6=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _table1=createSimpleObject["Land_TablePlastic_01_F",[0,0,0]];
private _table2=createSimpleObject["Land_TablePlastic_01_F",[0,0,0]];
private _table3=createSimpleObject["Land_TablePlastic_01_F",[0,0,0]];

_table1 attachTo[_H,[-4.04,-0.81,1.35]];_table1 setDir 90;
_chair1 attachTo[_H,[-3.62,-0.81,1.35]];_chair1 setDir 180;
_chair2 attachTo[_H,[-4.04,.18,1.35]];_chair2 setDir 90;
_table2 attachTo[_H,[4.04,-0.81,1.35]];_table2 setDir 90;
_chair3 attachTo[_H,[4.04,.18,1.35]];_chair3 setDir 90;
_chair4 attachTo[_H,[3.63,-1,1.35]];
_table3 attachTo[_H,[3.44,3.45,1.35]];
_chair5 attachTo[_H,[3.7,3,1.35]];_chair5 setDir 270;
_chair6 attachTo[_H,[2.4,3.45,1.35]];

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};