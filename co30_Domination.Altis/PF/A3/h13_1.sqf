//Land_Slum_House03_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_box=createSimpleObject["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0]];
_boxes=createSimpleObject["A3\Structures_F\Civ\Market\CratesShabby_F.p3d",[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_crate=createSimpleObject["A3\Structures_F\Civ\Market\CratesWooden_F.p3d",[0,0,0]];
_pbox=createSimpleObject["A3\Structures_F\Civ\Market\CratesPlastic_F.p3d",[0,0,0]];
_stool=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_blanket,_box,_boxes,_can,_crate,_pbox,_stool];
_b setVariable["PF",_f];

_blanket setPos(_b modelToWorld[.9,2.6,-1.03]);_blanket setDir(_dir+270);private _pos=getPosATL _blanket;_blanket setPosATL[_pos#0,_pos#1,0];
_boxes setPos(_b modelToWorld[3.9,2.65,0.451]);_boxes setDir(_dir+270);private _pos=getPosATL _boxes;_boxes setPosATL[_pos#0,_pos#1,0];
_crate setPos(_b modelToWorld[-1.37,2.2,.417]);_crate setDir _dir;private _pos=getPosATL _crate;_crate setPosATL[_pos#0,_pos#1,0];
_box setPosATL(_crate modelToWorld[.75,0,-.033]);_box setDir(_dir+90);
_can setPosATL(_crate modelToWorld[.77,-.1,0]);_can setDir(_dir+88);
_pbox setPos(_b modelToWorld[1.33,-0.3,-.61]);_pbox setDir(_dir+(random 15+80));private _pos=getPosATL _pbox;_pbox setPosATL[_pos#0,_pos#1,0];
_stool setPos(_b modelToWorld[0,-.5,-.593]);_stool setDir(_dir+90);private _pos=getPosATL _stool;_stool setPosATL[_pos#0,_pos#1,0]}