// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

disableSerialization;

private _selIdx = (_this # 0) # 1;
__TRACE_1("","_selIdx")
if (_selIdx == -1) exitWith {};

if ((_this # 1) == 0) then {
	__TRACE("In Earplugs")
	d_earplugs_userakey = _selIdx;
	d_earplugs_userakey_str = format ["User%1", d_earplugs_userakey + 1];
	d_ak_earplugs = actionKeys d_earplugs_userakey_str;
	profileNamespace setVariable ["dom_earplugs_userakey", d_earplugs_userakey];
} else {
	__TRACE("In 3DMarker")
	d_3dmarker_userakey = _selIdx;
	d_3dmarker_userakey_str = format ["User%1", d_3dmarker_userakey + 1];
	d_ak_3dtoggle = actionKeys d_3dmarker_userakey_str;
	profileNamespace setVariable ["dom_3dmarker_userakey", d_3dmarker_userakey];
};