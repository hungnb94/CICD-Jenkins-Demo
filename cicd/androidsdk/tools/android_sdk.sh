#!/bin/bash

mkdir -p $ANDROID_HOME
cd $ANDROID_HOME


echo "*** Install Android SDK Command-line Tools ***"
wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandlinetools-linux.zip
unzip commandlinetools-linux.zip
mv cmdline-tools tools
mkdir cmdline-tools
mv tools cmdline-tools/tools
rm commandlinetools-linux.zip

echo "*** Automatically accept all SDK licences ***"
yes | sdkmanager --licenses

echo "*** Install Android SDK Platform 33 ***"
sdkmanager --list | grep "build-tools"
sdkmanager "platforms;android-33"

echo "*** Install Android Emulator ***"
if [ "$TARGETARCH" = "arm64" ]; then
  echo "Install Android Emulator Manually because run on MacOS"
  source /opt/tools/emulator.sh
else
  echo "Install Android Emulator Automatically"
  sdkmanager "emulator"
fi

echo "*** Install Android SDK Build-Tools ***"
sdkmanager "build-tools;30.0.3"

chmod -R 777 $ANDROID_HOME