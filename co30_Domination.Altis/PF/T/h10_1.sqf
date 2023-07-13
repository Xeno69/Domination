//Land_House_Native_02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_blanky=createSimpleObject["A3\Props_F_Orange\Humanitarian\Camps\EmergencyBlanket_01_discarded_F.p3d",[0,0,0]];
_bucket1=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_bucket2=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_cloth=createSimpleObject["A3\Structures_F_Exp\Civilian\Accessories\ClothesLine_01_short_F.p3d",[0,0,0]];
_fire=createSimpleObject["A3\Structures_F\Civ\Camping\Fireplace_F.p3d",[0,0,0]];
_pbox=createSimpleObject["A3\Structures_F\Civ\Market\CratesPlastic_F.p3d",[0,0,0]];
_sack1=createSimpleObject["Land_Sack_F",[0,0,0]];
_sack2=createSimpleObject["Land_Sack_F",[0,0,0]];
_wood=createSimpleObject["A3\Structures_F\Civ\Accessories\WoodPile_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_bed,_blanky,_bucket1,_bucket2,_cloth,_fire,_pbox,_sack1,_sack2,_wood];
_b setVariable["PF",_f];

_basket setPos(_b modelToWorld[-3.75,.1,-1.72]);
_bed setPos(_b modelToWorld[-3,2.5,-1.93]);_bed setDir(_dir+90);
_blanky setPos(_b modelToWorld[-3,2.5,-1.83]);_blanky setDir(_dir-90);
_bucket1 setPos(_b modelToWorld[2.51,1,-1.96]);
_bucket2 setPos(_b modelToWorld[2.4,1.37,-1.96]);
_cloth setPos(_b modelToWorld[-.78,.07,1.18]);_cloth setDir(_dir-90);
_fire setPos(_b modelToWorld[0,0,-2.295]);
_pbox setPos(_b modelToWorld[2.35,-2.15,-1.938]);_pbox setDir(_dir+90);
_sack1 setPos(_b modelToWorld[2.26,2.505,-1.57]);_sack1 setDir(_dir-45);
_sack2 setPos(_b modelToWorld[2.34,1.9,-1.57]);_sack2 setDir(_dir+90);
_wood setPos(_b modelToWorld[-3.65,-1.25,-1.85]);_wood setDir(_dir-180);
{_x setDir(random 359)}forEach[_basket,_bucket1,_bucket2,_fire]}