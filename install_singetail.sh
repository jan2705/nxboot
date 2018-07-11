#!/bin/sh
set -e
set -o pipefail

device=singetail

echo Building...
./build.sh
version=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" MobileFuseeLauncher/Info.plist)
archivedest=

echo Cleaning...
ssh root@$device rm -rf /jb/bin/nxboot /Applications/NXBoot.app
ssh root@$device killall NXBoot || true

echo Installing nxboot command-line tool...
scp nxboot root@$device:/jb/bin/nxboot

echo Installing iOS application $version via dpkg...
debname=com.mologie.NXBoot-$version.deb
scp dist/$debname root@$device:/tmp/$debname
ssh root@$device dpkg -i /tmp/$debname

echo Done! You may want to run uicache on $device.