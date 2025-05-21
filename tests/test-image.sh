#!/bin/bash
export DOTDOTDOT=".................................................."

if [[ ${DEBUG} -ge 1 ]]; then
  printf "%-50.50s: %s\n" "DEBUG${DOTDOTDOT}" "${DEBUG}"
  printf "%-50.50s: %s\n" "VAULT_ADDR${DOTDOTDOT}" "${VAULT_ADDR}"
  printf "%-50.50s: %s\n" "VAULT_SKIP_VERIFY${DOTDOTDOT}" "${VAULT_SKIP_VERIFY}"
  printf "%-50.50s: %s\n" "VAULT_ROLE_ID${DOTDOTDOT}" "${VAULT_ROLE_ID}"
  printf "%-50.50s: %s\n" "VAULT_SECRET_ID${DOTDOTDOT}" "${VAULT_SECRET_ID:0:5}..."
  printf "%-50.50s: %s\n" "BUILD_STEP${DOTDOTDOT}" "${BUILD_STEP}"
  printf "%-50.50s: %s\n" "BUILD_ARGS_FILE${DOTDOTDOT}" "${BUILD_ARGS_FILE}"
  printf "%-50.50s: %s\n" "ATC_EXTERNAL_URL${DOTDOTDOT}" "${ATC_EXTERNAL_URL}"
fi

# cat > tools.csv <<EOF
# jq,apt-get,--version
# wget,apt-get,--version | head -n 1 | awk '{print \$3}'
# curl,apt-get,--version | head -n 1 | awk '{print \$2}'
# python,apt-get,--version
# yq,pip,--version
# csvlook,pip,--version
# fly,wget,--version
# EOF

# printf "%-50.50s: %s\n" "tool" "version"

# IFS=","
# while read -r thisTool thisMethod versionCMD; do
#   thisToolLocation=$(which "${thisTool}")

#   if [[ -z "${thisToolLocation}" ]]; then
#     echo -e "Missing tool ${thisTool}, installed via ${thisMethod}"
#     exit 1
#   else
#     thisVersion=$(eval "${thisTool} ${versionCMD}")
#     printf "%-50.50s: %s\n" "${thisTool} ${DOTDOTDOT}" "${thisVersion}"
#   fi

# done < tools.csv

# if [[ ${DEBUG} -ge 1 ]]; then
#   echo -e "concourseWebVersion=\$(curl --silent --insecure \"${ATC_EXTERNAL_URL}/api/v1/info\" | jq --raw-output .version)"
# fi

# concourseWebVersion=$(curl --silent --insecure "${ATC_EXTERNAL_URL}/api/v1/info" | jq --raw-output .version)
# concourseFlyVersion=$(fly --version)

# if [[ ${DEBUG} -ge 1 ]]; then
#   printf "%-50.50s: %s\n" "concourseWebVersion${DOTDOTDOT}" "${concourseWebVersion}"
#   printf "%-50.50s: %s\n" "concourseFlyVersion${DOTDOTDOT}" "${concourseFlyVersion}"
# fi

# if [[ "${concourseWebVersion}" != "${concourseFlyVersion}" ]]; then
#   echo -e "Fly Version \"${concourseFlyVersion}\" does not match Web Version \"${concourseWebVersion}\""
#   exit 1
# fi

echo -e "All Tests pass, tag image"
thisTag=$(cat docker-repo/version.txt)
thisTagMinor=$(echo "${thisTag}" | cut -d "." -f 1-2)
thisTagMajor=$(echo "${thisTag}" | cut -d "." -f 1)

{
  echo -e "${thisTag}"
  echo -e "${thisTagMinor}"
  echo -e "${thisTagMajor}"
  echo -e "latest"
} > docker-repo/additional_tags

echo -e "Image Tags:"
cat docker-repo/additional_tags

echo -e ""
printf "%-50.50s: " "uname kernel name${DOTDOTDOT}"
uname -s

printf "%-50.50s: " "uname kernel version${DOTDOTDOT}"
uname -r

printf "%-50.50s: " "uname machine hardware name${DOTDOTDOT}"
uname -m

printf "%-50.50s: " "uname operating system${DOTDOTDOT}"
uname -o

printf "%-50.50s: " "uname processor type${DOTDOTDOT}"
uname -p

printf "%-50.50s: " "os version${DOTDOTDOT}"
cat /etc/*ease | grep 'VERSION=' | cut -d "=" -f 2
echo -e ""
# cat /etc/*ease
