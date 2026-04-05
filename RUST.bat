:: MADE BY VYN
:: автоматический поиск лаунчера раста
:: indexing rust launcher
::================================
@echo off
setlocal enabledelayedexpansion

for /f "skip=2 tokens=2,*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM=%%b"
set "STEAM=%STEAM:/=\%"

set "RUST="

for /f tokens^=2^,4^ delims^=^" %%a in ('type "%STEAM%\steamapps\libraryfolders.vdf" ^| findstr /i "path"') do (
    if /i "%%a"=="path" (
        set "libpath=%%b"
        set "libpath=!libpath:/=\!"
        if exist "!libpath!\steamapps\common\Rust\Rust.exe" set "RUST=!libpath!\steamapps\common\Rust\Rust.exe"
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
        -lerp.timeoffsetinterval 4 ^
        -texture.memory_vram_factor 2 ^
        -ai.maxgroundaligndist 1 ^
        -instruments.processsustainpedal 0 ^

        -global.maxthreads 14 ^
        -grass.maxthreads 2 ^
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
        -particle.ik 0 ^

        -playercull.enabled 0 ^
        -culling.toggle 1 ^
        -console.erroroverlay 0 ^
        -gametip.showgametips 0 ^

        -client.prioritize_premium_servers 0 ^
        -client.cached_browser_parallel 1 
) else (
    echo Rust.exe not found
    pause
)
