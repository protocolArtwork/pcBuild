#!/bin/sh

# Get the location of this script
script_dir="$(dirname "$(realpath "$0")")"

# If no lua is defined, use the one defined by luarocks
if [ -z "$LUA" ]; then
    LUA="$script_dir/lua"
fi

# Get the CPATH and PATH for project-local lua_modules rocktree
LUA_PATH_EXT="$script_dir/lua_modules/share/lua/5.1/?.lua"
LUA_CPATH_EXT="$script_dir/lua_modules/lib/lua/5.1/?.so"

# Add project-local lua_modules rocktree to package path & cpath
lua_code_cpath="package.cpath = package.cpath..';$LUA_CPATH_EXT'"
lua_code_path="package.path = package.path..';$LUA_PATH_EXT'"

# Run main.lua, prefixed with path changes, passing all arguments to this script
exec $LUA -e "$lua_code_path" -e "$lua_code_cpath" "$script_dir/lua_modules/share/lua/5.1/main.lua" "$@"
