//Land_i_Garage_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
switch(floor random 5)do{ 
case 0:{private _car=createSimpleObject["A3\soft_f_gamma\Hatchback_01\Hatchback_01_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[0,-1.3,2.7]);_car setDir(_dir+(random 10+270));_f pushBack _car;{_car hideSelection[_x,true]}forEach["clan","daylights","light_l","light_r","reverse_light","zadni svetlo","brzdove svetlo"]}; 
case 1:{private _car=createSimpleObject["A3\Soft_F_Exp\Offroad_02\Offroad_02_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[0,-1.3,2.87]);_car setDir(_dir+(random 10+270));_f pushBack _car;{_car hideSelection[_x,true]}forEach["clan","daylights","mph","mph_on","rpm_on","fuel_on","tmp_on","light_1","light_1_hide","light_2","light_2_hide","light_l","light_r","reverse_light","zadni svetlo","brzdove svetlo","podsvit pristroju"]};
case 2:{private _car=createSimpleObject["A3\soft_f\Offroad_01\Offroad_01_unarmed_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[0.2,-1.3,2.99]);_car setDir(_dir+(random 10+270));_f pushBack _car;{_car hideSelection[_x,true]}forEach["clan","zadni svetlo","brzdove svetlo","light_l","light_r","police"];_car animate["hidepolice",1,1]};
case 3:{private _car=createSimpleObject["C_Hatchback_01_sport_F",[0,0,0]];_car setPos(_b modelToWorld[0,-1.3,2.7]);_car setDir(_dir+(random 10+270));_f pushBack _car};
case 4:{private _car=createSimpleObject["A3\Soft_F\Quadbike_01\Quadbike_01_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-1,2,2.9]);_car setDir(_dir+(random 10+90));_f pushBack _car;{_car hideSelection[_x,true]}forEach["clan","light_r","light_l","zadni svetlo"]};};
_trash=createSimpleObject["A3\Structures_F_Heli\Civ\Garbage\WheelieBin_01_F.p3d",[0,0,0]]; 
_trash setPos(_b modelToWorld[-3,2.3,0.9]);_trash setDir(_dir+random -20);_f pushBack _trash; 
_b setVariable["PF",_f]}