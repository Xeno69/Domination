//Land_Slum_01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed1=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_bed2=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_boxes=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_bucket=createSimpleObject["A3\Structures_F\Items\Vessels\Bucket_painted_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_cloth=createSimpleObject["A3\Props_F_Orange\Humanitarian\Camps\EmergencyBlanket_01_F.p3d",[0,0,0]];
_gas=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f\furniture\Rack_F.p3d",[0,0,0]];
_sack=createSimpleObject["A3\Structures_F\Civ\Market\Sack_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_bed1,_bed2,_blanket,_boxes,_bucket,_chair,_gas,_rack,_sack,_table,_trash];
_b setVariable["PF",_f];

_basket setPos(_b modelToWorld[5.31,-2.06,1.34]);
_bed1 setPos(_b modelToWorld[-.28,.3,1.14]);_bed1 setDir(_dir+90);
_bed2 setPos(_b modelToWorld[-.28,.6,1.14]);_bed2 setDir(_dir+90);
_blanket setPos(_b modelToWorld[-.25,.45,1.207]);_blanket setDir(_dir+270);
_boxes setPos(_b modelToWorld[-.885,1.91,2.18]);
_bucket setPos(_b modelToWorld[1.96,2.3,.935]);
_chair setPos(_b modelToWorld[3.4,.75,.66]);
_cloth setPos(_b modelToWorld[2,-2.23,1.516]);_cloth setDir(_dir+180);
_gas setPos(_b modelToWorld[3,-2.25,1.2]);_gas setDir(_dir-90);
_rack setPos(_b modelToWorld[2.2,-2.192,2.3]);_rack setDir(_dir-90);
_sack setPos(_b modelToWorld[1.5,2.07,1.5]);_sack setDir(_dir-35);
_table setPos(_b modelToWorld[3.4,.2,1.52]);
_trash setPos(_b modelToWorld[2.5,0,.75]);
{_x setDir _dir}forEach[_boxes,_chair,_table];
{_x setDir(random 359)}forEach[_basket,_bucket,_trash]}