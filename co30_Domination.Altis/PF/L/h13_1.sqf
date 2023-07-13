//Land_House_1W02_F
isNil{params["_b"];_f=[];_pic=0;_sack=0;_dir=getDir _b;
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_bed2=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f_heli\furniture\officechair_01_f.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair3=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f_heli\furniture\officetable_01_f.p3d",[0,0,0]];
_kb=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_keyboard_f.p3d",[0,0,0]];
_mon=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[0,0,0]];
_mice=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_mouse_f.p3d",[0,0,0]];
_pc=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[0,0,0]];
if(floor random 2==0)then{_pic=createSimpleObject["a3\props_f_orange\items\decorative\photoframe_01_f.p3d",[0,0,0]];_f pushBack _pic};
_rack=createSimpleObject["a3\structures_f_heli\furniture\officecabinet_01_f.p3d",[0,0,0]];
if(floor random 2==0)then{_sack=createSimpleObject["a3\structures_f\civ\market\sack_f.p3d",[0,0,0]];_f pushBack _sack};
_table=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
_table2=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_bed2,_chair,_chair1,_chair2,_chair3,_desk,_kb,_mon,_mice,_pc,_rack,_table,_table2];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[3,3,-1.22]);
_bed2 setPos(_b modelToWorld[1.18,3,-1.22]);
_chair setPos(_b modelToWorld[-0.2,3.32,-0.78]);_chair setDir(_dir+38);
_chair1 setPos(_b modelToWorld[-3.31,0.01,-2.13]);
_chair2 setPos(_b modelToWorld[-2.88,-1.23,-2.13]);_chair2 setDir(_dir+108);
_chair3 setPos(_b modelToWorld[-2.9,-0.36,-2.13]);_chair3 setDir(_dir+90);
_desk setPos(_b modelToWorld[-0.98,3.08,-1.28]);_desk setDir(_dir+270);
_kb setPos(_b modelToWorld[-0.8,2.8,-1.281]);_kb setDir(_dir+263);
_mice setPos(_b modelToWorld[-0.8,3.15,-1.248]);_mice setDir(_dir+263);
_mon setPos(_b modelToWorld[-1.2,3,-0.788]);_mon setDir(_dir+270);
_pc setPos(_b modelToWorld[-0.93,2.3,-1.61]);_pc setDir(_dir+270);
if(_pic isEqualType objNull)then{_pic setPos(_b modelToWorld[5.314,0.5,-0.5]);_pic setDir(_dir+180)};
_rack setPos(_b modelToWorld[4.5,3.5,-1.38]);
if(_sack isEqualType objNull)then{_sack setPos(_b modelToWorld[5,-1.45,-1.292]);_sack setDir(_dir+57.273)};
_table setPos(_b modelToWorld[-3.31,-1.08,-1.33]);
_table2 setPos(_b modelToWorld[-3.31,-0.36,-1.3301]);
{_x setDir _dir}forEach[_bed,_bed2,_chair1,_rack,_table,_table2]}