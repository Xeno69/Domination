params["_B","_T"];
PF_B pushBack _B;
switch(_T)do{
//ALTIS / MALDEN / STRATIS
	case"Land_i_House_Small_01_V1_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_V2_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_V3_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_blue_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_pink_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_white_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_whiteblue_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_brown_F":{_B call PF_h1_1};
	case"Land_i_House_Small_01_b_yellow_F":{_B call PF_h1_1};

	case"Land_i_House_Small_02_V1_F":{
	if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 3))do{
		case 0:{[_B,_X]call PF_h2a_1};
		case 1:{[_B,_X]call PF_h2b_1};
		case 2:{[_B,_X]call PF_h2c_1}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_1":{[_B,_X]call PF_h2a_1};
		case"h2b_1":{[_B,_X]call PF_h2b_1};
		case"h2c_1":{[_B,_X]call PF_h2c_1};
		}}};
	case"Land_i_House_Small_02_V2_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 3))do{
		case 0:{[_B,_X]call PF_h2a_1};
		case 1:{[_B,_X]call PF_h2b_1};
		case 2:{[_B,_X]call PF_h2c_1}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_1":{[_B,_X]call PF_h2a_1};
		case"h2b_1":{[_B,_X]call PF_h2b_1};
		case"h2c_1":{[_B,_X]call PF_h2c_1};
		}}};
	case"Land_i_House_Small_02_V3_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 3))do{
		case 0:{[_B,_X]call PF_h2a_1};
		case 1:{[_B,_X]call PF_h2b_1};
		case 2:{[_B,_X]call PF_h2c_1}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_1":{[_B,_X]call PF_h2a_1};
		case"h2b_1":{[_B,_X]call PF_h2b_1};
		case"h2c_1":{[_B,_X]call PF_h2c_1};
		}}};

	case"Land_i_House_Small_03_V1_F":{_B call PF_h5_1};

	case"Land_i_Stone_Shed_V1_F":{_B call PF_h6_1};
	case"Land_i_Stone_Shed_V2_F":{_B call PF_h6_1};
	case"Land_i_Stone_Shed_V3_F":{_B call PF_h6_1};

	case"Land_i_Stone_HouseSmall_V1_F":{_B call PF_h7_1};
	case"Land_i_Stone_HouseSmall_V2_F":{_B call PF_h7_1};
	case"Land_i_Stone_HouseSmall_V3_F":{_B call PF_h7_1};

	case"Land_i_Shed_Ind_F":{_B call PF_h16_1};
	case"Land_i_Shed_Ind_03_F":{_B call PF_h16_1};
	case"Land_i_Shed_Ind_old_F":{_B call PF_h16_1};

	case"Land_Shed_08_brown_F":{_B call PF_h9_1};
	case"Land_Shed_08_grey_F":{_B call PF_h9_1};

	case"Land_i_Stone_Shed_01_b_clay_F":{_B call PF_h10_1};
	case"Land_i_Stone_Shed_01_b_raw_F":{_B call PF_h10_1};
	case"Land_i_Stone_Shed_01_b_white_F":{_B call PF_h10_1};
	case"Land_i_Stone_Shed_01_c_clay_F":{_B call PF_h10_1};
	case"Land_i_Stone_Shed_01_c_raw_F":{_B call PF_h10_1};
	case"Land_i_Stone_Shed_01_c_white_F":{_B call PF_h10_1};

	case"Land_Barn_01_brown_F":{_B call PF_h11_1};
	case"Land_Barn_01_grey_F":{_B call PF_h11_1};

	case"Land_Slum_House01_F":{_B call PF_h14_1};
	case"Land_Slum_House02_F":{_B call PF_h12_1};
	case"Land_Slum_House03_F":{_B call PF_h13_1};

	case"Land_i_Addon_02_V1_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 2))do{
		case 0:{[_B,_X]call PF_h8a_1};
		case 1:{[_B,_X]call PF_h8b_1};
		case 2:{[_B,_X]call PF_h8c_1}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h8a_1":{[_B,_X]call PF_h8a_1};
		case"h8b_1":{[_B,_X]call PF_h8b_1};
		case"h8c_1":{[_B,_X]call PF_h8c_1}};
		}};

	case"Land_i_Addon_03_V1_F":{_B call PF_h15_1};

	case"Land_CarService_F":{_B call PF_h3_1};
	case"Land_FuelStation_02_workshop_F":{_B call PF_h3_1};

	case"Land_FuelStation_01_workshop_F":{_B call PF_h18_1};

	case"Land_FuelStation_01_shop_F":{_B call PF_h19_1};

	case"Land_i_Garage_V1_F":{_B call PF_h4_1};
	case"Land_i_Garage_V2_F":{_B call PF_h4_1};

	case"Land_GuardHouse_01_F":{_B call PF_h17_1};

	case"Land_i_Stone_HouseBig_V1_F":{_B call PF_h5_2};
	case"Land_i_Stone_HouseBig_V2_F":{_B call PF_h5_2};
	case"Land_i_Stone_HouseBig_V3_F":{_B call PF_h5_2};
	case"Land_i_Stone_House_Big_01_b_clay_F":{_B call PF_h5_2};

	case"Land_i_House_Big_01_V1_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_V2_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_V3_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_blue_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_whiteblue_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_pink_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_pink_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_white_F":{_B call PF_h1_2};
	case"Land_i_House_Big_01_b_brown_F":{_B call PF_h1_2};

	case"Land_i_House_Big_02_V1_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_V2_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_V3_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_blue_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_pink_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_white_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_whiteblue_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_brown_F":{_B call PF_h4_2};
	case"Land_i_House_Big_02_b_yellow_F":{_B call PF_h4_2};

	case"Land_i_Shop_01_V1_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 2))do{
		case 0:{[_B,_X]call PF_h2a_2};
		case 1:{[_B,_X]call PF_h2b_2}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_2":{[_B,_X]call PF_h2a_2};
		case"h2b_2":{[_B,_X]call PF_h2b_2}};
		}};
	case"Land_i_Shop_01_V2_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 2))do{
		case 0:{[_B,_X]call PF_h2a_2};
		case 1:{[_B,_X]call PF_h2b_2}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_2":{[_B,_X]call PF_h2a_2};
		case"h2b_2":{[_B,_X]call PF_h2b_2}};
		}};
	case"Land_i_Shop_01_V3_F":{
		if(isNil{_B getVariable"PF_B"})then{
		switch(floor(random 2))do{
		case 0:{[_B,_X]call PF_h2a_2};
		case 1:{[_B,_X]call PF_h2b_2}};
		}else{
		private _hVar=_B getVariable"PF_B";
		switch(_hVar)do{
		case"h2a_2":{[_B,_X]call PF_h2a_2};
		case"h2b_2":{[_B,_X]call PF_h2b_2}};
		}};

	case"Land_i_Shop_02_V1_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_V2_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_V3_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_blue_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_pink_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_white_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_whiteblue_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_brown_F":{_B call PF_h3_2};
	case"Land_i_Shop_02_b_yellow_F":{_B call PF_h3_2};

	case"Land_Offices_01_V1_F":{_B call PF_h1_4};

//LIVONIA
	case"Land_House_1W10_F":{_B call PF_Lh1_1};
	case"Land_House_1W06_F":{_B call PF_Lh2_1};
	case"Land_House_2W04_F":{_B call PF_Lh2_2};
	case"Land_House_1W05_F":{_B call PF_Lh3_1};
	case"Land_Camp_House_01_brown_F":{_B call PF_Lh4_1};
	case"Land_House_1W08_F":{_B call PF_Lh5_1};
	case"Land_House_1W09_F":{_B call PF_Lh6_1};
	case"Land_House_1W01_F":{_B call PF_Lh7_1};
	case"Land_House_1W03_F":{_B call PF_Lh8_1};
	case"Land_House_1W04_F":{_B call PF_Lh9_1};
	case"Land_House_1W11_F":{_B call PF_Lh17_1};
	case"Land_HealthCenter_01_F":{_B call PF_Lh10_1};
	case"Land_VillageStore_01_F":{_B call PF_Lh11_1};
	case"Land_House_2W03_F":{_B call PF_Lh1_2};
	case"Land_Shed_13_F":{_B call PF_Lh12_1};
	case"Land_House_1W02_F":{_B call PF_Lh13_1};
	case"Land_House_2B04_F":{_B call PF_Lh14_1};
	case"Land_Barn_02_F":{_B call PF_Lh15_1};

//TANOA
	case"Land_House_Big_01_F":{_B call PF_Th1_1};
	case"Land_House_Small_02_F":{_B call PF_Th2_1};
	case"Land_House_Small_03_F":{_B call PF_Th3_1};
	case"Land_Slum_01_F":{_B call PF_H20_1};
	case"Land_Slum_03_F":{_B call PF_Th3s_1};
	case"Land_House_Small_05_F":{_B call PF_Th5_1};
	case"Land_House_Small_06_F":{_B call PF_Th6_1};
	case"Land_Shed_02_F":{_B call PF_Th7a_1};
	case"Land_House_Native_01_F":{_B call PF_Th11_1};
	case"Land_House_Native_02_F":{_B call PF_Th10_1};

//MILITARY
	case"Land_Cargo_Patrol_V1_F":{_B call PF_m1a_2};
	case"Land_Cargo_Patrol_V2_F":{_B call PF_m1a_2};
	case"Land_Cargo_Patrol_V3_F":{_B call PF_m1b_2};
	case"Land_Cargo_Patrol_V4_F":{_B call PF_m1a_2};

	default{_B setVariable["PF",nil];_B setVariable["PF_B",nil];PF_B=PF_B-[_B]}}