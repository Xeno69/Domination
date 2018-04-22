:::::::::::::::::::::::::::::::::::::::::
::	file: CPPToBin.bat
::	======
::	Author: Bohemia Interactive
::	Description: Convert a CPP file to BIN
::	Note: 
::	Wiki:
::		Go to http://community.bistudio.com/wiki/CfgConvert for more information
:::::::::::::::::::::::::::::::::::::::::
@pushd P:\
@"%~dp0CfgConvert.exe" -bin -dst "%~dpn1.bin" %1
@if Errorlevel 1 pause
@popd