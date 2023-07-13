//Land_Slum_01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_axe=createSimpleObject["A3\Structures_F\Items\Tools\Axe_F.p3d",[0,0,0]];
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed1=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_bed2=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_blanky=createSimpleObject["A3\Props_F_Orange\Humanitarian\Camps\EmergencyBlanket_01_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_crates=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_gas=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d",[0,0,0]];
_pcrate=createSimpleObject["A3\Structures_F\Civ\Market\CratesPlastic_F.p3d",[0,0,0]];
_rack=createSimpleObject["A3\Structures_F\Furniture\Rack_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_small_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",[0,0,0]];
_wood=createSimpleObject["A3\Structures_F\Civ\Accessories\WoodPile_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_axe,_basket,_bed1,_bed2,_blanket,_blanky,_chair,_crates,_gas,_pcrate,_rack,_table,_trash,_wood];
_b setVariable["PF",_f];

_axe setPos(_b modelToWorld[2.2,-2.197,1.496]);_axe setDir _dir;
_basket setPos(_b modelToWorld[5.3,-2.08,1.347]);_basket setDir(random 359);
_bed1 setPos(_b modelToWorld[-.22,0.2,1.15]);_bed1 setDir(_dir+90);
_bed2 setPos(_b modelToWorld[-.22,0.5,1.15]);_bed2 setDir(_dir+90);
_blanket setPos(_b modelToWorld[-.22,.355,1.218]);_blanket setDir(_dir-90);
_blanky setPos(_b modelToWorld[2.5,-2.2,1.146]);
_chair setPos(_b modelToWorld[2.6,.35,.66]);_chair setDir(_dir-90);
_crates setPos(_b modelToWorld[-.85,1.93,2.18]);
_gas setPos(_b modelToWorld[3,-2.2,1.21]);_gas setDir(_dir+86);
_pcrate setPos(_b modelToWorld[2.2,-2.09,2.605]);
_rack setPos(_b modelToWorld[2.2,-2.197,2.29]);_rack setDir(_dir-90);
_table setPos(_b modelToWorld[3,.35,1.52]);
_trash setPos(_b modelToWorld[3,.35,.745]);_trash setDir(random 359);
_wood setPos(_b modelToWorld[5.22,1.44,1.22]);_wood setDir _dir;
{_x setDir(_dir+180)}forEach[_blanky,_crates,_pcrate,_table]}