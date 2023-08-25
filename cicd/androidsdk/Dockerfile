FROM ubuntu:20.04

ARG TARGETARCH

USER root

# Install Android SDK
ENV ANDROID_HOME      /opt/android-sdk-linux

ENV PATH "${PATH}:${ANDROID_HOME}/cmdline-tools/tools/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/tools/bin"
ENV PATH "${PATH}:${ANDROID_HOME}/build-tools/30.0.3"
ENV PATH "${PATH}:${ANDROID_HOME}/platform-tools"
ENV PATH "${PATH}:${ANDROID_HOME}/emulator"
ENV PATH "${PATH}:${ANDROID_HOME}/bin"

RUN apt-get update \
 && apt-get install -y openjdk-11-jdk wget unzip \
 && apt-get clean

COPY tools /opt/tools
COPY license /opt/license
RUN chmod +x /opt/tools/*.sh

# Install Android Commandline-Tools
RUN /opt/tools/commandline_tools.sh

# Install Android SDK Platform 33
RUN sdkmanager "platforms;android-33"

# Install Android Emulator
RUN /opt/tools/emulator.sh
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib64:/usr/x86_64-linux-gnu/lib"

# Install Android SDK Build-Tools
RUN sdkmanager "build-tools;30.0.3"


# Install gradle
ENV GRADLE_HOME     /opt/gradle
ARG GRADLE_VERSION=7.5.1

ENV PATH "${PATH}:${GRADLE_HOME}/bin"

RUN wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O gradle.zip \
 && unzip gradle.zip \
 && rm gradle.zip \
 && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/"