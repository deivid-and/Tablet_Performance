@echo off
echo Setting CPU governor to performance...
.\adb\adb.exe shell "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
.\adb\adb.exe shell "echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor"
.\adb\adb.exe shell "echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor"
.\adb\adb.exe shell "echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor"
echo CPU governor set to performance mode.
