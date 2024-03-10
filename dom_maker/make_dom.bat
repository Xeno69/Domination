rem Domination Build Batch, really shitty batch file :D
rem needs makepbo from mikero https://mikero.bytex.digital/Downloads needs makePBO and dePBO
rem just copy MakePBO.exe and DePbo.dll in the dom_maker folder
rem The ArmaScriptCompiler.exe which is needed for SQFC files can be found at https://github.com/dedmen/ArmaScriptCompiler/actions/workflows/ci.yml (click on the latest workflow runs link to download)

set BASE_MASTER=co30_Domination.Altis
set MASTER=co30_Domination.Altis
set D_VER=4_70
set D_BNVER=4.70
set D_NUM_PLAYERS=40
set D_NUM_PLAYERS_TT=50
set D_NUM_PLAYERS_CO=40
rem set D_DO_ASC=1
rem set D_DO_ASC_ALL=1

set WORK_DIR=E:\DomSQFC

del *.pbo

rmdir /S /Q %WORK_DIR%

md %MASTER%
xcopy ..\%BASE_MASTER%\*.* %MASTER% /E /Y

rem Blufor Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.altis
set MISSION_SQM=..\mission_sqm\mission_blufor_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%

rem goto cleanup


rem Independet PRACS
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_indep_pracs.sara
set MISSION_SQM=..\mission_sqm\mission_indep_pracs_sara_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_indep_pracs_sara.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rem rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
rmdir /S /Q ma3a
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor JSDF Kushirobeppo
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor_jsdf.Kushirobeppo
set MISSION_SQM=..\mission_sqm\mission_blufor_jsdf_Kushirobeppo_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_jsdf.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
rem rmdir /S /Q ma3a
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor JSDF Shikotan
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor_jsdf.Shikotan
set MISSION_SQM=..\mission_sqm\mission_blufor_jsdf_Shikotan_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_jsdf.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
rem rmdir /S /Q ma3a
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Stratis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.stratis
set MISSION_SQM=..\mission_sqm\mission_blufor_stratis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_stratis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor RHS Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_rhs_blufor.altis
set MISSION_SQM=..\mission_sqm\mission_blufor_rhs_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_rhs_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Carrier Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_carrier_%D_VER%_blufor.altis
set MISSION_SQM=..\mission_sqm\mission_blufor_carrier_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_carrier_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Malden
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.malden
set MISSION_SQM=..\mission_sqm\mission_blufor_malden_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_malden.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3a
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Opfor Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_opfor.altis
set MISSION_SQM=..\mission_sqm\mission_opfor_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Opfor RHS Altis
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_rhs_opfor.altis
set MISSION_SQM=..\mission_sqm\mission_opfor_rhs_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_opfor_rhs_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_default.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Chernarus
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.chernarus
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Chernarus 2020 (A3)
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.cup_chernarus_A3
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_a3_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Chernarus Winter
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.chernarus_winter
set MISSION_SQM=..\mission_sqm\mission_blufor_chernarus_winter_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_chernarus_winter.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Takistan
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.takistan
set MISSION_SQM=..\mission_sqm\mission_blufor_takistan_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_takistan.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem Blufor Sahrani
set NEW_VER=co%D_NUM_PLAYERS%_domination_%D_VER%_blufor.sara
set MISSION_SQM=..\mission_sqm\mission_blufor_sara_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_blufor_sara.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_default.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q ma3a
rmdir /S /Q moa
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem TT Altis
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.altis
set MISSION_SQM=..\mission_sqm\mission_tt_altis_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_tt_altis.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3m
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%


rem TT Malden
set NEW_VER=tvt%D_NUM_PLAYERS_TT%_domination_%D_VER%_tt.malden
set MISSION_SQM=..\mission_sqm\mission_tt_malden_bin.sqm
set X_SETUP=..\mission_sqm\x_setup_tt_malden.sqf
md %WORK_DIR%
xcopy %MASTER%\*.* %WORK_DIR% /E /Y
echo d | xcopy %MISSION_SQM% %WORK_DIR%\mission.sqm /Y
echo d | xcopy %X_SETUP% %WORK_DIR%\x_setup.sqf /Y
if defined D_DO_ASC_ALL ArmaScriptCompiler.exe
md %NEW_VER%
xcopy %WORK_DIR%\*.* %NEW_VER% /E /Y
cd %NEW_VER%
del i_weapons_rhs.sqf
del i_weapons_CUP.sqf
del i_weapons_PRACS.sqf
cd missions
rmdir /S /Q m
rmdir /S /Q moa
rmdir /S /Q msara
rmdir /S /Q ma3s
rmdir /S /Q ma3a
cd ..
cd ..
makePbo -A -B -P -X %NEW_VER% %NEW_VER%
rmdir /S /Q %NEW_VER%
rmdir /S /Q %WORK_DIR%

rem cleanup
:cleanup
rmdir /S /Q %MASTER%
rem del ddmnew.sqm
