#!/bin/sh
echo ""
echo "Running Discord-Bot with auto restart normally! (without updating)"
root=$(pwd)
youtube-dl -U

sleep 5s
cd "$root/Discord-Bot"
dotnet restore && dotnet build -c Release

while :; do cd "$root/Discord-Bot/src/NadekoBot" && dotnet run -c Release && youtube-dl -U; sleep 5s; done
echo ""
echo "That didn't work? Please report in #NadekoLog Discord Server."
sleep 3s

cd "$root"
bash "$root/linuxAIO.sh"
echo "Done"

exit 0
