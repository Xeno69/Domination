title=Copy and PBO files for Arma
SET workdir=C:\Users\neily_yblyyb7\Documents\arma-tmp\arma-workdir\
echo "%workdir%"

SET srcdirname=co30_Domination.Altis

SET destdirname=co30_Domination.Altis
::SET destdirname=co30_Domination.Malden
::SET destdirname=co30_Domination.Tanoa
::SET destdirname=co30_Domination.Takistan
::SET destdirname=co30_Domination.Enoch
::SET destdirname=co30_Domination.Zargabad

SET mapname=altis
::SET mapname=malden
::SET mapname=tanoa
::SET mapname=takistan
::SET mapname=enoch
::SET mapname=zargabad

XCOPY /Y /E %srcdirname% %workdir%\%destdirname%\ 
COPY mission_sqm\mission_blufor_%mapname%_bin.sqm %workdir%\%destdirname%\mission.sqm
COPY mission_sqm\x_setup_blufor_%mapname%.sqf %workdir%\%destdirname%\x_setup.sqf

"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe" -pack %workdir%\%destdirname% %workdir%\%destdirname%.pbo

COPY /Y %workdir%\%destdirname%.pbo C:\Users\neily_yblyyb7\Dropbox\arma\campflabanabba\domination\%destdirname%.pbo

echo "complete"
pause