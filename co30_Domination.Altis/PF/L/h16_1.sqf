//Land_House_2W02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bath=createSimpleObject["a3\structures_f_enoch\industrial\agriculture\trough_01_f.p3d",[0,0,0]];
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_book=createSimpleObject["a3\Structures_F_Enoch\Furniture\Cases\library_a\library_a.p3d",[0,0,0]];
_box=createSimpleObject["a3\structures_f_heli\items\luggage\plasticcase_01_small_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_desk=createSimpleObject["a3\Structures_F_Enoch\Furniture\School_equipment\teacher_desk.p3d",[0,0,0]];
_desk2=createSimpleObject["a3\Structures_F_Enoch\Furniture\Tables\conference_table_a\conference_table_a.p3d",[0,0,0]];
_heat=createSimpleObject["a3\Structures_F_Enoch\Furniture\kitchen\Dkamna_uhli\Dkamna_uhli.p3d",[0,0,0]];
_piss=createSimpleObject["a3\Structures_F_Enoch\Furniture\Bathroom\toilet_b_02\toilet_b_02.p3d",[0,0,0]];
_rack=createSimpleObject[selectRandom(["a3\Structures_F_Enoch\Furniture\School_equipment\class_case_b_open.p3d","a3\Structures_F_Enoch\Furniture\School_equipment\class_case_b_closed.p3d"]),[0,0,0]];
_rack2=createSimpleObject["a3\props_f_orange\furniture\officecabinet_02_f.p3d",[0,0,0]];
_rad=createSimpleObject["a3\Structures_F_Enoch\Furniture\School_equipment\radiator.p3d",[0,0,0]];
_sink=createSimpleObject["a3\Structures_F_Enoch\Furniture\School_equipment\lab_sink.p3d",[0,0,0]];
_wet=createSimpleObject["a3\Props_F_Enoch\Military\Decontamination\WaterSpill_01_Small_F",[0,0,0]];
{_f pushBack _x}forEach[_bath,_bed,_book,_box,_chair,_chair2,_desk,_desk2,_heat,_piss,_rack,_rack2,_rad,_sink,_wet];_b setVariable["PF",_f];

_bath setPos(_b modelToWorld[8.7,-1,-0.92]);_bath setDir(_dir+90);
_bed setPos(_b modelToWorld[1.85,-1.2,-3.14]);
_book setPos(_b modelToWorld[1.55,0,-1.3]);_book setDir(_dir+90);
_box setPos(_b modelToWorld[3.15,-1.2,-3.75]);_box setDir(_dir+180);
_chair setPos(_b modelToWorld[6,-2,-4.04]);
_chair2 setPos(_b modelToWorld[4.25,-1.2,-1.296]);
_desk setPos(_b modelToWorld[6.3,-2,-4.04]);
_desk2 setPos(_b modelToWorld[4.5,-1,-0.59]);
_heat setPos(_b modelToWorld[6.268,1,-4.035]);_heat setDir(_dir+90);
_piss setPos(_b modelToWorld[5.5,-2.12,-1.3]);
_rack setPos(_b modelToWorld[0.1,-3.45,-4.04]);
_rack2 setPos(_b modelToWorld[1.6,-2.2,0.26]);
_rad setPos(_b modelToWorld[7.5,4.41,-1.3]);
_sink setPos(_b modelToWorld[6.4,-1.845,-1.11]);
_wet setPos(_b modelToWorld[8,-1,-1.295]);
{_x setDir _dir}forEach[_piss,_rad,_sink,_wet];
{_x setDir(_dir+270)}forEach[_bed,_chair,_chair2,_desk,_desk2,_rack,_rack2]}