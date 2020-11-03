//Land_i_house_Small_02_V1_F
private _h=_this;

private _flag1=createVehicle["Banner_01_F",[0,0,0],[],0,"can_collide"];_flag1 enableSimulationGlobal false;
private _bed1=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _bed2=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket1=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket1 enableSimulationGlobal false;
private _blanket2=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket2 enableSimulationGlobal false;
private _chair1=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _chair2=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _desk=createSimpleObject["Land_TableDesk_F",[0,0,0]];
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _microW=createSimpleObject["Land_Microwave_01_F",[0,0,0]];
private _pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _pillow1=createSimpleObject[_pillow,[0,0,0]];
private _pillow2=createSimpleObject[_pillow,[0,0,0]];
private _rack=createSimpleObject["Land_OfficeCabinet_01_F",[0,0,0]];
private _sack=createVehicle["Land_Sack_F",[0,0,0],[],0,"can_collide"];_sack enableSimulationGlobal false;
private _radio=createSimpleObject["Land_FMradio_F",[0,0,0]];
private _sink=createSimpleObject["Land_Sink_F",[0,0,0]];
private _table=createSimpleObject["Land_TablePlastic_01_F",[0,0,0]];
private _trash=createSimpleObject["Land_WheelieBin_01_F",[0,0,0]];

_trash attachTo[_h,[-3.3,2.4,0.9]];_trash setDir 180;
_sack attachTo[_h,[-2.6,2.47,0.8]];_sack setDir 270;
_bed1 attachTo[_h,[6.55,2.4,.42]];_bed1 setDir 180;
_blanket1 attachTo[_h,[6.55,2.4,.84]];_blanket1 setDir 90;
_pillow1 attachTo[_h,[7.3,2.4,.88]];_pillow1 setDir 90;
_bed2 attachTo[_h,[7.15,-2.35,.42]];_bed2 setDir 270;
_blanket2 attachTo[_h,[7.15,-2.35,.84]];_blanket2 setDir 180;
_pillow2 attachTo[_h,[7.15,-3.1,.88]];_pillow2 setDir 90;
_rack attachTo[_h,[1.55,-3.1,1.15]];_rack setDir 180;
_table attachTo[_h,[7,.35,.8]];_table setDir 270;
_radio attachTo[_h,[7,.35,1.345]];_radio setDir 290;
_chair1 attachTo[_h,[6.5,.35,.8]];
_chair2 attachTo[_h,[6.85,1.35,.8]];_chair2 setDir 50;
_fridge attachTo[_h,[.35,-2.3,.9]];_fridge setDir 90;
_desk attachTo[_h,[.4,-1.115,.65]];_desk setDir 90;
_microW attachTo[_h,[.4,-.815,1.15]];_microW setDir 110;
_sink attachTo[_h,[-.3,-3,.8]];
_flag1 attachTo[_h,[1.1,-1,2]];_flag1 setDir 90;
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa];};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"];};};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};