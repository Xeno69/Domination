//Land_House_1W10_F
isNil{params["_b"];_f=[];_fire=0;_match=0;_flag=0;_pic=0;_dir=getDir _b;
_ax=createSimpleObject["a3\structures_f\items\tools\axe_f.p3d",[0,0,0]];
_bag=createSimpleObject["a3\Props_F_Enoch\Military\Camps\TentSolar_01_folded_F.p3d",[0,0,0]];
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_blanky=createSimpleObject[(selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"]),[0,0,0]];
_chair=createSimpleObject["a3\structures_f_heli\furniture\rattanchair_01_f.p3d",[0,0,0]];
if((dayTime<6)||(dayTime>18))then{_fire=createVehicle["FirePlace_burning_F",[0,0,0],[],0,"can_collide"];_match=createSimpleObject["A3\Structures_F_EPA\Items\Tools\Matches_F.p3d",[0,0,0]];{_f pushBack _x}forEach[_fire,_match]};
if(floor random 2==0)then{_flag=createSimpleObject["Banner_01_F",[0,0,0]];_f pushBack _flag};
if(floor random 2==0)then{_pic=createSimpleObject["a3\props_f_orange\items\decorative\photoframe_01_f.p3d",[0,0,0]];_f pushBack _pic};
_rack=createSimpleObject["a3\structures_f_epb\furniture\shelveswooden_f.p3d",[0,0,0]];
_rug=createSimpleObject["a3\props_f_orange\furniture\rug_01_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_epa\civ\camping\woodentable_large_f.p3d",[0,0,0]];
_wood=createSimpleObject["a3\structures_f\civ\accessories\woodpile_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_ax,_bag,_bed,_blanky,_chair,_rack,_rug,_table,_wood];
_b setVariable["PF",_f];

_ax setPos(_b modelToWorld[-1.8,-.5,-1.42]);_ax setDir(_dir+99);
_bag setPos(_b modelToWorld[-5.11,-0.33,-.57]);_bag setDir(_dir+99);
_bed setPos(_b modelToWorld[2.54,-3,-.546]);_bed setDir(_dir+180);
_blanky setPos(_b modelToWorld[2.08,-2.9,-0.959]);_blanky setDir(_dir+180);
_chair setPos(_b modelToWorld[-3.5,-3,-.34]);_chair setDir(_dir+225);
if(_fire isEqualType objNull)then{_fire setPos(_b modelToWorld[-2.5,-.32,-1.15]);_match setPos(_b modelToWorld[-1.8,-.8,-1.434]);_match setDir _dir};
if(_flag isEqualType objNull)then{_flag setPos(_b modelToWorld[-4.3,0.16,.6]);_flag setDir _dir;_flag setObjectTexture[0,(selectRandom["a3\data_f_enoch\flags\flag_enoch_co.paa","a3\data_f_enoch\flags\flag_eaf_co.paa"])]};
_rug setPos(_b modelToWorld[-2.5,-2.5,-1.44]);_rug setDir(_dir+90);
_rack setPos(_b modelToWorld[-5.11,-0.33,-.46]);_rack setDir _dir;
if(_pic isEqualType objNull)then{_pic setPos(_b modelToWorld[-1.5,-4.17,.4]);_pic setDir(_dir+270)};
_wood setPos(_b modelToWorld[-0.56,-.35,-0.9]);_wood setDir(_dir+80)}