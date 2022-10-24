#!/bin/bash
export thisTag=`cat version.txt`
aptPackages=files/aptPackages.txt
pipPackages=files/pipPackages.txt
#
# Update Base Version
#
export baseVersion=`docker run -it donbower/ubuntu-base:${thisTag} grep ^VERSION= /etc/os-release | tr -d '\n' | tr -d '\r'`
echo -e "Update Base Version to ${baseVersion}..."
sed -i .old  "s/^VERSION=.*/${baseVersion}/g" README.md 
#
# update Cloud Versions
#
echo -e "Update Cloud Versions..."
export awsCLIVersion=`docker run -it donbower/ubuntu-base:${thisTag} aws --version | cut -d "/" -f 2 | awk '{print $1}'`
sed -i .old  "s/^|aws-cli|.*/|aws-cli|${awsCLIVersion}|/g" README.md
#
# LOL, azure returns windows format, even in linux
#
export azureCLIVersion=`docker run -it donbower/ubuntu-base:${thisTag} az --version | grep azure-cli | awk '{print $2}' | tr -d '\r\n'`
sed -i .old  "s/^|azure-cli|.*/|azure-cli|${azureCLIVersion}|/g" README.md
#
# Update APT Packege Versions
#
echo -e "Update APT Package Versions..."
docker run \
  -it \
  donbower/ubuntu-base:${thisTag} \
    apt list --installed | \
      sed 's/[^[:print:]]//g' | \
      sed 's/\[32m//g' | \
      sed 's/\[0m//g' | \
      awk '{print $1"/"$2}' | \
      sed 's/^ubuntu/\n/; s/ubuntu.*//g; s/^\n/ubuntu/' | \
      awk -F "/" '{print $1","$3}' \
        > aptInstalled.txt

while read aptPackage; do
  aptVersion=`grep -e "^${aptPackage}," aptInstalled.txt | awk -F"," '{print $2}'`

  # echo -e "Update ${aptPackage} to version ${aptVersion}"
  sed -i .old  "s/^|${aptPackage}|.*/|${aptPackage}|${aptVersion}|/g" README.md
done < ${aptPackages}
#
# Update PIP Package Versions
#
echo -e "Update PIP Package Versions..."
docker run -it donbower/ubuntu-base:${thisTag} pip list installed > pipInstalled.txt
while read pipPackage; do
  pipVersion=`grep ^${pipPackage} pipInstalled.txt | awk '{print $2}'`

  # echo -e "Update ${pipPackage} to version ${pipVersion}"
  sed -i .old  "s/^|${pipPackage}|.*/|${pipPackage}|${pipVersion}|/g" README.md
done < ${pipPackages}

