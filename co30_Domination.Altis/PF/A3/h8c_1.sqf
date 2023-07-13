//Land_i_Addon_02_V1_F
isNil{params["_b"];
if(isNil{_b getVariable"PF_B"})then{_b setVariable["PF_B","h8c_1"]};_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
_microW=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_pillow=createSimpleObject[(selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"]),[0,0,0]];
_sink=createSimpleObject["A3\Structures_F\Civ\Accessories\Sink_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_blanket,_chair1,_chair2,_desk,_fridge,_microW,_pillow,_sink,_table];
 _b setVariable["PF",_f];

_bed setPos(_b modelToWorld[.5,.15,.56]);
_blanket setPos(_b modelToWorld[.5,.15,.595]);_blanket setDir(_dir+270);
_chair1 setPos(_b modelToWorld[3.03,3.1,0]);_chair1 setDir(_dir+180);
_chair2 setPos(_b modelToWorld[2.63,3.7,0]);_chair2 setDir(_dir+270);
_desk setPos(_b modelToWorld[.52,4,.79]);
_fridge setPos(_b modelToWorld[-2.9,4,1.11]);
_microW setPos(_b modelToWorld[.52,4,.97]);
_pillow setPos(_b modelToWorld[-.2,.15,.64]);
_sink setPos(_b modelToWorld[-1.45,4,1.3]);
_table setPos(_b modelToWorld[3.03,3.65,.95]);
{_x setDir _dir}forEach[_bed,_desk,_fridge,_microW,_pillow,_sink,_table]}