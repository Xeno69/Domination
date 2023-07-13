//Land_Barn_01_brown_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bucket1=createSimpleObject["A3\Structures_F\Items\Vessels\Bucket_painted_F.p3d",[0,0,0]];
_bucket2=createSimpleObject["A3\Structures_F\Items\Vessels\Bucket_painted_F.p3d",[0,0,0]];
_can1=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_can2=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_crowbar=createSimpleObject["a3\Props_F_Orange\Items\Tools\Crowbar_01_F.p3d",[0,0,0]];
_glove1=createSimpleObject["A3\Structures_F\Items\Tools\Gloves_F.p3d",[0,0,0]];
_glove2=createSimpleObject["A3\Structures_F\Items\Tools\Gloves_F.p3d",[0,0,0]];
_hammer=createSimpleObject["A3\Structures_F\Items\Tools\Hammer_F.p3d",[0,0,0]];
_mask=createSimpleObject["A3\Structures_F\Items\Tools\DustMask_F.p3d",[0,0,0]];
_rope=createSimpleObject["A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d",[0,0,0]];
_saw1=createSimpleObject["A3\Structures_F\Items\Tools\Saw_F.p3d",[0,0,0]];
_saw2=createSimpleObject["A3\Structures_F\Items\Tools\Saw_F.p3d",[0,0,0]];
_shovel1=createSimpleObject["A3\Structures_F_EPA\Items\Tools\Shovel_F.p3d",[0,0,0]];
_shovel2=createSimpleObject["A3\Structures_F_EPA\Items\Tools\Shovel_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bucket1,_bucket2,_can1,_can2,_crowbar,_glove1,_glove2,_hammer,_mask,_rope,_saw1,_saw2,_shovel1,_shovel2];
 _b setVariable["PF",_f];

_bucket1 setPos(_b modelToWorld[-7,-3.7,-.52]);
_bucket2 setPos(_b modelToWorld[-6,-3.9,-.52]);
_can1 setPos(_b modelToWorld[-5.7,3.7,-.11]);
_can2 setPos(_b modelToWorld[-5.6,3.2,-.11]);_can2 setDir _dir;
_crowbar setPos(_b modelToWorld[5.89,-3.1,-.08]);_crowbar setVectorUp[-450,.5,5];
_glove1 setPos(_b modelToWorld[-7.6,-3.8,.545]);_glove1 setDir(_dir+40);
_glove2 setPos(_b modelToWorld[-7.42,-3.9,.545]);_glove2 setDir(_dir+80);
_hammer setPos(_b modelToWorld[-8,-3.85,.18]);_hammer setDir(_dir+60);_hammer setVectorUp[-1,0,0];
_mask setPos(_b modelToWorld[-7,-3.7,.557]);
_rope setPos(_b modelToWorld[5.86,-1.706,.105]);_rope setVectorUp[-1,0,0];
_saw1 setPos(_b modelToWorld[-7.25,-3.9,.116]);_saw1 setDir(_dir+60);
_saw2 setPos(_b modelToWorld[5.86,-2.328,.069]);_saw2 setVectorUp[-1500,0,90];
_shovel1 setPos(_b modelToWorld[4.8,2.05,-.74]);
_shovel2 setPos(_b modelToWorld[5.88,-2.02,-.195]);
{_x setDir(random 359)}forEach[_bucket1,_bucket2];
{_x setDir(_dir+20)}forEach[_can1,_mask,_shovel1];
{_x setDir(_dir+90)}forEach[_crowbar,_saw2,_shovel2];
_crowbar setVectorUp[-450,.5,5];_saw2 setVectorUp[-1500,0,90];_shovel2 setVectorUp[-50,0,-1]}