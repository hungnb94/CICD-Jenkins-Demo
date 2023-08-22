FROM --platform=linux/amd64 ubuntu:20.04

USER root

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
RUN chmod +x /opt/tools/*.sh

RUN /opt/tools/android_sdk.sh

# RUN /opt/tools/entrypoint.sh built-in
