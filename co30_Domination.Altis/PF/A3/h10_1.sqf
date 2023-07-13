//Land_i_Stone_Shed_01_c_raw_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_bucket=createSimpleObject["A3\Structures_F\Items\Vessels\Bucket_F.p3d",[0,0,0]];
_chair=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V1_F.p3d",[0,0,0]];
_towels=createSimpleObject["A3\Structures_F_Heli\Items\Food\Tableware_01_stackOfNapkins_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F\Civ\Garbage\Garbage_square3_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_blanket,_bucket,_chair,_towels,_trash];
_b setVariable["PF",_f];

_blanket setPos(_b modelToWorld[-.5,3.3,-.06]);_blanket setDir _dir;
_bucket setPos(_b modelToWorld[-.8,2,.22]);_bucket setDir(_dir+90);
_chair setPos(_b modelToWorld[5.7,4,.905]);_chair setDir(_dir+45);
_towels setPos(_b modelToWorld[-.55,1.9,-.04]);
_trash setPos(_b modelToWorld[2,2,-.02]);
{_x setDir(random 359)}forEach[_towels,_trash]}