//Land_House_Big_01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\Props_F_Orange\Furniture\WoodenBed_01_F.p3d",[0,0,0]];
_can1=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_can2=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];_desk setObjectTextureGlobal[0,"A3\Structures_F_Heli\Furniture\Data\OfficeTable_01_old_CO.paa"];
_flag1=createSimpleObject["Banner_01_F",[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_Heli\Furniture\RattanTable_01_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_line_F.p3d",[0,0,0]];
_tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
{_f pushBack _x}forEach[_bed,_can1,_can2,_chair,_desk,_flag1,_shelf,_sofa,_table,_tv,_trash];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[.8,4,-.11]);
_can1 setPos(_b modelToWorld[-7.6,-2,-.35]);_can1 setDir(random 359);
_can2 setPos(_b modelToWorld[-7.5,-2.55,-.35]);_can2 setDir(random 359);
_chair setPos(_b modelToWorld[0.22,1.75,-1.02]);_chair setDir(_dir+90);
_desk setPos(_b modelToWorld[0.05,2,-.18]);
_flag1 setPos(_b modelToWorld[-.35,4,1.2]);_flag1 setDir(_dir+90);
_shelf setPos(_b modelToWorld[-0.15,5.5,.541]);
_sofa setPos(_b modelToWorld[7,-.68,-.05]);
_table setPos(_b modelToWorld[3.5,3,-.22]);
_trash setPos(_b modelToWorld[0,-2.5,-.93]);_trash setDir(_dir+(random 25+85));
_tv setPos(_b modelToWorld[3.5,3,.39]);
{_x setDir(_dir+270)}forEach[_bed,_desk,_shelf];
{_x setDir(_dir+315)}forEach[_sofa,_table,_tv];
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f_exp\flags\flag_SYND_CO.paa","a3\data_f_exp\flags\flag_VIPER_CO.paa","a3\data_f_exp\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa]};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"]}}}