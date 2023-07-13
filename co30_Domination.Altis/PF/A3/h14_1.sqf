//Land_Slum_House01_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_blanky=createSimpleObject["A3\Props_F_Orange\Humanitarian\Camps\EmergencyBlanket_01_discarded_F.p3d",[0,0,0]];
_box1=createSimpleObject["Land_PaperBox_01_small_destroyed_brown_F",[0,0,0]];
_box2=createSimpleObject["Land_PaperBox_01_small_ransacked_brown_F",[0,0,0]];
_chair=createSimpleObject["A3\Structures_F\Civ\Camping\CampingChair_V1_F.p3d",[0,0,0]];
_tire=createSimpleObject["A3\Structures_F_Bootcamp\Civ\SportsGrounds\TyreBarrier_01_black_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_blanky,_box1,_box2,_chair,_tire];
_b setVariable["PF",_f];

_blanky setPos(_b modelToWorld[1.7,1.5,-.994]);private _pos=getPosATL _blanky;_blanky setPosATL[_pos#0,_pos#1,0];_blanky setDir(_dir+(random 7));
_box1 setPosATL(_b modelToWorld[-1.45,-.8,-.64]);private _pos=getPosATL _box1;_box1 setPosATL[_pos#0,_pos#1,0];
_box2 setPosATL(_b modelToWorld[-.58,-.8,-.64]);private _pos=getPosATL _box2;_box2 setPosATL[_pos#0,_pos#1,0];
_chair setPosATL(_b modelToWorld[.9,2.16,-.065]);private _pos=getPosATL _chair;_chair setPosATL[_pos#0,_pos#1,0];
_tire setPosATL(_b modelToWorld[.14,-.74,-.42]);private _pos=getPosATL _tire;_tire setPosATL[_pos#0,_pos#1,0];
{_x setDir _dir}forEach[_box1,_box2,_chair,_tire]}