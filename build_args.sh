#!/bin/bash
if [[ ${DEBUG} -ge 1 ]]; then
  printf "%-50.50s: %s\n" "1${DOTDOTDOT}" "${1}"
  printf "%-50.50s: %s\n" "2${DOTDOTDOT}" "${2}"
  printf "%-50.50s: %s\n" "DEBUG${DOTDOTDOT}" "${DEBUG}"
  printf "%-50.50s: %s\n" "VAULT_ADDR${DOTDOTDOT}" "${VAULT_ADDR}"
  printf "%-50.50s: %s\n" "VAULT_SKIP_VERIFY${DOTDOTDOT}" "${VAULT_SKIP_VERIFY}"
  printf "%-50.50s: %s\n" "VAULT_ROLE_ID${DOTDOTDOT}" "${VAULT_ROLE_ID}"
  printf "%-50.50s: %s\n" "VAULT_SECRET_ID${DOTDOTDOT}" "${VAULT_SECRET_ID:0:5}..."
  printf "%-50.50s: %s\n" "BUILD_STEP${DOTDOTDOT}" "${BUILD_STEP}"
  printf "%-50.50s: %s\n" "BUILD_ARGS_FILE${DOTDOTDOT}" "${BUILD_ARGS_FILE}"
fi

thisTag=$(cat docker-repo/version.txt)
thisTagMinor=$(echo "${thisTag}" | cut -d "." -f 1-2)
thisTagMajor=$(echo "${thisTag}" | cut -d "." -f 1)

if [[ "${1}" == "test" ]]; then
  echo -e "${thisTag}-rc" > docker-repo/additional_tags
else
  {
    echo -e "${thisTag}"
    echo -e "${thisTagMinor}"
    echo -e "${thisTagMajor}"
    echo -e "latest"
  } > docker-repo/additional_tags
fi

if [[ ${DEBUG} -ge 3 ]]; then
  echo -e "docker-repo/additional_tags"
  cat docker-repo/additional_tags
fi

cat > "${2}" <<EOF
---
VAULT_VERSION: '1.19.2'
DOCKER_TAG: "${thisTag}"
ATC_EXTERNAL_URL: "${ATC_EXTERNAL_URL}"
EOF

if [[ ${DEBUG} -ge 3 ]]; then
  echo -e "\"${2}\""
  cat "${2}"
fi
