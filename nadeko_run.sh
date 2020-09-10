#!/bin/sh
echo ""
echo "Discord-Bot 1.9+"
echo "Mirai was here."
root=$(pwd)
youtube-dl -U

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi
cd "$root/Discord-Bot"
dotnet restore
dotnet build -c Release
cd "$root/Discord-Bot/src/NadekoBot"
echo "Running Discord-Bot. Please wait."
dotnet run -c Release
echo "Done"

cd "$root"
rm "$root/nadeko_run.sh"
exit 0
