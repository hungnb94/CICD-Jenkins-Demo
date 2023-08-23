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

chmod -R 777 $ANDROID_HOME