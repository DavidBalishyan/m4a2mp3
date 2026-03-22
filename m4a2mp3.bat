@echo off
setlocal enabledelayedexpansion

rem Defaults
set "INPUT=."
set "OUTPUT=mp3"
set "QUALITY=2"
set "VERBOSE=0"

:parse
if "%~1"=="" goto after_parse

if /I "%~1"=="-i" (
  set "INPUT=%~2"
  shift & shift
  goto parse
)
if /I "%~1"=="--input" (
  set "INPUT=%~2"
  shift & shift
  goto parse
)

if /I "%~1"=="-o" (
  set "OUTPUT=%~2"
  shift & shift
  goto parse
)
if /I "%~1"=="--output" (
  set "OUTPUT=%~2"
  shift & shift
  goto parse
)

if /I "%~1"=="-q" (
  set "QUALITY=%~2"
  shift & shift
  goto parse
)
if /I "%~1"=="--quality" (
  set "QUALITY=%~2"
  shift & shift
  goto parse
)

if /I "%~1"=="-v" (
  set "VERBOSE=1"
  shift
  goto parse
)
if /I "%~1"=="--verbose" (
  set "VERBOSE=1"
  shift
  goto parse
)

if /I "%~1"=="-h" goto help
if /I "%~1"=="--help" goto help

 echo Unknown option: %~1
 goto help

:after_parse

rem Check ffmpeg
where ffmpeg >nul 2>nul
if errorlevel 1 (
  echo Error: ffmpeg is not installed or not in PATH
  exit /b 1
)

if not exist "%OUTPUT%" mkdir "%OUTPUT%"

for %%f in ("%INPUT%\*.m4a") do (
  echo Converting %%f
  if "%VERBOSE%"=="1" (
    ffmpeg -i "%%f" -vn -q:a %QUALITY% "%OUTPUT%\%%~nf.mp3"
  ) else (
    ffmpeg -loglevel error -i "%%f" -vn -q:a %QUALITY% "%OUTPUT%\%%~nf.mp3"
  )
)

echo Done
exit /b 0

:help
 echo Usage: m4a2mp3 [options]
 echo.
 echo Options:
 echo   -i, --input DIR      Input directory (default: current directory)
 echo   -o, --output DIR     Output directory (default: mp3)
 echo   -q, --quality N      MP3 quality (0 = best, 9 = worst, default: 2)
 echo   -v, --verbose        Enable verbose output
 echo   -h, --help           Show this help message
 exit /b 0