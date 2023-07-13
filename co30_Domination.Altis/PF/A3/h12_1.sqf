//Land_Slum_House02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_boxes=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_blanket,_boxes,_can,_chair,_table,_trash];
 _b setVariable["PF",_f];

 _basket setPos(_b modelToWorld[2.32,3.54,-.27]);
_boxes setPos(_b modelToWorld[2.95,3.25,.566]);
_blanket setPos(_b modelToWorld[2.9,1.6,-.91]);_blanket setDir(_dir+3);
_can setPos(_b modelToWorld[1.67,-1.5,-.26]);
_chair setPos(_b modelToWorld[2.6,-.77,-.96]);
_table setPos(_b modelToWorld[2.58,-1.18,-.1]);_table setDir(_dir+90);
_trash setPos(_b modelToWorld[1.6,1,-.87]);
{_x setDir _dir}forEach[_boxes,_can,_chair];
{_x setDir(random 359)}forEach[_basket,_trash]}