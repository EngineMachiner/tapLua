[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W32691S)

# tapLua

**tapLua** is a **Lua scripting** library for **[StepMania](https://github.com/stepmania/stepmania) and [OutFox](https://github.com/TeamRizu/OutFox)** developers.
It features functions for actors, colors, file management, vectors and object type checking. It also includes [**Astro**](https://github.com/EngineMachiner/Astro) and some sprite actors.

tapLua focuses to be compatible with newer game builds, so it may not be compatible with older versions.

It is also used in some of my other StepMania projects.

## Usage

### OutFox

  1. Clone in fallback's Modules folder.
  2. Load it using `LoadModule("tapLua/tapLua.lua")` once. This could be done through a script that runs once.

### Legacy

  1. Create a Modules folder in the game's root folder and clone the repository in it.
  2. Create or load tapLua through a script.
  3. Make sure the `package.path` for Lua modules includes the `./?/init.lua` path for that game version or else add it.
  4. Load tapLua through `dofile("Modules/tapLua/tapLua.lua")`.

  Example:
  ```lua
  -- Script in /Scripts/ to run once.

  package.path = package.path .. ";./?/init.lua" -- Doesn't include the path.

  dofile("Modules/tapLua/tapLua.lua")
  ```

