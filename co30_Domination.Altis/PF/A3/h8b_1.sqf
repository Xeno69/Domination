//Land_i_Addon_02_V1_F
private _h=_this;

private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _can=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _flag1=createVehicle["Banner_01_F",[0,0,0],[],0,"can_collide"];_flag1 enableSimulationGlobal false;
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _rack=createSimpleObject["Land_OfficeCabinet_01_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow=createSimpleObject[_pillow,[0,0,0]];

_bed attachTo[_h,[0,0.15,0.34]];
_blanket attachTo[_h,[0,0.15,0.76]];_blanket setDir 270;
_pillow attachTo[_h,[-.8,0.15,0.79]];
_rack attachTo[_h,[-3.15,0.15,1.06]];_rack setDir 270;
_fridge attachTo[_h,[-3.02,1,.8]];_fridge setDir 270;
_table attachTo[_h,[-2.64,3.75,.71]];_table setDir 270;
_chair attachTo[_h,[-3,3.1,.3]];_chair setDir(random 60)+180;
_can attachTo[_h,[3.35,4.18,.6]];
_flag1 attachTo[_h,[3.58,2,1.8]];_flag1 setDir 90;
private _flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
private _flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa];};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"];};};

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