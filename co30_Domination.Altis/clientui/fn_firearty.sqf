// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!d_tt_ver) then {
	if !(d_ari_available) exitWith {[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_149")};
} else {
	if (d_player_side == blufor && {!d_ari_available_w} || {d_player_side == opfor && {!d_ari_available_e}}) exitWith {
		[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_149");
	};
};

disableSerialization;

private _lbctrl = (uiNamespace getVariable "d_ArtilleryDialog2") displayCtrl 1000;
private _idx = lbCurSel _lbctrl;
if (_idx == -1) exitWith {};

private _arele = d_cur_art_marker_ar select (_lbctrl lbValue _idx);
private _curmar_pos = markerPos (_arele # 0);
__TRACE_2("","_arele","_curmar_pos")

private _no = [];

if (d_artycheckfriendlies == 1) then {
	private _ammoconf = configFile>>"CfgAmmo">>getText(configFile>>"CfgMagazines">>(_arele # 2)>>"ammo");

	if (getText(_ammoconf>>"effectFlare") != "CounterMeasureFlare" && {getText(_ammoconf>>"submunitionAmmo") != "SmokeShellArty"}) then {
		private _man_types = [];
		{
			_man_types pushBack (switch (_x) do {
				case "WEST": {"SoldierWB"};
				case "EAST": {"SoldierEB"};
				case "GUER": {"SoldierGB"};
				default {"SoldierWB"};
			});
		} forEach d_own_sides;
		_no = _curmar_pos nearEntities [_man_types, 20];
	};
};

if (_no isNotEqualTo []) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_151");
};

if ((d_with_ranked || {d_database_found}) && {d_ranked_a # 2 > 0}) then {[player, 1] remoteExecCall ["d_fnc_ascfc", 2]};
if (!d_tt_ver) then {
	player kbTell [d_kb_logic1, d_kb_topic_side_arti, "ArtilleryRequest", ["1", "", getText(configFile>>"CfgMagazines">>(_arele # 2)>>"displayname"), []], ["2", "", str (_arele # 3), []], ["3", "", mapGridPosition _curmar_pos, []], d_kbtel_chan];
} else {
	private _topicside = switch (d_player_side) do {
			case blufor: {"HQ_ART_W"};
			case opfor: {"HQ_ART_E"};
		};
	private _logic = switch (d_player_side) do {
		case blufor: {d_hq_logic_blufor1};
		case opfor: {d_hq_logic_opfor1};
	};
	player kbTell [_logic, _topicside, "ArtilleryRequest", ["1", "", getText(configFile>>"CfgMagazines">>(_arele # 2)>>"displayname"), []], ["2", "", str (_arele # 3), []], ["3", "", mapGridPosition _curmar_pos, []], "SIDE"];
};
__TRACE_1("","_arele")
[_arele # 2, _arele # 3, netId player, _arele # 0] remoteExec ["d_fnc_arifire", 2];
d_arti_did_fire = true;
