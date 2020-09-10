#!/bin/sh
echo ""
echo "Running Discord-Bot with auto restart and updating to latest build!"
root=$(pwd)
youtube-dl -U

sleep 5s
while :; do cd "$root/Discord-Bot" && dotnet restore && dotnet build -c Release && cd "$root/Discord-Bot/src/Discord-Bot" && dotnet run -c Release && youtube-dl -U && cd "$root" && wget -N https://github.com/rd184/DiscordBot-BashScript/raw/1.9/nadeko_installer_latest.sh && bash "$root/nadeko_installer_latest.sh"; sleep 5s; done
echo ""
echo "That didn't work? Please report in #NadekoLog Discord Server."
sleep 3s

cd "$root"
bash "$root/linuxAIO.sh"
echo "Done"

rm "$root/NadekoARU_Latest.sh"
exit 0
