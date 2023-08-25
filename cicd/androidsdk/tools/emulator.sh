#!/bin/bash

cd $ANDROID_HOME

echo "*** Install Android Emulator ***"
if [ "$TARGETARCH" = "arm64" ]; then
  apt-get install -y libc6-amd64-cross libgcc1-amd64-cross
  ln -s /usr/x86_64-linux-gnu/lib64/ /lib64
  # This is link download emulator for Mac Apple Silicon
  wget -q https://redirector.gvt1.com/edgedl/android/repository/emulator-darwin_aarch64-8420304.zip -O emulator-linux.zip
  unzip emulator-linux.zip
  rm emulator-linux.zip
else
  sdkmanager "emulator"
fi

mv /opt/license/package.xml $ANDROID_HOME/emulator