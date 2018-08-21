/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_vehicle"];

// Check for pre-defined rappel points

private ["_preDefinedRappelPoints", "_className", "_rappelPoints", "_preDefinedRappelPointsConverted"];
_preDefinedRappelPoints = [];
{
	_x params ["_className", "_rappelPoints"];
	if (_vehicle isKindOf _className) then {
		_preDefinedRappelPoints = _rappelPoints;
	};
} forEach (AP_RAPPEL_POINTS + (missionNamespace getVariable ["AP_CUSTOM_RAPPEL_POINTS", []]));

if (count _preDefinedRappelPoints > 0) exitWith { 
	_preDefinedRappelPointsConverted = [];
	{
		if (_x isEqualType "") then {
			_modelPosition = _vehicle selectionPosition _x;
			if ([0,0,0] distance _modelPosition > 0) then {
				_preDefinedRappelPointsConverted pushBack _modelPosition;
			};
		} else {
			_preDefinedRappelPointsConverted pushBack _x;
		};
	} forEach _preDefinedRappelPoints;
	_preDefinedRappelPointsConverted;
};

// Calculate dynamic rappel points

private ["_rappelPointsArray","_cornerPoints","_frontLeftPoint","_frontRightPoint","_rearLeftPoint","_rearRightPoint","_rearLeftPointFinal"];
private ["_rearRightPointFinal","_frontLeftPointFinal","_frontRightPointFinal","_middleLeftPointFinal","_middleRightPointFinal","_vehicleUnitVectorUp"];
private ["_rappelPoints","_modelPoint","_modelPointASL","_surfaceIntersectStartASL","_surfaceIntersectEndASL","_surfaces","_intersectionASL"];
private ["_la","_lb","_n","_p0","_l","_d","_validRappelPoints"];

_rappelPointsArray = [];
_cornerPoints = [_vehicle] call AR_fnc_Get_Corner_Points;

_frontLeftPoint = (((_cornerPoints select 2) vectorDiff (_cornerPoints select 3)) vectorMultiply 0.2) vectorAdd (_cornerPoints select 3);
_frontRightPoint = (((_cornerPoints select 2) vectorDiff (_cornerPoints select 3)) vectorMultiply 0.8) vectorAdd (_cornerPoints select 3);
_rearLeftPoint = (((_cornerPoints select 0) vectorDiff (_cornerPoints select 1)) vectorMultiply 0.2) vectorAdd (_cornerPoints select 1);
_rearRightPoint = (((_cornerPoints select 0) vectorDiff (_cornerPoints select 1)) vectorMultiply 0.8) vectorAdd (_cornerPoints select 1);

_rearLeftPointFinal = ((_frontLeftPoint vectorDiff _rearLeftPoint) vectorMultiply 0.2) vectorAdd _rearLeftPoint;
_rearRightPointFinal = ((_frontRightPoint vectorDiff _rearRightPoint) vectorMultiply 0.2) vectorAdd _rearRightPoint;
_frontLeftPointFinal = ((_rearLeftPoint vectorDiff _frontLeftPoint) vectorMultiply 0.2) vectorAdd _frontLeftPoint;
_frontRightPointFinal = ((_rearRightPoint vectorDiff _frontRightPoint) vectorMultiply 0.2) vectorAdd _frontRightPoint;
_middleLeftPointFinal = ((_frontLeftPointFinal vectorDiff _rearLeftPointFinal) vectorMultiply 0.5) vectorAdd _rearLeftPointFinal;
_middleRightPointFinal = ((_frontRightPointFinal vectorDiff _rearRightPointFinal) vectorMultiply 0.5) vectorAdd _rearRightPointFinal;

_vehicleUnitVectorUp = vectorNormalized (vectorUp _vehicle);

_rappelPointHeightOffset = 0;
{
	if (_vehicle isKindOf (_x select 0)) then {
		_rappelPointHeightOffset = _x select 1;
	};
} forEach AR_RAPPEL_POINT_CLASS_HEIGHT_OFFSET;

_rappelPoints = [];
{
	_modelPoint = _x;
	_modelPointASL = AGLToASL (_vehicle modelToWorldVisual _modelPoint);
	_surfaceIntersectStartASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply -5 );
	_surfaceIntersectEndASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply 5 );
	
	// Determine if the surface intersection line crosses below ground level
	// If if does, move surfaceIntersectStartASL above ground level (lineIntersectsSurfaces
	// doesn't work if starting below ground level for some reason
	// See: https://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection
	
	_la = ASLToAGL _surfaceIntersectStartASL;
	_lb = ASLToAGL _surfaceIntersectEndASL;
	
	if (_la select 2 < 0 && {_lb select 2 > 0}) then {
		_n = [0, 0, 1];
		_p0 = [0, 0, 0.1];
		_l = _la vectorFromTo _lb;
		if ((_l vectorDotProduct _n) != 0) then {
			_d = ((_p0 vectorAdd (_la vectorMultiply -1)) vectorDotProduct _n) / (_l vectorDotProduct _n);
			_surfaceIntersectStartASL = AGLToASL ((_l vectorMultiply _d) vectorAdd _la);
		};
	};
	
	_surfaces = lineIntersectsSurfaces [_surfaceIntersectStartASL, _surfaceIntersectEndASL, objNull, objNull, true, 100];
	_intersectionASL = [];
	{
		if (_x select 2 == _vehicle) exitWith {
			_intersectionASL = _x select 0;
		};
	} forEach _surfaces;
	if (count _intersectionASL > 0) then {
		_intersectionASL = _intersectionASL vectorAdd ((_surfaceIntersectStartASL vectorFromTo _surfaceIntersectEndASL) vectorMultiply (_rappelPointHeightOffset select (count _rappelPoints)));
		_rappelPoints pushBack (_vehicle worldToModelVisual (ASLToAGL _intersectionASL));
	} else {
		_rappelPoints pushBack [];
	};
} forEach [_middleLeftPointFinal, _middleRightPointFinal, _frontLeftPointFinal, _frontRightPointFinal, _rearLeftPointFinal, _rearRightPointFinal];

_validRappelPoints = [];
{
	if (count _x > 0 && {count _validRappelPoints < missionNamespace getVariable ["AR_MAX_RAPPEL_POINTS_OVERRIDE",6]}) then {
		_validRappelPoints pushBack _x;
	};
} forEach _rappelPoints;

_validRappelPoints