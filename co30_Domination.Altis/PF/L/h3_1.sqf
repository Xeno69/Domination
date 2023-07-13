//Land_House_1W05_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_chair=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
_rack=createSimpleObject["A3\Structures_F\Furniture\Rack_F.p3d",[0,0,0]];
_rug=createSimpleObject["a3\props_f_orange\furniture\rug_01_f.p3d",[0,0,0]];
_shelf=createSimpleObject["a3\Props_F_Orange\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\props_f_orange\furniture\sofa_01_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_chair,_desk,_fridge,_rack,_rug,_shelf,_sofa];
_b setVariable["PF",_f];

_chair setPos(_b modelToWorld[4.2,-1.95,0.14]);_chair setDir(_dir+152);
_desk setPos(_b modelToWorld[0.22,1.26,-.11]);_desk setDir(_dir+90);
_fridge setPos(_b modelToWorld[0.18,.065,0.21]);_fridge setDir(_dir+90);
_rack setPos(_b modelToWorld[-1.33,-2.28,.8]);_rack setDir(_dir+270);
_rug setPos(_b modelToWorld[4.23,1,-0.81]);
_shelf setPos(_b modelToWorld[1.2,3.75,0.73]);
_sofa setPos(_b modelToWorld[1.18,1,0.16]);_sofa setDir(_dir+90);
{_x setDir _dir}forEach[_chair,_rug,_shelf]}