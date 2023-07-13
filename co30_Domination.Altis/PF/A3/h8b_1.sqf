//Land_i_Addon_02_V1_F
isNil{params["_b"];
if(isNil{_b getVariable"PF_B"})then{_b setVariable["PF_B","h8b_1"]};_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_flag1=createSimpleObject["Banner_01_F",[0,0,0]];
_fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
_pillow=createSimpleObject[(selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"]),[0,0,0]];
_rack=createSimpleObject["a3\Props_F_Orange\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_blanket,_can,_chair,_flag1,_fridge,_pillow,_rack,_table];
 _b setVariable["PF",_f];

_bed setPos(_b modelToWorld[0,0.15,0.56]);
_blanket setPos(_b modelToWorld[0,0.15,0.592]);
_pillow setPos(_b modelToWorld[-.8,0.15,0.65]);
_rack setPos(_b modelToWorld[-3.15,0.15,1.64]);
_fridge setPos(_b modelToWorld[-3.02,1,1.11]);
_table setPos(_b modelToWorld[-2.64,3.75,.94]);
_chair setPos(_b modelToWorld[-3,3.1,0]);_chair setDir(_dir+(random 60+180));
_can setPos(_b modelToWorld[3.35,4.18,.745]);
_flag1 setPos(_b modelToWorld[3.58,2,2]);_flag1 setDir(_dir+90);
{_x setDir(_dir+270)}forEach[_blanket,_rack,_fridge,_table];
{_x setDir _dir}forEach[_bed,_pillow,_can];
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa]};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"]}}}