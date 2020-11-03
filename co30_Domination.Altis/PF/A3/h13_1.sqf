//Land_Slum_House03_F
private _h=_this;

private _blanket=createVehicle[(selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"]),[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _crate=createVehicle["Land_CratesWooden_F",[0,0,0],[],0,"can_collide"];_crate enableSimulationGlobal false;
private _boxes=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes enableSimulationGlobal false;
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _box=createVehicle["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0],[],0,"can_collide"];_box enableSimulationGlobal false;
private _pbox=createVehicle["Land_CratesPlastic_F",[0,0,0],[],0,"can_collide"];_pbox enableSimulationGlobal false;
private _stool=createSimpleObject["Land_Bench_F",[0,0,0]];

_stool attachTo[_h,[0,-.5,0.23]];_stool setDir 90;
_pbox attachTo[_h,[1.33,-0.3,0.23]];_pbox setDir 80+(random 15);
_crate attachTo[_h,[-1.37,2.2,0.74]];_crate setDir 0;
_box attachTo[_h,[-.57,2.2,.92]];_box setDir 90;
_can attachTo[_h,[-.57,2.2,1.06]];_can setDir 90;
_blanket attachTo[_h,[.9,2.6,0.03]];_blanket setDir 270;
_boxes attachTo[_h,[3.9,2.65,0.5]];_boxes setDir 270;

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};