@echo off
echo Disabling Samsung Notes...
.\adb\adb.exe shell pm disable-user --user 0 com.samsung.android.app.notes
if %errorlevel% neq 0 (
    echo Error: Disabling Samsung Notes failed or not found.
) else (
    echo Success: Disabling Samsung Notes.
)
