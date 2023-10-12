@echo off
:: CREATED BY PSYSTEC
:: Discord: https://discord.gg/EyRgFdA
:: GitHub: https://github.com/Psystec/RUST-ServerScript
:: A script that will help you keep your steamcmd rust server and oxide mod up to date.
:: You will need 7z and wget for the automation to work fully.

::SET LOCATION VARIABLES (IMPORTANT)
:: SteamCMD.exe Path (https://developer.valvesoftware.com/wiki/SteamCMD)
SET steamCmdPath=D:\DedicatedServers\SteamServers\steamcmd.exe

:: Directory to the RUST server.
SET rustServerPath=D:\DedicatedServers\SteamServers\steamapps\common\rust_dedicated

:: wget.exe Path (https://www.gnu.org/software/wget/) this will allow the script to download the lastest Oxide for RUST.
SET wgetPath=D:\DedicatedServers\SteamServers\wget.exe

::7z.exe Path (https://7-zip.org/) This will allow the script to extract the Oxide update.
SET sevenZPath=D:\DedicatedServers\SteamServers\7z.exe

::SET RUST SERVER VARIABLES
SET rustServerPort=28015
SET rustServerLevel="Procedural Map"
SET rustServerSeed=12345
SET rustServerSize=4000
SET rustServerMaxPlayers=100
SET rustServerHostName="Example Test Server"
SET rustServerDescription="This is an exampe descrition"
SET rustServerUrl="http://mysite.com"
SET rustServerHeaderImage="http://mysite.com/serverimage.jpg"
SET rustServerIdentity="exampleserver"
SET rustServerRconPort=28016
SET rustServerRconPassword="letmein"
SET rustServerLogfile=rustServerlogfile

::
:: DO NOT CHANGE ANYTHING BELLOW
::

cls
echo.
echo  --------------------------------------------------------
echo           PSYSTEC RUST UPDATER AND LAUNCHER v0.1
echo  --------------------------------------------------------
echo  Created by Psystec : Discord: https://discord.gg/EyRgFdA
echo.

::CHECKS
IF NOT EXIST %steamCmdPath% (
echo SteamCMD.exe does not exist. See this link for more information: https://developer.valvesoftware.com/wiki/SteamCMD
GOTO EXIT
)
IF NOT EXIST %wgetPath% (
echo wget.exe does not exist. See this link for more information: https://www.gnu.org/software/wget/
GOTO EXIT
)
IF NOT EXIST %sevenZPath% (
echo 7z.exe does not exist. See this link for more information: https://7-zip.org/
GOTO EXIT
)

::DateTimeFormat
Set mm=%DATE:~5,2%
Set dd=%DATE:~8,2%
Set yyyy=%DATE:~-10,4%
Set myDate=%yyyy%_%mm%_%dd%

%steamCmdPath% +force_install_dir "%rustServerPath%" +login anonymous +app_update 258550 validate +quit
%wgetPath% -O %rustServerPath%\Oxide.Rust.zip https://umod.org/games/rust/download
%sevenZPath% x %rustServerPath%\Oxide.Rust.zip -o"%rustServerPath%" -r -aoa

IF EXIST %rustServerPath%\Oxide.Rust.zip (
DEL %rustServerPath%\Oxide.Rust.zip
)
IF EXIST %rustServerPath%\.wget-hsts (
DEL %rustServerPath%\.wget-hsts
)

start "" /D "%rustServerPath%" RustDedicated.exe -batchmode ^
+server.port %rustServerPort% ^
+server.level %rustServerLevel% ^
+server.seed %rustServerSeed% ^
+server.worldsize %rustServerSize% ^
+server.maxplayers %rustServerMaxPlayers% ^
+server.hostname %rustServerHostName% ^
+server.description %rustServerDescription% ^
+server.url %rustServerUrl% ^
+server.headerimage %rustServerHeaderImage% ^
+server.identity %rustServerIdentity% ^
+rcon.port %rustServerRconPort% ^
+rcon.password %rustServerRconPassword% ^
+rcon.web 1 ^
-logfile "%rustServerPath%\logs\%rustServerLogfile%_%myDate%.log"