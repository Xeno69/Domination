//Land_Barn_01_brown_F
private _h=_this;

private _bucket1=createSimpleObject["Land_Bucket_painted_F",[0,0,0]];
private _bucket2=createSimpleObject["Land_Bucket_painted_F",[0,0,0]];
private _can1=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _can2=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _crowbar=createSimpleObject["Land_Crowbar_F",[0,0,0]];
private _glove1=createSimpleObject["Land_Gloves_F",[0,0,0]];
private _glove2=createSimpleObject["Land_Gloves_F",[0,0,0]];
private _hammer=createSimpleObject["Land_Hammer_F",[0,0,0]];
private _mask=createSimpleObject["Land_DustMask_F",[0,0,0]];
private _rope=createSimpleObject["Land_Rope_01_F",[0,0,0]];
private _saw1=createSimpleObject["Land_Saw_F",[0,0,0]];
private _saw2=createSimpleObject["Land_Saw_F",[0,0,0]];
private _shovel1=createSimpleObject["Land_Shovel_F",[0,0,0]];
private _shovel2=createSimpleObject["Land_Shovel_F",[0,0,0]];

_shovel1 attachTo[_h,[4.8,2.05,.814]];_shovel1 setDir 20;
_can1 attachTo[_h,[-5.7,3.7,1.13]];_can1 setDir 20;
_can2 attachTo[_h,[-5.6,3.2,1.13]];_can2 setDir 0;
_mask attachTo[_h,[-7,-3.7,1.689]];_mask setDir 20;
_bucket1 attachTo[_h,[-7,-3.7,.93]];_bucket1 setDir(random 359);
_bucket2 attachTo[_h,[-6,-3.9,.93]];_bucket2 setDir(random 359);
_glove1 attachTo[_h,[-7.6,-3.8,1.679]];_glove1 setDir 40;
_glove2 attachTo[_h,[-7.42,-3.9,1.679]];_glove2 setDir 80;
_saw1 attachTo[_h,[-7.25,-3.9,1.685]];_saw1 setDir 60;
_hammer attachTo[_h,[-8,-3.85,1.7]];_hammer setDir 60;_hammer setVectorUp[-1,0,0];
_rope attachTo[_h,[5.86,-1.706,1.73]];_rope setVectorUp[-1,0,0];
_shovel2 attachTo[_h,[5.86,-2.02,1.364]];_shovel2 setVectorUp[-1,0,0];
_saw2 attachTo[_h,[5.86,-2.534,1.635]];_saw2 setVectorUp[100,5,-.5];
_crowbar attachTo[_h,[5.86,-2.831,1.482]];_crowbar setVectorUp[-1,0,0];

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light1=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light1 attachTo[_h,[.95,-.02,3.33]];
	_light1 setLightColor[.6,.3,0];  
	_light1 setLightAmbient[.1,.1,.1];  
	_light1 setLightBrightness .08;
	private _light2=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light2 attachTo[_h,[5.5, 0.09, 3.20]];
	_light2 setLightColor[.6,.3,0];  
	_light2 setLightAmbient[.1,.1,.1];  
	_light2 setLightBrightness .08;};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};