// by Xeno
#define THIS_FILE "fn_ropekeyb.sqf"
#include "..\x_setup.sqf"

((_this select 1) in actionKeys "HeliRopeAction" || {(_this select 1) in actionKeys "HeliSlingLoadManager" || {inputAction "HeliRopeAction" > 0 || {inputAction "HeliSlingLoadManager" > 0}}})