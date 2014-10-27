@ECHO OFF
:: ###########################################################################
:: -- Prepare the Command Processor --
SETLOCAL EnableExtensions
SETLOCAL EnableDelayedExpansion

:: ###########################################################
:: -- Version History --
::          X.Y.Z_YYYYMMDD-hhmm Author Description
SET version=1.1.0._20140410-0700 &: pk new java version and adding Daimler ProxySettings
::SET version=1.0.2_20130716-1200 &: pk updated workspace location and introduced java version placeholder
::SET version=1.0.1_20130715-1500 &: Christian Fein changed java to jdk 1.7.21 for 64bit Win
::SET version=1.0.1_20130221-1400 &: Peter Kirschner   fixed missing JAVA_PATH output in echo statement
::SET version=1.0.0_20130206-0900 &: Peter Kirschner   fixed bug in @ECHO OFF statement
::SET version=1.0.0_20130108-1300 &: Peter Kirschner   adding fixed relative JVM 
::SET version=1.0.0_20121121-1000 &: Peter Kirschner   initial version of the script
:: !! For a new version entry, copy the last entry down and modify Date, Author and Description
SET version=%version: =%

:: ###########################################################
:: set the title of the window
SET title=%~nx0 - version %version%
TITLE %title%
SET SCRIPTNAME=%~n0
SET SCRIPT_PATH=%~dp0
SET SCRIPT_PATH=%SCRIPT_PATH:~0,-1%

ECHO.
ECHO ================================================================================
ECHO === IDEfix launch script                                                     ===
ECHO ================================================================================
ECHO.
ECHO.

:: evaluate the drive the script is stored
SET DRIVE=%~d0
SET LOCATION=%SCRIPT_PATH%
SET WIN_LOCATION=%SCRIPT_PATH%

ECHO running on 64 Bit Operating System
SET  OS64=TRUE
SET  "JAVA_PATH=___JAVAPATH___"
SET  JAVA_XMS=512m
SET  JAVA_XMX=2028m

:: ########################################################################
:: ########################################################################
:: DON'T CHANGE BELOW THIS
:: ########################################################################
:: ########################################################################

ECHO ################################################################################ 
ECHO Following locations are used
ECHO.
:: eclipse installation location (based on the first segment of the filename of this script)
FOR /F "tokens=2 delims=#" %%Q IN ("%SCRIPTNAME%") DO (SET ECL_INSTALL_NAME=%%Q)
SET "ECL_INSTALL_PATH=%WIN_LOCATION%\%ECL_INSTALL_NAME%"
ECHO Eclipse install   location "%ECL_INSTALL_PATH%"

FOR /F "tokens=3 delims=#" %%P IN ("%SCRIPTNAME%") DO (SET WRK_SPACE_NAME=%%P)
SET "ECL_RUNTIME_PATH=%WIN_LOCATION%\wrk\%WRK_SPACE_NAME%"

:: eclipse configuration location 
SET "ECL_CONFIG_PATH=%ECL_RUNTIME_PATH%\config"
ECHO config    location "%ECL_CONFIG_PATH%"
MKDIR %ECL_WRKSPC_PATH% 2> NUL 

:: eclipse workspace location (based on the 3 segment of the filename of this script) 
SET ECL_WRKSPC_PATH=%ECL_RUNTIME_PATH%\data
ECHO workspace location "%ECL_WRKSPC_PATH%"
MKDIR %ECL_WRKSPC_PATH% 2> NUL 

:: eclipse user home and keyring location 
SET "ECL_KEYRING=%ECL_RUNTIME_PATH%\.eclipse"
ECHO keyring   location "%ECL_KEYRING%"
MKDIR %ECL_KEYRING% 2> NUL 

SET "ECL_USER=%ECL_RUNTIME_PATH%\.user"
ECHO user      location "%ECL_USER%"
MKDIR %ECL_USER% 2> NUL 



:: ########################################################################
:: proxy setting - for bundles which are not NTLM v2 capable or do not use eclipse proxy settings
:: ########################################################################
SET http_proxy=localhost:5865
SET https_proxy=localhost:5865

:: ########################################################################
:: eclipse launch
:: ########################################################################
:: set the log file name with the ISO date as prefix
FOR /f "tokens=1,2,3 delims=. " %%i in ('date /t') do set date=%%k%%j%%i
FOR /f "tokens=1" %%u in ('time /t') do set t=%%u
IF "%t:~1,1%"==":" set t=0%t%
SET datetime=%date%-%t:~0,2%%t:~3,2%

ECHO ================================================================================
ECHO === starting eclipse with following command at %datetime%
ECHO.  
ECHO START %ECL_INSTALL_PATH%\eclipse.exe ^^
ECHO -configuration %ECL_CONFIG_PATH% ^^
ECHO -data %ECL_WRKSPC_PATH% ^^
ECHO -eclipse.keyring %ECL_KEYRING%\secure_storage ^^
ECHO -vm "%JAVA_PATH%\bin" ^^
ECHO -user %ECL_USER% ^^
ECHO -vmargs ^^
ECHO -Duser.home=%ECL_USER% ^^
ECHO -Xms%JAVA_XMS% ^^
ECHO -Xmx%JAVA_XMX%
ECHO.  
START %ECL_INSTALL_PATH%\eclipse.exe ^
-configuration %ECL_CONFIG_PATH% ^
-data %ECL_WRKSPC_PATH% ^
-eclipse.keyring %ECL_KEYRING%\secure_storage ^
-vm "%JAVA_PATH%\bin" ^
-user %ECL_USER% ^
-vmargs ^
-Duser.home=%ECL_USER% ^
-Xms%JAVA_XMS% ^
-Xmx%JAVA_XMX%

ECHO.   
ECHO ================================================================================
ECHO.
ECHO.
ECHO Please be patient eclipse is starting ... (this window is self-destroying automatically ;)
ECHO.
ECHO.
ECHO ================================================================================

FOR /l %%a in (10,-1,1) do (TITLE %title% -- closing in %%as&ping -n 2 -w 1 127.0.0.1>NUL)
TITLE Press any key to close the application&ECHO.&GOTO:EOF


:EOF
