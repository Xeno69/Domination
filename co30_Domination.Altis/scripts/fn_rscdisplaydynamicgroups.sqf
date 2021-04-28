// Do not serialize
disableSerialization;

// Include common defines file
#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"

// Script parameters
params [["_mode", "", [""]], ["_params", [], [[]]]];

switch _mode do {
	case "onLoad": {
		_params params ["_display"];
		
		// Store
		uiNamespace setVariable ["d_dynamicGroups_display", _display];

		// Reset
		uiNamespace setVariable [VAR_SELECTED_MEMBER, nil];
		uiNamespace setVariable [VAR_SELECTED_PLAYER, nil];
		uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, nil];

		// Sections
		private _sectionGroups = _display displayCtrl IDC_DYNAMICGROUPS_SECTIONGROUPS;
		private _sectionManage = _display displayCtrl IDC_DYNAMICGROUPS_SECTIONMANAGE;

		// List boxes
		private _groupsListbox 	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		private _playersListbox	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS;
		private _manageListbox 	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXMANAGE;

		// Buttons
		private _createLeaveKickButton 	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONCREATELEAVEKICK;
		private _promoteDisbandButton 	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONPROMOTEDISBAND;
		private _joinButton 			= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONJOIN;
		private _kickPlayerButton 		= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONKICK;
		private _invitePlayerButton 	= _display displayCtrl 9980;
		private _closeInterfaceButton 	= _display displayCtrl IDC_DYNAMICGROUPS_CLOSEINTERFACE;
		private _tabGroupsButton 		= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONGROUPS;
		private _tabPlayersButton 		= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONPLAYERS;

		// Check boxes
		private _checkboxPrivate 	= _display displayCtrl IDC_DYNAMICGROUPS_CHECKBOXPRIVATE;

		// Misc
		private _iconPicture 		= _display displayCtrl IDC_DYNAMICGROUPS_GROUPICON;
		private _editGroupName 		= _display displayCtrl IDC_DYNAMICGROUPS_EDITGROUPNAME;

		// Add click events to list boxes
		_groupsListbox ctrlAddEventHandler ["treeSelChanged", {['OnGroupsTreeSelChanged', _this] call d_fnc_rscdisplaydynamicgroups}];
		_playersListbox ctrlAddEventHandler ["LBSelChanged", {['OnPlayersLbSelChanged', _this] call d_fnc_rscdisplaydynamicgroups}];
		_manageListbox ctrlAddEventHandler ["LBSelChanged", {["OnManageLbSelChanged", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add double click events to list boxes
		_groupsListbox ctrlAddEventHandler ["TreeDblClick", {['OnTreeDoubleClick', _this] call d_fnc_rscdisplaydynamicgroups}];
		_playersListbox ctrlAddEventHandler ["LBDblClick", {['OnListDoubleClick', _this] call d_fnc_rscdisplaydynamicgroups}];
		_manageListbox ctrlAddEventHandler ["LBDblClick", {["OnListDoubleClick", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add expanded/collapsed events for Tree
		_groupsListbox ctrlAddEventHandler ["TreeExpanded", {['OnGroupExpanded', _this] call d_fnc_rscdisplaydynamicgroups}];
		_groupsListbox ctrlAddEventHandler ["TreeCollapsed", {['OnGroupCollapsed', _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add event handlers to buttons
		_createLeaveKickButton ctrlAddEventHandler ["ButtonClick", {["OnCreateLeaveKickButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];
		_promoteDisbandButton ctrlAddEventHandler ["ButtonClick", {["OnPromoteDisbandButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];
		_joinButton ctrlAddEventHandler ["ButtonClick", {["OnJoinButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];
		_invitePlayerButton ctrlAddEventHandler ["ButtonClick", {["OnInvitePlayerButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];
		_closeInterfaceButton ctrlAddEventHandler ["ButtonClick", {["CloseDisplay"] call d_fnc_rscdisplaydynamicgroups}];
		_tabGroupsButton ctrlAddEventHandler ["ButtonClick", {["OnTabGroupsButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];
		_tabPlayersButton ctrlAddEventHandler ["ButtonClick", {["OnTabPlayersButtonClick", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add event handler to check box, detect when it's state changes
		_checkboxPrivate ctrlAddEventHandler ["CheckedChanged", {["OnPrivateStateChanged", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add event handlers to group picture/icon
		_iconPicture ctrlAddEventHandler ["MouseEnter", {["OnGroupIconMouseEnter", _this] call d_fnc_rscdisplaydynamicgroups}];
		_iconPicture ctrlAddEventHandler ["MouseExit", {["OnGroupIconMouseExit", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Add event handlers for editing the group name
		_editGroupName ctrlAddEventHandler ["KeyDown", {["SetGroupName", _this] call d_fnc_rscdisplaydynamicgroups}];
		_editGroupName ctrlAddEventHandler ["SetFocus", {["OnGroupNameSetFocus", _this] call d_fnc_rscdisplaydynamicgroups}];
		_editGroupName ctrlAddEventHandler ["KillFocus", {["OnGroupNameKillFocus", _this] call d_fnc_rscdisplaydynamicgroups}];

		// Put Players list box right where groups list box is, both are never shown at the same time
		_playersListbox ctrlSetPosition (ctrlPosition _groupsListbox);
		_playersListbox ctrlCommit 0;
		_playersListbox ctrlShow false;

		// Make all sections invisible
		{_x ctrlSetFade 1; _x ctrlShow false; _x ctrlCommit 0} forEach [_sectionManage, _sectionGroups];

		// We always default to showing groups
		uiNamespace setVariable [VAR_SHOW_GROUPS, true];

		// Add key down event for our display
		["AddKeyEvents", [_display]] call d_fnc_dynamicgroups;

		// Hide hud and commanding menu
		showHud false;
		showCommandingMenu "";

		// Reset collapsed groups variable
		uiNamespace setVariable [VAR_COLLAPSED_GROUPS, []];

		// Initial update
		["Update", [true]] call d_fnc_rscdisplaydynamicgroups;
		
		["dom_dg_eh", {call d_fnc_dgefmeh}, 0.4] call d_fnc_eachframeadd;
	};

	case "onUnload": {
		["dom_dg_eh"] call d_fnc_eachframeremove;
		
		if (!isNil {uiNamespace getVariable "BIS_dynamicGroups_update"}) then {
			terminate (uiNamespace getVariable "BIS_dynamicGroups_update");
		};

		uiNamespace setVariable ["d_dynamicGroups_display", nil];
		uiNamespace setVariable [VAR_HAS_FOCUS, nil];
		uiNamespace setVariable [VAR_OLD_GROUPS_LIST, nil];
		uiNamespace setVariable [VAR_OLD_GROUPS_PLAYERS_LIST, nil];
		uiNamespace setVariable [VAR_OLD_PLAYERS_LIST, nil];
		uiNamespace setVariable [VAR_OLD_MEMBERS_LIST, nil];
		uiNamespace setVariable [VAR_SHOW_GROUPS, nil];
		uiNamespace setVariable [VAR_COLLAPSED_GROUPS, nil];
		uiNamespace setVariable [VAR_LAST_PLAYER_GROUP, nil];
		uiNamespace setVariable [VAR_SELECTED_MEMBER, nil];
		uiNamespace setVariable [VAR_SELECTED_PLAYER, nil];
		uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, nil];

		// Show hud and commanding menu
		showHud true;
	};

	case "GetDisplay": {
		uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
	};

	case "CreateDisplay": {
		([] call BIS_fnc_displayMission) createDisplay "d_RscDisplayDynamicGroups";
	};

	case "CloseDisplay": {
		(uiNamespace getVariable ["d_dynamicGroups_display", displayNull]) closeDisplay IDC_CANCEL;
	};

	case "Update": {
		private _initialUpdate = _params param [0, false, [true]];

		// Update groups section
		["UpdateGroupsSection", [_initialUpdate]] call d_fnc_rscdisplaydynamicgroups;

		// Update manage section
		["UpdateManageSection", [_initialUpdate]] call d_fnc_rscdisplaydynamicgroups;

		// Store last known player group
		uiNamespace setVariable [VAR_LAST_PLAYER_GROUP, group player];
	};

	case "UpdateManageSection" : {
		private _initialUpdate = _params param [0, false, [true]];
		private _display = uiNamespace getVariable ["d_dynamicGroups_display", displayNull];

		// Make sure ourt display is valid
		CHECK(isNull _display)

		// Controls
		private _sectionManage 			= _display displayCtrl IDC_DYNAMICGROUPS_SECTIONMANAGE;
		private _buttonPromoteDisband	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONPROMOTEDISBAND;
		private _buttonInvite 			= _display displayCtrl 9980;
		private _buttonCreateLeaveKick	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONCREATELEAVEKICK;
		private _editGroupName 			= _display displayCtrl IDC_DYNAMICGROUPS_EDITGROUPNAME;
		private _textNumberOfPlayers 	= _display displayCtrl IDC_DYNAMICGROUPS_TEXTPLAYERCOUNT;
		private _listBoxMembers			= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXMANAGE;
		private _listBoxGroups 			= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		private _listBoxPlayers			= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS;
		private _checkboxPrivate 		= _display displayCtrl IDC_DYNAMICGROUPS_CHECKBOXPRIVATE;
		private _sidePicture 			= _display displayCtrl IDC_DYNAMICGROUPS_PICTURESIDE;
		private _groupIcon				= _display displayCtrl IDC_DYNAMICGROUPS_GROUPICON;
		private _fillPlayerName			= _display displayCtrl IDC_DYNAMICGROUPS_TEXTPLAYERNAMEFILL;
		private _fillPlayerSide			= _display displayCtrl IDC_DYNAMICGROUPS_TEXTPLAYERSIDEFILL;
		private _fillPlayerScore		= _display displayCtrl IDC_DYNAMICGROUPS_TEXTPLAYERSCOREFILL;

		private _playerGroup 			= group player;
		private _playerIsLeader			= player == leader _playerGroup;
		private _playerGroupRegistered	= ["IsGroupRegistered", [_playerGroup]] call d_fnc_dynamicgroups;

		if (!_playerGroupRegistered) then {
			_sectionManage ctrlShow true;
			_sectionManage ctrlSetFade 0.5;
			_sectionManage ctrlCommit SECTION_FADE_TIME;

			_buttonCreateLeaveKick ctrlEnable true;
			_buttonCreateLeaveKick ctrlSetText (localize "STR_A3_RscDisplayDynamicGroups_Button_Create");
			_buttonCreateLeaveKick ctrlSetTooltip localize "STR_A3_DynamicGroups_Tooltip_CreateOwnGroup";

			_buttonPromoteDisband ctrlEnable false;
			_buttonInvite ctrlEnable false;

			_checkboxPrivate ctrlEnable false;
			_checkboxPrivate cbSetChecked false;

			_listBoxMembers ctrlEnable false;
			lbClear _listBoxMembers;

			_editGroupName ctrlEnable false;
			_editGroupName ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Hint";
			_editGroupName ctrlEnable false;

			_textNumberOfPlayers ctrlSetText "-";

			_fillPlayerName ctrlSetText "-";
			_fillPlayerSide ctrlSetText "-";
			_fillPlayerScore ctrlSetText "-";

			_sidePicture ctrlSetText "#(argb,8,8,3)color(0,0,0,0.5)";

			_groupIcon ctrlSetText "\A3\Ui_f\data\GUI\Cfg\UnitInsignia\bi_ca.paa";
		} else {
			private ["_groupName", "_groupPicture", "_groupInstance", "_groupLeader", "_groupPlayers", "_groupSide", "_groupIsPrivate"];
			_groupName 		= groupId _playerGroup;
			_groupPicture 	= _playerGroup getVariable [VAR_GROUP_INSIGNIA, ""];
			_groupIsPrivate = _playerGroup getVariable [VAR_GROUP_PRIVATE, false];
			_groupLeader 	= leader _playerGroup;
			_groupPlayers 	= units _playerGroup;
			_groupSide 		= side _playerGroup;

			_sectionManage ctrlShow true;
			_sectionManage ctrlSetFade 0;
			_sectionManage ctrlCommit SECTION_FADE_TIME;

			// Update members
			["FillPlayersListbox", [_listBoxMembers, _groupPlayers, true]] call d_fnc_rscdisplaydynamicgroups;
			uiNamespace setVariable [VAR_OLD_MEMBERS, _groupPlayers];
			uiNamespace setVariable [VAR_OLD_GROUP, _playerGroup];

			private ["_selectedMemberIndex", "_selectedMemberUid"];
			_selectedMemberIndex 	= lnbCurSelRow _listBoxMembers;
			_selectedMemberUid		= "";

			if (!isNull _listBoxMembers && {!isNil {_selectedMemberIndex} && {_selectedMemberIndex != -1}}) then {
				_selectedMemberUid = _listBoxMembers lnbData [_selectedMemberIndex, 0];
			};

			_listBoxMembers ctrlEnable true;
			_checkboxPrivate ctrlEnable (_playerIsLeader && {!(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false])});
			_checkboxPrivate cbSetChecked _groupIsPrivate;
			_fillPlayerName ctrlSetText ([player] call BIS_fnc_getName);
			_fillPlayerSide ctrlSetText (["GetSideFormattedString", [_groupSide]] call d_fnc_rscdisplaydynamicgroups);
			_fillPlayerScore ctrlSetText str score player;

			// Update edit box only if player is not leader (cannot edit)
			private _lastPlayerGroup = uiNamespace getVariable [VAR_LAST_PLAYER_GROUP, grpNull];

			if (!_playerIsLeader || {_initialUpdate || {_playerGroup != _lastPlayerGroup || {ctrlText _editGroupName == ["ClampString", [localize "STR_A3_RscDisplayDynamicGroups_Hint"]] call d_fnc_rscdisplaydynamicgroups}}}) then {
				_editGroupName ctrlSetText _groupName;
			};

			// Enable edit box only for leader, because only leader can change group name
			if (_playerIsLeader && {!(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false])}) then {
				_editGroupName ctrlEnable true;
			} else {
				_editGroupName ctrlEnable false;
			};

			// Fill the number of players in the group
			_textNumberOfPlayers ctrlSetText str (count _groupPlayers);

			// Set the side color
			private _sideColor = [_groupSide] call BIS_fnc_sideColor;
			private _sideColorString = switch (_groupSide) do {
				case WEST : 		{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
				case EAST : 		{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
				case RESISTANCE : 	{ format["#(argb,8,8,3)color(%1,%2,%3,0.6)", _sideColor select 0, _sideColor select 1, _sideColor select 2] };
				case default 		{ "#(argb,8,8,3)color(0.9,0.9,0.9,0.6)" };
			};
			_sidePicture ctrlSetText _sideColorString;

			// Set the group icon
			private _insignia = missionNamespace getVariable ["d_dg_fia", ""];
			private _insigniaTexture = if (_insignia != "") then {["GetInsigniaTexture", [_insignia]] call d_fnc_dynamicgroups} else {["GetInsigniaTexture", [_groupPicture]] call d_fnc_dynamicgroups};
			_groupIcon ctrlSetText _insigniaTexture;
		};
	};

	case "UpdateGroupsSection": {
		private _initialUpdate = _params param [0, false, [true]];

		private _display = uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		CHECK(isNull _display)

		// Show groups section
		(_display displayCtrl IDC_DYNAMICGROUPS_SECTIONGROUPS) ctrlShow true;
		_sectionGroups ctrlSetFade 0;
		_sectionGroups ctrlCommit SECTION_FADE_TIME;

		// Disable the join button since groups section was just updated
		(_display displayCtrl IDC_DYNAMICGROUPS_BUTTONJOIN) ctrlEnable false;

		private _friendlyGroups = ["GetAllGroupsOfSide", [side group player]] call d_fnc_dynamicgroups;

		// Go through all players of same side and those which are not in the list are added to an "Unsorted Players" list
		private _pllist = playableUnits + switchableUnits + allDeadMen;
		private _unsortedPlayers = _pllist select {isPlayer _x && {side group _x == side group player && {!(["IsGroupRegistered", [group _x]] call d_fnc_dynamicgroups)}}};

		private _sidePlayers = _pllist select {isPlayer _x && {side group _x == side group player}};

		if (uiNamespace getVariable [VAR_SHOW_GROUPS, true]) then {
			["OnTabGroupsButtonClick"] call d_fnc_rscdisplaydynamicgroups;

			["FillPlayersListbox", [_display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS, _sidePlayers]] call d_fnc_rscdisplaydynamicgroups;
			uiNamespace setVariable [VAR_OLD_PLAYERS, _sidePlayers];

			["FillGroupsListbox", [_friendlyGroups, _unsortedPlayers]] call d_fnc_rscdisplaydynamicgroups;
			uiNamespace setVariable [VAR_OLD_GROUPS, [_friendlyGroups, _unsortedPlayers]];
		} else {
			["OnTabPlayersButtonClick"] call d_fnc_rscdisplaydynamicgroups;

			["FillGroupsListbox", [_friendlyGroups, _unsortedPlayers]] call d_fnc_rscdisplaydynamicgroups;
			uiNamespace setVariable [VAR_OLD_GROUPS, [_friendlyGroups, _unsortedPlayers]];

			["FillPlayersListbox", [_display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS, _sidePlayers]] call d_fnc_rscdisplaydynamicgroups;
			uiNamespace setVariable [VAR_OLD_PLAYERS, _sidePlayers];
		};
	};

	case "FillGroupsListbox" : {
		_params params [["_groupsList", [], [[]]], ["_unsortedPlayers", [], [[]]]];

		// The selected index, this is used to know if we should manually select a list element in case it was selected before this update
		private _selectedIndex 	= [-1, -1];
		private _totalIndex	= -1;

		private _display = uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		CHECK(isNull _display)

		private _listbox = _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		CHECK(isNull _listbox)

		// Clear the tree
		tvClear _listbox;

		// Add them to the list box
		{
			private _index = _forEachIndex;
			_totalIndex = _totalIndex + 1;

			private _groupName 		= groupId _x;
			private _groupPicture 	= _x getVariable [VAR_GROUP_INSIGNIA, ["LoadRandomInsignia"] call d_fnc_dynamicgroups];
			private _groupIsPrivate = _x getVariable [VAR_GROUP_PRIVATE, false];
			private _groupLeader 	= leader _x;
			private _groupPlayers 	= units _x;
			private _wasKickedFrom	= ["WasPlayerKickedFrom", [_x, player]] call d_fnc_dynamicgroups;
			private _hasInvite		= ["HasInvite", [_x, player]] call d_fnc_dynamicgroups;
			private _locked			= (_groupIsPrivate || {_wasKickedFrom}) && {!(player in _groupPlayers)} && {!_hasInvite};
			private _maxUnitCount	= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];
			private _isFull			= count units _x >= _maxUnitCount;
			private _autoName		= if (_maxUnitCount < 99) then {format ["%1  (%2/%3)", _groupName, count units _x, missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99]]} else { _groupName };

			// Selected group?
			if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 0 == _x) then {
				_selectedIndex = [_index, -1];
			};

			private _texture = if (_locked) then {
				"a3\Ui_f\data\GUI\Rsc\RscDisplayDynamicGroups\Lock.paa";
			} else {
				["GetInsigniaTexture", [_groupPicture]] call d_fnc_dynamicgroups;
			};

			private _parent = _listbox tvAdd [[], _autoName];
			_listbox tvSetData [[_parent], _groupName];
			_listbox tvSort [[_parent], true];
			_listbox tvSetPicture [[_parent], _texture];
			if (_locked) then { _listbox tvSetPictureColor [[_parent], COLOR_LOCKED]; } else { _listbox tvSetPictureColor [[_parent], [1,1,1,1]]; };
			_listbox tvSetPictureColorSelected [[_parent], [1,1,1,1]];
			_listbox tvSetPictureColorDisabled [[_parent], [1,1,1,1]];
			if (_x in (uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []])) then { _listbox tvCollapse [_parent]; } else { _listbox tvExpand [_parent]; };

			{
				private _groupPlayerName 	= [_x] call BIS_fnc_getName;
				private _isLeader			= _x == _groupLeader;
				private _sameGroup			= group player == group _x;
				private _groupPlayerIcon	= if (!_isLeader) then { ["GetPlayerIcon", [_x]] call d_fnc_rscdisplaydynamicgroups; } else { ICON_GENERAL; };
				private _isDead				= !alive _x;
				private _isIncapacitated	= alive _x && {_x getVariable ["BIS_revive_incapacitated", false] || {_x getVariable ["xr_pluncon", false] || {_x getVariable ["ace_isunconscious", false]}}};

				private _color = switch (true) do {
					case (_isDead) : 			{ COLOR_DEAD };
					case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
					case (player == _x) : 		{ COLOR_SELF };
					case (_sameGroup) : 		{ COLOR_GROUP };
					default 					{ COLOR_DEFAULT };
				};

				// Selected player?
				if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 1 == _x) then {
					_selectedIndex = [_index, _forEachIndex];
				};

				if (_isDead) then {
					_groupPlayerName = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
					_groupPlayerIcon = ICON_KIA;
				} else {
					if (_isIncapacitated) then {_groupPlayerIcon = ICON_REVIVE};
				};

				private _child = _listbox tvAdd [[_parent], _groupPlayerName];
				_listbox tvSetData [[_parent, _child], getPlayerUid _x];
				_listbox tvSort [[_parent, _child], true];
				_listbox tvSetPicture [[_parent, _child], _groupPlayerIcon];
				_listbox tvSetPictureColor [[_parent, _child], _color];
			} forEach _groupPlayers;
		} forEach _groupsList;

		if (_unsortedPlayers isNotEqualTo []) then {
			// Add unsorted players to the list
			private _parent = _listbox tvAdd [[], UNSORTED_GROUP_ID];
			_listbox tvSetData [[_parent], UNSORTED_GROUP_ID];
			_listbox tvSort [[_parent], true];
			_listbox tvExpand [_parent];

			_totalIndex = _totalIndex + 1;

			// Selected group?
			if (isNull ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 0)) then {
				_selectedIndex = [count _groupsList, -1];
			};

			{
				private _unsortedPlayerName 	= [_x] call BIS_fnc_getName;
				private _unsortedPlayerIcon	= ["GetPlayerIcon", [_x]] call d_fnc_rscdisplaydynamicgroups;
				_isDead			= !alive _x;
				_isIncapacitated	= alive _x && {_x getVariable ["BIS_revive_incapacitated", false] || {_x getVariable ["xr_pluncon", false] || {_x getVariable ["ace_isunconscious", false]}}};

				private _color = switch (true) do {
					case (_isDead) : 		{ COLOR_DEAD };
					case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
					case (player == _x) : 		{ COLOR_SELF };
					default 			{ COLOR_DEFAULT };
				};

				// Selected player?
				if ((uiNamespace getVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]]) select 1 == _x) then {
					_selectedIndex = [_totalIndex, _forEachIndex];
				};

				if (_isDead) then {
					_unsortedPlayerName = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
					_unsortedPlayerIcon = ICON_KIA;
				} else {
					if (_isIncapacitated) then { _unsortedPlayerIcon = ICON_REVIVE; };
				};

				private _child = _listbox tvAdd [[_parent], _unsortedPlayerName];
				_listbox tvSetData [[_parent, _child], getPlayerUid _x];
				_listbox tvSort [[_parent, _child], true];
				_listbox tvSetPicture [[_parent, _child], _unsortedPlayerIcon];
				_listbox tvSetPictureColor [[_parent, _child], _color];

				if (UNSORTED_GROUP_ID in (uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []])) then {
					_listbox tvCollapse [_parent];
				} else {
					_listbox tvExpand [_parent];
				};
			} forEach _unsortedPlayers;
		};

		// If we had a previously selected element, try to re-set it if it still exists
		if (_selectedIndex select 0 != -1) then {
			if (_selectedIndex select 1 != -1) then {
				_listbox tvSetCurSel _selectedIndex;
			} else {
				_listbox tvSetCurSel [_selectedIndex select 0];
			};
		};
	};

	case "FillPlayersListbox" : {
		_params params [["_listbox", controlNull, [controlNull]], ["_playerList", [], [[]]], ["_isManageSection", false, [true]]];

		//private _targetVar	= if (_isManageSection) then { VAR_SELECTED_MEMBER } else { VAR_SELECTED_PLAYER };
		private _targetList	= if (_isManageSection) then { VAR_OLD_MEMBERS_LIST } else { VAR_OLD_PLAYERS_LIST };

		// All elements currently in list
		private _unitElements = [];
		for "_i" from 0 to (((lnbSize _listbox) select 0) - 1) do {_unitElements pushBackUnique (_listbox lnbData [_i, 0]);};

		// The old and new lists
		private _oldPlayersList = uiNamespace getVariable [_targetList, []];
		private _newPlayersList = [];

		// Create abstract data for comparation
		{
			_newPlayersList pushBack [_x, [_x] call BIS_fnc_getName, group _x, groupId group _x, leader group _x == _x, alive _x, alive _x && {_x getVariable ["BIS_revive_incapacitated", false] || {_x getVariable ["xr_pluncon", false] || {_x getVariable ["ace_isunconscious", false]}}}];
		} forEach _playerList;

		// Make sure we need to update
		if !(_newPlayersList isEqualTo _oldPlayersList) then {
			// Store new list
			uiNamespace setVariable [_targetList, _newPlayersList];

			// The selected item index
			private _curSel = -1;

			// Fill listbox
			{
				_unitElements = _unitElements - [getPlayerUid _x];

				private _name 				= [_x] call BIS_fnc_getName;
				private _textureIcon		= ["GetPlayerIcon", [_x]] call d_fnc_rscdisplaydynamicgroups;
				private _textureRank		= "a3\Ui_f\data\GUI\Cfg\Ranks\general_gs.paa";
				private _isGroupLeader		= _x == leader group _x;
				private _texture 			= if (_isGroupLeader && ["IsGroupRegistered", [group _x]] call d_fnc_dynamicgroups) then { _textureRank } else { _textureIcon };
				private _sameGroup			= group player == group _x;
				private _isDead				= !alive _x;
				private _isIncapacitated	= alive _x && {_x getVariable ["BIS_revive_incapacitated", false] || {_x getVariable ["xr_pluncon", false] || {_x getVariable ["ace_isunconscious", false]}}};

				private _color = switch (true) do {
					case (_isDead) : 		{ COLOR_DEAD };
					case (_isIncapacitated) : 	{ COLOR_INCAPACITATED };
					case (player == _x) : 		{ COLOR_SELF };
					case (_sameGroup) : 		{ COLOR_GROUP };
				};

				if (_isDead) then {
					_name = localize "STR_A3_rscdisplaydynamicgroups_deadplayer";
					_texture = ICON_KIA;
				} else {
					if (_isIncapacitated) then { _texture = ICON_REVIVE; };
				};

				private _index = ["LnbGetDataIndex", [_listbox, getPlayerUid _x]] call d_fnc_rscdisplaydynamicgroups;

				if (_index == -1) then {
					_listbox lnbAddRow [""];
					_listbox lnbSetData [[_forEachIndex, 0], getPlayerUid _x];
					_listbox lnbSetPicture [[_forEachIndex, 0], _texture];
					_listbox lnbSetText [[_forEachIndex, 1], _name];
					_listbox lnbSetColor [[_forEachIndex, 1], [1,1,1,1]];
					_listbox lnbSetPictureColor [[_forEachIndex, 0], _color];
					_listbox lnbSetPictureColorSelected [[_forEachIndex, 0], _color];
				} else {
					_listbox lnbSetPicture [[_index, 0], _texture];
					_listbox lnbSetText [[_index, 1], _name];
					_listbox lnbSetColor [[_index, 1], [1,1,1,1]];
					_listbox lnbSetPictureColor [[_index, 0], _color];
					_listbox lnbSetPictureColorSelected [[_index, 0], _color];
				};

				if (player == _x) then { _curSel = _forEachIndex; };
			} forEach _playerList;

			// Set selected item
			_listbox lbSetCurSel _curSel;

			// Delete leftovers
			{["LnbDeleteUnit", [_listbox, _x]] call d_fnc_rscdisplaydynamicgroups} forEach _unitElements;
		};
	};

	case "LnbGetDataIndex": {
		_params params [["_listbox", controlNull, [controlNull]], ["_data", "", [""]]];
		private _index 		= -1;

		if (_data != "") then {
			for "_i" from 0 to (((lnbSize _listbox) select 0) - 1) do {
				if (_listbox lnbData [_i, 0] == _data) then {_index = _i};
			};
		};

		_index;
	};

	case "LnbDeleteUnit": {
		_params params [["_listbox", controlNull, [controlNull]], ["_data", "", [""]]];

		// Make sure data is not empty
		if (!isNull _listbox && {_data != ""}) then {
			for "_i" from 0 to (((lnbSize _listbox) select 0) - 1) do {
				if (_listbox lnbData [_i, 0] == _data) then {_listbox lnbDeleteRow _i};
			};
		};
	};

	case "TreeGetDataIndex": {
		_params params [["_listbox", controlNull, [controlNull]], ["_data", "", [""]]];
		private _index 		= [];

		if (_data != "") then {
			for "_i" from 0 to ((_listbox tvCount []) - 1) do {
				if (_listbox tvData [_i] == _data) then {_index = [_i]};

				for "_a" from 0 to ((_listbox tvCount [_i]) - 1) do {
					if (_listbox tvData [_i, _a] == _data) then {_index = [_i, _a]};
				};
			};
		};

		_index;
	};

	case "TreeUpdateElement": {
		_params params
		[
			["_listbox", controlNull, [controlNull]],
			["_data", "", [""]],
			["_text", "", [""]],
			["_picture", "", [""]],
			["_pictureColor", [1,1,1,1], [[]]]
		];

		// Make sure data is not empty
		if (_data != "") then {
			private _index = ["TreeGetDataIndex", [_listbox, _data]] call d_fnc_rscdisplaydynamicgroups;

			if !(_index isEqualTo []) then {
				_listbox tvSetText [_index, _text];
				_listbox tvSetPicture [_index, _picture];
				_listbox tvSetPictureColor [_index, _pictureColor];
				_listbox tvSort [_index, true];
			};
		};
	};

	case "TreeGetAllElements": {
		private _listbox = _params param [0, controlNull, [controlNull]];
		private _elements = [[], []];

		for "_i" from 0 to ((_listbox tvCount []) - 1) do {
			(_elements select 0) pushBack (_listbox tvData [_i]);

			for "_a" from 0 to ((_listbox tvCount [_i]) - 1) do {
				(_elements select 1) pushBack (_listbox tvData [_i, _a]);
			};
		};

		_elements;
	};

	case "TreeDeleteGroup": {
		private _data = _params param [0, "", [""]];

		// Make sure data is not empty
		if (_data != "") then {
			private _display = uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
			private _listbox = _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;

			if (!isNull _listbox) then {
				for "_i" from 0 to ((_listbox tvCount []) - 1) do {
					if (_listbox tvData [_i] == _data) exitWith {
						_listbox tvDelete [_i];
					};
				};
			};
		};
	};

	case "TreeDeleteUnit": {
		private _data = _params param [0, "", [""]];

		// Make sure data is not empty
		if (_data != "") then {
			private _display = uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
			private _listbox = _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;

			if (!isNull _listbox) then {
				for "_i" from 0 to ((_listbox tvCount []) - 1) do {
					for "_a" from 0 to ((_listbox tvCount [_i]) - 1) do {
						if (_listbox tvData [_i, _a] == _data) exitWith {
							_listbox tvDelete [_i, _a];
						};
					};
				};
			};
		};
	};

	case "OnGroupsTreeSelChanged": {
		private _listbox 	= _params # 0;
		private _index 		= tvCurSel _listbox;

		// Exit if index is invalid
		if (count _index < 1 || {_index select 0 < 0}) exitWith {};

		private _display 		= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _inviteButton 	= _display displayCtrl 9980;
		private _joinButton 	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONJOIN;

		_joinButton ctrlEnable false;
		_inviteButton ctrlEnable false;

		private _data = _listbox tvData _index;

		// If we are dealing with the unsorted group we exit
		if (_data == UNSORTED_GROUP_ID) exitWith {
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, [grpNull, objNull]];
		};

		// The group
		private _group  = ["GetGroupByName", [_data, side group player]] call d_fnc_dynamicgroups;
		private _player = [_data] call BIS_fnc_getUnitByUid;

		// Validate group or player
		if (isNull _group && {isNull _player}) exitWith {};

		// Did the user just clicked a group or a player
		if (!isNull _group) then {
			// A group was selected
			private _groupIsPrivate 	= _group getVariable [VAR_GROUP_PRIVATE, false];
			private _wasKickedFrom		= ["WasPlayerKickedFrom", [_group, player]] call d_fnc_dynamicgroups;
			private _isInGroup			= _group == group player;
			private _hasInvite 			= ["HasInvite", [_group, player]] call d_fnc_dynamicgroups;
			private _isFull				= count units _group >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];

			// Store the newly selected group
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, [_group, objNull]];

			if (_isInGroup || {_isFull} || {!_hasInvite && {_groupIsPrivate || {_wasKickedFrom}}}) then {
				_joinButton ctrlEnable false;
			} else {
				_joinButton ctrlEnable true;
			};
		} else {
			// A player was selected
			private _playerName 	= [_player] call BIS_fnc_getName;
			private _weAreLeader 	= player == leader group player;
			private _hasInvite 	= ["HasInvite", [group player, _player]] call d_fnc_dynamicgroups;
			private _sameGroup	= group player == group _player;
			private _noGroup	= !(["PlayerHasGroup", [player]] call d_fnc_dynamicgroups);

			// Store the newly selected player
			uiNamespace setVariable [VAR_SELECTED_GROUPORPLAYER, [group _player, _player]];

			switch (true) do {
				case (_hasInvite): {
					_inviteButton ctrlSetText localize "STR_A3_rscdisplaydynamicgroups_button_invited";
					_inviteButton ctrlSetTooltip localize "STR_A3_rscdisplaydynamicgroups_tooltip_invited";
					_inviteButton ctrlSetBackgroundColor [0.5, 0.5, 0.5, 1.0];
					_inviteButton ctrlSetTextColor [1.0, 1.0, 1.0, 1.0];
					_inviteButton ctrlEnable false;
					_joinButton ctrlEnable false;
				};

				case (!_weAreLeader || {_sameGroup || {_noGroup || {player == _player}}}): {
					_inviteButton ctrlSetText localize "STR_A3_rscdisplaydynamicgroups_button_invite";
					_inviteButton ctrlSetTooltip "";
					_inviteButton ctrlEnable false;
					_joinButton ctrlEnable false;
				};

				default {
					_inviteButton ctrlSetText localize "STR_A3_rscdisplaydynamicgroups_button_invite";
					_inviteButton ctrlSetTooltip "";
					_inviteButton ctrlEnable true;
					_joinButton ctrlEnable false;
				};
			};
		};
	};

	case "OnPlayersLbSelChanged": {
		_params params ["_listbox", "_index"];

		private _display 	= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _inviteButton 	= _display displayCtrl 9980;
		private _joinButton 	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONJOIN;

		_joinButton ctrlEnable false;
		_inviteButton ctrlEnable false;

		// Make sure we have a group, otherwise there is nothing for us to do here
		if !(["PlayerHasGroup", [player]] call d_fnc_dynamicgroups) exitWith {};

		// The clicked player
		private _clickedUid = _listbox lnbData [_index, 0];

		// The player to which the uid belongs to
		private _clickedPlayer 	= [_clickedUid] call BIS_fnc_getUnitByUid;
		private _hasInvite 	= ["HasInvite", [group player, _clickedPlayer]] call d_fnc_dynamicgroups;
		private _inSameGroup 	= group player == group _clickedPlayer;
		private _weAreLeader 	= player == leader group player;

		// Store the newly selected player
		uiNamespace setVariable [VAR_SELECTED_PLAYER, _clickedPlayer];

		if (!_hasInvite && {!_inSameGroup && {_weAreLeader && {getPlayerUid player != _clickedUid}}}) then {
			_inviteButton ctrlEnable true;
		};
	};

	case "OnManageLbSelChanged": {
		_params params ["_listbox", "_index"];

		// The clicked player uid
		private _clickedUid = _listbox lnbData [_index, 0];

		// The player to which the uid belongs to
		private _clickedPlayer 			= [_clickedUid] call BIS_fnc_getUnitByUid;
		private _currentPlayerIsLeader 	= player == leader group player;

		// Store the newly selected member
		uiNamespace setVariable [VAR_SELECTED_MEMBER, _clickedPlayer];

		private _display 				= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _buttonCreateLeaveKick 	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONCREATELEAVEKICK;
		private _buttonPromoteDisband	= _display displayCtrl IDC_DYNAMICGROUPS_BUTTONPROMOTEDISBAND;

		_buttonCreateLeaveKick ctrlEnable false;
		_buttonPromoteDisband ctrlEnable false;

		// Did we click ourselves?
		if (_clickedPlayer == player) then {
			if (count units group player < 2) then {
				_buttonCreateLeaveKick ctrlEnable !(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false]);
				_buttonCreateLeaveKick ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Leave";
				_buttonCreateLeaveKick ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_LeaveGroup";

				_buttonPromoteDisband ctrlEnable false;
				_buttonPromoteDisband ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Disband";
				_buttonPromoteDisband ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_KickAll";
			} else {
				_buttonCreateLeaveKick ctrlEnable !(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false]);
				_buttonCreateLeaveKick ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Leave";
				_buttonCreateLeaveKick ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_LeaveGroup";

				if (_currentPlayerIsLeader) then {
					_buttonPromoteDisband ctrlEnable !(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false]);
					_buttonPromoteDisband ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Disband";
					_buttonPromoteDisband ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_KickAll";
				};
			};
		} else {
			if (_currentPlayerIsLeader) then {
				_buttonCreateLeaveKick ctrlEnable !(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false]);
				_buttonCreateLeaveKick ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_KickBan";
				_buttonCreateLeaveKick ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_KickPlayer";

				_buttonPromoteDisband ctrlEnable true;
				_buttonPromoteDisband ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Promote";
				_buttonPromoteDisband ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_PromotePlayer";
			} else {
				_buttonCreateLeaveKick ctrlEnable !(missionNamespace getVariable [VAR_MINIMAL_INTERACTION, false]);
				_buttonCreateLeaveKick ctrlSetText localize "STR_A3_RscDisplayDynamicGroups_Button_Leave";
				_buttonCreateLeaveKick ctrlSetTooltip localize "STR_A3_RscDisplayDynamicGroups_Tooltip_LeaveGroup";
			};
		};
	};

	case "OnCreateLeaveKickButtonClick": {
		_params params ["_button"];

		_button ctrlEnable false;
		["SetDefaultFocus"] call d_fnc_rscdisplaydynamicgroups;

		private _display 	= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _listbox 	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXMANAGE;
		private _listBoxIndex	= lnbCurSelRow _listbox;
		private _selectedUid	= _listbox lnbData [_listBoxIndex, 0];

		private _hasGroup 	= ["PlayerHasGroup", [player]] call d_fnc_dynamicgroups;
		private _isLeader 	= _hasGroup && {player == leader group player};
		private _isSelfSelected	= _selectedUid == getPlayeruid player;

		switch (true) do {
			case (_hasGroup && {_isLeader && {_isSelfSelected}}): 	{["OnLeaveGroupButtonClick"] call d_fnc_rscdisplaydynamicgroups};
			case (_hasGroup && {_isLeader && {!_isSelfSelected}}): {["OnKickPlayerButtonClick", [_selectedUid]] call d_fnc_rscdisplaydynamicgroups};
			case (_hasGroup && {!_isLeader}):			{["OnLeaveGroupButtonClick"] call d_fnc_rscdisplaydynamicgroups};
			case default 						{["OnCreateGroupButtonClick"] call d_fnc_rscdisplaydynamicgroups};
		};
	};

	case "OnCreateGroupButtonClick": {
		// Request group for player
		if (player == leader group player) then {
			["SendClientMessage", ["RegisterGroup", [group player, player]]] call d_fnc_dynamicgroups;
		} else {
			["SendClientMessage", ["CreateGroupAndRegister", [player]]] call d_fnc_dynamicgroups;
		};
	};

	case "OnLeaveGroupButtonClick": {
		// Request server to make player leave the current group
		["SendClientMessage", ["RemoveGroupMember", [group player, player]]] call d_fnc_dynamicgroups;

		// Event
		["OnGroupLeave", [group player, leader group player, player]] call d_fnc_dynamicgroups;
	};

	case "OnKickPlayerButtonClick": {
		_params params [["_uid", "", [""]]];

		private _group 		= group player;
		private _groupLeader	= leader _group;
		private _kickedPlayer	= [_uid] call BIS_fnc_getUnitByUid;

		if (!isNull _group && {!isNull _groupLeader && {!isNull _kickedPlayer && {_groupLeader == player}}}) then {
			// Request server to make player leave the current group
			["SendClientMessage", ["KickPlayer", [_group, _groupLeader, _kickedPlayer]]] call d_fnc_dynamicgroups;

			// Event
			["OnKicked", [_group, _kickedPlayer, _groupLeader]] call d_fnc_dynamicgroups;
		};
	};

	case "OnPromoteDisbandButtonClick": {
		_params params ["_button"];

		_button ctrlEnable false;
		["SetDefaultFocus"] call d_fnc_rscdisplaydynamicgroups;

		private _hasGroup 		= ["PlayerHasGroup", [player]] call d_fnc_dynamicgroups;
		private _hasEnoughPlayers	= count units group player > 1;

		// Make sure player has a group, group has at least another player and that player is actually leader
		if (!_hasGroup && {!_hasEnoughPlayers} && {player == leader group player}) exitWith {};

		private _display 	= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _listbox 	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXMANAGE;
		private _listBoxIndex	= lnbCurSelRow _listbox;
		private _selectedUid	= _listbox lnbData [_listBoxIndex, 0];

		private _isSelfSelected	= _selectedUid == getPlayerUid player;

		// If we have ourselves selected in the listbox, we Disband group, otherwise we will Promote to leader
		if (_isSelfSelected) then {
			["OnDisbandGroupButtonClick"] call d_fnc_rscdisplaydynamicgroups;
		} else {
			["OnPromotePlayerButtonClick", [_selectedUid]] call d_fnc_rscdisplaydynamicgroups;
		};
	};

	case "OnDisbandGroupButtonClick": {
		private _group	 	= group player;
		private _groupPlayers	= units _group;
		private _groupLeader	= leader _group;

		{
			["OnGroupDisbanded", [_group, _x, _groupLeader]] call d_fnc_dynamicgroups;
		} forEach _groupPlayers - [_groupLeader];

		{
			[_x] joinSilent grpNull;
		} forEach _groupPlayers;

		// Request server to make player leave the current group
		["SendClientMessage", ["UnregisterGroup", [_group]]] call d_fnc_dynamicgroups;
	};

	case "OnPromotePlayerButtonClick": {
		_params params [["_uid", "", [""]]];

		private _group 			= group player;
		private _groupLeader		= leader _group;
		private _newLeader		= [_uid] call BIS_fnc_getUnitByUid;
		
		if (!isPlayer _newLeader) exitWith {};

		// Request server to switch leader
		["SendClientMessage", ["SwitchLeader", [_group, _newLeader]]] call d_fnc_dynamicgroups;

		// Event
		["OnPromotedToLeader", [_group, _newLeader, _groupLeader]] call d_fnc_dynamicgroups;
	};

	case "OnJoinButtonClick": {
		_params params ["_button"];

		_button ctrlEnable false;
		["SetDefaultFocus"] call d_fnc_rscdisplaydynamicgroups;

		private _display 	= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _listboxGroups 	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		private _index 		= tvCurSel _listboxGroups;
		private _groupUniqueId 	= _listboxGroups tvData _index;

		private _group = ["GetGroupByName", [_groupUniqueId, side group player]] call d_fnc_dynamicgroups;

		if (!isNull _group) then {
			private _groupLeader		= leader _group;
			private _groupIsPrivate 	= _group getVariable [VAR_GROUP_PRIVATE, false];
			private _hasInvite		= ["HasInvite", [_group, player]] call d_fnc_dynamicgroups;
			private _isFull			= count units _group >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];

			if ((!_groupIsPrivate || {_hasInvite}) && {!_isFull}) then {
				if !(["PlayerHasGroup", [player]] call d_fnc_dynamicgroups) then {
					["SendClientMessage", ["AddGroupMember", [_group, player]]] call d_fnc_dynamicgroups;
				} else {
					["SendClientMessage", ["SwitchGroup", [_group, player]]] call d_fnc_dynamicgroups;
				};

				if (_hasInvite) then {
					["RemoveInvite", [_group, player]] call d_fnc_dynamicgroups;
				};

				// Event
				["OnGroupJoin", [_group, _groupLeader, player]] call d_fnc_dynamicgroups;
			};
		};
	};

	case "OnInvitePlayerButtonClick": {
		_params params ["_button"];

		_button ctrlEnable false;
		["SetDefaultFocus"] call d_fnc_rscdisplaydynamicgroups;

		private _display 	= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _isTree		= uiNamespace getVariable [VAR_SHOW_GROUPS, true];
		private _listbox 	= if (_isTree) then { _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS; } else { _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS; };
		private _listboxIndex	= if (_isTree) then { tvCurSel _listbox; } else { lnbCurSelRow _listbox; };

		// Validate selected player in list box
		if (_listboxIndex isEqualTo []) exitWith {};

		// The local player group
		private _group = group player;

		// The clicked player uid
		private _clickedUid = if (_isTree) then { _listbox tvData _listboxIndex; } else { _listbox lnbData [_listboxIndex, 0]; };
		private _clickedPlayer = [_clickedUid] call BIS_fnc_getUnitByUid;

		// Validate player object
		if (isNull _clickedPlayer) exitWith {
			["OnInvitePlayerButtonClick: Player with uid (%1) not found", _clickedUid] call BIS_fnc_error;
		};

		// Add invite
		if !(["HasInvite", [_group, _clickedPlayer]] call d_fnc_dynamicgroups) then {
			["AddInvite", [_group, player, _clickedPlayer]] call d_fnc_dynamicgroups;
		};
	};

	case "OnTabGroupsButtonClick": {
		private _display 		= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _listGroups		= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		private _listPlayers	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS;
		private _buttonGroups	= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONGROUPS;
		private _buttonPlayers	= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONPLAYERS;

		_listGroups ctrlShow true;
		_buttonGroups ctrlSetTextColor [1,1,1,1];
		_buttonGroups ctrlSetBackgroundColor [1,1,1,0.6];
		_buttonGroups ctrlSetActiveColor [1,1,1,0.6];

		_listPlayers ctrlShow false;
		_buttonPlayers ctrlSetTextColor [1,1,1,0.4];
		_buttonPlayers ctrlSetBackgroundColor [0,0,0,0.6];
		_buttonPlayers ctrlSetActiveColor [0,0,0,0.6];

		uiNamespace setVariable [VAR_SHOW_GROUPS, true];
	};

	case "OnTabPlayersButtonClick": {
		private _display 		= uiNamespace getVariable ["d_dynamicGroups_display", displayNull];
		private _listGroups		= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXGROUPS;
		private _listPlayers	= _display displayCtrl IDC_DYNAMICGROUPS_LISTBOXPLAYERS;
		private _buttonGroups	= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONGROUPS;
		private _buttonPlayers	= _display displayCtrl IDC_DYNAMICGROUPS_TABBUTTONPLAYERS;

		_listPlayers ctrlShow true;
		_buttonPlayers ctrlSetTextColor [1,1,1,1];
		_buttonPlayers ctrlSetBackgroundColor [1,1,1,0.6];
		_buttonPlayers ctrlSetActiveColor [1,1,1,0.6];

		_listGroups ctrlShow false;
		_buttonGroups ctrlSetTextColor [1,1,1,0.4];
		_buttonGroups ctrlSetBackgroundColor [0,0,0,0.6];
		_buttonGroups ctrlSetActiveColor [0,0,0,0.6];

		uiNamespace setVariable [VAR_SHOW_GROUPS, false];
	};

	case "OnGroupIconMouseEnter": {};

	case "OnGroupIconMouseExit": {};

	case "OnPrivateStateChanged": {
		private _checkboxPrivate 	= _params # 0;
		private _isChecked 			= (_params # 1) == 1;

		["SendClientMessage", ["SetPrivateState", [group player, _isChecked]]] call d_fnc_dynamicgroups;
	};

	case "OnTreeDoubleClick": {
		_params params ["_tree"];

		private _index = tvCurSel _tree;

		if (count _index > 1) then {
			private _clickedUid = _tree tvData _index;

			// The player to which the uid belongs to
			private _clickedPlayer = [_clickedUid] call BIS_fnc_getUnitByUid;

			// Player was clicked
			if (player != _clickedPlayer) then {
				["OnPlayerDoubleClick", [_clickedPlayer]] call d_fnc_rscdisplaydynamicgroups;
			};
		} else {
			private _clickedId 		= _tree tvData _index;
			private _clickedGroup	= ["GetGroupByName", [_clickedId, side group player]] call d_fnc_dynamicgroups;

			// Group was clicked
			if (!isNull _clickedGroup) then {
				["OnGroupDoubleClick", [_clickedGroup]] call d_fnc_rscdisplaydynamicgroups;
			};
		};
	};

	case "OnListDoubleClick": {
		_params params ["_listbox", "_index"];

		// The clicked player uid
		private _clickedUid = _listbox lnbData [_index, 0];

		// The player to which the uid belongs to
		private _clickedPlayer = [_clickedUid] call BIS_fnc_getUnitByUid;

		// Player was clicked
		if (player != _clickedPlayer) then {
			["OnPlayerDoubleClick", [_clickedPlayer]] call d_fnc_rscdisplaydynamicgroups;
		};
	};

	case "OnGroupDoubleClick": {
		_params params ["_group"];

		private _groupPrivate 	= _group getVariable [VAR_GROUP_PRIVATE, false];
		private _wasKickedFrom	= ["WasPlayerKickedFrom", [_group, player]] call d_fnc_dynamicgroups;
		private _hasInvite	= ["HasInvite", [_group, player]] call d_fnc_dynamicgroups;
		private _isFull		= count units _group >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];

		// Make sure that group is not private and player is not kicked from it, or player as invite
		if (!_isFull && {_hasInvite || {!_groupPrivate && {!_wasKickedFrom}}}) then {
			if (["PlayerHasGroup", [player]] call d_fnc_dynamicgroups) then {
				["SendClientMessage", ["AddGroupMember", [_group, player]]] call d_fnc_dynamicgroups;
			} else {
				["SendClientMessage", ["SwitchGroup", [_group, player]]] call d_fnc_dynamicgroups;
			};

			if (_hasInvite) then {
				["RemoveInvite", [_group, player]] call d_fnc_dynamicgroups;
			};
		};
	};

	case "OnPlayerDoubleClick": {
		private _clickedPlayer = _params # 0;

		// Did we clicked ourselves
		if (_clickedPlayer != player) then {
			private _selfInGroup 	= ["PlayerHasGroup", [player]] call d_fnc_dynamicgroups;
			private _otherInGroup	= ["PlayerHasGroup", [_clickedPlayer]] call d_fnc_dynamicgroups;
			private _hasInvite		= ["HasInvite", [group player, _clickedPlayer]] call d_fnc_dynamicgroups;
			private _wasKicked		= ["WasPlayerKickedFrom", [group _clickedPlayer, player]] call d_fnc_dynamicgroups;
			private _groupIsLocked	= (group _clickedPlayer) getVariable [VAR_GROUP_PRIVATE, false];
			private _isFull			= count units (group _clickedPlayer) >= missionNamespace getVariable [VAR_MAX_UNITS_PER_GROUP, 99];

			switch (true) do {
				// Invite player
				case (_selfInGroup && {!_hasInvite && {group player != group _clickedPlayer}}): {
					["AddInvite", [group player, player, _clickedPlayer]] call d_fnc_dynamicgroups;
				};

				// Join other player's group
				case (!_selfInGroup && {_otherInGroup && {!_wasKicked && {!_groupIsLocked && {!_isFull}}}}): {
					["SendClientMessage", ["AddGroupMember", [group _clickedPlayer, player]]] call d_fnc_dynamicgroups;

					if (_hasInvite) then {
						["RemoveInvite", [group _clickedPlayer, player]] call d_fnc_dynamicgroups;
					};
				};
			};
		};
	};

	case "SetGroupName": {
		_params params [["_editGroupName", controlNull, [controlNull]], ["_key", -1, [0]]];

		if (_key == 28 || {_key == 156 || {_key == -1}}) then {
			// Lose focus
			ctrlSetFocus ((uiNamespace getVariable ["d_dynamicGroups_display", displayNull]) displayCtrl IDC_DYNAMICGROUPS_LISTBOXMANAGE);
		};
	};

	case "OnGroupNameChanged": {
		private _editGroupName = _params param [0, controlNull, [controlNull]];

		// New and old group name
		private _oldGroupName = groupid (group player);
		private _groupName = ctrlText _editGroupName;

		// Make sure names are different
		if (_oldGroupName == _groupName) exitWith {};

		private _wasUpdated 	= false;
		private _groupNameSize	= count (toArray _groupName);

		private _clampedGroupName 		= ["ClampString", [_groupName]] call d_fnc_rscdisplaydynamicgroups;
		private _groupNameWasClamped	= _groupNameSize > count (toArray _clampedGroupName);

		private _nameTaken = (["GetAllGroupsOfSide", [side group player]] call d_fnc_dynamicgroups) findIf {groupId _x isEqualTo _clampedGroupName} > -1;

		if (_clampedGroupName isEqualType "" && {_clampedGroupName != _oldGroupName && {_clampedGroupName != "" && {!_nameTaken}}}) then {
			(group player) setGroupId [_clampedGroupName];
			["SendClientMessage", ["SetName", [group player, _clampedGroupName]]] call d_fnc_dynamicgroups;
			playsound "ReadoutHideClick1";
			_wasUpdated = true;
		};

		// Animate
		private _backgroundGroupName = (uiNamespace getVariable ["d_dynamicGroups_display", displayNull]) displayCtrl IDC_DYNAMICGROUPS_BACKGROUNDGROUPNAME;
		private _color = switch (true) do {
			case (_wasUpdated && {!_groupNameWasClamped}): 	{[RESISTANCE] call BIS_fnc_sideColor};
			case (_wasUpdated && {_groupNameWasClamped}):  	{[CIVILIAN] call BIS_fnc_sideColor};
			case default {[EAST] call BIS_fnc_sideColor};
		};
		_backgroundGroupName ctrlSetBackgroundColor _color;
		_editGroupName ctrlSetTextColor [1,1,1,1];

		[_backgroundGroupName, _editGroupName, if (_wasUpdated) then { _clampedGroupName } else { _oldGroupName }] spawn {
			scriptName "RscDisplayDynamicGroups RscEdit animation";

			disableSerialization;

			sleep 0.3;
			(_this # 0) ctrlSetBackgroundColor [0, 0, 0, 1];
			(_this # 1) ctrlEnable true;
			(_this # 1) ctrlSetText (_this select 2);
			(_this # 1) ctrlSetTextColor [1, 1, 1, 1];
		};
	};

	case "OnGroupExpanded": {
		_params params ["_tree", "_index"];

		private _data 				= _tree tvData _index;
		private _collapsedGroups 	= uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []];
		private _group				= ["GetGroupByName", [_data, side group player]] call d_fnc_dynamicgroups;

		if (!isNull _group && {_group in _collapsedGroups}) then {
			_collapsedGroups deleteAt (_collapsedGroups find _group);
			uiNamespace setVariable [VAR_COLLAPSED_GROUPS, _collapsedGroups];
		};
	};

	case "OnGroupCollapsed": {
		_params params ["_tree", "_index"];

		private _data 				= _tree tvData _index;
		private _collapsedGroups 	= uiNamespace getVariable [VAR_COLLAPSED_GROUPS, []];
		private _group				= ["GetGroupByName", [_data, side group player]] call d_fnc_dynamicgroups;

		if (!isNull _group && {!(_group in _collapsedGroups)}) then {
			_collapsedGroups pushBack _group;
			uiNamespace setVariable [VAR_COLLAPSED_GROUPS, _collapsedGroups];
		};
	};

	case "SetDefaultFocus" : {
		ctrlSetFocus ((uiNamespace getVariable ["d_dynamicGroups_display", displayNull]) displayCtrl IDC_CANCEL);
	};

	case "OnGroupNameSetFocus" : {
		// Flag
		uiNamespace setVariable [VAR_HAS_FOCUS, true];
	};

	case "OnGroupNameKillFocus" : {
		_params params ["_editGroupName"];
		// Flag
		uiNamespace setVariable [VAR_HAS_FOCUS, nil];

		// Apply group name change
		["OnGroupNameChanged", [_editGroupName]] call d_fnc_rscdisplaydynamicgroups;
	};

	case "GetFactionPicture": {
		private _leader = _params param [0, objNull, [objNull]];

		private _picture = getText (configFile >> "CfgFactionClasses" >> faction _leader >> "flag");

		if (_picture != "") then {
			_picture;
		} else {
			["GetSideColor", [side group _leader]] call d_fnc_rscdisplaydynamicgroups;
		};
	};

	case "GetSideColor" : {
		private _side = _params param [0, SIDEUNKNOWN, [SIDEUNKNOWN]];

		private _color = switch (_side) do {
			case WEST: 		{"#(argb,8,8,3)color(0,0,1,0.6)" };
			case EAST: 		{"#(argb,8,8,3)color(1,0,0,0.6)" };
			case RESISTANCE: 	{"#(argb,8,8,3)color(0,1,0,0.6)" };
			case CIVILIAN: 	{"#(argb,8,8,3)color(0.5,0.5,0.5,0.6)" };
			case default {"#(argb,8,8,3)color(0,0,0,0.6)" };
		};

		_color;
	};

	case "GetPlayerIcon": {
		private _player = _params param [0, objNull, [objNull, ""]];

		if (_player isEqualType "") then {
			_player = [_player] call BIS_fnc_getUnitByUid;
		};

		if (isNull _player) exitWith {""};

		private _icon 		= getText (configfile >> "CfgVehicles" >> typeOf _player >> "icon");
		private _texture	= if (_icon != "") then {getText (configfile >> "CfgVehicleIcons" >> _icon)} else {""};

		_texture;
	};

	case "GetSideFormattedString": {
		private _side = _params param [0, sideUnknown, [sideUnknown]];

		private _string = switch (_side) do {
			case WEST : 		{ localize "STR_A3_texturesources_blu0" };
			case EAST : 		{ localize "STR_A3_truck_02_transport_base_f_texturesources_opfor0" };
			case RESISTANCE : 	{ localize "STR_A3_cfggroups_indep0" };
			case default 		{ localize "STR_A3_cfgvehicles_c_man_10" };
		};

		_string;
	};

	case "ClampString": {
		_params params [["_inString", "", [""]], ["_maxSize", MAX_GROUP_NAME_SIZE, [0]]];

		private _outString = "";
		private _groupNameArray = toArray _inString;

		if (count _groupNameArray > _maxSize) then {
			_groupNameArray resize _maxSize;
			_outString = toString _groupNameArray;
		} else {
			_outString = _inString;
		};

		_outString;
	};

	case default {
	};
};