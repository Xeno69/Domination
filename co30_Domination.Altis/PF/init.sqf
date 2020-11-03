if(isServer)then{
{_x params[["_function",""],["_file",""],["_useState",false]];
private _code=compileFinal(preprocessFileLineNumbers _file);
if(!(_file isEqualTo""))then{
	if(_useState isEqualTo true)then{missionNamespace setVariable[_function,_code];};
	};
true
}count[
	["PF_h1_1","PF\A3\h1_1.sqf",true],
	["PF_Th1_1","PF\T\h1_1.sqf",true],
	["PF_Th2_1","PF\T\h2_1.sqf",true],
	["PF_h2a_1","PF\A3\h2a_1.sqf",true],
	["PF_h2b_1","PF\A3\h2b_1.sqf",true],
	["PF_h2c_1","PF\A3\h2c_1.sqf",true],
	["PF_h3_1","PF\A3\h3_1.sqf",true],
	["PF_Th3_1","PF\T\h3_1.sqf",true],
	["PF_Th3s_1","PF\T\h3s_1.sqf",true],
	["PF_h4_1","PF\A3\h4_1.sqf",true],
	["PF_h5_1","PF\A3\h5_1.sqf",true],
	["PF_Th5_1","PF\T\h5_1.sqf",true],
	["PF_h6_1","PF\A3\h6_1.sqf",true],
	["PF_Th6_1","PF\T\h6_1.sqf",true],
	["PF_Th7a_1","PF\T\h7_1a.sqf",true],
	["PF_h7_1","PF\A3\h7_1.sqf",true],
	["PF_h8a_1","PF\A3\h8a_1.sqf",true],
	["PF_h8b_1","PF\A3\h8b_1.sqf",true],
	["PF_h8c_1","PF\A3\h8c_1.sqf",true],
	["PF_h9_1","PF\A3\h9_1.sqf",true],
	["PF_h10_1","PF\A3\h10_1.sqf",true],
	["PF_h11_1","PF\A3\h11_1.sqf",true],
	["PF_h12_1","PF\A3\h12_1.sqf",true],
	["PF_h13_1","PF\A3\h13_1.sqf",true],
	["PF_h14_1","PF\A3\h14_1.sqf",true],
	["PF_h15_1","PF\A3\h15_1.sqf",true],
	["PF_h1_2","PF\A3\h1_2.sqf",true],
	["PF_h2a_2","PF\A3\h2a_2.sqf",true],
	["PF_h2b_2","PF\A3\h2b_2.sqf",true],
	["PF_h3_2","PF\A3\h3_2.sqf",true],
	["PF_h4_2","PF\A3\h4_2.sqf",true],
	["PF_h5_2","PF\A3\h5_2.sqf",true],
	["PF_h1_4","PF\A3\h1_4.sqf",true],
	["PF_spawn","PF\f\spawn.sqf",true],
	["PF_CFG","PF\CFG.sqf",true]
	];call PF_CFG;
call compileFinal(preprocessFile"PF\f\PF.sqf");};
sleep 2; 
if(PF_Optimize)then{if(!isDedicated)then{execVM"PF\f\unhide.sqf";};};