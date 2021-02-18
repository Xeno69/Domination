// by Longtime
//#define __DEBUG__
#define THIS_FILE "fn_showhud.sqf"
#include "..\x_setup.sqf"

//hud: Boolean - show scripted HUD (same as normal showHUD true/false)
//info: Boolean - show vehicle + soldier info (hides weapon info from the HUD as well)
//radar: Boolean - show vehicle radar
//compass: Boolean - show vehicle compass
//direction: Boolean - show tank direction indicator (not present in vanilla Arma 3)
//menu: Boolean - show commanding menu (hides HC related menus)
//group: Boolean - show group info bar (hides squad leader info bar)
//cursors: Boolean - show HUD weapon cursors (connected with scripted HUD)
//panels: Boolean - show vehicle panels
//kills: Boolean - show "x killed by y" systemChat messages
// TODO in 2.03: showIcon3D: Boolean - (Since Arma 3 v2.03.147265) show icons drawn with drawIcon3D even when the HUD is hidden. System default: false

showChat false;
enableSentences false;
showSubtitles false;
showHUD [true, true, true, true, true, true, false, true, true, false];
