//Land_Camp_House_01_brown_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed1=createSimpleObject["a3\structures_f\furniture\bench_f.p3d",[0,0,0]];
_bed2=createSimpleObject["a3\structures_f\furniture\bench_f.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_can=createSimpleObject["a3\structures_f\items\vessels\canisterplastic_f.p3d",[0,0,0]];
_chair=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair1=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\chairplastic_f.p3d",[0,0,0]];
_chair3=createSimpleObject["a3\structures_f\furniture\chairplastic_f.p3d",[0,0,0]];
_pillo=createSimpleObject["a3\structures_f\civ\camping\pillow_grey_f.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f_epb\furniture\shelveswooden_f.p3d",[0,0,0]];
_sack=createSimpleObject["a3\structures_f\civ\market\sack_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_epa\civ\camping\woodentable_small_f.p3d",[0,0,0]];
_wood=createSimpleObject["a3\structures_f\civ\accessories\woodpile_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed1,_bed2,_blanket,_can,_chair,_chair1,_chair2,_chair3,_pillo,_rack,_sack,_table,_wood];
_b setVariable["PF",_f];

_bed1 setPos(_b modelToWorld[-2.95,5.8,-0.92]);
_bed2 setPos(_b modelToWorld[-2.49,5.8,-0.92]);
_blanket setPos(_b modelToWorld[-2.72,5.8,-0.851]);
_can setPos(_b modelToWorld[-2.8,1,-0.71]);
_chair setPos(_b modelToWorld[2.38,6.2,-1.4]);_chair setDir(_dir+270);
_chair1 setPos(_b modelToWorld[2.8,5.5,-1.4]);_chair1 setDir(_dir+165+random 35);
_chair2 setPos(_b modelToWorld[-2,0.9,-0.43]);_chair2 setDir(_dir+90);
_chair3 setPos(_b modelToWorld[-2.8,0.4,-0.43]);_chair3 setDir(_dir+45);
_pillo setPos(_b modelToWorld[-2.72,6.6,-0.8]);
_rack setPos(_b modelToWorld[3.03,3.84,-0.41]);
_sack setPos(_b modelToWorld[-2.7,4.43,-0.56]);_sack setDir(_dir-34);
_table setPos(_b modelToWorld[2.78,6.11,-.54]);
_wood setPos(_b modelToWorld[2.7,2.5,-0.84]);_wood setDir(_dir+15);
{_x setDir _dir}forEach[_bed1,_bed2,_blanket,_can,_pillo,_rack,_table]}