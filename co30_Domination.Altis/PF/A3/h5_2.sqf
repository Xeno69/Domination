//Land_i_Stone_HouseBig_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_axe=createSimpleObject["A3\Structures_F\Items\Tools\Axe_F.p3d",[0,0,0]];
_blanket=[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_blanket1=createSimpleObject _blanket;
_blanket2=createSimpleObject _blanket;
_blanket3=createSimpleObject _blanket;
_chair1=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V1_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V1_F.p3d",[0,0,0]];
_graf1=createSimpleObject[(selectRandom["Land_Graffiti_01_F","Land_Graffiti_02_F","Land_Graffiti_03_F","Land_Graffiti_04_F"]),[0,0,0]];
_graf2=createSimpleObject[(selectRandom["Land_Graffiti_01_F","Land_Graffiti_02_F","Land_Graffiti_03_F","Land_Graffiti_04_F"]),[0,0,0]];
_log1=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d",[0,0,0]];
_log2=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d",[0,0,0]];
_log3=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d",[0,0,0]];
_logs=createSimpleObject["A3\Structures_F\Civ\Accessories\WoodPile_F.p3d",[0,0,0]];
_stool=createSimpleObject["a3\structures_f\furniture\Bench_F.p3d",[0,0,0]];
_stump=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_large_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_axe,_blanket1,_blanket2,_blanket3,_chair1,_chair2,_graf1,_graf2,_log1,_log2,_log3,_logs,_stool,_stump,_table];
 _b setVariable["PF",_f];

_blanket1 setPos(_b modelToWorld[-1.1,-1.2,1.2]);_blanket1 setDir(_dir+270);
_blanket2 setPos(_b modelToWorld[-1,.3,1.22]);_blanket2 setDir(_dir+250);
_blanket3 setPos(_b modelToWorld[-1.6,2.7,1.22]);_blanket3 setDir _dir;
_table setPos(_b modelToWorld[-1.05,-1,-.83]);_table setDir(_dir+270);
_stool setPos(_b modelToWorld[-1.05,-.1,-1.21]);_stool setDir(_dir+90);
_log1 setPos(_b modelToWorld[1,3.2,-.06]);_log1 setDir(random 359);
_log2 setPos(_b modelToWorld[0.45,3.45,-.06]);_log2 setDir(random 359);
_log3 setPos(_b modelToWorld[0.7,3.3,.48]);_log3 setDir(random 359);
_stump setPos(_b modelToWorld[-.3,3.5,-1.15]);_stump setDir(_dir+90);_stump setVectorUp[0,1,0];
_logs setPos(_b modelToWorld[3.7,3.5,-1.1]);_logs setDir(_dir+90);
_axe setPos(_b modelToWorld[0.4,3,-.54]);_axe setDir(_dir+40);
_graf1 setPos(_b modelToWorld[-2.17,.1,2.5]);_graf1 setDir(_dir+270);
_graf2 setPos(_b modelToWorld[0,3.825,2.15]);_graf2 setDir _dir;
_chair1 setPos(_b modelToWorld[4.7,-1.2,2.17]);_chair1 setDir(_dir+(random 40+90));
_chair2 setPos(_b modelToWorld[4.7,-0.1,2.17]);_chair2 setDir(_dir+(random 40+50))}