rem Domination Build Batch, really shitty batch file :D
rem needs makepbo from mikero https://mikero.bytex.digital/Downloads needs makePBO and dePBO
rem just copy MakePBO.exe and DePbo.dll in the dom_maker folder

set BASE_MASTER=co30_Domination.Altis
set MASTER=co30_Domination.Altis
set D_VER=4_38
set D_BNVER=4.38
set D_NUM_PLAYERS=40
set D_NUM_PLAYERS_TT=50
set D_NUM_PLAYERS_CO=40

del *.pbo

md %MASTER%
xcopy ..\%BASE_MASTER%\*.* %MASTER% /E /Y

rem Blufor Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.altis
set MISSION_SQM=..\mission_sqm\mission_blufor_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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


rem Blufor Stratis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.stratis
set MISSION_SQM=..\mission_sqm\mission_blufor_stratis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_stratis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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


rem Blufor RHS Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_rhs_blufor.altis
set MISSION_SQM=..\mission_sqm\mission_blufor_rhs_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_rhs_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_carrier_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_carrier_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_malden_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_malden.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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


rem Blufor NBV Malden
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor_nbv.malden
set MISSION_SQM=..\mission_sqm\mission_blufor_nbv_malden_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_nbv_malden.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_opfor_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_opfor_rhs_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_rhs_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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

rem Blufor Chernarus 2020 (A3)
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.cup_chernarus_A3
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_a3_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_winter_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus_winter.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_IFA3.sqf
del i_weapons_default.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_takistan_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_takistan.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_IFA3.sqf
del i_weapons_default.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_sara_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_sara.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_IFA3.sqf
del i_weapons_default.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_blufor_tanoa_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_tanoa.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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


rem Blufor Rosche
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.wl_rosche
set MISSION_SQM=..\mission_sqm\mission_blufor_rosche_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_rosche.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q mifa3
rmdir /S /Q ma3m
rmdir /S /Q ma3s
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Weferlingen Summer
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.gm_weferlingen_summer
set MISSION_SQM=..\mission_sqm\mission_blufor_weferlingen_summer.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_weferlingen_summer.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_default.sqf
del i_weapons_csla.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q mifa3
rmdir /S /Q ma3m
rmdir /S /Q ma3s
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Weferlingen Winter
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.gm_weferlingen_winter
set MISSION_SQM=..\mission_sqm\mission_blufor_weferlingen_winter.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_weferlingen_winter.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_default.sqf
del i_weapons_csla.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q mifa3
rmdir /S /Q ma3m
rmdir /S /Q ma3s
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Blufor Livonia
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.enoch
set MISSION_SQM=..\mission_sqm\mission_blufor_enoch_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_enoch.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_gmcwg.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_csla.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q mifa3
rmdir /S /Q ma3m
rmdir /S /Q ma3s
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%


rem Opfor IFA3
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_opfor_ifa3.staszow
set MISSION_SQM=..\mission_sqm\mission_opfor_ifa3_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_ifa3.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
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



rem Blufor Unsung
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor_usnung.song_bin_tanh
set MISSION_SQM=..\mission_sqm\mission_blufor_unsung_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_unsung.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_gmcwg.sqf
del i_weapons_csla.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q ma3a
rmdir /S /Q ma3m
rmdir /S /Q mifa3
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%



rem Opfor CSLA
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_opfor.stozec
set MISSION_SQM=..\mission_sqm\mission_opfor_csla_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_csla.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_gmcwg.sqf
del i_weapons_default.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3t
rmdir /S /Q ma3s
rmdir /S /Q ma3a
rmdir /S /Q ma3m
rmdir /S /Q mifa3
cd ..
cd ..
makePbo -AJNP %NEW_VER%
rmdir /S /Q %NEW_VER%





rem TT Altis
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.altis
set MISSION_SQM=..\mission_sqm\mission_tt_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_tt_altis.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_gmcwg.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_csla.sqf
cd missions
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
set MISSION_SQM=..\mission_sqm\mission_tt_tanoa_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_tt_tanoa.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_gmcwg.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_csla.sqf
cd missions
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

rem TT Malden
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.malden
set MISSION_SQM=..\mission_sqm\mission_tt_malden_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_tt_malden.sqf
md %NEW_VER%
xcopy %MASTER%\*.* %NEW_VER% /E /Y
echo d | xcopy %MISSION_SQM% %NEW_VER%\mission.sqm /Y
echo d | xcopy %X_SETUP% %NEW_VER%\x_setup.sqf /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_IFA3.sqf
del i_weapons_gmcwg.sqf
del i_weapons_UNSUNG.sqf
del i_weapons_csla.sqf
cd missions
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

rem cleanup
rmdir /S /Q %MASTER%
del ddmnew.sqm