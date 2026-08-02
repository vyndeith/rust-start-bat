:: MADE BY VYN
:: автоматический поиск лаунчера раста
::================================
@echo off
setlocal enabledelayedexpansion

for /f "skip=2 tokens=2,*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM=%%b"
set "STEAM=%STEAM:/=\%"

for /f %%C in ('powershell -command "(Get-WmiObject Win32_ComputerSystem).NumberOfLogicalProcessors"') do set "LOGICAL=%%C"
set /a MAXTHREADS=%LOGICAL% - 2

set "RUST="

for /f tokens^=2^,4^ delims^=^" %%a in ('type "%STEAM%\steamapps\libraryfolders.vdf" ^| findstr /i "path"') do (
  if /i "%%a"=="path" (
    set "libpath=%%b"
    set "libpath=!libpath:/=\!"
    if exist "!libpath!\steamapps\common\Rust\Rust.exe" set "RUST=!libpath!\steamapps\common\Rust\Rust.exe"
  )
)
::================================
if defined RUST (
  start "" "%RUST%" ^
  -steam ^
  -client.headlerp 5 ^
  -gc.incremental_milliseconds 1 ^
  -texture.memory_vram_factor 2 ^
  -graphics.maxqueuedframes 0 ^
  -global.maxthreads %MAXTHREADS% ^
  -grass.maxthreads 1 ^
  -grass.refresh_budget 0.1 ^
  -shadowcaching.enabled 0 ^
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
  -ai.maxgroundaligndist 1 ^
  -npcwalkanimation.framebudgetms 0 ^
  -playercull.enabled 1 ^
  -culling.toggle 1 ^
  -culling.entitymaxdist 350 ^
  -culling.entityupdaterate 3 ^
  -culling.entityminshadowculldist 2 ^
  -culling.envmindist 5 ^
  -render.building_blocked_preview_distance 50 ^
  -nobuildzonematerialcontroller.setstrengthday 0 ^
  -nobuildzonematerialcontroller.setstrengthnight 0 ^
  -nobuildzonematerialcontroller.setheight 10 ^
  -graphics.branding 0 ^
  -console.erroroverlay 0 ^
  -gametip.showgametips 0 ^
  -client.cached_browser_parallel 0 ^
  -signage.texturerequestdistance 20 ^
  -instruments.processsustainpedal 0
) else (
  echo Rust.exe not found
  pause
)
