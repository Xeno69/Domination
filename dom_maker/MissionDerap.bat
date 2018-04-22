:::::::::::::::::::::::::::::::::::::::::
::	file: MissionDerap.bat
::	======
::	Author: Bohemia Interactive
::	Description: Unrap a mission file (Eden) (plain text)
::	Note:
::	Wiki:
::		Go to http://community.bistudio.com/wiki/CfgConvert for more information
:::::::::::::::::::::::::::::::::::::::::
@echo off
cd %~p1
copy /y %~n1%~x1 %~n1%~x1.Backup
"%~dp0CfgConvert.exe" -txt -dst "%~dpn1.sqm" %1
if Errorlevel 1 pause