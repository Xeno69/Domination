//Land_House_Small_05_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\Props_F_Orange\Furniture\WoodenBed_01_F.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair3=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair4=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_plant=createSimpleObject["a3\Props_F_Orange\Items\Decorative\FlowerPot_01_flower_F.p3d",[0,0,0]];
_pot1=createSimpleObject["a3\Props_F_Orange\Items\Decorative\FlowerPot_01_F.p3d",[0,0,0]];
_pot2=createSimpleObject["a3\Props_F_Orange\Items\Decorative\FlowerPot_01_F.p3d",[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_table1=createSimpleObject["A3\Structures_F_Heli\Furniture\RattanTable_01_F.p3d",[0,0,0]];
_table2=createSimpleObject["A3\Structures_F_EPC\Civ\Accessories\TablePlastic_01_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair1,_chair2,_chair3,_chair4,_desk,_plant,_pot1,_pot2,_shelf,_table1,_table2];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[-3,4.2,-.175]);
_chair1 setPos(_b modelToWorld[-2,-.65,-1.09]);
_chair2 setPos(_b modelToWorld[-3.75,-3.3,-.12]);
_chair3 setPos(_b modelToWorld[-1.3,-3.3,-.12]);_chair3 setDir(_dir+180);
_chair4 setPos(_b modelToWorld[-2.6,-3.8,-.12]);_chair4 setDir(_dir+270);
_desk setPos(_b modelToWorld[-2.2,-1.1,-.242]);_desk setDir(_dir+180);
_plant setPos(_b modelToWorld[-2.6,-1,1.343]);
_pot1 setPos(_b modelToWorld[-0.56,-1.7,-.84]);
_pot2 setPos(_b modelToWorld[-0.9,-1.7,-.84]);
_shelf setPos(_b modelToWorld[-3.56,-1.24,.48]);_shelf setDir(_dir+180);
_table1 setPos(_b modelToWorld[0,4.8,-.29]);
_table2 setPos(_b modelToWorld[-2.7,-3.3,-.2]);
{_x setDir _dir}forEach[_bed,_chair1,_chair2,_table1,_table2];
{_x setDir(random 359)}forEach[_plant,_pot1,_pot2]}