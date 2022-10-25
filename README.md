# docker-ubuntu-base
Basic Ubuntu Docker image

[![Repo](https://img.shields.io/static/v1?style=for-the-badge&logo=github&logoColor=white&label=tag&message=0.1.0&color=blue)](https://github.com/DonBower/docker-ubuntu-base)
[![Ubuntu](https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&logoColor=white&label=ubuntu&message=20.04_LTS&color=blue)](https://ubuntu.com/download/server)

# Changelog
- 0.1.0 Initial Release

# Base Image
VERSION="20.04.5 LTS (Focal Fossa)"

# Pacakages
## Cloud Providers
| Cloud       | Version  |
| ----------- | -------- |
|aws-cli|2.8.5|
|azure-cli|2.41.0|

## APT
| Package     | Version  |
| ----------- | -------- |
|ca-certificates|20211016~20.04.1|
|curl|7.68.0-1|
|dnsutils|1:9.16.1-0|
|git|1:2.25.1-1|
|jq|1.6-1|
|net-tools|1.60+git20180626.aebd88e-1|
|netcat|1.206-1|
|python-is-python3|3.8.2-4|
|python3-pip|20.0.2-5|
|unzip|6.0-25|
|vim|2:8.1.2269-1|
|wget|1.20.3-1|


## PIP
| Package     | Version  |
| ----------- | -------- |
|csvkit|1.0.7|
|yq|3.1.0|
