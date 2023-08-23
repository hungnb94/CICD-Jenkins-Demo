#!/bin/bash

cd $ANDROID_HOME
#31.2.10
echo "Download emulator manually"
wget -q https://redirector.gvt1.com/edgedl/android/repository/emulator-darwin_aarch64-8420304.zip -O emulator-linux.zip
unzip emulator-linux.zip
rm emulator-linux.zip

mv /opt/license/package.xml $ANDROID_HOME/emulator