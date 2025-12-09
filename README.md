[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/W7W32691S)

# tapLua

**tapLua** is a **Lua scripting** library for **[StepMania 5](https://github.com/stepmania/stepmania) and [OutFox](https://github.com/TeamRizu/OutFox)** developers.
It features functions for actors, colors, file management, vectors and object type checking. It also includes [**Astro**](https://github.com/EngineMachiner/Astro) and some sprite actors.

tapLua focuses to be compatible with newer game builds, so it may not be compatible with older versions.

It is also used in some of my other StepMania 5 projects.

## Installation

### Linux

  1. Run the next commands in the game directory:
  ```console
  curl -o tapLua.sh https://raw.githubusercontent.com/EngineMachiner/tapLua/refs/heads/master/tapLua.sh
  ./tapLua.sh; rm tapLua.sh
  ```

---

Or it can be installed manually:

Be aware that to successfully add the actors, it's important that you have a basic understanding of **scripting and theme structure**.

### OutFox

  1. Clone in fallback's modules folder.
  2. Load it using `LoadModule("tapLua/tapLua.lua")` in a script that runs once in fallback's Script folder.

### Legacy

  1. Clone the repository in `./Modules`.
  2. Load tapLua using `dofile("Modules/tapLua/tapLua.lua")` in a script that runs once in fallback's Script folder and make sure the `package.path` for Lua modules includes the `./?/init.lua` path for that game version.
  ```lua
  -- A script in fallback's Scripts folder to run once.

  package.path = package.path .. ";./?/init.lua"

  dofile("Modules/tapLua/tapLua.lua")
  ```

---

  3. Add the persistent actors as children of _fallback's ScreenSystemLayer:
  ```lua
  return tapLua.PersistentActors -- fallbacks's ScreenSystemLayer aux.lua
  ```

Remember, if the theme overrides the ScreenSystemLayer you have to add the children there as well.