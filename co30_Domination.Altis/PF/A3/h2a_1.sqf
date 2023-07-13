//Land_i_House_Small_02_V1_F
isNil{params["_b"];
if(isNil{_b getVariable"PF_B"})then{_b setVariable["PF_B","h2a_1"]};_dir=getDir _b;_f=[];
_bed=createSimpleObject["a3\Props_F_Orange\Furniture\WoodenBed_01_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_mw=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_sink=createSimpleObject["A3\Structures_F\Civ\Accessories\Sink_F.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];
_table=createSimpleObject["a3\Props_F_Orange\Furniture\TableBig_01_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair,_desk,_mw,_sink,_sofa,_table];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[6.5,0,.17]);_bed setDir(_dir+90);
_chair setPos(_b modelToWorld[-2.5,2.4,-.74]);_chair setDir(_dir+58);
_desk setPos(_b modelToWorld[.4,-2.5,0]);_desk setDir(_dir+90);
_mw setPos(_b modelToWorld[.4,-2.5,.185]);_mw setDir(_dir+99);
_sink setPos(_b modelToWorld[.35,-.6,.47]);_sink setDir(_dir+270);
_sofa setPos(_b modelToWorld[1.8,-2.6,.22]);_sofa setDir(_dir+45);
_table setPos(_b modelToWorld[-3.2,1.8,.14]);_table setDir(_dir+270)}