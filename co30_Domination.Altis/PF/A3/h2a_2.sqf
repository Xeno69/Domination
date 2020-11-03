//Land_i_Shop_01_V1_F	-	Flower shop
private _h=_this;

private _bucket=createSimpleObject["Land_Bucket_F",[0,0,0]];
private _cashier=createSimpleObject["Land_CashDesk_F",[0,0,0]];
private _chairW1=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _chairW2=createSimpleObject["Land_ChairWood_F",[0,0,0]];
private _shelfW1=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _shelfW2=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _shelfW3=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _shelfW4=createSimpleObject["Land_ShelvesWooden_F",[0,0,0]];
private _rack=createSimpleObject["Land_Metal_wooden_rack_F",[0,0,0]];
private _notepad=createSimpleObject["Land_Notepad_F",[0,0,0]];
private _oldDesk=createSimpleObject["OfficeTable_01_old_F",[0,0,0]];
private _papers=createSimpleObject["Leaflet_05_Stack_F",[0,0,0]];
private _pChair=createSimpleObject["Land_ChairPlastic_F",[0,0,0]];
private _pencil=createSimpleObject["Land_PencilYellow_F",[0,0,0]];
private _pot1=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _pot2=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _pot3=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _pot4=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _pot5=createSimpleObject["Land_FlowerPot_01_F",[0,0,0]];
private _plant1=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _plant2=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _plant3=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _plant4=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _plant5=createSimpleObject["Land_FlowerPot_01_Flower_F",[0,0,0]];
private _sacks1=createSimpleObject["Land_FoodSacks_01_large_brown_F",[0,0,0]];
private _sacks2=createVehicle["Land_Sacks_goods_F",[0,0,0],[],0,"can_collide"];_sacks2 enableSimulationGlobal false;
private _boxes=createVehicle["Land_CratesShabby_F",[0,0,0],[],0,"can_collide"];_boxes enableSimulationGlobal false;
private _luggage=createVehicle["Land_LuggageHeap_01_F",[0,0,0],[],0,"can_collide"];_luggage enableSimulationGlobal false;
private _trash=createSimpleObject["Land_WheelieBin_01_F",[0,0,0]];
private _fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
private _bed=createSimpleObject["Land_CampingTable_F",[0,0,0]];
private _blanket=selectRandom["Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F","Land_Sleeping_bag_brown_F"];
private _blanket=createVehicle[_blanket,[0,0,0],[],0,"can_collide"];_blanket enableSimulationGlobal false;
private _paper=selectRandom["Leaflet_05_New_F","Leaflet_05_Old_F"];
private _paper=createSimpleObject[_paper,[0,0,0]];

_chairW1 attachTo[_h,[-3.2,-1.78,0.27]];_chairW1 setDir 250;
_shelfW1 attachTo[_h,[-.8,-2,.76]];_shelfW1 setDir 90;
_shelfW2 attachTo[_h,[-2.8,-2,.76]];_shelfW2 setDir 270;
_shelfW3 attachTo[_h,[1.75,-.5,.76]];
_shelfW4 attachTo[_h,[1.75,1,.76]];
_cashier attachTo[_h,[-2,0,0.27]];_cashier setDir 270; 
_plant1 attachTo[_h,[-0.5,-2,2.023]];_plant1 setDir(random 359);
_plant2 attachTo[_h,[-0.9,-2,2.023]];_plant2 setDir(random 359);
_plant3 attachTo[_h,[-2.7,-2,2.023]];_plant3 setDir(random 359);
_plant4 attachTo[_h,[-3.1,-2,2.027]];_plant4 setDir(random 359);
_plant5 attachTo[_h,[1.75,1,2.023]];_plant5 setDir(random 359);
_pot1 attachTo[_h,[-.8,-2,1.004]];_pot1 setDir(random 359);
_pot2 attachTo[_h,[-2.6,-2,0.69]];_pot2 setDir(random 359);
_pot3 attachTo[_h,[-3,-2,0.69]];_pot3 setDir(random 359);
_pot4 attachTo[_h,[1.75,-0.7,1]];_pot4 setDir(random 359);
_pot5 attachTo[_h,[1.75,-0.3,1]];_pot5 setDir(random 359);
_trash attachTo[_h,[3.15,4.6,0.78]]; 
_chairW1 attachTo[_h,[-3.2,0.5,0.27]];_chairW1 setDir 300;
_sacks1 attachTo[_h,[-3,6.25,.76]];
_sacks2 attachTo[_h,[-3.2,3.5,.76]];_sacks2 setDir 90;
_boxes attachTo[_h,[-3.42,6.53,4.9]];_boxes setDir 182;
_luggage attachTo[_h,[-2.28,3.98,4.66]];_luggage setDir 8;
_oldDesk attachTo[_h,[-3.14,4.45,4.57]];
_chairW2 attachTo[_h,[-3.4,4.25,4.15]];_chairW2 setDir (random 10)+180;
_papers attachTo[_h,[-3.67,4.5,5.05]];_papers setDir 90;
_notepad attachTo[_h,[-3.4,4.25,4.989]];_notepad setDir 260;
_pencil attachTo[_h,[-3.4,4.25,4.989]];_pencil setDir(random 50);
_paper attachTo[_h,[-3.1,4.35,4.977]];_paper setDir 105;
_bucket attachTo[_h,[-2.8,3.9,4.32]];_bucket setDir 140;
_bed attachTo[_h,[-2.5,1,4.2]];_bed setDir 90;
_blanket attachTo[_h,[-2.5,1,4.62]];_blanket setDir 270;
_rack attachTo[_h,[1.7,4.27,5.145]];_rack setDir 90;
_fridge attachTo[_h,[1.6,2.63,4.7]];_fridge setDir 90;
_pChair attachTo[_h,[-3.2,-3.15,4.62]];_pChair setDir(random -80)+90;

if(dayTime>18 || dayTime<5)then{
	sleep 5;
	private _guyHome=_h nearEntities["Man",6];
	if(count _guyHome>0)then{
	private _light=createVehicle["#lightpoint",[0,0,0],[],0,"can_collide"];
	_light attachTo[_h,[-2,3.5,7.1]];
	_light setLightColor[1,1,1];  
	_light setLightAmbient[1,1,1];  
	_light setLightBrightness 0.04;};
	};

if(PF_Optimize)then{
sleep .2;
{_x hideObjectGlobal true}forEach attachedObjects _H;};