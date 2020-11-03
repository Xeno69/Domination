//Land_i_Stone_HouseSmall_V1_F
private _h=_this;

private _axe=createSimpleObject["Land_Axe_F",[0,0,0]];
private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _bed1=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _bed2=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket1=createSimpleObject["Land_Sleeping_bag_brown_F",[0,0,0]];
private _blanket2=createSimpleObject["Land_Sleeping_bag_brown_F",[0,0,0]];
private _bottle=createSimpleObject["Land_WaterBottle_01_compressed_F",[0,0,0]];
private _bottle1=createSimpleObject["Land_WaterBottle_01_full_F",[0,0,0]];
private _bottle2=createSimpleObject["Land_WaterBottle_01_empty_F",[0,0,0]];
private _bucket=createSimpleObject["Land_Bucket_F",[0,0,0]];
private _carton=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chair3=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _crates=createVehicle["Land_CratesWooden_F",[0,0,0],[],0,"can_collide"];_crates enableSimulationGlobal false;
private _desk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
private _gen=createSimpleObject["Land_Portable_generator_F",[0,0,0]];
private _glove=createSimpleObject["Land_Gloves_F",[0,0,0]];
private _logs=createVehicle["Land_WoodPile_F",[0,0,0],[],0,"can_collide"];_logs enableSimulationGlobal false;
private _matches=createSimpleObject["Land_Matches_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow1=createSimpleObject[_pillow,[0,0,0]];
private _pillow2=createSimpleObject[_pillow,[0,0,0]];
private _poster=selectRandom["Land_Poster_01_F","Land_Poster_02_F","Land_Poster_03_F"];
private _poster=createVehicle[_poster,[0,0,0],[],0,"can_collide"];_poster enableSimulationGlobal false;
private _radio=selectRandom["Land_FMRadio_F","Land_SurvivalRadio_F"];
private _radio=createSimpleObject[_radio,[0,0,0]];
private _rug=selectRandom["Land_Rug_01_F","Land_Rug_01_Traditional_F"];
private _rug=createVehicle[_rug,[0,0,0],[],0,"can_collide"];_rug enableSimulationGlobal false;
private _shelf=createSimpleObject["Land_OfficeCabinet_02_F",[0,0,0]];
private _stool=createSimpleObject["Land_Bench_F",[0,0,0]];
private _stump=createSimpleObject["Land_WoodenLog_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_large_F",[0,0,0]];
private _towels=createSimpleObject["Land_Tableware_01_stackOfNapkins_F",[0,0,0]];
private _wrench=createSimpleObject["Land_Wrench_F",[0,0,0]];

_table attachTo[_h,[8.75,2,1.62]];
_desk attachTo[_h,[4.3,-.7,1.62]];_desk setDir 180;
_shelf attachTo[_h,[5.56,-.83,2]];_shelf setDir 180;
_chair1 attachTo[_h,[8.3,1.5,1.25]];_chair1 setDir (random 10)+270;
_chair2 attachTo[_h,[8.3,2.5,1.25]];_chair2 setDir (random 10)+270;
_chair3 attachTo[_h,[4.5,-.5,1.22]];
_bottle attachTo[_h,[8.28,2.15,2.08]];_bottle setDir (random 359);
_bottle1 attachTo[_h,[8.3,2.35,2.168]];_bottle1 setDir (random 359);
_bottle2 attachTo[_h,[8.4,1.35,2.17]];_bottle2 setDir (random 359);
_radio attachTo[_h,[8.7,2,2.115]];_radio setDir 280;
_stool attachTo[_h,[3,3.5,1.438]];_stool setDir 40;
_matches attachTo[_h,[3,3.75,1.708]];_matches setDir(random 359);
_logs attachTo[_h,[3.2,4.85,1.45]];_logs setDir 90;
_stump attachTo[_h,[1.315,3.93,1.465]];
_bed1 attachTo[_h,[-5,0,1.28]];_bed1 setDir 90;
_bed2 attachTo[_h,[-5.9,0,1.28]];_bed2 setDir 270;
_blanket1 attachTo[_h,[-5,0,1.696]];_blanket1 setDir 180;
_blanket2 attachTo[_h,[-5.9,0,1.696]];_blanket2 setDir 180;
_pillow1 attachTo[_h,[-5,-.8,1.742]];
_pillow2 attachTo[_h,[-5.9,-.8,1.742]];
_poster attachTo[_h,[-6.8,5.2,3]];
_axe attachTo[_h,[1.09,2.539,1.69]];_axe setDir 90;_axe setVectorUp[.8,.8,.2];
_bucket attachTo[_h,[0.4,-.7,1.42]];_bucket setDir 280;
_towels attachTo[_h,[0.4,-.48,1.28]];_towels setDir(random 359);
_crates attachTo[_h,[-.65,4.4,2]];_crates setDir 180;
_rug attachTo[_h,[7,.5,1.251]];
_carton attachTo[_h,[-9.4,-.7,1.54]];_carton setDir 270;
_gen attachTo[_h,[-9.3,1,1.55]];_gen setDir 90;
_wrench attachTo[_h,[-8.8,1.3,1.23]];_wrench setDir 305;
_glove attachTo[_h,[-8.9,1.5,1.23]];_glove setDir 260;
_basket attachTo[_h,[-5.5,1.45,1.55]];_basket setDir(random 359);

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _fire1=createVehicle["FirePlace_burning_F",[0,0,0],[],0,"can_collide"];
	_fire1 attachTo[_h,[1.6,4.7,1.55]];
	sleep .5;
	detach _fire1;
	};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};