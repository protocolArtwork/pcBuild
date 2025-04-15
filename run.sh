if [ -z "$LUA" ]; then
	LUA="./lua"
fi

command="$LUA -l lpath ./lua_modules/share/lua/5.1/main.lua $@"
echo $command
$command
