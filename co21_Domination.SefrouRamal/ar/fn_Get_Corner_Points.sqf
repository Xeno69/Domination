/*
The MIT License (MIT)

Copyright (c) 2016 Seth Duda

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

params ["_vehicle"];

// Correct width and length factor for air
private _widthFactor = 0.5;
private _lengthFactor = 0.5;
if (_vehicle isKindOf "Air") then {
	_widthFactor = 0.3;
};
if (_vehicle isKindOf "Helicopter") then {
	_widthFactor = 0.2;
	_lengthFactor = 0.45;
};

private _centerOfMass = getCenterOfMass _vehicle;
(boundingBoxReal _vehicle) params ["_p1", "_p2"];
private _widthOffset = (((abs ((_p2 select 0) - (_p1 select 0))) / 2) - abs (_centerOfMass select 0)) * _widthFactor;
private _lengthOffset = (((abs ((_p2 select 1) - (_p1 select 1))) / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
private _heightOffset = (abs ((_p2 select 2) - (_p1 select 2))) / 6;

[[(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2) + _heightOffset],
[(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2) + _heightOffset],
[(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2) + _heightOffset],
[(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2) + _heightOffset]]