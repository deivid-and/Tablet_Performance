@echo off
echo Disabling Bixby agent...
.\adb\adb.exe shell pm disable-user --user 0 com.samsung.android.bixby.agent
if %errorlevel% neq 0 (
    echo Error: Disabling Bixby agent failed or not found.
) else (
    echo Success: Disabling Bixby agent.
)
