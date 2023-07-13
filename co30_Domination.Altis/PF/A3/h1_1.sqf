//Land_i_house_Small_01_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=createSimpleObject[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_mw=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
_rack=createSimpleObject["a3\structures_f\furniture\Rack_F.p3d",[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\Props_F_Orange\Furniture\Sofa_01_F.p3d",[0,0,0]];
_stool=createSimpleObject["a3\structures_f\furniture\Bench_F.p3d",[0,0,0]];
_junk=createSimpleObject["A3\Structures_F_Heli\Civ\Garbage\WheelieBin_01_F.p3d",[0,0,0]];
_tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
{_f pushBack _x}forEach[_bed,_blanket,_chair,_desk,_mw,_fridge,_rack,_shelf,_sofa,_stool,_junk,_tv];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[-3.6,1.05,-.6]);
_blanket setPos(_b modelToWorld[-3.6,1.1,-.565]);_blanket setDir(_dir+270);
_chair setPos(_b modelToWorld[-1.2,2.08,-1.03]);_chair setDir(_dir+250);
_desk setPos(_b modelToWorld[.025,2.16,-.36]);
_fridge setPos(_b modelToWorld[1.22,2.14,-.04]);
_mw setPos(_b modelToWorld[0.5,2,-.177]);_mw setDir(_dir+150);
_rack setPos(_b modelToWorld[-4.35,2.5,.59]);
_shelf setPos(_b modelToWorld[-4.18,-4.12,.515]);
_sofa setPos(_b modelToWorld[-1.15,-3.8,-.07]);
_stool setPos(_b modelToWorld[-1,1.23,-.57]);_stool setDir(_dir+90);
_junk setPos(_b modelToWorld[4.2,4.44,0]);
_tv setPos(_b modelToWorld[-1.0,1.3,.06]);
{_x setDir _dir}forEach[_rack,_sofa,_tv];
{_x setDir(_dir+180)}forEach[_bed,_desk,_fridge,_shelf,_junk];
if((dayTime<18)&&{(dayTime>6)})then{_tv setObjectTextureGlobal[0,(selectRandom["\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_pills_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_supermarket_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_maskrtnik_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_bluking_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_wine_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_plane_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_action_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_getlost_co.paa"])]}}