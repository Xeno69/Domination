#define addc(cname) class cname {headerType = -1;}
class cfgFunctions {
	version = 3.0;
	createShortcuts = 1;
	class Dom {
		tag = "d";
		class Dom_PrePostInit {
			file = "init";
			class preinit {
				preInit = 1;
				headerType = -1;
			};
			class postinit {
				postInit = 1;
				headerType = -1;
			};
		};
	};
	class Dom_AR {
		tag = "ar";
		class Dom_AR_prestart {
			file = "ar";
			class postinit {
				postInit = 1;
				headerType = -1;
			};
		};
	};
};
