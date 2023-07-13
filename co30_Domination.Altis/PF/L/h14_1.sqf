//Land_House_2B04_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_aid=createSimpleObject["a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d",[0,0,0]];
_bin=createSimpleObject["a3\structures_f_epc\civ\garbage\garbagebin_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair3=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair4=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair5=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair6=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair7=createSimpleObject["a3\Structures_F_Enoch\Furniture\Chairs\ch_mod_c\ch_mod_c.p3d",[0,0,0]];
_chair8=createSimpleObject["a3\structures_f_heli\furniture\officechair_01_f.p3d",[0,0,0]];
_desk=createSimpleObject["a3\Structures_F_Enoch\Furniture\Tables\conference_table_a\conference_table_a.p3d",[0,0,0]];
_desk2=createSimpleObject["a3\structures_f\furniture\tabledesk_f.p3d",[0,0,0]];
_news=createSimpleObject["a3\Props_F_Enoch\Items\Documents\Newspaper_01_F",[0,0,0]];
_rack=createSimpleObject[selectRandom(["a3\Structures_F_Enoch\Furniture\School_equipment\class_case_b_open.p3d","a3\Structures_F_Enoch\Furniture\School_equipment\class_case_b_closed.p3d"]),[0,0,0]];
_table=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
_table2=createSimpleObject["Land_PortableDesk_01_sand_F",[0,0,0]];
{_f pushBack _x}forEach[_aid,_bin,_chair,_chair1,_chair2,_chair3,_chair4,_chair5,_chair6,_chair7,_chair8,_desk,_desk2,_news,_rack,_table,_table2];_b setVariable["PF",_f];

_aid setPos(_b modelToWorld[-6,6.1,-4.565]);_aid setDir(_dir+270);
_bin setPos(_b modelToWorld[-0.692,3.1,-4.73]);
_chair setPos(_b modelToWorld[3.1,6.52,-5.75]);_chair setDir _dir;
_chair1 setPos(_b modelToWorld[8,4.24,-5.75]);
_chair2 setPos(_b modelToWorld[8,3,-5.75]);
_chair3 setPos(_b modelToWorld[8,1.75,-5.75]);
_chair4 setPos(_b modelToWorld[8,0.45,-5.75]);
_chair5 setPos(_b modelToWorld[4.65,0.1,-5.75]);_chair5 setDir(_dir+270);
_chair6 setPos(_b modelToWorld[-0.8,6,-5.75]);
_chair7 setPos(_b modelToWorld[-0.8,6.7,-5.75]);
_chair8 setPos(_b modelToWorld[-4.9,7.1,-4.41]);_chair8 setDir(_dir+45);
_desk setPos(_b modelToWorld[3.35,6.3,-5]);_desk setDir _dir;
_desk2 setPos(_b modelToWorld[-5.7,6.7,-4.93]);
_news setPos(_b modelToWorld[5,3.2,-5.08]);_news setDir(_dir-45);
_rack setPos(_b modelToWorld[3.43,2.62,-5.74]);_rack setDir(_dir+180);
_table setPos(_b modelToWorld[4.8,3,-5.1]);_table setDir _dir;
_table2 setPos(_b modelToWorld[-4.95,3.4,-4.87]);_table2 setDir(_dir-45);
{_x setDir(_dir+90)}forEach[_bin,_chair1,_chair2,_chair3,_chair4,_chair6,_chair7,_desk2]}