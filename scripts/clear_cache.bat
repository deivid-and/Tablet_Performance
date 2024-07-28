:: Clear cache
echo Clearing cache for disabled services...
.\adb\adb.exe shell pm clear com.samsung.android.bixby.agent
if %errorlevel% neq 0 (echo Error: Clearing cache for Bixby agent failed or not found.) else (echo Success: Clearing cache for Bixby agent.)
.\adb\adb.exe shell pm clear com.samsung.android.app.notes
if %errorlevel% neq 0 (echo Error: Clearing cache for Samsung Notes failed or not found.) else (echo Success: Clearing cache for Samsung Notes.)