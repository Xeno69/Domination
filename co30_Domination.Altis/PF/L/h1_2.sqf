//Land_House_2W03_F
isNil{params["_b"];_f=[];
_bag=createSimpleObject["a3\structures_f_epb\items\luggage\luggageheap_01_f.p3d",[0,0,0]];
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_book=createSimpleObject["a3\structures_f_heli\furniture\officecabinet_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\props_f_orange\furniture\armchair_01_f.p3d",[0,0,0]];
_chair1=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_fridge=createSimpleObject["a3\structures_f_heli\items\electronics\fridge_01_f.p3d",[0,0,0]];
_junk=createSimpleObject["a3\props_f_exp\civilian\garbage\garbageheap_03_f.p3d",[0,0,0]];
_plant=createSimpleObject["a3\props_f_orange\items\decorative\flowerpot_01_flower_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bag,_bed,_book,_chair,_chair1,_chair2,_fridge,_junk,_plant,_table];
_b setVariable["PF",_f];

_dir=getDir _b;
_bag setPos(_b modelToWorld[-9,-0.63,.23]);_bag setDir(_dir+326.161);
_bed setPos(_b modelToWorld[-7.6,3.96,.13]);
_book setPos(_b modelToWorld[-6.2,4.47,-0.035]);
_chair setPos(_b modelToWorld[-2,-0.3,.18]);_chair setDir(_dir-45);
_chair1 setPos(_b modelToWorld[-3.68,0.83,-0.78]);_chair1 setDir(_dir+90);
_chair2 setPos(_b modelToWorld[-4.4,0.83,-0.78]);_chair2 setDir(_dir+270);
_junk setPos(_b modelToWorld[-1.5,5.39,-4.6]);_junk setDir(_dir+90);
_plant setPos(_b modelToWorld[-1.7,0.5,0.82]);
_fridge setPos(_b modelToWorld[-1.7,1.5,0.25]);_fridge setDir(_dir+90);
_table setPos(_b modelToWorld[-4.04,0.83,0.01]);
{_x setDir _dir}forEach[_bed,_book,_table]}