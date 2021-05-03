// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_vec"];

if (getNumber(configOf _vec>>"attendant") == 0) exitWith {};

_vec setVariable ["ace_medical_isMedicalFacility", true, true];
