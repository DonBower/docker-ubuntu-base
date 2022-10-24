cat ~/.ssh/dockerpw | docker login --username donbower --password-stdin

export thisTag=`cat version.txt`
export tfVersion=`echo ${thisTag} | cut -d "-" -f 1`
export azSubscriptionID=`vault kv get -format=json concourse/common/azure/role_Contributor | jq --raw-output .data.data.subscriptionId`
export azClientID=`vault kv get -format=json concourse/common/azure/role_Contributor | jq --raw-output .data.data.appId`
export azClientSecret=`vault kv get -format=json concourse/common/azure/role_Contributor | jq --raw-output .data.data.password`
export azTenantID=`vault kv get -format=json concourse/common/azure/role_Contributor | jq --raw-output .data.data.tenant`

docker build \
  --build-arg DOCKER_TAG=${thisTag} \
  --build-arg ARM_SUBSCRIPTION_ID=${azSubscriptionID} \
  --build-arg ARM_CLIENT_ID=${azClientID} \
  --build-arg ARM_CLIENT_SECRET=${azClientSecret} \
  --build-arg ARM_TENANT_ID=${azTenantID} \
  --tag donbower/ubuntu-base:${thisTag} \
  .
errorLevel=$?
if [[ ${errorLevel} -gt 0 ]]; then
  echo docker build failed, exiting...
  exit ${errorLevel}
fi

./getVersions.sh