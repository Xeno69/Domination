//Land_Shed_02_F
private _H=_this;

private _boxes=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes enableSimulationGlobal false;
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _pbox=createVehicle["Land_CratesPlastic_F",[0,0,0],[],0,"can_collide"];_pbox enableSimulationGlobal false;
private _sack=createVehicle["Land_Sack_F",[0,0,0],[],0,"can_collide"];_sack enableSimulationGlobal false;
private _shelf=createSimpleObject["Land_Metal_rack_Tall_F",[0,0,0]];

_pbox attachTo[_H,[1.4,-0.83,0.25]];_pbox setDir 180;
_can attachTo[_H,[-1.65,-.93,.34]];_can setDir 90;
_sack attachTo[_H,[1.5,2.2,.4]];_sack setDir 90;
_boxes attachTo[_H,[-1.6,1.05,.8]];_boxes setDir 0;
_shelf attachTo[_H,[-1.7,.2,0]];_shelf setDir 270;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};