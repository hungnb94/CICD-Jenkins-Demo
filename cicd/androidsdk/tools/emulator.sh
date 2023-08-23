#!/bin/bash

cd $ANDROID_HOME

echo "Download emulator manually"
# This is link download emulator for Mac Apple Silicon
wget -q https://redirector.gvt1.com/edgedl/android/repository/emulator-darwin_aarch64-8420304.zip -O emulator-linux.zip
unzip emulator-linux.zip
rm emulator-linux.zip

mv /opt/license/package.xml $ANDROID_HOME/emulator