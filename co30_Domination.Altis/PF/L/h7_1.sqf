//Land_House_1W01_F
isNil{params["_b"];_f=[];_pkg=0;_table3=0;_dir=getDir _b;
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_desk2=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_desk3=createSimpleObject["a3\structures_f_heli\furniture\officetable_01_f.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
_mw=createSimpleObject["a3\structures_f_heli\items\electronics\microwave_01_f.p3d",[0,0,0]];
if(floor random 1==0)then{_pkg=createSimpleObject["a3\structures_f_epb\items\luggage\luggageheap_01_f.p3d",[0,0,0]];_f pushBack _pkg};
_plant=createSimpleObject["a3\props_f_orange\items\decorative\flowerpot_01_flower_f.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f_heli\furniture\officecabinet_01_f.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\props_f_orange\furniture\sofa_01_f.p3d",[0,0,0]];
_table=createSimpleObject["a3\props_f_orange\furniture\tablebig_01_f.p3d",[0,0,0]];
_table2=createSimpleObject["a3\structures_f_heli\furniture\rattantable_01_f.p3d",[0,0,0]];
if(floor random 1==0)then{_table3=createSimpleObject["a3\props_f_orange\furniture\tablesmall_01_f.p3d",[0,0,0]];_f pushBack _table3};
_tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair,_chair2,_desk,_desk2,_desk3,_fridge,_mw,_plant,_rack,_sofa,_table,_table2,_tv];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[-2.4026,4.69,-1.937]);_bed setDir(_dir+90);
_chair setPos(_b modelToWorld[3.8,.1,-2.84]);_chair setDir(_dir+90);
_chair2 setPos(_b modelToWorld[1.95,0,-2.84]);_chair2 setDir(_dir+260);
_desk setPos(_b modelToWorld[-.907,4.917,-2.137]);_desk setDir(_dir+270);
_desk2 setPos(_b modelToWorld[-0.3,5.27,-2.137]);
_desk3 setPos(_b modelToWorld[4.455,3.7,-2.23]);_desk3 setDir(_dir+270);
_fridge setPos(_b modelToWorld[-0.89,3.72,-1.8]);_fridge setDir(_dir+270);
_mw setPos(_b modelToWorld[-.8,5.3,-1.95]);_mw setDir(_dir+325);
if(_pkg isEqualType objNull)then{_pkg setPos(_b modelToWorld[-2.01,.15,-1.831]);_pkg setDir(_dir+130)};
_plant setPos(_b modelToWorld[4.2,5.07,-0.455]);
_rack setPos(_b modelToWorld[-4.518,2.75,-1.22]);_rack setDir(_dir+270);
_sofa setPos(_b modelToWorld[2,3.7,-1.856]);_sofa setDir(_dir+90);
_table setPos(_b modelToWorld[2.9,.114,-2]);
_table2 setPos(_b modelToWorld[4.19,5.03,-2.05]);_table2 setDir(_dir+45);
if(_table3 isEqualType objNull)then{_table3 setPos(_b modelToWorld[3,3.7,-2.414]);_table3 setDir _dir};
_tv setPos(_b modelToWorld[4.6,3.7,-1.626]);_tv setDir(_dir+90);
if((dayTime<18)&&{(dayTime>6)})then{_tv setObjectTextureGlobal[0,(selectRandom["A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_pills_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_supermarket_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_maskrtnik_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_bluking_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_wine_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_plane_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_action_co.paa","A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_getlost_co.paa"])]};
{_x setDir _dir}forEach[_desk2,_plant,_table]}