del /s /q Source\*.dcu
del /s /q Source\*.exe
del /s /q Source\*.res
del /s /q Source\*.rsm
del /s /q Source\*.log
del /s /q Source\*.dsk
del /s /q Source\*.identcache
del /s /q Source\*.stat
del /s /q Source\*.local
del /s /q Source\*.~*

rmdir Win32\Debug
rmdir Win32
rmdir Win64\Debug
rmdir Win64
rmdir Source\Win32\Release
rmdir Source\Win32
rmdir Source\Win64\Release
rmdir Source\Win64
rmdir __history
rmdir __recovery