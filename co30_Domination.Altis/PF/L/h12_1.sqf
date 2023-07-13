//Land_Shed_13_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bucket=createSimpleObject["a3\structures_f\items\vessels\bucket_f.p3d",[0,0,0]];
_bucket2=createSimpleObject["a3\structures_f\items\vessels\bucket_painted_f.p3d",[0,0,0]];
_can=createSimpleObject["a3\structures_f_epa\items\tools\butanecanister_f.p3d",[0,0,0]];
_can2=createSimpleObject["a3\structures_f_epa\items\tools\butanetorch_f.p3d",[0,0,0]];
_glove=createSimpleObject["a3\structures_f\items\tools\gloves_f.p3d",[0,0,0]];
_glove2=createSimpleObject["a3\structures_f\items\tools\gloves_f.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f\furniture\metal_rack_f.p3d",[0,0,0]];
_saw=createSimpleObject["a3\structures_f\items\tools\saw_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\structures_f_heli\furniture\workbench_01_f.p3d",[0,0,0]];
_wood=createSimpleObject["a3\structures_f\civ\constructions\workstand_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bucket,_bucket2,_can,_can2,_glove,_glove2,_rack,_saw,_table,_wood];
_b setVariable["PF",_f];

_bucket setPos(_b modelToWorld[0.4,1.3,-0.74]);
_bucket2 setPos(_b modelToWorld[1.3,1.3,-0.905]);
_can setPos(_b modelToWorld[0,1.3,0.03]);_can setDir(_dir+225);
_can2 setPos(_b modelToWorld[0.1,1.35,0.094]);_can2 setDir(_dir+180);
_glove setPos(_b modelToWorld[2.8,1,-0.364]);
_glove2 setPos(_b modelToWorld[2.75,1,-0.36]);_glove2 setDir(_dir-50);
_rack setPos(_b modelToWorld[0.2,1.3,0.63]);
_saw setPos(_b modelToWorld[3,-1.19,-0.33]);
_table setPos(_b modelToWorld[2.39,1.04,-0.19]);
_wood setPos(_b modelToWorld[1.56,-1.06,-1.2]);
{_x setDir _dir}forEach[_bucket,_bucket2,_glove,_rack,_saw,_table,_wood]}