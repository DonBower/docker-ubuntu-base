#Download base image ubuntu 20.04
################################################################################
#                                    LAYER 1                                   #
################################################################################
FROM ubuntu:20.04

# LABEL about the custom image
# ARG BUNDLE_DATE="2022-09-29"
ARG DOCKER_TAG
ARG ARM_SUBSCRIPTION_ID
ARG ARM_CLIENT_ID
ARG ARM_TENANT_ID
ARG ARM_CLIENT_SECRET
ENV UNAMEM="x86_64"
ENV UNAMES=linux
ENV ARCH="amd64"
ENV OS_NAME="linux"
ENV DOCKER_TAG="${DOCKER_TAG}"
ENV AWS_PAGER=''
ENV ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID}
ENV ARM_CLIENT_ID=${ARM_CLIENT_ID}
ENV ARM_TENANT_ID=${ARM_TENANT_ID}
ENV ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}
LABEL maintainer="Don.Bower@outlook.com"
LABEL version="${DOCKER_TF_BUNDLE}"
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
COPY files/aptPackages.txt aptPackages.txt
RUN apt update --assume-yes \
    && apt install \
          --assume-yes \
          --install-recommends \
          $(cat aptPackages.txt) \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/* \
    && apt upgrade \
          --assume-yes \
    && apt clean
################################################################################
#                                    LAYER 3                                   #
################################################################################
COPY files/pipPackages.txt pipPackages.txt
RUN pip install $(cat pipPackages.txt)
################################################################################
#                                    LAYER 4                                   #
################################################################################
RUN wget https://awscli.amazonaws.com/awscli-exe-${OS_NAME}-${UNAMEM}.zip \
    && unzip awscli-exe-${OS_NAME}-${UNAMEM}.zip \
    && ./aws/install \
    && rm awscli-exe-${OS_NAME}-${UNAMEM}.zip
