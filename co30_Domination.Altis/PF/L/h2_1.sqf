//Land_House_1W06_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_chair=createSimpleObject["A3\Structures_F_Heli\Furniture\RattanChair_01_F.p3d",[0,0,0]];
_chair1=createSimpleObject["A3\Structures_F_Heli\Furniture\RattanChair_01_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair3=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_desk1=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_desk2=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
_mw=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_plant=createSimpleObject["a3\Props_F_Orange\Items\Decorative\FlowerPot_01_flower_F.p3d",[0,0,0]];
_rack=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_table=createSimpleObject["a3\Props_F_Orange\Furniture\TableSmall_01_F.p3d",[0,0,0]];
_table1=createSimpleObject["a3\props_f_orange\furniture\tablebig_01_f.p3d",[0,0,0]];
_tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
{_f pushBack _x}forEach[_chair,_chair1,_chair2,_chair3,_desk,_desk1,_desk2,_fridge,_mw,_plant,_rack,_table,_table1,_tv];
_b setVariable["PF",_f];

_chair setPos(_b modelToWorld[4.7,-2.2,.5]);_chair setDir(_dir+150);
_chair1 setPos(_b modelToWorld[4.61,0.7,0.5]);_chair1 setDir(_dir+45);
_chair2 setPos(_b modelToWorld[-1.7,1.49,-.62]);_chair2 setDir(_dir+180);
_chair3 setPos(_b modelToWorld[-.28,1.9,-.62]);_chair3 setDir(_dir+70);
_desk setPos(_b modelToWorld[3,1.93,.225]);
_desk1 setPos(_b modelToWorld[-2.38,-1.3,0.09]);_desk1 setDir(_dir+270);
_desk2 setPos(_b modelToWorld[.01,-2.1,0.09]);_desk2 setDir(_dir+90);
_fridge setPos(_b modelToWorld[-.06,-0.88,.415]);_fridge setDir(_dir+90);
_mw setPos(_b modelToWorld[.05,-1.7,.28]);_mw setDir(_dir+115);
_plant setPos(_b modelToWorld[3.4,1.85,1.81]);
_rack setPos(_b modelToWorld[4.908,-.05,0.94]);_rack setDir(_dir+90);
_table setPos(_b modelToWorld[.67,-.45,-.185]);
_table1 setPos(_b modelToWorld[-1.23,1.82,0.27]);
_tv setPos(_b modelToWorld[.67,-.45,.435]);_tv setDir(_dir+290);
if((dayTime<18)&&{(dayTime>6)})then{_tv setObjectTextureGlobal[0,(selectRandom["A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_pills_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_supermarket_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_maskrtnik_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_bluking_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_wine_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_plane_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_action_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_getlost_co.paa"])]};
{_x setDir _dir}forEach[_desk,_table,_table1]}