if [ -z "$LUA" ]; then
	LUA="./lua"
fi

command="$LUA -l lpath -e require'luarocks.loader' -i"
echo $command
$command
