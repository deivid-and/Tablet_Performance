@echo off
echo Setting CPU governor to balanced mode...
.\adb\adb.exe shell "echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
echo CPU governor set to balanced mode.
