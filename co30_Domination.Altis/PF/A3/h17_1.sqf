//Land_GuardHouse_01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_chair1=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeChair_01_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeChair_01_F.p3d",[0,0,0]];
_cup=createSimpleObject["A3\Structures_F_Heli\Items\Food\Tableware_01_cup_F.p3d",[0,0,0]];
_desk1=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_desk2=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_desk3=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_desk4=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_pages1=createSimpleObject["a3\Weapons_F_Orange\Ammo\leaflet_05_stack_f.p3d",[0,0,0]];
_pages2=createSimpleObject["a3\Weapons_F_Orange\Ammo\leaflet_05_stack_f.p3d",[0,0,0]];
_pcMon=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\PCSet_01_screen_F.p3d",[0,0,0]];
_rack1=createSimpleObject["A3\Structures_F_EPB\Furniture\ShelvesWooden_F.p3d",[0,0,0]];
_rack2=createSimpleObject["A3\Structures_F_EPB\Furniture\ShelvesWooden_F.p3d",[0,0,0]];
_rack3=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_radio=createSimpleObject["a3\structures_f\Items\Electronics\FMradio_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_chair1,_chair2,_cup,_desk1,_desk2,_desk3,_desk4,_pages1,_pages2,_pcMon,_rack1,_rack2,_rack3,_radio];
_b setVariable["PF",_f];

_chair1 setPos(_b modelToWorld[-1.7,.3,.33]);_chair1 setDir(_dir+207);
_chair2 setPos(_b modelToWorld[1.5,0,.33]);
_cup setPos(_b modelToWorld[-1.75,.48,.093]);
_desk1 setPos(_b modelToWorld[-1.97,-4.7,-.18]);
_desk2 setPos(_b modelToWorld[-1.5,-4.7,-.18]);
_desk3 setPos(_b modelToWorld[-1.03,-4.69,-.18]);
_desk4 setPos(_b modelToWorld[-1.97,-4.7,.39]);
_pages1 setPos(_b modelToWorld[2.23,-1.2,-.57]);
_pages2 setPos(_b modelToWorld[2.23,-1,-.26]);
_pcMon setPos(_b modelToWorld[-1.75,-4.65,.31]);
_rack1 setPos(_b modelToWorld[2.23,-.23,-.03]);
_rack2 setPos(_b modelToWorld[2.23,-1.2,-.03]);
_rack3 setPos(_b modelToWorld[.03,-4.83,.54]);
_radio setPos(_b modelToWorld[2.312,.46,1.215]);_radio setDir(_dir+270);
{_x setDir(_dir+180)}forEach[_chair2,_desk1,_desk2,_desk3,_desk4,_pcMon,_rack3];
{_x setDir _dir}forEach[_cup,_pages1,_pages2,_rack1,_rack2]}