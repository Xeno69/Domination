//Land_House_Big_01_F
private _H=_this;

private _bed=createSimpleObject["Land_WoodenBed_01_F",[0,0,0]];
private _can1=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _can2=createSimpleObject["Land_CanisterPlastic_F",[0,0,0]];
private _chair=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _desk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
private _shelf=createSimpleObject["Land_OfficeCabinet_01_F",[0,0,0]];
private _sofa=createSimpleObject["Land_ArmChair_01_F",[0,0,0]];
private _table=createSimpleObject["Land_RattanTable_01_F",[0,0,0]];
private _tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
private _flag1=createVehicle["Banner_01_F",[0,0,0],[],0,"can_collide"];_flag1 enableSimulationGlobal false;
private _trash=createVehicle["Land_Garbage_line_F",[0,0,0],[],0,"can_collide"];_trash enableSimulationGlobal false;

_bed attachTo[_H,[.8,4,.67]];_bed setDir 270;
_shelf attachTo[_H,[-0.15,5.5,1]];_shelf setDir 270;
_sofa attachTo[_H,[7,-.68,.65]];_sofa setDir 315;
_table attachTo[_H,[3.5,3,.61]];_table setDir 315;
_tv attachTo[_H,[3.5,3,1.315]];_tv setDir 315;
_flag1 attachTo[_H,[-.35,4,1.7]];_flag1 setDir 90;
_desk attachTo[_H,[0.05,2,.6]];_desk setDir 270;
_chair attachTo[_H,[0.22,1.75,.2]];_chair setDir 90;
_trash attachTo[_H,[0,-2.5,0.26]];_trash setDir(random 25)+85;
_can1 attachTo[_H,[-7.6,-2,0.55]];_can1 setDir(random 359);
_can2 attachTo[_H,[-7.5,-2.55,0.55]];_can2 setDir(random 359);
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f_exp\flags\flag_SYND_CO.paa","a3\data_f_exp\flags\flag_VIPER_CO.paa","a3\data_f_exp\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis];};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa];};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"];};};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};