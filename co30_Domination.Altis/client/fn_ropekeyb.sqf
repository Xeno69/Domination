// by Xeno
#include "..\x_setup.sqf"

((_this # 1) in d_ak_hra || {(_this # 1) in d_ak_hslm || {inputAction "HeliRopeAction" > 0 || {inputAction "HeliSlingLoadManager" > 0}}})