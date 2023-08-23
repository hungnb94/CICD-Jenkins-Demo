FROM ubuntu:20.04

ARG TARGETPLATFORM
RUN echo "I'm building for $TARGETPLATFORM"
ARG TARGETARCH
RUN echo "Target arch is: $TARGETARCH"

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
COPY license /opt/license
RUN chmod +x /opt/tools/*.sh

RUN /opt/tools/android_sdk.sh