while{true}do{sleep 2;
if(objectParent player isKindOf"Air")then{sleep 2;}else{
private _f=player nearObjects["Land_HelipadEmpty_F",150];
if(count _f>0)then{{if(_x getVariable'PF')then{{_x hideObject false}forEach attachedObjects _x;};}forEach _f;};};};