@echo off
SET "REPO_URL=https://github.com/Kitzukii/cr-figura-libs.git"
SET "TARGET_DIR=%cd%\LiminalIntegration"
SET "TEMP_DIR=temp_repo"

REM Check if the target folder exists and delete it
IF EXIST "%TARGET_DIR%" (
    echo Deleting existing folder: %TARGET_DIR%
    rmdir /s /q "%TARGET_DIR%"
)

REM Check if temp_repo exists and delete it
IF EXIST "%TEMP_DIR%" (
    echo Deleting existing temp directory: %TEMP_DIR%
    rmdir /s /q "%TEMP_DIR%"
)

REM Clone the repository
git clone --depth 1 --filter=blob:none --sparse "%REPO_URL%" "%TEMP_DIR%"
cd "%TEMP_DIR%"
git sparse-checkout set "LiminalIntegration"

REM Move the LiminalIntegration folder to the target directory
move "LiminalIntegration" "%TARGET_DIR%"

)

cd ..
rmdir /s /q "%TEMP_DIR%"

REM Finished.
echo files downloaded to %TARGET_DIR%, Temp repo created and deleted, LI updated.
pause
