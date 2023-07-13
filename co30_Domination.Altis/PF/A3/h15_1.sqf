//Land_i_Addon_03_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_chair1=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair3=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair4=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair5=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair6=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_table1=createSimpleObject["A3\Structures_F_EPC\Civ\Accessories\TablePlastic_01_F.p3d",[0,0,0]];
_table2=createSimpleObject["A3\Structures_F_EPC\Civ\Accessories\TablePlastic_01_F.p3d",[0,0,0]];
_table3=createSimpleObject["A3\Structures_F_EPC\Civ\Accessories\TablePlastic_01_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_chair1,_chair2,_chair3,_chair4,_chair5,_chair6,_table1,_table2,_table3];
 _b setVariable["PF",_f];

_chair1 setPos(_b modelToWorld[-3.54,-0.81,.912]);_chair1 setDir(_dir+180);
_chair2 setPos(_b modelToWorld[-4.04,.22,.912]);
_chair3 setPos(_b modelToWorld[4.04,.22,.912]);
_chair4 setPos(_b modelToWorld[3.54,-1,.912]);
_chair5 setPos(_b modelToWorld[3.7,2.95,.912]);_chair5 setDir(_dir+270);
_chair6 setPos(_b modelToWorld[2.4,3.45,.912]);
_table1 setPos(_b modelToWorld[-4.04,-0.81,.828]);
_table2 setPos(_b modelToWorld[4.04,-0.81,.828]);
_table3 setPos(_b modelToWorld[3.44,3.45,.828]);
{_x setDir(_dir+90)}forEach[_chair2,_chair3,_table1,_table2];
{_x setDir _dir}forEach[_chair4,_chair6,_table3]}