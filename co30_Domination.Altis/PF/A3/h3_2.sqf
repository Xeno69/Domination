//Land_i_Shop_02_V1_F	-	RESTAURANT
private _h=_this;

private _cashier=createSimpleObject["Land_CashDesk_F",[0,0,0]];
private _chair1=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair2=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair3=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair4=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair5=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair6=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair7=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair8=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair9=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair10=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair11=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair12=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair13=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair14=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair15=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair16=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair17=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair18=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair19=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair20=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _chair21=createSimpleObject["Land_RattanChair_01_F",[0,0,0]];
private _dTable1=createSimpleObject["Land_TableBig_01_F",[0,0,0]];
private _dTable2=createSimpleObject["Land_TableBig_01_F",[0,0,0]];
private _dTable3=createSimpleObject["Land_TableBig_01_F",[0,0,0]];
private _dTable4=createSimpleObject["Land_TableBig_01_F",[0,0,0]];
private _plant=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _sTable=createSimpleObject["Land_RattanTable_01_F",[0,0,0]];
private _stool=createSimpleObject["Land_Bench_F",[0,0,0]];
private _sign=createSimpleObject["Land_InfoSign_V1_F",[0,0,0]];
private _sink=createSimpleObject["Land_Sink_F",[0,0,0]];

_dTable1 attachTo[_h,[3.26,-3.185,0.94]];_dTable1 setDir 90;
_chair1 attachTo[_h,[3.26,-1.79,1.06]];
_chair2 attachTo[_h,[2.41,-2.6,1.06]];_chair2 setDir 270;
_chair3 attachTo[_h,[2.33,-3.7,1.06]];_chair3 setDir (random -40)+230;
_dTable2 attachTo[_h,[0.3,-3.43,0.94]];_dTable2 setDir 90;
_chair4 attachTo[_h,[1.1,-4.11,1.06]];_chair4 setDir 90;
_chair5 attachTo[_h,[1.1,-3.35,1.06]];_chair5 setDir 90;
_chair6 attachTo[_h,[1.15,-2.65,1.06]];_chair6 setDir(random 13)+90;
_chair7 attachTo[_h,[0.3,-2,1.06]];
_chair8 attachTo[_h,[-0.55,-4.05,1.06]];_chair8 setDir 260;
_chair9 attachTo[_h,[-0.55,-3.37,1.06]];_chair9 setDir 279;
_chair10 attachTo[_h,[-0.585,-2.7,1.06]];_chair10 setDir 275;
_cashier attachTo[_h,[1.33,1.68,0.49]];_cashier setDir 270;
_sign attachTo[_h,[1.3,0.65,1.07]];_sign setDir 270;
_stool attachTo[_h,[3.495,2.1,0.735]];
_plant attachTo[_h,[3.53,4.3,1.295]];_plant setDir 40;
_dTable3 attachTo[_h,[0,-1,4.81]];
_chair13 attachTo[_h,[-1.4,-1,4.93]];_chair13 setDir 270;
_chair14 attachTo[_h,[-0.6,-0.2,4.93]];
_chair15 attachTo[_h,[0.3,-0.2,4.93]];
_chair16 attachTo[_h,[0.5,-1.85,4.93]];_chair16 setDir 180;
_chair17 attachTo[_h,[-0.5,-1.85,4.93]];_chair17 setDir 180;
_chair18 attachTo[_h,[1.4,-1,4.93]];_chair18 setDir 90;
_sTable attachTo[_h,[0,2.26,4.81]];_sTable setDir 270;
_chair11 attachTo[_h,[-0.6,2.26,4.93]];_chair11 setDir 270;
_chair12 attachTo[_h,[0.6,2.26,4.93]];_chair12 setDir 90;
_dTable4 attachTo[_h,[-5.17,-3.5,4.81]];_dTable4 setDir 90;
_chair19 attachTo[_h,[-4.37,-4.05,4.93]];_chair19 setDir 90;
_chair20 attachTo[_h,[-4.37,-3.1,4.93]];_chair20 setDir 90;
_chair21 attachTo[_h,[-5.2,-2.1,4.93]];
_sink attachTo[_h,[-2.94,-3.5,1.1]];_sink setDir 90;

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light1=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light1 attachTo[_h,[0,0,3.85]];
	_light1 setLightColor[1,1,1];   
	_light1 setLightAmbient[.01,.01,.01];   
	_light1 setLightBrightness 0.1;
		if(round(random 3)==1)then{
		_light2=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
		_light2 attachTo[_h,[4.11,0.83,3]];
		_light2 setLightColor[1,1,1];   
		_light2 setLightAmbient[.01,.01,.01];   
		_light2 setLightBrightness .1;};
		};
	};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};