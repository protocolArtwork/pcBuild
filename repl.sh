LUA="./lua"

if [ -n "$1" ]; then
	LUA=$1
fi

command="$LUA -l lpath -e require'luarocks.loader' -i"
echo $command
$command
