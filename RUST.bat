:: MADE BY VYN
:: автоматический поиск лаунчера раста
:: indexing rust launcher
::================================
@echo off
setlocal enabledelayedexpansion

for /f "skip=2 tokens=2,*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM=%%b"
set "STEAM=%STEAM:/=\%"

set "RUST="

for /f "tokens=*" %%L in ('type "%STEAM%\steamapps\libraryfolders.vdf" ^| findstr "path"') do (
    set "line=%%L"
    set "line=!line:"=!"
    for %%P in (!line!) do (
        if exist "%%P\steamapps\common\Rust\Rust.exe" set "RUST=%%P\steamapps\common\Rust\Rust.exe"
    )
)
::================================
:: запуск самого лаунчера
:: launcher starting
if defined RUST (
    start "" "%RUST%" ^
        -steam ^
        -high ^
        -gc.incremental_enabled 5 ^
        -graphics.branding 0 ^
        -headlerp 5 ^
        -decal.capacity 0 ^
        -decal.limit 0 ^
        -decal.instancing 0 ^
        -effects.maxgibs 0 ^
        -player.cold_breath 0 ^
        -player.eye_blinking 0 ^
        -player.eye_movement 0 ^
        -legs.enablelegs 0 ^
        -playercull.enabled 0 ^
        -culling.toggle 1
) else (
    echo Rust.exe not found
    pause
)
