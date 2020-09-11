#!/bin/sh
echo ""
echo "Discord-Bot Installer started."

if hash git 1>/dev/null 2>&1
then
    echo ""
    echo "Git Installed."
else
    echo ""    
    echo "Git is not installed. Please install Git."
    exit 1
fi


if hash dotnet 1>/dev/null 2>&1
then
    echo ""
    echo "Dotnet installed."
else
    echo ""
    echo "Dotnet is not installed. Please install dotnet."
    exit 1
fi

root=$(pwd)
tempdir=NadekoInstall_Temp

rm -r "$tempdir" 1>/dev/null 2>&1
mkdir "$tempdir"
cd "$tempdir"

echo ""
echo "Downloading Discord-Bot, please wait."
git clone -b 1.9 --recursive --depth 1 https://github.com/slimshot/Discord-Bot
echo ""
echo "Discord-Bot downloaded."

echo ""
echo "Downloading Nadeko dependencies"
cd "$root/$tempdir/Discord-Bot"
dotnet restore
echo ""
echo "Download done"

echo ""
echo "Building Discord-Bot"
dotnet build --configuration Release
echo ""
echo "Building done. Moving Nadeko"

cd "$root"

if [ ! -d Discord-Bot ]
then
    mv "$tempdir"/Discord-Bot Discord-Bot
else
    rm -rf Discord-Bot_old 1>/dev/null 2>&1
    mv -fT Discord-Bot Discord-Bot_old 1>/dev/null 2>&1
    mv "$tempdir"/Discord-Bot Discord-Bot
    cp -f "$root/Discord-Bot_old/src/NadekoBot/credentials.json" "$root/Discord-Bot/src/NadekoBot/credentials.json" 1>/dev/null 2>&1
    echo ""
    echo "credentials.json copied to the new version"
    cp -RT "$root/Discord-Bot_old/src/NadekoBot/bin/" "$root/Discord-Bot/src/NadekoBot/bin/" 1>/dev/null 2>&1
    cp -RT "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.0/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.1/data/Discord-Bot.db" 1>/dev/null 2>&1
	cp -RT "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.1/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.1/data/Discord-Bot.db" 1>/dev/null 2>&1
    cp -RT "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.0/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.1/data/Discord-Bot.db" 1>/dev/null 2>&1
    mv -f "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.0/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.0/data/Discord-Bot_old.db" 1>/dev/null 2>&1
	mv -f "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.1/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp1.1/data/Discord-Bot_old.db" 1>/dev/null 2>&1
    mv -f "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.0/data/Discord-Bot.db" "$root/Discord-Bot/src/NadekoBot/bin/Release/netcoreapp2.0/data/Discord-Bot_old.db" 1>/dev/null 2>&1
    echo ""
    echo "Database copied to the new version"
    cp -RT "$root/Discord-Bot_old/src/NadekoBot/data/" "$root/Discord-Bot/src/NadekoBot/data/" 1>/dev/null 2>&1
    echo ""
    echo "Other data copied to the new version"
fi

rm -r "$tempdir"
echo ""
echo "Installation Complete."

cd "$root"
rm "$root/nadeko_installer_latest.sh"
exit 0
