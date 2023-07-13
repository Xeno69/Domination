//Land_House_Native_01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_blanky=createSimpleObject["A3\Props_F_Orange\Humanitarian\Camps\EmergencyBlanket_01_discarded_F.p3d",[0,0,0]];
_bucket1=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_bucket2=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_can=createSimpleObject["a3\structures_f\items\vessels\canisterplastic_f.p3d",[0,0,0]];
_cloth=createSimpleObject["A3\Structures_F_Exp\Civilian\Accessories\ClothesLine_01_short_F.p3d",[0,0,0]];
_fire=createSimpleObject["A3\Structures_F\Civ\Camping\Fireplace_F.p3d",[0,0,0]];
_pbox=createSimpleObject["A3\Structures_F\Civ\Market\CratesPlastic_F.p3d",[0,0,0]];
_pchair=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_rack=createSimpleObject["A3\Structures_F_EPB\Furniture\ShelvesWooden_F.p3d",[0,0,0]];
_sack1=createSimpleObject["A3\Structures_F\Civ\Market\Sack_F.p3d",[0,0,0]];
_sack2=createSimpleObject["A3\Structures_F\Civ\Market\Sacks_goods_F.p3d",[0,0,0]];
_sack3=createSimpleObject["A3\Structures_F\Civ\Market\Sacks_heap_F.p3d",[0,0,0]];
_wood=createSimpleObject["A3\Structures_F\Civ\Accessories\WoodPile_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_basket,_bed,_blanky,_bucket1,_bucket2,_can,_cloth,_fire,_pbox,_pchair,_rack,_sack1,_sack2,_sack3,_wood];
_b setVariable["PF",_f];

_basket setPos(_b modelToWorld[-4.35,-2.98,-2.49]);
_bed setPos(_b modelToWorld[3.64,-3.01,-2.65]);
_blanky setPos(_b modelToWorld[3.64,-3.01,-2.553]);
_bucket1 setPos(_b modelToWorld[.5,3.1,-1.76]);
_bucket2 setPos(_b modelToWorld[-.16,3.05,-2.67]);
_can setPos(_b modelToWorld[1.2,3.1,-2.553]);
_cloth setPos(_b modelToWorld[-4.75,0,0.3]);
_fire setPos(_b modelToWorld[0,0,-3.04]);_fire setDir _dir;
_pbox setPos(_b modelToWorld[4.06,-2.35,-2.89]);
_pchair setPos(_b modelToWorld[-4.3,3,-2.166]);_pchair setDir(_dir+60);
_rack setPos(_b modelToWorld[.5,3.08,-2.166]);
_sack1 setPos(_b modelToWorld[-4.56,-2.25,-2.26]);
_sack2 setPos(_b modelToWorld[4.14,-1.4,-2.14]);_sack2 setDir(_dir+30);
_sack3 setPos(_b modelToWorld[3.76,2.7,-2.34]);_sack3 setDir _dir;
_wood setPos(_b modelToWorld[-1,-2.87,-2.57]);
{_x setDir(random 359)}forEach[_basket,_bucket1,_bucket2,_sack1];
{_x setDir(_dir+90)}forEach[_bed,_blanky,_can,_cloth,_pbox,_rack,_wood]}