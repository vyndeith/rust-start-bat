# RUST game start script
Its basically just a script that automatically indexes the Rust EAC launcher (Rust.exe, not RustClient.exe). It also starts it with some opti args.
# Arguments used here
  Disable player eyes actions, playerculling (Rendering players always, even when theyre not visible), headlerp 5 (not insta, but still fast), disabling legs, gibs, and decal. Forcing Occlusion Culling.

# Work with threads
  Value in global.maxthreads u need calculate that: ur CPU threads - 2. E.g my process has 12 threads, 12-2 = 10. 7800X3D = 14
