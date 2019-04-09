class CfgPatches {
	class dom_server
	{
		author = "Xeno";
		name = "Domination Server Addon";
		url = "";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.9;
		requiredAddons[] = {
			"cba_xeh"
		};
		version = "1.0";
		versionStr = "1.0";
		versionAr[] = {1,0};
		authors[] = {};
	};
};

class CfgFunctions {
	class Dom_Server_Intercept {
		tag = "dsi";
		project = "Domination";
		class intercept {
			file = "dom_server\intercept";
			class preInit {
				preInit = 1;
			};
			class createdbconn {};
			class queryconfig {};
			class queryconfigasync {};
			class gettopplayers {};
		};
	};
};
