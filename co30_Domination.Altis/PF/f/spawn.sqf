private _H=_this select 0;
private _B=_this select 1;

switch(typeOf _B)do{

	//ALTIS / MALDEN / STRATIS
	case"Land_i_House_Small_01_V1_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_V2_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_V3_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_blue_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_pink_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_white_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_whiteblue_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_brown_F":{_H spawn PF_h1_1;};
	case"Land_i_House_Small_01_b_yellow_F":{_H spawn PF_h1_1;};

	case"Land_i_House_Small_02_V1_F":{switch(floor(random 3))do{
		case 0:{_H spawn PF_h2a_1;};
		case 1:{_H spawn PF_h2b_1;};
		case 2:{_H spawn PF_h2c_1;};};
		};
	case"Land_i_House_Small_02_V2_F":{switch(floor(random 3))do{
		case 0:{_H spawn PF_h2a_1;};
		case 1:{_H spawn PF_h2b_1;};
		case 2:{_H spawn PF_h2c_1;};};
		};
	case"Land_i_House_Small_02_V3_F":{switch(floor(random 3))do{
		case 0:{_H spawn PF_h2a_1;};
		case 1:{_H spawn PF_h2b_1;};
		case 2:{_H spawn PF_h2c_1;};};
		};

	case"Land_i_House_Small_03_V1_F":{_H spawn PF_h5_1;};

	case"Land_i_Stone_Shed_V1_F":{_H spawn PF_h6_1;};
	case"Land_i_Stone_Shed_V2_F":{_H spawn PF_h6_1;};
	case"Land_i_Stone_Shed_V3_F":{_H spawn PF_h6_1;};

	case"Land_i_Stone_HouseSmall_V1_F":{_H spawn PF_h7_1;};
	case"Land_i_Stone_HouseSmall_V2_F":{_H spawn PF_h7_1;};
	case"Land_i_Stone_HouseSmall_V3_F":{_H spawn PF_h7_1;};

	case"Land_Shed_08_brown_F":{_H spawn PF_h9_1;};
	case"Land_Shed_08_grey_F":{_H spawn PF_h9_1;};

	case"Land_i_Stone_Shed_01_b_clay_F":{_H spawn PF_h10_1;};
	case"Land_i_Stone_Shed_01_b_raw_F":{_H spawn PF_h10_1;};
	case"Land_i_Stone_Shed_01_b_white_F":{_H spawn PF_h10_1;};
	case"Land_i_Stone_Shed_01_c_clay_F":{_H spawn PF_h10_1;};
	case"Land_i_Stone_Shed_01_c_raw_F":{_H spawn PF_h10_1;};
	case"Land_i_Stone_Shed_01_c_white_F":{_H spawn PF_h10_1;};

	case"Land_Barn_01_brown_F":{_H spawn PF_h11_1;};
	case"Land_Barn_01_grey_F":{_H spawn PF_h11_1;};
	
	case"Land_Slum_House01_F":{_H spawn PF_h14_1;};
	case"Land_Slum_House02_F":{_H spawn PF_h12_1;};
	case"Land_Slum_House03_F":{_H spawn PF_h13_1;};

	case"Land_i_Addon_02_V1_F":{
		switch(floor(random 3))do{
		case 0:{_H spawn PF_h8a_1;};
		case 1:{_H spawn PF_h8b_1;};
		case 2:{_H spawn PF_h8c_1;};};
		};
	
	case"Land_i_Addon_03_V1_F":{_H spawn PF_h15_1};

	case"Land_CarService_F":{_H spawn PF_h3_1;};
	case"Land_FuelStation_02_workshop_F":{_H spawn PF_h3_1;};

	case"Land_i_Garage_V1_F":{_H spawn PF_h4_1;};
	case"Land_i_Garage_V2_F":{_H spawn PF_h4_1;};

	case"Land_i_Stone_HouseBig_V1_F":{_H spawn PF_h5_2;};
	case"Land_i_Stone_HouseBig_V2_F":{_H spawn PF_h5_2;};
	case"Land_i_Stone_HouseBig_V3_F":{_H spawn PF_h5_2;};
	case"Land_i_Stone_House_Big_01_b_clay_F":{_H spawn PF_h5_2;};

	case"Land_i_House_Big_01_V1_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_V2_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_V3_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_blue_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_whiteblue_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_pink_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_pink_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_white_F":{_H spawn PF_h1_2;};
	case"Land_i_House_Big_01_b_brown_F":{_H spawn PF_h1_2;};

	case"Land_i_House_Big_02_V1_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_V2_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_V3_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_blue_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_pink_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_white_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_whiteblue_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_brown_F":{_H spawn PF_h4_2;};
	case"Land_i_House_Big_02_b_yellow_F":{_H spawn PF_h4_2;};

	case"Land_i_Shop_01_V1_F":{
		switch(floor(random 2))do{
		case 0:{_H spawn PF_h2a_2;};
		case 1:{_H spawn PF_h2b_2;};};
		};
	case"Land_i_Shop_01_V2_F":{
		switch(floor(random 2))do{
		case 0:{_H spawn PF_h2a_2;};
		case 1:{_H spawn PF_h2b_2;};};
		};
	case"Land_i_Shop_01_V3_F":{
		switch(floor(random 2))do{
		case 0:{_H spawn PF_h2a_2;};
		case 1:{_H spawn PF_h2b_2;};};
		};

	case"Land_i_Shop_02_V1_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_V2_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_V3_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_blue_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_pink_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_white_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_whiteblue_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_brown_F":{_H spawn PF_h3_2;};
	case"Land_i_Shop_02_b_yellow_F":{_H spawn PF_h3_2;};

	case"Land_Offices_01_V1_F":{_H spawn PF_h1_4;};
	
	//TANOA
	case"Land_House_Big_01_F":{_H spawn PF_Th1_1;};
	case"Land_House_Small_02_F":{_H spawn PF_Th2_1;};
	case"Land_House_Small_03_F":{_H spawn PF_Th3_1;};
	case"Land_Slum_03_F":{_H spawn PF_Th3s_1;};
	case"Land_House_Small_05_F":{_H spawn PF_Th5_1;};
	case"Land_House_Small_06_F":{_H spawn PF_Th6_1;};
	case"Land_Shed_02_F":{_H spawn PF_Th7a_1;};

	default{deleteVehicle _H;};
	};