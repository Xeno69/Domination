//Land_i_Addon_02_V1_F
private _h=_this;

private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _desk=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _microW=createSimpleObject["Land_Microwave_01_F",[0,0,0]];
private _sink=createSimpleObject["Land_Sink_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow=createSimpleObject[_pillow,[0,0,0]];

_sink attachTo[_H,[-1.45,4,.85]];
_fridge attachTo[_H,[-2.9,4,.8]];
_desk attachTo[_H,[.52,4,.6]];
_microW attachTo[_H,[.52,4,1.1]];
_table attachTo[_H,[3.03,3.65,.7]];
_chair1 attachTo[_H,[3.03,3.1,.28]];_chair1 setDir 180;
_chair2 attachTo[_H,[2.63,3.7,.28]];_chair2 setDir 270;
_bed attachTo[_H,[.5,.15,.35]];
_blanket attachTo[_H,[.5,.15,.77]];_blanket setDir 270;
_pillow attachTo[_H,[-.2,.15,.8]];

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light attachTo[_h,[3.45,-0.86,2.5]];
	_light setLightColor[1,1,1];
	_light setLightAmbient[0.1,0.1,0.1];
	_light setLightBrightness 0.1;};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};