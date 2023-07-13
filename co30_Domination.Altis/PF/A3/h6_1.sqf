//Land_i_Stone_Shed_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed=createSimpleObject["A3\Structures_F\Civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_chair=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V1_folded_F.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_flag1=createSimpleObject["Banner_01_F",[0,0,0]];
_pillow=createSimpleObject[(selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"]),[0,0,0]];
_sacks=createSimpleObject["A3\Structures_F\Civ\Market\Sacks_goods_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_bed,_blanket,_chair,_chair1,_chair2,_flag1,_pillow,_sacks,_table];
 _b setVariable["PF",_f];

_basket setPos(_b modelToWorld[-0,4,1.445]);_basket setDir(random 359);
_bed setPos(_b modelToWorld[0,-.2,.36]);
_blanket setPos(_b modelToWorld[0,-.2,.39]);_blanket setDir(_dir+270);
_chair setPos(_b modelToWorld[1.3,-.423,0.445]);
_chair1 setPos(_b modelToWorld[1.04,3.8,-.1]);
_chair2 setPos(_b modelToWorld[-.2,3.8,-.1]);_chair2 setDir(_dir+(random 40+270));
_flag1 setPos(_b modelToWorld[0.78,-.648,2]);
_pillow setPos(_b modelToWorld[-.75,-.2,0.44]);
_sacks setPos(_b modelToWorld[-3.34,1.7,.9]);
_table setPos(_b modelToWorld[.5,3.8,0.77]);
{_x setDir(_dir+90)}forEach[_chair,_chair1,_sacks,_table];
{_x setDir _dir}forEach[_bed,_flag1,_pillow];_chair setVectorUp[.1,1,.5];
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa]};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"]}}}