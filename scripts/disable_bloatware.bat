@echo off
REM Define ADB path
set ADB_PATH=.\adb\adb.exe

REM Disable unnecessary services
echo Disabling additional bloatware...
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.calendar
%ADB_PATH% shell pm disable-user --user 0 com.sec.android.app.samsungapps
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.app.appsedge
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.mdx
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent
%ADB_PATH% shell pm disable-user --user 0 com.sec.android.widgetapp.webmanual
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.app.routines
%ADB_PATH% shell pm disable-user --user 0 com.google.android.googlequicksearchbox
%ADB_PATH% shell pm disable-user --user 0 com.sec.android.easyMover
%ADB_PATH% shell pm disable-user --user 0 com.android.chrome
%ADB_PATH% shell pm disable-user --user 0 com.microsoft.skydrive
%ADB_PATH% shell pm disable-user --user 0 com.netflix.mediaclient
%ADB_PATH% shell pm disable-user --user 0 com.google.android.youtube
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.knox.containercore
%ADB_PATH% shell pm disable-user --user 0 com.samsung.android.mdx.kit
%ADB_PATH% shell am force-stop com.android.chrome
%ADB_PATH% shell pm disable com.android.chrome/.Main

echo Disabled unnecessary bloatware and stopped Chrome process.
