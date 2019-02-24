// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_draw3dprep.sqf"
#include "..\..\x_setup.sqf"

draw3d_ar = [];
draw3d_ar append d_3draw_ar_prep;
draw3d_ar append d_all_p_a_boxes_prep;
if (d_with_ai) then {
	draw3d_ar append d_allai_recruit_objs_prep;
};
draw3d_ar append d_mhq_3ddraw_prep;
draw3d_ar append d_currentcamps_prep;
if (d_showallnearusermarkers) then {
	draw3d_ar append d_usermarkers_prep;
};
