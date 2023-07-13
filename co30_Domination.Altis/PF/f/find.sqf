private _ftypes=(PF_Houses+PF_Mil);
private["_ap","_Bs"];
waitUntil{sleep 5;
_ap=(allPlayers select{alive _x && speed _x<30});
if(count _ap>0)then{_Bs=[];
{_Bs pushBackUnique(nearestObjects[_x,_ftypes,PF_Range,true])}forEach _ap;_Bs=(_Bs arrayIntersect _Bs)#0;
if(count _Bs>0)then{
{if(!(_x in PF_B)&&isNil{_x getVariable"PF"})then{
if(toLowerANSI typeOf _x in _ftypes)then{[_x,typeOf _x]call PF_call}}}count _Bs}};false};
diag_log"PF: Find.sqf loop has been executed.";[]spawn compileFinal(loadFile"PF\f\find.sqf");