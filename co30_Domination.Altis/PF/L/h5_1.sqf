//Land_House_1W08_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
_mw=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f_epb\furniture\shelveswooden_f.p3d",[0,0,0]];
_radio=createSimpleObject["a3\structures_f\items\electronics\fmradio_f.p3d",[0,0,0]];
_rug=createSimpleObject["a3\props_f_orange\furniture\rug_01_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
_walker=createSimpleObject["a3\Props_F_Enoch\Military\Decontamination\WalkingFrame_01_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair,_desk,_fridge,_mw,_rack,_radio,_rug,_table,_walker];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[-2.02,-.64,-0.97]);_bed setDir(_dir+180);
_chair setPos(_b modelToWorld[3.78,3.66,-0.976]);_chair setDir(_dir+225);
_desk setPos(_b modelToWorld[3.67,0.56,-1.16]);_desk setDir(_dir+180);
_fridge setPos(_b modelToWorld[2.48,0.5,-0.846]);_fridge setDir(_dir+180);
_mw setPos(_b modelToWorld[4,0.56,-0.976]);_mw setDir(_dir+135);
_rack setPos(_b modelToWorld[1.06,-0.93,-0.83]);
_radio setPos(_b modelToWorld[3,3.8,-0.95]);_radio setDir(_dir+105);
_rug setPos(_b modelToWorld[-.2,-0.6,-1.86]);
_table setPos(_b modelToWorld[2.78,4,-1.09]);
_walker setPos(_b modelToWorld[-0.7,-1.51,-0.83]);
{_x setDir _dir}forEach[_rack,_rug,_table,_walker]}