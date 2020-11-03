//Land_CarService_F
private _h=_this;

private _desk=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _pcChair=createSimpleObject["Land_OfficeChair_01_F",[0,0,0]];
private _chairM1=createSimpleObject["Land_CampingChair_V2_F",[0,0,0]];
private _chairM2=createSimpleObject["Land_CampingChair_V2_F",[0,0,0]];
private _trash=createSimpleObject["Land_WheelieBin_01_F",[0,0,0]];
private _car=createSimpleObject["C_Hatchback_01_F",[0,0,0]];
private _sign=createSimpleObject["Land_Billboard_02_carrental_F",[0,0,0]];
private _weldTank=createSimpleObject["Land_GasTank_02_F",[0,0,0]];
private _weldCart=createSimpleObject["Land_WeldingTrolley_01_F",[0,0,0]];
private _toolBox1=createSimpleObject["Land_ToolTrolley_02_F",[0,0,0]];
private _toolBox2=createSimpleObject["Land_ToolTrolley_01_F",[0,0,0]];
private _tires=createSimpleObject["TyreBarrier_01_black_F",[0,0,0]];
private _canister=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _crates=createSimpleObject["Land_CratesWooden_F",[0,0,0]];
private _drill=createSimpleObject["Land_DrillAku_F",[0,0,0]];
private _screwdriver1=createSimpleObject["Land_Screwdriver_V2_F",[0,0,0]];
private _screwdriver2=createSimpleObject["Land_Screwdriver_V1_F",[0,0,0]];
private _file=createSimpleObject["Land_File_F",[0,0,0]];
private _glove1=createSimpleObject["Land_Gloves_F",[0,0,0]];
private _grinder=createSimpleObject["Land_Grinder_F",[0,0,0]];
private _tape1=createSimpleObject["Land_DuctTape_F",[0,0,0]];
private _tape2=createSimpleObject["Land_DuctTape_F",[0,0,0]];
private _bucket1=createSimpleObject["Land_PlasticBucket_01_closed_F",[0,0,0]];
private _bucket2=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
private _plant=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _spray=createSimpleObject["Land_DisinfectantSpray_F",[0,0,0]];

_trash attachTo[_h,[4.6,8.1,1]];_trash setDir 180;
_sign attachTo[_h,[3.9,-2.1,2]];
_car attachTo[_h,[-2.73,3.5,2]];
_toolBox1 attachTo[_h,[-5.1,8,1]];_toolBox1 setDir 180;
_toolBox2 attachTo[_h,[-5,6.8,1]];_toolBox2 setDir 180;
_glove1 attachTo[_h,[-2.5,5.15,1.71]];_glove1 setDir 180;
_glove1 setVectorUp[0,0.002,0.01];
_tape1 attachTo[_h,[-2.65,5.2,1.73]];
_tape1 setVectorUp[0,0.002,0.01];
_tape2 attachTo[_h,[-2.33,1.7,2.19]];_tape2 setDir 90;
_tape2 setVectorUp[-0.07,0.02,-0.5];
_desk attachTo[_h,[0.94,1.7,0.92]];
_pcChair attachTo[_h,[0.6,3,1.18]];_pcChair setDir 320;
_tires attachTo[_h,[-5.05,-1.4,0.82]];
_crates attachTo[_h,[1.3,7.82,1.26]];
_canister attachTo[_h,[-5.1,5.85,0.84]];
_drill attachTo[_h,[-5.15,7.2,1.38]];_drill setVectorUp[0,-1,0];
_screwDriver1 attachTo[_h,[-4.9,6.5,1.38]];_screwDriver1 setDir 40;
_screwDriver2 attachTo[_h,[-5,6.6,1.38]];
_file attachTo[_h,[-5,6.9,1.38]];_file setDir 280;
_spray attachTo[_h,[-2.33,1.9,2.31]];_spray setDir 50;
_grinder attachTo[_h,[-5.1,8,1.546]];_grinder setDir 295;
_bucket1 attachTo[_h,[-5.1,0,0.72]];_bucket1 setDir 295;
_bucket2 attachTo[_h,[-5.18,0.37,0.72]];
_chairM1 attachTo[_h,[4.67,-0.5,1]];_chairM1 setDir 95;
_chairM2 attachTo[_h,[4.6,0.5,1]];_chairM2 setDir 88;
_plant attachTo[_h,[4.6,-1.4,1.34]];
_weldTank attachTo[_h,[-0.4,-1.5,1]];_weldTank setDir 120;
_weldCart attachTo[_h,[-2.5,7,1.12]];_weldCart setDir 120;

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light attachTo[_h,[-2.5,2.5,3.5]];
	_light setLightColor[1,1,1];  
	_light setLightAmbient[.3,.3,.3];  
	_light setLightBrightness 0.1;};
	};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};