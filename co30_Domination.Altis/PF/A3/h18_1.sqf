//Land_FuelStation_01_workshop_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bucket=createSimpleObject["Land_PlasticBucket_01_open_F",[0,0,0]];
_cart1=createSimpleObject["A3\Structures_F_Heli\Civ\Constructions\ToolTrolley_02_F.p3d",[0,0,0]];
_cart2=createSimpleObject["A3\Structures_F_Heli\Civ\Constructions\ToolTrolley_01_F.p3d",[0,0,0]];
_cart3=createSimpleObject["A3\Structures_F_Heli\Civ\Constructions\WeldingTrolley_01_F.p3d",[0,0,0]];
_cord=createSimpleObject["A3\Structures_F\Items\Electronics\ExtensionCord_F.p3d",[0,0,0]];
_drill=createSimpleObject["A3\Structures_F\Items\Tools\DrillAku_F.p3d",[0,0,0]];
_fireX=createSimpleObject["A3\Structures_F_EPA\Items\Tools\FireExtinguisher_F.p3d",[0,0,0]];
_gas=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d",[0,0,0]];
_glove=createSimpleObject["a3\Props_F_Orange\Humanitarian\Garbage\MedicalGarbage_01_Gloves_F.p3d",[0,0,0]];
_pliers=createSimpleObject["a3\structures_f\Items\Tools\Pliers_F.p3d",[0,0,0]];
_screwD=createSimpleObject["A3\Structures_F\Items\Tools\Screwdriver_V1_F.p3d",[0,0,0]];
_tires=createSimpleObject["A3\Structures_F_Bootcamp\Civ\SportsGrounds\TyreBarrier_01_black_F.p3d",[0,0,0]];
_wBench=createSimpleObject["A3\Structures_F_Heli\Furniture\Workbench_01_F.p3d",[0,0,0]];
_wrench=createSimpleObject["A3\Structures_F\Items\Tools\Wrench_F.p3d",[0,0,0]];
_car=objNull;
switch(floor random 7)do{
case 0:{_car=createSimpleObject["A3\soft_f_gamma\van_01\Van_01_fuel_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,2.3,1.2]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","zadni svetlo","brzdove svetlo","light_l","light_r"]};
case 1:{_car=createSimpleObject["A3\soft_f\Offroad_01\Offroad_01_unarmed_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,1.6,.75]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","zadni svetlo","brzdove svetlo","light_l","light_r","police"];_car animate["hidepolice",1,1]};
case 2:{_car=createSimpleObject["A3\soft_f_gamma\Hatchback_01\Hatchback_01_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,2,.45]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","daylights","light_l","light_r","reverse_light","zadni svetlo","brzdove svetlo"]};
case 3:{_car=createSimpleObject["C_Hatchback_01_sport_F",[0,0,0]];_car setPos(_b modelToWorld[-3,2,.45]);_car setDir _dir};
case 4:{_car=createSimpleObject["A3\Soft_F_Exp\Offroad_02\Offroad_02_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,1.7,.63]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","daylights","mph","mph_on","rpm_on","fuel_on","tmp_on","light_1","light_1_hide","light_2","light_2_hide","light_l","light_r","reverse_light","zadni svetlo","brzdove svetlo","podsvit pristroju"]};
case 5:{_car=createSimpleObject["A3\soft_f_gamma\van_01\Van_01_transport_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,1.7,1.22]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","zadni svetlo","brzdove svetlo","light_l","light_r"]};
case 6:{_car=createSimpleObject["A3\soft_f_gamma\van_01\Van_01_box_F.p3d",[0,0,0]];_car setPos(_b modelToWorld[-3,2,1.22]);_car setDir(_dir+180);{_car hideSelection[_x,true]}forEach["clan","zadni svetlo","brzdove svetlo","light_l","light_r"]}};
{_f pushBack _x}forEach[_bucket,_car,_cart1,_cart2,_cart3,_cord,_drill,_fireX,_gas,_glove,_pliers,_screwD,_tires,_wBench];
 _b setVariable["PF",_f];

_bucket setPos(_b modelToWorld[5.2,4.26,-1.91]);
_cart1 setPos(_b modelToWorld[.45,3.97,-1.4]);_cart1 setDir(_dir+270);
_cart2 setPos(_b modelToWorld[-.8,3.97,-1.375]);_cart2 setDir(_dir+260);
_cart3 setPos(_b modelToWorld[5.6,3.78,-.97]);_cart3 setDir(_dir+99);
_cord setPos(_b modelToWorld[0,-5.43,-2.23]);_cord setDir(random 359);
_drill setPos(_b modelToWorld[-1,3.9,-1.22]);
_fireX setPos(_b modelToWorld[0,-5.67,-.8]);_fireX setDir(_dir+180);
_gas setPos(_b modelToWorld[-5.52,-5.69,-1.81]);
_glove setPos(_b modelToWorld[2.7,3.9,-1.495]);
_pliers setPos(_b modelToWorld[-.35,4.1,-1.5]);_pliers setDir(_dir+30);
_screwD setPos(_b modelToWorld[-.8,4,-1.48]);_screwD setDir(_dir+random 270);
_tires setPos(_b modelToWorld[5.56,-5.42,-1.7]);_tires setDir(_dir+90);
_wBench setPos(_b modelToWorld[2.3,3.97,-1.36]);
_wrench setPos(_b modelToWorld[-.5,4,-1.5]);
{_x setDir _dir}forEach[_bucket,_drill,_gas,_glove,_wBench,_wrench]}