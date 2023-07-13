waitUntil{sleep 15;
if((count allPlayers>0)&&{(count PF_B>0)})then{
{if!(isNil{_x getVariable"PF"})then{
if((_x nearEntities[["Man","Car","Tank","Ship"],PF_Range+50]findIf{isPlayer _x})==-1)then{
{deleteVehicle _x}count(_x getVariable"PF");PF_B=PF_B-[_x];_x setVariable["PF",nil]}}}forEach PF_B};false};
sleep 15;
diag_log"PF: Clean.sqf loop has been executed.";[]spawn compileFinal(loadFile"PF\f\clean.sqf");