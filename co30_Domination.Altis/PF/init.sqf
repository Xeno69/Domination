PF_Houses=[];
if(!isServer)exitWith{};if(PFrun)exitWith{};
#include"CFG.sqf"
PFrun=true;
PF_WN=worldName;
PF_Houses=[
//Altis,Malden,Stratis
"land_i_house_small_01_v1_f",
"land_i_house_small_01_v2_f",
"land_i_house_small_01_v3_f",
"land_i_house_small_01_b_blue_f",
"land_i_house_small_01_b_pink_f",
"land_i_house_small_01_b_white_f",
"land_i_house_small_01_b_whiteblue_f",
"land_i_house_small_01_b_brown_f",
"land_i_house_small_01_b_yellow_f",
"land_i_house_small_02_v1_f",
"land_i_house_small_02_v2_f",
"land_i_house_small_02_v3_f",
"land_i_house_small_03_v1_f",
"land_slum_01_f",
"land_slum_house01_f",
"land_slum_house02_f",
"land_slum_house03_f",
"land_i_stone_shed_v1_f",
"land_i_stone_shed_v2_f",
"land_i_stone_shed_v3_f",
"land_i_stone_housesmall_v1_f",
"land_i_stone_housesmall_v2_f",
"land_i_stone_housesmall_v3_f",
"land_i_shed_ind_f",
"land_i_shed_ind_03_f",
"land_shed_08_brown_f",
"land_shed_08_grey_f",
"land_i_stone_shed_01_b_clay_f",
"land_i_stone_shed_01_b_raw_f",
"land_i_stone_shed_01_b_white_f",
"land_i_stone_shed_01_c_clay_f",
"land_i_stone_shed_01_c_raw_f",
"land_i_stone_shed_01_c_white_f",
"land_barn_01_brown_f",
"land_barn_01_grey_f",
"land_i_addon_02_v1_f",
"land_i_addon_03_v1_f",
"land_carservice_f",
"land_fuelstation_01_shop_f",
"land_fuelstation_01_workshop_f",
"land_fuelstation_02_workshop_f",
"land_i_garage_v1_f",
"land_i_garage_v2_f",
"land_guardhouse_01_f",
"land_i_stone_housebig_v1_f",
"land_i_stone_housebig_v2_f",
"land_i_stone_housebig_v3_f",
"land_i_stone_house_big_01_b_clay_f",
"land_i_house_big_01_v1_f",
"land_i_house_big_01_v2_f",
"land_i_house_big_01_v3_f",
"land_i_house_big_01_b_blue_f",
"land_i_house_big_01_b_whiteblue_f",
"land_i_house_big_01_b_pink_f",
"land_i_house_big_01_b_pink_f",
"land_i_house_big_01_b_white_f",
"land_i_house_big_01_b_brown_f",
"land_i_house_big_02_v1_f",
"land_i_house_big_02_v2_f",
"land_i_house_big_02_v3_f",
"land_i_house_big_02_b_blue_f",
"land_i_house_big_02_b_pink_f",
"land_i_house_big_02_b_white_f",
"land_i_house_big_02_b_whiteblue_f",
"land_i_house_big_02_b_brown_f",
"land_i_house_big_02_b_yellow_f",
"land_i_shop_01_v1_f",
//"land_i_shop_01_v2_f",
"land_i_shop_01_v3_f",
"land_i_shop_02_v1_f",
"land_i_shop_02_v2_f",
"land_i_shop_02_v3_f",
"land_i_shop_02_b_blue_f",
"land_i_shop_02_b_pink_f",
"land_i_shop_02_b_white_f",
"land_i_shop_02_b_whiteblue_f",
"land_i_shop_02_b_brown_f",
"land_i_shop_02_b_yellow_f",
"land_offices_01_v1_f",

//Livonia
"land_house_1w11_f",
"land_house_1w10_f",
"land_house_1w09_f",
"land_house_1w08_f",
"land_house_1w06_f",
"land_house_1w05_f",
"land_house_1w04_f",
"land_house_1w03_f",
"land_house_1w02_f",
"land_house_1w01_f",
"land_house_2w02_f",
"land_house_2w03_f",
"land_house_2w04_f",
"land_house_2b04_f",
"land_shed_13_f",
"land_barn_02_f",
"land_camp_house_01_brown_f",
"land_healthcenter_01_f",
"land_villagestore_01_f",

//Tanoa
"land_house_big_01_f",
"land_house_small_02_f",
"land_house_small_03_f",
"land_shed_02_f",
"land_slum_03_f",
"land_house_small_05_f",
"land_house_small_06_f",
"land_house_native_01_f",
"land_house_native_02_f"
];
PF_Mil=[
"land_cargo_patrol_v1_f",
"land_cargo_patrol_v2_f",
"land_cargo_patrol_v3_f",
"land_cargo_patrol_v4_f"
];
PFHomes=PF_Houses;
switch(true)do{
case(toLower worldName in["desert","takistan","zargabad"]):{
PF_Houses=["Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_C_2_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1"];
PFHomes=["Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_C_2_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1"];
PFJobs=["Land_House_C_1_EP1","Land_House_C_1_v2_EP1","Land_House_C_2_EP1","Land_House_C_2_EP1","Land_House_C_3_EP1","Land_House_C_4_EP1","Land_House_C_9_EP1","Land_Market_stalls_01_EP1","Land_Market_stalls_02_EP1","Land_Ind_Coltan_Main_EP1","Land_Ind_Garage01_EP1","Land_A_FuelStation_Build","Land_Ind_FuelStation_Build_EP1","Land_FuelStation_Build_PMC","Land_House_C_12_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_A_Mosque_big_hq_EP1"];
if(isCUPV)then{PFCars=["CUP_C_Datsun_Tubeframe","CUP_C_Datsun","CUP_C_Datsun_Plain","CUP_C_Datsun_Covered","CUP_C_Datsun_4seat","CUP_C_Skoda_White_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_Green_CIV","CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_LR_Transport_CTK","CUP_C_Ural_Civ_01","CUP_C_Ural_Open_Civ_01"]};
};
default{PFCars=["C_Offroad_01_F","C_Offroad_01_repair_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_02_transport_F","C_Van_02_service_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","I_C_Van_02_vehicle_F"]}};
PF_B=[];PF_wMid=[worldSize/2,worldSize/2,0];

{_x params[["_function",""],["_file",""]];
private _code=compileFinal(preprocessFile _file);
if!(_file isEqualTo"")then{missionNamespace setVariable[_function,_code]}}forEach[
["PF_call","PF\f\call.sqf"],
["PF_h1_1","PF\A3\h1_1.sqf"],
["PF_Lh1_1","PF\L\h1_1.sqf"],
["PF_Th1_1","PF\T\h1_1.sqf"],
["PF_Th2_1","PF\T\h2_1.sqf"],
["PF_Lh2_1","PF\L\h2_1.sqf"],
["PF_Lh2_2","PF\L\h2_2.sqf"],
["PF_h2a_1","PF\A3\h2a_1.sqf"],
["PF_h2b_1","PF\A3\h2b_1.sqf"],
["PF_h2c_1","PF\A3\h2c_1.sqf"],
["PF_h3_1","PF\A3\h3_1.sqf"],
["PF_Lh3_1","PF\L\h3_1.sqf"],
["PF_Th3_1","PF\T\h3_1.sqf"],
["PF_Th3s_1","PF\T\h3s_1.sqf"],
["PF_h4_1","PF\A3\h4_1.sqf"],
["PF_Lh4_1","PF\L\h4_1.sqf"],
["PF_h5_1","PF\A3\h5_1.sqf"],
["PF_Lh5_1","PF\L\h5_1.sqf"],
["PF_Th5_1","PF\T\h5_1.sqf"],
["PF_h6_1","PF\A3\h6_1.sqf"],
["PF_Lh6_1","PF\L\h6_1.sqf"],
["PF_Th6_1","PF\T\h6_1.sqf"],
["PF_Th7a_1","PF\T\h7_1a.sqf"],
["PF_Lh7_1","PF\L\h7_1.sqf"],
["PF_h7_1","PF\A3\h7_1.sqf"],
["PF_Lh8_1","PF\L\h8_1.sqf"],
["PF_h8a_1","PF\A3\h8a_1.sqf"],
["PF_h8b_1","PF\A3\h8b_1.sqf"],
["PF_h8c_1","PF\A3\h8c_1.sqf"],
["PF_h9_1","PF\A3\h9_1.sqf"],
["PF_Lh9_1","PF\L\h9_1.sqf"],
["PF_h10_1","PF\A3\h10_1.sqf"],
["PF_Lh10_1","PF\L\h10_1.sqf"],
["PF_Th10_1","PF\T\h10_1.sqf"],
["PF_h11_1","PF\A3\h11_1.sqf"],
["PF_Lh11_1","PF\L\h11_1.sqf"],
["PF_Th11_1","PF\T\h11_1.sqf"],
["PF_h12_1","PF\A3\h12_1.sqf"],
["PF_Lh12_1","PF\L\h12_1.sqf"],
["PF_h13_1","PF\A3\h13_1.sqf"],
["PF_Lh13_1","PF\L\h13_1.sqf"],
["PF_h14_1","PF\A3\h14_1.sqf"],
["PF_Lh14_1","PF\L\h14_1.sqf"],
["PF_h15_1","PF\A3\h15_1.sqf"],
["PF_Lh15_1","PF\L\h15_1.sqf"],
["PF_h16_1","PF\A3\h16_1.sqf"],
["PF_Lh16_1","PF\L\h16_1.sqf"],
["PF_h17_1","PF\A3\h17_1.sqf"],
["PF_Lh17_1","PF\L\h17_1.sqf"],
["PF_h18_1","PF\A3\h18_1.sqf"],
["PF_h19_1","PF\A3\h19_1.sqf"],
["PF_h20_1","PF\A3\h20_1.sqf"],
["PF_h1_2","PF\A3\h1_2.sqf"],
["PF_Lh1_2","PF\L\h1_2.sqf"],
["PF_m1a_2","PF\A3\m1a_2.sqf"],
["PF_m1b_2","PF\A3\m1b_2.sqf"],
["PF_h2a_2","PF\A3\h2a_2.sqf"],
["PF_h2b_2","PF\A3\h2b_2.sqf"],
["PF_h3_2","PF\A3\h3_2.sqf"],
["PF_Lh3_2","PF\L\h3_2.sqf"],
["PF_h4_2","PF\A3\h4_2.sqf"],
["PF_h5_2","PF\A3\h5_2.sqf"],
["PF_h1_4","PF\A3\h1_4.sqf"]];

//Delete all furniture and nil the variable upon building destruction
addMissionEventHandler["buildingChanged",{
params["_b","_r"];
if(count(_r buildingPos -1)<2)exitWith{};
if(!isNil{_b getVariable"PF"})then{
{deleteVehicle _x}forEach(_b getVariable"PF");
_b setVariable["PF",nil];_b setVariable["PF_B",nil]}}];

//Blacklist Areas Code
waitUntil{!isNil"PF_BlacklistObj"};
if(count PF_BlacklistObj>0)then{PFHomes=PFHomes-[PF_BlacklistObj]};
sleep 1;
if(PF_On)then{
private _BLT=(allMissionObjects"EmptyDetector")select{"PFBL"in str _x};
if!(_BLT isEqualTo[])then{
 private _BLH=[];
{_tArea=triggerArea _x;_size=(if((_tArea#0)>(_tArea#1))then{_tArea#0}else{_tArea#1});
_BLH=_BLH+(nearestObjects[_x,PFHomes,_size,true])}forEach _BLT;
if!(_BLH isEqualTo[])then{{_x setVariable["PF",[]]}forEach _BLH}};

[]spawn compileFinal(loadFile"PF\f\find.sqf");[]spawn compileFinal(loadFile"PF\f\clean.sqf")}