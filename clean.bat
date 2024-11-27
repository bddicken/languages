@rem Run this script if you're using windows.

setlocal
@echo off

if exist "c\code" del "c\code"
if exist "go\code" del "go\code"
if exist "jvm\code.class" del "jvm\code.class"
if exist "rust\target" rmdir /s /q "rust\target"
if exist "kotlin\code.jar" del /f /q "kotlin\code.jar"
if exist "dart\code" del "dart\code"

endlocal
@rem End of line.
@rem DO NOT WRITE BEYOND HERE.