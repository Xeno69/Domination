//Land_House_Small_02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"]),[0,0,0]];
_boxes=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_bucket1=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_bucket2=createSimpleObject["A3\Props_F_Orange\Humanitarian\Supplies\PlasticBucket_01_F.p3d",[0,0,0]];
_bucket3=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_chair=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V2_F.p3d",[0,0,0]];
_pillow=createSimpleObject[(selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"]),[0,0,0]];
_radio=createSimpleObject["A3\Structures_F\Items\Electronics\SurvivalRadio_F.p3d",[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",[0,0,0]];
{_f pushBack _x;}forEach[_basket,_bed,_blanket,_boxes,_bucket1,_bucket2,_bucket3,_can,_chair,_pillow,_radio,_shelf,_trash];
 _b setVariable["PF",_f];

_basket setPos(_b modelToWorld[-4.25,.525,-.07]);
_bed setPos(_b modelToWorld[.42,3,-.27]);_bed setDir(_dir+270);
_blanket setPos(_b modelToWorld[.42,3,-.24]);
_boxes setPos(_b modelToWorld[.445,-5.71,.78]);_boxes setDir _dir;
_bucket1 setPos(_b modelToWorld[0,-5.5,-.3]);_bucket1 setDir(_dir+(random 90+270));
_bucket2 setPos(_b modelToWorld[-.005,-6,-.3]);_bucket2 setDir(_dir+(random 90+270));
_bucket3 setPos(_b modelToWorld[-.005,-5.7,.142]);
_can setPos(_b modelToWorld[-4.3,-5.93,-.07]);
_chair setPos(_b modelToWorld[-4.19,-0.575,.265]);_chair setDir(_dir+320);
_pillow setPos(_b modelToWorld[.42,2.25,-.2]);
_radio setPos(_b modelToWorld[-4.5,-1.25,-.54]);_radio setDir(_dir+90);
_shelf setPos(_b modelToWorld[.42,.4,.91]);
_trash setPos(_b modelToWorld[-2,3,-.66]);
{_x setDir(_dir+180)}forEach[_blanket,_pillow,_shelf];
{_x setDir(random 359)}forEach[_basket,_bucket3,_can,_trash]}