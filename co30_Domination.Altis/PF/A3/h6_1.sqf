//Land_i_Stone_Shed_V1_F
private _h=_this;

private _basket=createSimpleObject["Land_Basket_F",[0,0,0]];
private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _chair=createSimpleObject["Land_CampingChair_V1_folded_F",[0,0,0]];
private _chairW1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chairW2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _flag1=createVehicle["Banner_01_F",[0,0,0],[],0,"can_collide"];_flag1 enableSimulationGlobal false;
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow=createSimpleObject[_pillow,[0,0,0]];
private _sacks=createSimpleObject["Land_Sacks_goods_F",[0,0,0]];
private _table=createSimpleObject["Land_WoodenTable_small_F",[0,0,0]];

_table attachTo[_h,[.5,3.8,0.68]];_table setDir 90;
_chairW1 attachTo[_h,[1.04,3.8,0.25]];_chairW1 setDir 90;
_chairW2 attachTo[_h,[-.2,3.8,0.25]];_chairW2 setDir(random 40)+270;
_bed attachTo[_h,[0,-.2,0.3]];
_pillow attachTo[_h,[-.75,-.2,0.765]];
_blanket attachTo[_h,[0,-.2,0.72]];_blanket setDir 270;
_chair attachTo[_h,[1.3,-.423,0.74]];_chair setDir 90;_chair setVectorUp[.1,1,.5];
_flag1 attachTo[_h,[0.78,-.648,1.8]];
_sacks attachTo[_h,[-3.34,1.7,.7]];_sacks setDir 90;
_basket attachTo[_h,[-0,4,1.445]];_basket setDir(random 359);
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
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
	private _fire1=createVehicle["FirePlace_burning_F",[0,0,0],[],0,"can_collide"];
	_fire1 attachTo[_h,[.5,1.5,.3]];_fire1 setDir(random 359);
	sleep .5;
	detach _fire1;
	};
};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};