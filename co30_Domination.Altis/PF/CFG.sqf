/*	VERSION: 0.7
	AUTHOR: Phronk
*/
// added by Longtime
//#define __DEBUG__
#include "../x_setup.sqf"

PF_On=TRUE;			//TRUE enables furniture, FALSE disables it (Default = TRUE)
//PF_Range=80;			//Activation range on buildings to spawn furniture (Default = 60) // see d_EnablePhronkFurniture
PF_BlacklistObj=[];	//List of building CLASSNAMES to avoid spawning furniture in (Example: ["land_slum_01_f"])