//Land_Shed_08_grey_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_box1=createSimpleObject["Land_PaperBox_01_small_destroyed_brown_F",[0,0,0]];
_box2=createSimpleObject["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0]];
_chair1=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_graf=createSimpleObject[(selectRandom["Land_Graffiti_01_F","Land_Graffiti_02_F","Land_Graffiti_03_F","Land_Graffiti_04_F"]),[0,0,0]];
_rack=createSimpleObject["a3\Props_F_Orange\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_sack=createSimpleObject["A3\Structures_F\Civ\Market\Sack_F.p3d",[0,0,0]];
_sacks=createSimpleObject["A3\Structures_F\Civ\Market\Sacks_goods_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square5_F.p3d",[0,0,0]];
_trashPile=createSimpleObject["A3\Structures_F\Civ\Garbage\GarbageBags_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_blanket,_box1,_box2,_chair1,_chair2,_graf,_rack,_rack,_sack,_sacks,_table,_trash,_trashPile];
 _b setVariable["PF",_f];

_basket setPos(_b modelToWorld[0.6,-.95,-.29]);
_blanket setPos(_b modelToWorld[-1.5,-1,-.92]);_blanket setDir(_dir+180);
_box1 setPos(_b modelToWorld[5,1.5,-.54]);
_box2 setPos(_b modelToWorld[4,0.6,-.54]);
_chair1 setPos(_b modelToWorld[-4.5,-1.8,-1]);_chair1 setDir(_dir);
_chair2 setPos(_b modelToWorld[-3.8,-2.3,-1]);_chair2 setDir(random 25)+90;
_graf setPos(_b modelToWorld[-5.37,1,.3]);_graf setDir(_dir+270);
_rack setPos(_b modelToWorld[-1.9,2.95,.59]);_rack setDir(_dir);
_sack setPos(_b modelToWorld[-1.35,-2.36,-.13]);_sack setDir(_dir+45);
_sacks setPos(_b modelToWorld[0,-1.7,.045]);_sacks setDir(_dir+40);
_table setPos(_b modelToWorld[-4.45,-2.2,-.11]);_table setDir(_dir+90);
_trash setPos(_b modelToWorld[2.5,0,-.895]);
_trashPile setPos(_b modelToWorld[4,-1.2,-.3]);
{_x setDir(random 359)}forEach[_basket,_box1,_box2,_trash,_trashPile]}