//Land_House_2W04_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_cupboard=createSimpleObject["a3\Structures_F_Enoch\Furniture\School_equipment\class_case_a_open.p3d",[0,0,0]];
_desk=createSimpleObject["a3\Structures_F_Enoch\Furniture\Tables\conference_table_a\conference_table_a.p3d",[0,0,0]];
_chair=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_junk=createSimpleObject["a3\props_f_exp\civilian\garbage\garbageheap_04_f.p3d",[0,0,0]];
_piano=createSimpleObject["a3\Structures_F_Enoch\Furniture\Decoration\piano\piano.p3d",[0,0,0]];
_rug=createSimpleObject["a3\Structures_F_Enoch\Furniture\Decoration\carpet_big\carpet_big.p3d",[0,0,0]];
_table=createSimpleObject["a3\props_f_orange\furniture\officecabinet_02_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair,_cupboard,_desk,_junk,_piano,_rug,_table];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[5.17,3.158,0.087]);_bed setDir(_dir+270);
_desk setPos(_b modelToWorld[0.3,-.29,-0.11]);
_chair setPos(_b modelToWorld[0.1,-.06,-0.825]);
_cupboard setPos(_b modelToWorld[1.44,-.29,-0.814]);_cupboard setDir(_dir+180);
_junk setPos(_b modelToWorld[-3,3.6,-4.24]);_junk setDir(_dir+259.537);
_piano setPos(_b modelToWorld[3.04,3.3,0.1]);
_rug setPos(_b modelToWorld[2.9,3.3,-.82]);
_table setPos(_b modelToWorld[4.27,1.658,-.08]);_table setDir(_dir+270);
{_x setDir _dir}forEach[_chair,_desk,_piano,_rug]}