//Land_i_Addon_02_V1_F
isNil{params["_b"];
if(isNil{_b getVariable"PF_B"})then{_b setVariable["PF_B","h8a_1"]};_f=[];_dir=getDir _b;
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_cup=createSimpleObject["A3\Structures_F_Heli\Items\Food\Tableware_01_cup_F.p3d",[0,0,0]];
_desk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
_laptop=createSimpleObject["Land_Laptop_02_unfolded_F",[0,0,0]];
_rack1=createSimpleObject["a3\Props_F_Orange\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_rack2=createSimpleObject["A3\Structures_F_EPB\Furniture\ShelvesWooden_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_blanket,_chair,_cup,_desk,_laptop,_rack1,_rack2];
 _b setVariable["PF",_f];

 _blanket setPos(_b modelToWorld[-2.3,3.9,.13]);_blanket setDir(_dir+270);
_chair setPos(_b modelToWorld[0.2,0.25,.08]);
_cup setPos(_b modelToWorld[0,0.3,1.008]);
_desk setPos(_b modelToWorld[0,0.07,0.925]);
_laptop setPos(_b modelToWorld[0.2,0.2,1.167]);
_rack1 setPos(_b modelToWorld[1.1,-0.04,1.642]);
_rack2 setPos(_b modelToWorld[3,4.1,1.08]);_rack2 setDir(_dir+90);
{_x setDir _dir}forEach[_chair,_cup];
{_x setDir(_dir+180)}forEach[_desk,_Laptop,_rack1]}