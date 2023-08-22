#!/bin/bash

mkdir -p $ANDROID_HOME
cd $ANDROID_HOME


echo "Bootstrapping SDK-Tools"
wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O commandlinetools-linux.zip
unzip commandlinetools-linux.zip
mv cmdline-tools tools
mkdir cmdline-tools
mv tools cmdline-tools/tools
rm commandlinetools-linux.zip

echo "*** Automatically accept all SDK licences ***"
yes | sdkmanager --licenses

echo "*** Install build tools 30.0.3 ***"
sdkmanager "platforms;android-30"
sdkmanager --install "build-tools;30.0.3"

chmod -R 777 $ANDROID_HOME