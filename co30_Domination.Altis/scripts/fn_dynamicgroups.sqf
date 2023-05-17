// Include common defines file

params [["_mode", "", [""]], ["_params", [], [[]]]];

switch (_mode) do {
	/**
	 * Initializes the dynamic groups system
	 * Runs only on the server
	 *
	 * @param Whether or not to register all groups led by a player at mission start
	 */
	case "Initialize": {
		if (!isServer) exitWith {};

		private _registerInitialPlayerGroups = _params param [0, false, [true]];
		private _maxUnitsPerGroup = _params param [1, 99, [0]];
		private _minimalInteraction = _params param [2, false, [true]];
		private _forcedInsignia = _params param [3, "", [""]];

		// Block multiple execution
		if (["IsInitialized"] call d_fnc_dynamicgroups) exitWith {};

		// Handle requests from clients
		"BIS_dynamicGroups_clientMessage" addPublicVariableEventHandler [missionnamespace, {
			["OnClientMessage", _this] call d_fnc_dynamicgroups;
		}];

		// Initialized flag
		missionNamespace setVariable ["BIS_dg_ini", true, true];

		// Group unit count limit
		if (_maxUnitsPerGroup < 99) then {
			missionNamespace setVariable ["BIS_dg_mupg", _maxUnitsPerGroup, true];
		};

		// Initialize initial player groups
		if (_registerInitialPlayerGroups) then {
			["RegisterInitialPlayerGroups", []] call d_fnc_dynamicgroups;
		};

		// Minimal interaction, only allows group leader to promote another team member to leader
		// No other actions are allowed
		if (_minimalInteraction) then {
			missionNamespace setVariable ["BIS_dg_mii", _minimalInteraction, true];
		};

		// The forced insignia if any
		if (_forcedInsignia isNotEqualTo "") then {
			missionNamespace setVariable ["BIS_dg_fia", _forcedInsignia, true];
		};
	};

	/**
	 * Terminates the dynamic groups system, and deletes all current data
	 * Runs only on the server
	 */
	case "Terminate": {
		if (!isServer) exitWith {};

		// Clear client message event handler
		"BIS_dynamicGroups_clientMessage" addPublicVariableEventHandler [missionnamespace, {}];

		// Public variables
		missionNamespace setVariable ["BIS_dg_ini", nil, true];
	};

	/**
	 * Returns whether the dynamic groups system is initialized
	 */
	case "IsInitialized": {
		missionNamespace getVariable ["BIS_dg_ini", false];
	};

	/**
	 * Receives and handles client requests on the server
	 */
	case "OnClientMessage": {
		if (!isServer) exitWith {};

		_params params [["_variable", "", [""]], ["_message", [], [[]]]];

		private _inMode 	= _message param [0, "", [""]];
		private _inParams 	= _message param [1, [], [[]]];
		private _player		= _message param [2, objNull, [objNull]];

		// Call requested function
		[_inMode, _inParams] call d_fnc_dynamicgroups;
	};

	case "RegisterInitialPlayerGroups": {
		{
			if (isPlayer leader _x && {count units _x > 0}) then {
				["RegisterGroup", [_x, leader _x]] call d_fnc_dynamicgroups;
			};
		} forEach (allGroups - (["GetAllGroups"] call d_fnc_dynamicgroups));
	};

	case "RegisterGroup": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_leader", objNull, [objNull]], ["_data", [], [[]]]];

		if (!isNull _group && {!isNull _leader && {_leader == leader _group}}) then {
			private _insignia	= _data param [0, ["LoadRandomInsignia"] call d_fnc_dynamicgroups, [""]];
			private _name		= _data param [1, groupId _group, [""]];
			private _private	= _data param [2, false, [true]];

			// Flag as registered
			_group setVariable ["BIS_dg_reg", true, true];

			// Set the creator of this group
			_group setVariable ["BIS_dg_cre", _leader, true];

			// Set random insignia
			_group setVariable ["BIS_dg_ins", _insignia, true];

			// Set lock status, unlocked by default
			_group setVariable ["BIS_dg_pri", _private, true];

			// Set unique var
			_group setVariable ["BIS_dg_var", format ["%1_%2_%3", _name, getPlayerUID _leader, time], true];

			// Set the default name of the group
			_group setGroupIdGlobal [_name];

			// Set insignia for all members of the group
			{
				["OnPlayerGroupChanged", [_x, _group]] call d_fnc_dynamicgroups;
			} forEach units _group;
		};
	};

	case "UnregisterGroup": {
		private _group 	= _params param [0, grpNull, [grpNull]];
		private _keep	= _params param [1, false, [false]];

		if (!isNull _group && {["IsGroupRegistered", [_group]] call d_fnc_dynamicgroups}) then {
			if (_keep || {count units _group > 0}) then {
				_group setVariable ["BIS_dg_reg", nil, true];
				_group setVariable ["BIS_dg_cre", nil, true];
				_group setVariable ["BIS_dg_ins", nil, true];
				_group setVariable ["BIS_dg_pri", nil, true];
				_group setVariable ["BIS_dg_var", nil, true];
			} else {
				["DeleteGroup", [_group]] call d_fnc_dynamicgroups;
			};
		};
	};

	case "IsGroupRegistered": {
		private _group = _params param [0, grpNull, [grpNull]];

		_group getVariable ["BIS_dg_reg", false];
	};

	case "DeleteGroup": {
		private _group = _params param [0, grpNull, [grpNull]];

		if (local _group) then {
			["DeleteGroupLocal", [_group]] call d_fnc_dynamicgroups;
		} else {
			["DeleteGroupLocal", [_group]] remoteExecCall ["d_fnc_dynamicGroups", groupOwner _group];
		};
	};

	case "DeleteGroupLocal": {
		private _group = _params param [0, grpNull, [grpNull]];

		if (!isNull _group && {local _group}) then {
			deleteGroup _group;
		};
	};

	case "SetName": {
		if (!isServer) exitWith {};

		private _group  = _params param [0, grpNull, [grpNull]];
		private _name 	= _params param [1, "", [""]];

		if (!isNull _group && {_name != ""}) then
		{
			_group setGroupIdGlobal [_name];
		};
	};

	case "SetPrivateState": {
		if (!isServer) exitWith {};

		private _group  = _params param [0, grpNull, [grpNull]];
		private _state 	= _params param [1, true, [true]];

		if (!isNull _group) then {
			_group setVariable ["BIS_dg_pri", _state, true];
		};
	};

	case "CreateGroupAndRegister": {
		if (!isServer) exitWith {};

		private _player = _params param [0, objNull, [objNull]];

		if (!isNull _player) then {
			// Create the new group in which we will put player
			private _newGroup = createGroup (side group _player);

			// Join player to new group
			[_player] joinSilent _newGroup;

			// Register
			["RegisterGroup", [_newGroup, _player]] call d_fnc_dynamicgroups;
		};
	};

	case "SwitchLeader": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		if (!isNull _group && {!isNull _player && {_group == group _player}}) then {
			// Select new leader
			[_group, _player] remoteExecCall ["d_fnc_selectLeader", 2];
		};
	};

	case "AddGroupMember": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		if (!isNull _player && {!isNull _group && {group _player != _group}}) then {
			private _oldGroup 	= group _player;
			private _units		= units _oldGroup - [_player];

			// Join player to new group
			[_player] joinSilent _group;

			// Trigger event
			["OnPlayerGroupChanged", [_player, _group]] call d_fnc_dynamicgroups;

			// Delete old group
			if (count _units < 1) then {
				["DeleteGroup", [_oldGroup]] call d_fnc_dynamicgroups;
			};
		};
	};

	case "RemoveGroupMember": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		if (!isNull _player && {!isNull _group && {group _player == _group}}) then {
			private _units = units _group - [_player];

			// Join player to his own group
			[_player] joinSilent grpNull;

			// Trigger event
			["OnPlayerGroupChanged", [_player, group _player]] call d_fnc_dynamicgroups;

			// Delete registered group
			if (count _units < 1) then {
				["DeleteGroup", [_group]] call d_fnc_dynamicgroups;
			};
		};
	};

	/**
	 * Switches a player from a group to another
	 */
	case "SwitchGroup": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		if (!isNull _player && {!isNull _group && {group _player != _group}}) then {
			private _oldGroup 	= group _player;
			private _units		= units _oldGroup - [_player];

			// Join player to new group
			[_player] joinSilent _group;

			// Trigger event
			["OnPlayerGroupChanged", [_player, _group]] call d_fnc_dynamicgroups;

			if (count _units < 1) then {
				["DeleteGroup", [_oldGroup]] call d_fnc_dynamicgroups;
			};
		};
	};

	/**
	 * Kicks a player out of a group
	 */
	case "KickPlayer": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_leader", objNull, [objNull]], ["_player", objNull, [objNull]]];

		if (!isNull _group && {!isNull _leader && {!isNull _player && {leader group _leader == _leader && {group _player == _group}}}}) then {
			// Make player leave group
			["RemoveGroupMember", [_group, _player]] call d_fnc_dynamicgroups;

			// The current list of group kicks this player has
			private _kicks = _player getVariable ["BIS_dg_kic", []];

			// Add new id
			_kicks pushBack _group;

			// Store this event, we want to be able to see if player was kicked out of a group
			_player setVariable ["BIS_dg_kic", _kicks, true];
		};
	};

	/**
	 * Un-kicks a player from a group
	 */
	case "UnKickPlayer": {
		if (!isServer) exitWith {};

		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		if (!isNull _group && {!isNull _player && {["WasPlayerKickedFrom", [_group, _player]] call d_fnc_dynamicgroups}}) then {
			// The current list of group kicks this player has
			private _kicksOld = _player getVariable ["BIS_dg_kic", []];

			// Remove given id from list if it exists
			private _kicks = _kicksOld - [_group];

			// Store this event, we want to be able to see if player was kicked out of a group
			if !(_kicksOld isEqualTo _kicks) then {
				_player setVariable ["BIS_dg_kic", _kicks, true];
			};
		};
	};

	case "WasPlayerKickedFrom": {
		_params params [["_group", grpNull, [grpNull]], ["_player", objNull, [objNull]]];

		_group in (_player getVariable ["BIS_dg_kic", []]);
	};

	/**
	 * Returns all abstract groups
	 */
	case "GetAllGroups": {
		allGroups select {isPlayer leader _x && {count units _x > 0 && {["IsGroupRegistered", [_x]] call d_fnc_dynamicgroups}}};
	};

	/**
	 * Returns all abstract groups belonging to a side
	 */
	case "GetAllGroupsOfSide": {
		private _side = _params param [0, sideUnknown, [sideUnknown]];

		((["GetAllGroups"] call d_fnc_dynamicgroups) select {side _x == _side})
	};

	/**
	 * Returns group with given name
	 */
	case "GetGroupByName": {
		_params params [["_name", "", [""]], ["_side", sideUnknown, [sideUnknown]]];

		//private _groups = ["GetAllGroups"] call d_fnc_dynamicgroups;
		private _group  = grpNull;

		{
			if (_name == groupId _x && {side _x == _side}) exitWith {
				_group = _x;
			};
		} forEach allGroups;

		_group;
	};

	/**
	 * Returns group with given unique id
	 */
	case "GetGroupByUniqueId": {
		_params params [["_id", "", [""]], ["_side", sideUnknown, [sideUnknown]]];

		//private _groups = ["GetAllGroups"] call d_fnc_dynamicgroups;
		private _group  = grpNull;

		{
			if (_id == _x getVariable ["BIS_dg_var", ""] && {side _x == _side}) exitWith {
				_group = _x;
			};
		} forEach allGroups;

		_group;
	};

	/**
	 * Gets the list of all friendly players
	 */
	case "GetFriendlyPlayers": {
		private _side = _params param [0, SIDEUNKNOWN, [SIDEUNKNOWN]];

		// Validate params
		if !(_side in [WEST, EAST, RESISTANCE, CIVILIAN]) exitWith {
			[];
		};

		((allUnits + allDead) select {isPlayer _x && {side group _x == _side}})
	};

	/**
	 * Return whether a player has group
	 */
	case "PlayerHasGroup": {
		private _player = _params param [0, objNull, [objNull]];

		["IsGroupRegistered", [group _player]] call d_fnc_dynamicgroups;
	};

	/**
	 * Return whether a player is leader of group
	 */
	case "PlayerIsLeader": {
		private _player = _params param [0, objNull, [objNull]];

		_player == leader group _player && ["PlayerHasGroup", [_player]] call d_fnc_dynamicgroups;
	};

	/**
	 * Initializes a player
	 * Can only be run on machines which have a player
	 */
	case "InitializePlayer": {
		if (!hasInterface) exitWith {};

		_params params [["_player", player, [objNull]], ["_registerInitialGroup", false, [true]]];

		if (isNull _player) exitWith {};

		if (!local _player) exitWith {};

		if (!isNil {_player getVariable "BIS_dg_ini"}) exitWith {};

		// Flag as initialized
		_player setVariable ["BIS_dg_ini", true, true];

		// Add key events for opening the Dynamic Groups interface and for invitation handling
		["AddKeyEvents"] call d_fnc_dynamicgroups;

		// When in the respawn screen, detect when we want to open dynamic groups
		/*missionNamespace setVariable ["BIS_dynamicGroups_respawnKeyDown",
		[
			missionnamespace,
			"RscDisplayRespawnKeyDown",
			{
				private _key = _this param [1, -1, [0]];

				if (_key in d_ak_teamswitch && {missionNamespace getVariable ["BIS_dynamicGroups_allowInterface", true]}) then {
					(_this # 0) createDisplay "d_RscDisplayDynamicGroups";
				};
			}
		] call bis_fnc_addscriptedeventhandler, IS_LOCAL];*/

		// The updating function
		//["dom_dg_eh", {call d_fnc_dgefmeh}, 0.4] call d_fnc_eachframeadd;
		//player sidechat "drin";

		// Register player group if requested, not already registered and player is leader
		if (_registerInitialGroup && {leader group _player == _player && {!(["IsGroupRegistered", [group _player]] call d_fnc_dynamicgroups)}}) then {
			["SendClientMessage", ["RegisterGroup", [group _player, _player]]] call d_fnc_dynamicgroups;
		};
	};

	/**
	 * Un-initializes player
	 * Can only be run on machines which have a player
	 */
	case "TerminatePlayer": {
		if (!hasInterface) exitWith {};

		private _player = _params param [0, player, [objNull]];

		if (!local _player) exitWith {};

		if (isNil {_player getVariable "BIS_dg_ini"}) exitWith {};

		// Remove key events for opening the Dynamic Groups interface and for invitation handling
		["RemoveKeyEvents"] call d_fnc_dynamicgroups;

		// Remove respawn screen key down event handling
		//[missionnamespace, "RscDisplayRespawnKeyDown", missionNamespace getVariable ["BIS_dynamicGroups_respawnKeyDown", []]] call bis_fnc_removescriptedeventhandler;

		// Stop the updating function
		//removeMissionEventHandler ["EachFrame", missionnamespace getVariable ["BIS_dynamicGroups_draw3D", -1]];
		//["dom_dg_eh"] call d_fnc_eachframeremove;
		//player sidechat "draußen";
	};

	/**
	 * Sends a message to server from a client machine
	 */
	case "SendClientMessage" : {
		if (!hasInterface) exitWith {};

		private _inMode         = _params param [0, "", [""]];
		private _inParams       = _params param [1, [], [[]]];

		// If we are on the server, we execute directly otherwise we send to the server to be executed
		if (isServer) then {
			[_inMode, _inParams] call d_fnc_dynamicgroups;
		} else {
			missionNamespace setVariable ["BIS_dynamicGroups_clientMessage", [_inMode, _inParams, player], true];
		};
	};

	/**
	 * Adds key down/up events for opening interface or invitation interaction
	 */
	case "AddKeyEvents": {
		disableSerialization;
		if (!hasInterface) exitWith {};

		private _display = _params param [0, displayNull, [displayNull]];

		[_display] spawn {
			scriptName "DynamicGroups: AddKeyEvents";
			disableSerialization;

			params ["_display"];
			private _varName = "BIS_dynamicGroups_keyMain";

			// Wait for display to become available
			if (isNull _display) then {
				waitUntil{ !isNull (findDisplay 46) };

				_display = (findDisplay 46);
				_varName = "BIS_dynamicGroups_key";
			};

			// Exit in case event is already registered
			if (!isNil {missionNamespace getVariable _varName}) then {
				private _index = missionNamespace getVariable _varName;
				_index params ["_down", "_up"];

				// Reset event handlers
				_display displayRemoveEventHandler ["KeyDown", _down];
				_display displayRemoveEventHandler ["KeyUp", _up];
				missionNamespace setVariable [_varName, nil];
			};

			// Add event handlers to display
			private _down   = _display displayAddEventHandler ["KeyDown", {call d_fnc_dgkdown}];
			private _up     = _display displayAddEventHandler ["KeyUp", {call d_fnc_dgkup}];

			// Store in ui namespace
			missionNamespace setVariable [_varName, [_down, _up]];
		};
	};

	/**
	 * Removes input event handling
	 */
	case "RemoveKeyEvents": {
		disableSerialization;
		if (!hasInterface) exitWith {};

		private _display = _params param [0, displayNull, [displayNull]];

		[_display] spawn {
			scriptName "DynamicGroups: RemoveKeyEvents";
			disableSerialization;

			private _display = _this # 0;
			private _varName = "BIS_dynamicGroups_keyMain";

			// Wait for display to become available
			if (isNull _display) then {
				waitUntil{!isNull (findDisplay 46)};

				_display = (findDisplay 46);
				_varName = "BIS_dynamicGroups_key";
			};

			// Exit in case event is already registered
			if (!isNil {missionNamespace getVariable _varName}) then {
				private _index = missionNamespace getVariable _varName;
				private _down = _index # 0;
				private _up = _index # 1;

				// Reset event handlers
				_display displayRemoveEventHandler ["KeyDown", _down];
				_display displayRemoveEventHandler ["KeyUp", _up];
				missionNamespace setVariable [_varName, nil];
			};
		};
	};

	/**
	 * Handles a key down event
	 */
	/*case "OnKeyDown" : {
		disableSerialization;

		_params params ["_key"];
		private _ctrl = _params # 3;

		if (!_ctrl && {_key in actionKeys "TeamSwitch"}) then {
			if (isNil {uiNamespace getVariable "BIS_dynamicGroups_keyDownTime"}) then {
				uiNamespace setVariable ["BIS_dynamicGroups_keyDownTime", time];
				uiNamespace setVariable ["BIS_dynamicGroups_ignoreInterfaceOpening", nil];
			};

			["UpdateKeyDown"] call d_fnc_dynamicgroups;
			true
		} else {
			false
		};
	};*/

	/**
	 * Handles a key up event
	 */
	/*case "OnKeyUp": {
		disableSerialization;

		_params params ["_key"];
		private _ctrl = _params # 3;

		uiNamespace setVariable ["BIS_dynamicGroups_keyDownTime", nil];

		if (!_ctrl && {_key in actionKeys "TeamSwitch"} && {isNil { uiNamespace getVariable "BIS_dynamicGroups_ignoreInterfaceOpening" }}) then {
			if (isNull (findDisplay 60490) && {missionNamespace getVariable ["BIS_dynamicGroups_allowInterface", true]}) then {
				([] call BIS_fnc_displayMission) createDisplay "d_RscDisplayDynamicGroups";
			} else {
				if (isNil {uiNamespace getVariable "BIS_dynamicGroups_hasFocus"}) then {
					(["GetDisplay"] call d_fnc_rscdisplaydynamicgroups) closeDisplay 2;
				};
			};

			true;
		} else {
			false;
		};
	};*/

	/**
	 *
	 */
	case "UpdateKeyDown": {
		if (!isNil {uiNamespace getVariable "BIS_dynamicGroups_keyDownTime"} && {count (["GetPlayerInvites", [player]] call d_fnc_dynamicgroups) > 0}) then {
			if ((time - (uiNamespace getVariable "BIS_dynamicGroups_keyDownTime")) >= 0.7) then {
				private _invites = ["GetPlayerInvites", [player]] call d_fnc_dynamicgroups;

				if (_invites isNotEqualTo []) then {
					private _group = (_invites select (count _invites - 1)) # 0;

					// Do not allow opening interface
					uiNamespace setVariable ["BIS_dynamicGroups_ignoreInterfaceOpening", true];

					// Remove invite
					["RemoveInvite", [_group, player]] call d_fnc_dynamicgroups;

					// Make sure group is not full
					if (count units _group < missionNamespace getVariable ["BIS_dg_mupg", 99]) then {
						if !(["PlayerHasGroup", [player]] call d_fnc_dynamicgroups) then {
							["SendClientMessage", ["AddGroupMember", [_group, player]]] call d_fnc_dynamicgroups;
						} else {
							["SendClientMessage", ["SwitchGroup", [_group, player]]] call d_fnc_dynamicgroups;
						};

						// Notification
						["LocalShowNotification", ["DynamicGroups_Joined", [groupId _group]]] call d_fnc_dynamicgroups;
					} else {
						// Notification
						["LocalShowNotification", ["DynamicGroups_PlayerJoinFailed", [_group]]] call d_fnc_dynamicgroups;
					};
				};
			};
		};
	};

	/**
	 * Adds a invitation/request to a player
	 * Invitations are stored within unique player
	 */
	case "AddInvite": {
		_params params [["_group", grpNull, [grpNull]], ["_from", objNull, [objNull]], ["_to", objNull, [objNull]]];

		// Validate params
		if (isNull _group) exitWith {};
		if (isNull _from) exitWith {};
		if (isNull _to) exitWith {};

		// Get current invites and requests
		private _invitations = _to getVariable ["BIS_dg_kic", []];

		// The index if group already in list
		private _index = _invitations findIf {_x # 0 == _group};

		// Store new info
		if (_index != -1) then {
			_invitations set [_index, [_group, _from, _to, time]];
		} else {
			_invitations pushBack [_group, _from, _to, time];
		};

		// Broadcast changes
		_to setVariable ["BIS_dg_kic", _invitations, true];

		// Fire event on target computer
		["OnInvitationReceived", [_group, _to, _from]] remoteExecCall ["d_fnc_dynamicGroups", _to];

		// If player was kicked from group we unkick since he was invited
		["UnKickPlayer", [_group, _to]] remoteExecCall ["d_fnc_dynamicGroups"];
	};

	/**
	 * Remove an invite from a player
	 */
	case "RemoveInvite": {
		private _group	= _params param [0, grpNull, [grpNull]];
		private _player	= _params param [1, objNull, [objNull]];

		if (isNull _group) exitWith {};
		if (isNull _player) exitWith {};

		// Get current invites and requests
		private _container      = [] + (_player getVariable ["BIS_dg_kic", []]);

		// Go through the container, find matching group id, get index within container and delete it
		private _index = _container findIf {_group == _x # 0 && {_player == _x # 2}};

		if (_index < 0) exitWith {};

		_container deleteAt _index;
		_player setVariable ["BIS_dg_kic", _container, true];
	};

	/**
	 * Whether player has an invite from a private group
	 */
	case "HasInvite": {
		private _group	= _params param [0, grpNull, [grpNull]];
		private _player	= _params param [1, objNull, [objNull]];

		((_player getVariable ["BIS_dg_kic", []]) findIf {_group == (_x # 0) && {_player == (_x # 2) && {time <= (_x # 3) + 60}}} > -1)
	};

	/**
	 * Returns all invites player has received
	 **/
	case "GetPlayerInvites": {
		private _player         = _params param [0, objNull, [objNull]];
		private _maxLifeTime    = _params param [1, 99999999, [0]];

		((_player getVariable ["BIS_dg_kic", []]) select {!isNull (_x # 0) && {time - (_x # 3) < _maxLifeTime}})
	};

	/**
	 * Event for player joining a group
	 */
	case "OnGroupJoin": {
		private _leader = _params param [1, objNull, [objNull]];
		private _who    = _params param [2, objNull, [objNull]];

		if (!isNull _leader && {!isNull _who && {_leader != _who}}) then {
			["LocalShowNotification", ["DynamicGroups_PlayerJoined", [name _who], _leader]] remoteExecCall ["d_fnc_dynamicGroups", _leader];
		};
	};

	/**
	 * Event for player joining a group failed
	 */
	case "OnGroupJoinFailed": {
		private _who    = _params param [1, objNull, [objNull]];

		if (!isNull _who) then {
			["LocalShowNotification", ["DynamicGroups_PlayerJoinFailed", [], _who]] remoteExecCall ["d_fnc_dynamicGroups", _who];
		};
	};

	/**
	 * Event for player leaving a group
	 */
	case "OnGroupLeave": {
		private _leader = _params param [1, objNull, [objNull]];
		private _who    = _params param [2, objNull, [objNull]];

		if (!isNull _leader && {!isNull _who && {_leader != _who}}) then {
			["LocalShowNotification", ["DynamicGroups_PlayerLeft", [name _who], _leader]] remoteExecCall ["d_fnc_dynamicGroups", _leader];
		};
	};

	/**
	 * Event for invitation received
	 */
	case "OnInvitationReceived": {
		if (!hasInterface) exitWith {};

		private _to     = _params param [1, objNull, [objNull]];
		private _from   = _params param [2, objNull, [objNull]];

		if (player != _to) exitWith {};

		if (!isNull _to && {!isNull _from && {_to != _from}}) then {
			["LocalShowNotification", ["DynamicGroups_InviteReceived", [name _from], _to]] call d_fnc_dynamicgroups;
		};
	};

	/**
	 * Event for player being promoted to leader
	 */
	case "OnPromotedToLeader": {
		private _newLeader      = _params param [1, objNull, [objNull]];
		private _oldLeader      = _params param [2, objNull, [objNull]];

		if (!isNull _oldLeader && {!isNull _newLeader && {_oldLeader != _newLeader}}) then {
			["LocalShowNotification", ["DynamicGroups_PromotedToLeader", [name _oldLeader], _newLeader]] remoteExecCall ["d_fnc_dynamicGroups", _newLeader];
		};
	};

	/**
	 * Event for player group being disbanded
	 */
	case "OnGroupDisbanded": {
		private _who            = _params param [1, objNull, [objNull]];
		private _oldLeader      = _params param [2, objNull, [objNull]];

		if (!isNull _oldLeader && {!isNull _who && {_oldLeader != _who}}) then {
			["LocalShowNotification", ["DynamicGroups_GroupDisbanded", [name _oldLeader], _who]] remoteExecCall ["d_fnc_dynamicGroups", _who];
		};
	};

	/**
	 * Event for player being kicked from his group
	 */
	case "OnKicked": {
		private _who    = _params param [1, objNull, [objNull]];
		private _leader = _params param [2, objNull, [objNull]];

		if (!isNull _leader && {!isNull _who && {_who != _leader}}) then {
			["LocalShowNotification", ["DynamicGroups_Kicked", [name _leader], _who]] remoteExecCall ["d_fnc_dynamicGroups", _who];
		};
	};

	case "LoadInsignias": {
		(configfile >> "CfgUnitInsignia") call BIS_fnc_getCfgSubClasses;
	};

	case "LoadInsignia": {
		private _cfg = configfile >> "CfgUnitInsignia" >> (_params param [0, "", [""]]);
		[getText (_cfg >> "displayName"), getText (_cfg >> "texture"), getText (_cfg >> "author")];
	};

	case "LoadRandomInsignia": {
		private _insignias = ["LoadInsignias"] call d_fnc_dynamicgroups;
		_insignias = _insignias - ["BI"];
		_insignias call bis_fnc_selectRandom;
	};

	case "GetInsigniaDisplayName": {
		(["LoadInsignia", [_params param [0, "", [""]]]] call d_fnc_dynamicgroups) # 0
	};

	case "GetInsigniaTexture": {
		(["LoadInsignia", [_params param [0, "", [""]]]] call d_fnc_dynamicgroups) # 1
	};

	case "GetInsigniaAuthor": {
		(["LoadInsignia", [_params param [0, "", [""]]]] call d_fnc_dynamicgroups) # 2
	};

	case "LocalShowNotification": {
		_params params [["_class", "", [""]], ["_notificationParams", [], [[]]], ["_target", objNull, [objNull]]];

		private _actionKeysNames        = actionkeysnamesarray ["TeamSwitch", 1];
		private _keyText                = if (count _actionKeysNames > 0) then { _actionKeysNames select 0 } else { "N/A" };
		private _string                 = format ["<t color = '%2'>[%1]</t>", _keyText, (["GUI", "BCG_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML];

		_notificationParams pushBack _string;

		if (player == _target || {isNull _target}) then {
			[_class, _notificationParams] call BIS_fnc_showNotification;
		};
	};

	case "OnPlayerGroupChanged": {
		_params params [["_player", objNull, [objNull]], ["_newGroup", grpNull, [grpNull]], ["_oldGroup", grpNull, [grpNull]]];

		if (["IsGroupRegistered", [_newGroup]] call d_fnc_dynamicgroups) then {
			[_player, _newGroup getVariable ["BIS_dg_ins", ""]] call BIS_fnc_setUnitInsignia;
		} else {
			[_player, ""] call BIS_fnc_setUnitInsignia;
		};
	};

	case "GetGroupTexture": {
		private _group = _params param [0, grpNull, [grpNull]];
		private _availableInsignias = [];

		if (!isNil { uiNamespace getVariable "RscEGSpectator_availableInsignias" }) then {
			_availableInsignias = uiNamespace getVariable "RscEGSpectator_availableInsignias";
		} else {
			_availableInsignias = (configfile >> "CfgUnitInsignia") call BIS_fnc_getCfgSubClasses;
			uiNamespace setVariable ["RscEGSpectator_availableInsignias", _availableInsignias];
		};

		private _lastInsigniaTexture = _group getVariable ["BIS_dynamicGroups_lastinsignia", ""];
		private _insigniaTexture = "";

		if (_lastInsigniaTexture == "") then {
			private _insignia = if (count _availableInsignias > 0) then { selectRandom _availableInsignias } else { "" };
			private _groupPicture 	= leader _group getVariable ["BIS_dg_ins", _insignia];
			_insigniaTexture = ["GetInsigniaTexture", [_groupPicture]] call d_fnc_dynamicGroups;
			_group setVariable ["BIS_dynamicGroups_lastinsignia", _insigniaTexture];
		} else {
			_insigniaTexture = _lastInsigniaTexture;
		};

		if (_insigniaTexture != "") then {
			_insigniaTexture;
		} else {
			private _squadParams = squadParams leader _group;
			private _squadPicture = if (count _squadParams > 0) then {(_squadParams # 0) # 4} else {""};
			_squadPicture;
		};
	};

	case "SetAvailableInsignias": {
		uiNamespace setVariable ["RscEGSpectator_availableInsignias", _params param [0, [], [[]]]];
	};

	case "GetAvailableInsignias": {
		uiNamespace getVariable ["RscEGSpectator_availableInsignias", []];
	};

	/**
	 * Log error in case of unknown given mode
	 */
	case default {};
};