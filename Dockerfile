#Download base image ubuntu 20.04
################################################################################
#                                    LAYER 1                                   #
################################################################################
FROM ubuntu:25.04

# LABEL about the custom image
# ARG BUNDLE_DATE="2022-09-29"
ARG DOCKER_TAG
ENV UNAMEM="x86_64"
ENV UNAMES=linux
ENV ARCH="amd64"
ENV OS_NAME="linux"
ENV DOCKER_TAG="${DOCKER_TAG}"
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="${DOCKER_TAG}"
LABEL description="This is custom Docker Image for basic concourse services"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
# ARG ARCH=amd64
# ARG OS_NAME=`uname -s | tr '[:upper:]' '[:lower:]'`
# ARG OS_NAME=linux
################################################################################
#                                    LAYER 2                                   #
################################################################################
# Update Ubuntu Software repository
RUN apt update --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && apt upgrade --assume-yes \
    && apt clean