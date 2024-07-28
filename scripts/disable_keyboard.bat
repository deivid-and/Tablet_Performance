echo Disabling virtual keyboard for external keyboard use...
.\adb\adb.exe shell settings put secure show_ime_with_hard_keyboard 0
if %errorlevel% neq 0 (echo Error: Disabling show_ime_with_hard_keyboard failed.) else (echo Success: Disabling show_ime_with_hard_keyboard.)
.\adb\adb.exe shell settings put secure disable_virtual_keyboard_if_hard_keyboard 1
if %errorlevel% neq 0 (echo Error: Disabling virtual keyboard failed.) else (echo Success: Disabling virtual keyboard.)