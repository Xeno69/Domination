//Land_Barn_02_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_box=createSimpleObject["a3\props_f_enoch\industrial\supplies\woodenbox_02_f.p3d",[0,0,0]];
_box2=createSimpleObject["a3\structures_f\civ\constructions\woodenbox_f.p3d",[0,0,0]];
_bucket=createSimpleObject["a3\structures_f\items\vessels\bucket_painted_f.p3d",[0,0,0]];
_dig=createSimpleObject["a3\structures_f_epa\items\tools\shovel_f.p3d",[0,0,0]];
_glove=createSimpleObject["a3\structures_f\items\tools\gloves_f.p3d",[0,0,0]];
_glove2=createSimpleObject["a3\structures_f\items\tools\gloves_f.p3d",[0,0,0]];
_hay=createSimpleObject["a3\structures_f_enoch\industrial\agriculture\haybale_01_decayed_f.p3d",[0,0,0]];
_hay2=createSimpleObject["a3\structures_f_enoch\industrial\agriculture\haybale_01_f.p3d",[0,0,0]];
_poo=createSimpleObject["a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d",[0,0,0]];
_trough=createSimpleObject["a3\structures_f_enoch\industrial\agriculture\trough_01_f.p3d",[0,0,0]];
_ladder=createVehicle["Land_PierLadder_F",[0,0,0],[],0,"can_collide"];
{_f pushBack _x}forEach[_box,_box2,_bucket,_dig,_glove,_glove2,_hay,_hay2,_poo,_trough,_ladder];_b setVariable["PF",_f];

_box setPos(_b modelToWorld[.25,5.25,1.4]);
_box2 setPos(_b modelToWorld[0,4,0.4]);_box2 setDir(_dir+14);
_bucket setPos(_b modelToWorld[1.6,6.5,-3.79]);
_dig setPos(_b modelToWorld[-1.7,3.2,-4.06]);_dig setDir(_dir+120);
_glove setPos(_b modelToWorld[1.9,6.3,-4.06]);_glove setDir(_dir+12);
_glove2 setPos(_b modelToWorld[2,6.2,-4.059]);_glove2 setDir(_dir+45);
_hay setPos(_b modelToWorld[-1,-3.2,-3.1]);_hay setDir(_dir+110);
_hay2 setPos(_b modelToWorld[-2.9,-2.6,-2.6]);
_poo setPos(_b modelToWorld[0,3,-3.6]);_poo setDir(_dir+45);
_trough setPos(_b modelToWorld[0,6.8,-3.68]);
_ladder setPos(_b modelToWorld[0.35,1.35,-2.34]);
{_x setDir _dir}forEach[_box,_bucket,_hay2,_trough,_ladder]}