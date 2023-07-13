//Land_House_1W04_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_ac=createSimpleObject["a3\structures_f_heli\civ\accessories\airconcondenser_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f_heli\furniture\officechair_01_f.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\tabledesk_f.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
_mon=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_screen_f.p3d",[0,0,0]];
_mw=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_pc=createSimpleObject["a3\structures_f_heli\items\electronics\pcset_01_case_f.p3d",[0,0,0]];
_pc2=createSimpleObject["a3\structures_f_heli\items\electronics\portablespeakers_01_f.p3d",[0,0,0]];
_plant=createSimpleObject["a3\props_f_orange\items\decorative\flowerpot_01_flower_f.p3d",[0,0,0]];
_rack=createSimpleObject["a3\props_f_orange\furniture\officecabinet_02_f.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\props_f_orange\furniture\sofa_01_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_epa\civ\camping\woodentable_small_f.p3d",[0,0,0]];
_tv=createSimpleObject["a3\structures_f_heli\items\electronics\flattv_01_f.p3d",[0,0,0]];
_tv1=createSimpleObject["a3\structures_f_mark\items\military\shottimer_01_f.p3d",[0,0,0]];
_tv2=createSimpleObject["a3\structures_f_epb\furniture\shelveswooden_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_ac,_chair,_chair1,_chair2,_desk,_fridge,_mon,_mw,_pc,_pc2,_plant,_rack,_sofa,_table,_tv,_tv1,_tv2,_wood];
_b setVariable["PF",_f];

_ac setPos(_b modelToWorld[1.52,-3.9,-.8]);
_chair setPos(_b modelToWorld[-4.26,-1.86,-2.55]);_chair setDir(_dir+180);
_chair1 setPos(_b modelToWorld[-3.79,-1,-2.55]);_chair1 setDir(_dir+70);
_chair2 setPos(_b modelToWorld[-3.94,-4.5,-1.2]);
_desk setPos(_b modelToWorld[-3.94,-5.11,-1.72]);
_fridge setPos(_b modelToWorld[-2.25,-.95,-1.51]);
_mon setPos(_b modelToWorld[-3.94,-5.3,-1.2]);_mon setDir(_dir+180);
_mw setPos(_b modelToWorld[-4.4,-1.2,-1.555]);_mw setDir(_dir-60);
_pc setPos(_b modelToWorld[-3.4,-5,-1.2]);_pc setDir(_dir+180);
_pc2 setPos(_b modelToWorld[-3.94,-5.25,-1.64]);_pc2 setDir(_dir+90);
_plant setPos(_b modelToWorld[.7,-5,-.946]);
_rack setPos(_b modelToWorld[.92,4.51,-.98]);_rack setDir(_dir+90);
_sofa setPos(_b modelToWorld[-1.2,3.77,-1.55]);_sofa setDir(_dir+90);
_table setPos(_b modelToWorld[-4.26,-1.3,-1.72]);
_tv setPos(_b modelToWorld[.95,3.63,-1.59]);_tv setDir(_dir+90);
_tv1 setPos(_b modelToWorld[-.9,2.7,-1.78]);_tv1 setDir(_dir+320);
_tv2 setPos(_b modelToWorld[0.86,3.63,-2.17]);

{_x setDir _dir}forEach[_ac,_chair2,_desk,_fridge,_plant,_table,_tv2]}