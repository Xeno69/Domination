rem Domination Build Batch, really shitty batch file :D

set BASE_MASTER=co30_Domination.Altis
set MASTER=co30_Domination.Altis
set D_VER=3_90
set D_BNVER=3.90
set D_NUM_PLAYERS=40
set D_NUM_PLAYERS_TT=50
set D_NUM_PLAYERS_CO=40

md %MASTER%
xcopy ..\%BASE_MASTER%\*.* %MASTER% /E /Y
cd %MASTER%
cd fsms
xcopy ..\..\DOMFSMClean.cfg /Y
xcopy ..\..\FSMCompiler.exe /Y
del *.fsm
FSMCompiler.exe fn_3rdperson.bifsm -o fn_3rdperson.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_AIRevive.bifsm -o fn_AIRevive.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_AmmoLoad.bifsm -o fn_AmmoLoad.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_Boatrespawn.bifsm -o fn_Boatrespawn.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_CampDialog.bifsm -o fn_CampDialog.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_DeleteEmpty.bifsm -o fn_DeleteEmpty.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_DeleteUnits.bifsm -o fn_DeleteUnits.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_HandleCamps2.bifsm -o fn_HandleCamps2.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_IsAdmin.bifsm -o fn_IsAdmin.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_Parahandler.bifsm -o fn_Parahandler.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_PlayerAmmobox.bifsm -o fn_PlayerAmmobox.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_Recapture.bifsm -o fn_Recapture.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_RepWreck.bifsm -o fn_RepWreck.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_RespawnGroups.bifsm -o fn_RespawnGroups.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_RetakeCamp.bifsm -o fn_RetakeCamp.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_WeatherServer.bifsm -o fn_WeatherServer.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_Wreckmarker.bifsm -o fn_Wreckmarker.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_XClearSidemission.bifsm -o fn_XClearSidemission.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_HandleCampsTT2.bifsm -o fn_HandleCampsTT2.fsm -c DOMFSMClean.cfg
FSMCompiler.exe fn_TTPoints.bifsm -o fn_TTPoints.fsm -c DOMFSMClean.cfg
del *.bifsm
del FSMCompiler.exe
del DOMFSMClean.cfg
cd ..
cd ..

rem Blufor
rem set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.stratis
rem set MISSION_SQM=mission_blufor.sqm
rem set X_SETUP=x_setup_blufor.sqf
rem md %NEW_VER%
rem xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
rem xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
rem xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
rem cd %NEW_VER%
rem call SETUPCOPY.BAT
rem rapify mission.sqm
rem del mission.sqm
rem move mission.sqm.bin mission.sqm
rem cd x_missions
rem rmdir /S /Q m
rem rmdir /S /Q ma3a
rem cd ..
rem cd x_client
rem del x_weaponcargo_a3_ace.sqf
rem del x_weaponcargor_a3_ace.sqf

rem cd ..
rem cd fsms
rem del XCheckSMHardTargetTT.fsm
rem del HandleCampsTT2.fsm
rem del TTPoints.fsm
rem cd ..
rem cd ..
rem makePbo -N -A %NEW_VER%
rem rmdir /S /Q %NEW_VER%


rem Blufor Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.altis
rem set MISSION_SQM=mission_blufor_altis.sqm
set MISSION_SQM=mission_blufor_altis_bin.sqm
set X_SETUP=x_setup_blufor_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor RHS Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_rhs_blufor.altis
rem set MISSION_SQM=mission_blufor_altis.sqm
set MISSION_SQM=mission_blufor_rhs_altis_bin.sqm
set X_SETUP=x_setup_blufor_rhs_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_default.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Carrier Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_carrier_%D_VER%_blufor.altis
rem set MISSION_SQM=mission_blufor_altis.sqm
set MISSION_SQM=mission_blufor_carrier_altis_bin.sqm
set X_SETUP=x_setup_blufor_carrier_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Malden
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.malden
rem set MISSION_SQM=mission_blufor_altis.sqm
set MISSION_SQM=mission_blufor_malden_bin.sqm
set X_SETUP=x_setup_blufor_malden.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q mifa3
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q ma3a
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Opfor Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_opfor.altis
rem set MISSION_SQM=mission_opfor_altis.sqm
set MISSION_SQM=mission_opfor_altis_bin.sqm
set X_SETUP=x_setup_opfor_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Opfor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem Opfor RHS Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_rhs_opfor.altis
rem set MISSION_SQM=mission_opfor_altis.sqm
set MISSION_SQM=mission_opfor_rhs_altis_bin.sqm
set X_SETUP=x_setup_opfor_rhs_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! RHS Opfor [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_default.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem Blufor Chernarus
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.chernarus
rem set MISSION_SQM=mission_blufor_chernarus.sqm
set MISSION_SQM=mission_blufor_chernarus_bin.sqm
set X_SETUP=x_setup_blufor_chernarus.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor CUP [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem Blufor Chernarus Winter
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.chernarus_winter
rem set MISSION_SQM=mission_blufor_chernarus.sqm
set MISSION_SQM=mission_blufor_chernarus_winter_bin.sqm
set X_SETUP=x_setup_blufor_chernarus_winter.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor Winter [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem Blufor Takistan
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.takistan
rem set MISSION_SQM=mission_blufor_takistan.sqm
set MISSION_SQM=mission_blufor_takistan_bin.sqm
set X_SETUP=x_setup_blufor_takistan.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor CUP [%D_BNVER%]" -o ddmnew.sqm
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem Blufor Sahrani
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.sara
rem set MISSION_SQM=mission_blufor_sara.sqm
set MISSION_SQM=mission_blufor_sara_bin.sqm
set X_SETUP=x_setup_blufor_sara.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor CUP [%D_BNVER%]" -o ddmnew.sqm
rem echo d | xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Tanoa
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.tanoa
rem set MISSION_SQM=mission_blufor_sara.sqm
set MISSION_SQM=mission_blufor_tanoa_bin.sqm
set X_SETUP=x_setup_blufor_tanoa.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
rem echo d | xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Stratis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.stratis
set MISSION_SQM=mission_blufor_stratis_bin.sqm
set X_SETUP=x_setup_blufor_stratis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "co%D_NUM_PLAYERS% Domination! Blufor [%D_BNVER%]" -o ddmnew.sqm
rem echo d | xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Opfor IFA3
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_opfor_ifa3.staszow
set MISSION_SQM=mission_opfor_ifa3_bin.sqm
set X_SETUP=x_setup_opfor_ifa3.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q ma3a
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem TT Altis
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.altis
rem set MISSION_SQM=mission_tt_altis.sqm
set MISSION_SQM=mission_tt_altis_bin.sqm
set X_SETUP=x_setup_tt_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "TvT%D_NUM_PLAYERS_TT% Domination! Two Teams [%D_BNVER%]" -o ddmnew.sqm
rem echo d | xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem TT Tanoa
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.tanoa
rem set MISSION_SQM=mission_tt_tanoa.sqm
set MISSION_SQM=mission_tt_tanoa_bin.sqm
set X_SETUP=x_setup_tt_tanoa.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
rem del ddmnew.sqm
rem sqm %MISSION_SQM% -s briefingName * "TvT%D_NUM_PLAYERS_TT% Domination! Two Teams [%D_BNVER%]" -o ddmnew.sqm
rem echo d | xcopy ddmnew.sqm %NEW_VER%\mission.sqm /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
cd x_missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3a
rmdir /S /Q ma3s
rmdir /S /Q mifa3
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%

rem cleanup
rmdir /S /Q %MASTER%
del ddmnew.sqm