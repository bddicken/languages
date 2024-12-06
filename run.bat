@rem Run this script if you're using windows.

@echo off

setlocal enabledelayedexpansion

@rem Function to run a command and measure execution time
:runOnce
set "cmd=%~2"
(for /f "tokens=1,2 delims=," %%A in ('powershell -Command "Measure-Command { %cmd% } | Select-Object TotalSeconds"') do @set elapsedTime=%%A) >nul 2>nul
echo %~1 = !elapsedTime!s
goto :eof

@rem Run a command three times and print the execution time
:run
echo.
call :runOnce %~1 %~2
call :runOnce %~1 %~2
call :runOnce %~1 %~2
goto :eof

@rem Run various language implementations
call :run "Kotlin" "java -jar kotlin\code.jar 40"
call :run "C" "c\code 40"
call :run "Go" "go\code 40"
call :run "Rust" "rust\target\release\code 40"
call :run "Node" "node js\code.js 40"
call :run "Bun" "bun js\code.js 40"
call :run "Deno" "deno run js\code.js 40"
call :run "PyPy" "pypy py\code.py 40"
call :run "Java" "java jvm.code 40"
call :run "Ruby" "ruby ruby\code.rb 40"
call :run "PHP" "php php\code.php 40"
call :run "R" "Rscript r\code.R 40"
call :run "Python" "python py\code.py 40"
call :run "Dart" "dart\code 40"

endlocal

@rem End of line.
@rem DO NOT WRITE BEYOND HERE.