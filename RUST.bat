:: MADE BY VYN
:: автоматический поиск лаунчера раста
:: indexing rust launcher
::================================
@echo off
setlocal enabledelayedexpansion

for /f "skip=2 tokens=2,*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM=%%b"
set "STEAM=%STEAM:/=\%"

:: thread calculation
for /f %%C in ('powershell -command "(Get-WmiObject Win32_ComputerSystem).NumberOfLogicalProcessors"') do set "LOGICAL=%%C"
for /f %%C in ('powershell -command "(Get-WmiObject Win32_Processor | Select -First 1).NumberOfCores"') do set "PHYSICAL=%%C"
set /a MAXTHREADS=%LOGICAL% - 2
set /a JOB_WORKERS=%PHYSICAL% - 2
set /a GC_HELPERS=%PHYSICAL% - 1
set /a PSO_JOBS=%PHYSICAL% / 2

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

        -gc.incremental_milliseconds 1 ^
        -texture.memory_vram_factor 2 ^
        -ai.maxgroundaligndist 1 ^
        -instruments.processsustainpedal 0 ^

        -global.maxthreads %MAXTHREADS% ^
        -job-worker-count %JOB_WORKERS% ^
        -gc-helper-count %GC_HELPERS% ^
        -max-async-pso-job-count %PSO_JOBS% ^
        -grass.maxthreads 0 ^
        -graphics.branding 0 ^
        -headlerp 5 ^

        -decal.capacity 0 ^
        -decal.limit 8 ^
        -decal.cache 0 ^
        -decal.instancing 1 ^
        -effects.maxgibs 0 ^
        -effects.maxgibdist 0 ^
        -effects.maxgiblife 0 ^
        -player.cold_breath 0 ^
        -player.eye_blinking 0 ^
        -player.eye_movement 0 ^
        -legs.enablelegs 0 ^
        -particle.ik 0 ^

        -playercull.enabled 0 ^
        -culling.toggle 1 ^
        -culling.entitymaxdist 350 ^
        -culling.entityupdaterate 3 ^
        -culling.entityminshadowculldist 2 ^
        -culling.envmindist 5 
        -console.erroroverlay 0 ^
        -gametip.showgametips 0 ^

        -render.building_blocked_preview_distance 50 ^
	    -nobuildzonematerialcontroller.setstrengthday 0 ^
	    -nobuildzonematerialcontroller.setstrengthnight 0 ^
	    -nobuildzonematerialcontroller.setheight 10 ^

        -audio.framebudget 0.2 ^
        -audio.minupdatefraction 0.05 ^
        -graphics.maxqueuedframes 0 ^
        -grass.refresh_budget 0.1 ^
        -npcwalkanimation.framebudgetms 0 ^
        -signage.texturerequestdistance 20 
) else (
    echo Rust.exe not found
    pause
)
