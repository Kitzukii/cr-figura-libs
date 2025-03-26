@echo off
SET "REPO_URL=https://github.com/Kitzukii/cr-figura-libs.git"
SET "FOLDER_PATH=LiminalIntegration"
SET "TARGET_DIR=%cd%\%FOLDER_PATH%"

REM Check if the LiminalIntegration folder exists and delete it
IF EXIST "%TARGET_DIR%" (
    echo Deleting existing folder: %TARGET_DIR%
    rmdir /s /q "%TARGET_DIR%"
)

REM Clone the repository, make a temp repo and take the folder to the avatar, then delete the temp repo
git clone --depth 1 --filter=blob:none --sparse "%REPO_URL%" temp_repo
cd temp_repo
git sparse-checkout set "%FOLDER_PATH%"
move "%FOLDER_PATH%" "%TARGET_DIR%"
cd ..
rmdir /s /q temp_repo

REM Finished.
echo Folder downloaded to %TARGET_DIR%
pause
