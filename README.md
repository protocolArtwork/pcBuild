# pcBuild

pcBuild is the build system for pcOS. It is intended for use with GCC & GNU Assembler.

# Build Instructions

## Prerequisites

Make sure you have the following installed on your system:

- [Lua](https://www.lua.org/)
- [LuaRocks](https://luarocks.org/)

## Steps

1. Clone this repository:
```bash
git clone https://www.github.com/protocolArtwork/pcBuild.git pcBuild
```
2. Initialize project
```bash
cd pcBuild
luarocks init
```
3. Install dependencies into project rocktree
```bash
luarocks build --local --tree=./lua_modules
```

To run the project, use the helper shell script `./run.sh` to set the CPATH and PATH for the local rocktree & run main.lua.
