// Infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/

// Teleports the units to random windows of the building(s) within the distance
// Faces units in the right direction and orders them to stand up or crouch on a roof
// Units will only fill the building to as many positions as there are windows
// Multiple buildings can be filled either evenly or to the limit of each sequentially
// Usage : Call, execVM
// Params: 1. Array, the building(s) nearest this position is used
//         2. Array of objects, the units that will garrison the building(s)
//  (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
//  (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
//  (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
//  (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
//  (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
// Return: Array of objects, the units that were not garrisoned

#define I(X) X = X + 1;
#define EVAL(X) (X call _comparator)
#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 10
#define ROOF_CHECK 4
#define ROOF_EDGE 2

private ["_center", "_units", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_Zen_ExtendPosition", "_buildingsArray", "_buildingPosArray", "_buildingPositions", "_posArray", "_unitIndex", "_j", "_building", "_posArray", "_randomIndex", "_housePos", "_startAngle", "_i", "_checkPos", "_hitCount", "_isRoof", "_edge", "_k", "_unUsedUnits", "_array", "_sortHeight", "_Zen_InsertionSort", "_Zen_ArrayShuffle", "_doMove"];

_center = _this param [0, [0,0,0], [[]], 3];
_units = _this param [1, [objNull], [[]]];
_buildingRadius = _this param [2, -1, [0]];
_putOnRoof = _this param [3, false, [true]];
_fillEvenly = _this param [4, false, [true]];
_sortHeight = _this param [5, false, [true]];
_doMove = _this param [6, false, [true]];

if (_center isEqualTo [0,0,0]) exitWith {
    player sideChat str "Zen_Occupy House Error : Invalid position given.";
    diag_log "Zen_Occupy House Error : Invalid position given.";
    ([])
};

if ((count _units == 0) || {isNull (_units select 0)}) exitWith {
    player sideChat str "Zen_Occupy House Error : No units given.";
    diag_log "Zen_Occupy House Error : No units given.";
    ([])
};

_Zen_ExtendPosition = {
    private ["_center", "_dist", "_phi"];

    _center = _this select 0;
    _dist = _this select 1;
    _phi = _this select 2;

    ([(_center select 0) + (_dist * (cos _phi)),(_center select 1) + (_dist * (sin _phi)), (_this select 3)])
};

_Zen_InsertionSort = {
    private ["_i", "_j", "_count", "_array", "_element", "_value", "_comparator"];

    _array = _this select 0;
    _comparator = _this select 1;
    _count = count _array - 1;

    if (count _array == 0) exitWith {};
    for "_i" from 1 to _count step 1 do {
        scopeName "forI";
        _element = _array select _i;
        _value = EVAL(_element);

        for [{_j = _i}, {_j >= 1}, {_j = _j - 1}] do {
            if (_value > EVAL(_array select (_j - 1))) then {
                breakTo "forI";
            };
            _array set [_j, _array select (_j - 1)];
        };

        _array set [_j, _element];
    };
    if (true) exitWith {};
};

_Zen_ArrayShuffle = {
    private ["_array", "_j", "_i", "_temp"];
    _array = _this select 0;

    if (count _array > 1) then {
        for "_i" from 0 to (count _array - 1) do {
                _j = _i + floor random ((count _array) - _i);
                _temp = _array select _i;
                _array set [_i, (_array select _j)];
                _array set [_j, _temp];
        };
    };
    if (true) exitWith {};
};

if (_buildingRadius < 0) then {
    _buildingsArray = [nearestBuilding _center];
} else {
    _buildingsArray0 = nearestObjects [_center, ["house"], _buildingRadius];
    _buildingsArray1 = nearestObjects [_center, ["building"], _buildingRadius];
    _buildingsArray = _buildingsArray0 arrayIntersect _buildingsArray1;
};

if (count _buildingsArray == 0) exitWith {
    player sideChat str "Zen_Occupy House Error : No buildings found.";
    diag_log "Zen_Occupy House Error : No buildings found.";
    ([])
};

_buildingPosArray = [];
0 = [_buildingsArray] call _Zen_ArrayShuffle;
{
    _posArray = [];
    for "_i" from 0 to 1000 do {
        if ((_x buildingPos _i) isEqualTo [0,0,0]) exitWith {};
        _posArray pushBack (_x buildingPos _i);
    };

    _buildingPosArray pushBack _posArray;
} forEach _buildingsArray;

if (_sortHeight) then {
    {
        0 = [_x, {-1 * (_this select 2)}] call _Zen_InsertionSort;
    } forEach _buildingPosArray;
} else {
    {
        0 = [_x] call _Zen_ArrayShuffle;
    } forEach _buildingPosArray;
};

_unitIndex = 0;
for [{_j = 0}, {(_unitIndex < count _units) && {(count _buildingPosArray > 0)}}, {I(_j)}] do {
    scopeName "for";

    _building = _buildingsArray select (_j % (count _buildingsArray));
    _posArray = _buildingPosArray select (_j % (count _buildingPosArray));

    if (count _posArray == 0) then {
        _buildingsArray deleteAt (_j % (count _buildingsArray));
        _buildingPosArray deleteAt (_j % (count _buildingPosArray));
    };

    while {(count _posArray) > 0} do {
        scopeName "while";
        if (_unitIndex >= count _units) exitWith {};

        _housePos = _posArray select 0;
        _posArray deleteAt 0;
        _housePos = [(_housePos select 0), (_housePos select 1), (_housePos select 2) + (getTerrainHeightASL _housePos) + EYE_HEIGHT];

        _startAngle = (round random 10) * (round random 36);
        for "_i" from _startAngle to (_startAngle + 350) step 10 do {
            _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2)] call _Zen_ExtendPosition;
            if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then {
                if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                    _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) + (CHECK_DISTANCE * tan FOV_ANGLE)] call _Zen_ExtendPosition;
                    if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                        _hitCount = 0;
                        for "_k" from 30 to 360 step 30 do {
                            _checkPos = [_housePos, 20, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
                            if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                                I(_hitCount)
                            };

                            if (_hitCount >= ROOF_CHECK) exitWith {};
                        };

                        _isRoof = (_hitCount < ROOF_CHECK) && {!(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])};
                        if (!(_isRoof) || {((_isRoof) && {(_putOnRoof)})}) then {
                            if (_isRoof) then {
                                _edge = false;
                                for "_k" from 30 to 360 step 30 do {
                                    _checkPos = [_housePos, ROOF_EDGE, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
                                    _edge = !(lineIntersects [_checkPos, [(_checkPos select 0), (_checkPos select 1), (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

                                    if (_edge) exitWith {
                                        _i = _k;
                                    };
                                };
                            };

                            if (!(_isRoof) || {_edge}) then {
                                (_units select _unitIndex) doWatch ([_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) - (getTerrainHeightASL _housePos)] call _Zen_ExtendPosition);

                                (_units select _unitIndex) disableAI "TARGET";
                                if (_doMove) then {
                                    (_units select _unitIndex) doMove ASLToATL ([(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT]);
                                } else {
                                    (_units select _unitIndex) setPosASL [(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT];
                                    (_units select _unitIndex) setDir _i;

                                    doStop (_units select _unitIndex);
                                    (_units select _unitIndex) forceSpeed 0;
                                };

                               //** JBOY_UpDown by JohnnyBoy //*/
                                #define JBOY_UpDown \
                                    if (!isServer)  exitWith {}; \
                                    _dude = _this select 0; \
                                    _stances = _this select 1; \
                                    _dude removeAllEventHandlers "FiredNear"; \
                                    while {alive _dude} do { \
                                        if ((unitPos _dude) == (_stances select 0)) then { \
                                            _dude setUnitPos (_stances select 1); \
                                        } else { \
                                            _dude setUnitPos (_stances select 0); \
                                        }; \
                                        sleep (1 + (random 7)); \
                                    };

                                if (_isRoof) then {
                                    (_units select _unitIndex) setUnitPos "MIDDLE";
                                   (_units select _unitIndex) addEventHandler ["FiredNear",{[(_this select 0),["DOWN","MIDDLE"]] spawn {JBOY_UpDown};}];
                                } else {
                                    (_units select _unitIndex) setUnitPos "UP";
                                   (_units select _unitIndex) addEventHandler ["FiredNear",{[(_this select 0),["UP","MIDDLE"]] spawn {JBOY_UpDown};}];
                                };

                                I(_unitIndex)
                                if (_fillEvenly) then {
                                    breakTo "for";
                                } else {
                                    breakTo "while";
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

if (_doMove) then {
    0 = [_units, _unitIndex] spawn {
        _units = _this select 0;
        _unitIndex = _this select 1;

        _usedUnits = [];
        for "_i" from 0 to (_unitIndex - 1) do {
            _usedUnits pushBack (_units select _i);
        };

        while {count _usedUnits > 0} do {
            sleep 1;
            _toRemove =  [];
            {
                if (unitReady _x) then {
                    doStop _x;
                    _x forceSpeed 0;
                    _toRemove pushBack _forEachIndex;
                };
            } forEach _usedUnits;

            {
                _usedUnits deleteAt (_x - _forEachIndex);
            } forEach _toRemove;
        };
        if (true) exitWith {};
    };
};

_unUsedUnits = [];
for "_i" from _unitIndex to (count _units - 1) step 1 do {
    _unUsedUnits pushBack (_units select _i);
};

(_unUsedUnits)

// Changelog
// 7/21/15
    // 1. Added: Error reporting for invalid position and unit array arguments
    // 1. Added: Check and error report if no buildings are found
    // 3. Improved: Parameters 3, 4, and 5 are now optional and check for the correct type
    // 4. Improved: Parameters 6 and 7 check for the correct type
    // 5. Improved: AI should now stay in place better (thanks to JohnnyBoy)

// 7/6/15
    // 1. Added: AI now take cover when fired upon (credit to JohnnyBoy)
    // 2. Added: Parameter to order the AI to move to their position
    // 3. Improved: The order of buildings filled is now random
    // 4. Improved: A few minor optimizations

// 6/30/15
    // 1. Added: Parameter to fill buildings from top to bottom
    // 2. Improved: Optimized

// 7/31/14
    // 1. Added: Parameter to cycle through each building in the radius, giving units to each one
    // 2. Improved: Units on roof are only placed at the edge, and face the edge
    // 3. Improved: Optimized roof check
    // 4. Improved: General script cleanup

// 7/28/14
    // 1. Fixed: Units facing the wrong window
    // 2. Added: Parameter for distance to select multiple buildings
    // 3. Added: Parameter for units being on a roof
    // 4. Improved: Now checks that unit has a good FOV from the windows
    // 5. Improved: Units can no longer face a windows greater than 5 meters away
    // 6. Improved: Units on a roof now crouch
    // 7. Tweaked: Height of human eye to the exact value in ArmA

// 7/24/14
    // Initial Release

// Known Issues
    // None
