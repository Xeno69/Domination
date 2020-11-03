//Land_Slum_House01_F
private _h=_this;

private _blanky=createSimpleObject["Land_EmergencyBlanket_01_discarded_F",[0,0,0]];
private _box1=createSimpleObject["Land_PaperBox_01_small_destroyed_brown_F",[0,0,0]];
private _box2=createVehicle["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0],[],0,"CAN_COLLIDE"];_box2 enableSimulationGlobal false;
private _chair=createSimpleObject["Land_CampingChair_V1_F",[0,0,0]];
private _tire=createSimpleObject["Land_Tyre_F",[0,0,0]];

_blanky attachTo[_h,[1.7,1.5,.05]];_blanky setDir(random 7);
_box1 attachTo[_h,[-1.45,-.8,.22]];
_box2 attachTo[_h,[-.58,-.8,.21]];
_chair attachTo[_h,[.9,2.16,.51]];
_tire attachTo[_h,[.14,-.74,.08]];

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};