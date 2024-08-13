@echo off
echo Clearing all app caches using 'pm trim-caches'...

:: Clear all caches on the device
.\adb\adb.exe shell pm trim-caches 100M

:: Verify cache clearing
.\adb\adb.exe shell df /data

echo All caches cleared.
