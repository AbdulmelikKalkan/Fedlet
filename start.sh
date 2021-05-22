#!/bin/bash
#
# Author: Abdulmelik Kalkan <kalkanabdulmelik@gmail.com>
#

#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
#set -o nounset
# don't hide errors within pipes
#set -o pipefail
#set -euo pipefail
#set -xeuo pipefail
set -eo pipefail
#}}}

. utils.sh


check_env_var "FEDLET_PROTOCOL"
check_env_var "FEDLET_HOST"
check_env_var "FEDLET_PORT"
check_env_var "FEDLET_DESCRIPTOR"

#find ./conf/* -type f -exec sed -i "s/com.iplanet.am.server.protocol=http/com.iplanet.am.server.protocol=${FEDLET_PROTOCOL}/g" {} +
sed -i "s/com.iplanet.am.server.protocol=http/com.iplanet.am.server.protocol=${FEDLET_PROTOCOL}/g" ./fedlet/*.properties
sed -i "s/com.iplanet.am.server.host=openam.example.com/com.iplanet.am.server.host=${FEDLET_HOST}/g" ./fedlet/*.properties
sed -i "s/com.iplanet.am.server.port=8080/com.iplanet.am.server.port=${FEDLET_PORT}/g" ./fedlet/*.properties
sed -i "s+com.iplanet.am.services.deploymentDescriptor=/openam+com.iplanet.am.services.deploymentDescriptor=/${FEDLET_DESCRIPTOR}+g" ./fedlet/*.properties

check_env_var "FEDLET_COT"
check_env_var "FEDLET_IDP_ENTITY_ID"
check_env_var "FEDLET_SP_ENTITY_ID"

sed -i "/cot-name/c\cot-name=${FEDLET_COT}" ./fedlet/*.cot
#sed -i "/sun-fm-trusted-providers/c\sun-fm-trusted-providers=${FEDLET_IDP_ENTITY_ID}, ${FEDLET_SP_ENTITY_ID}" ./fedlet/*.cot
. set-providers.sh ${FEDLET_IDP_ENTITY_ID} ${FEDLET_SP_ENTITY_ID}

sed -i "s+FEDLET_ENTITY_ID+${FEDLET_SP_ENTITY_ID}+g" ./fedlet/sp.xml
sed -i "s/FEDLET_PROTOCOL/${FEDLET_PROTOCOL}/g" ./fedlet/sp.xml
sed -i "s/FEDLET_HOST/${FEDLET_HOST}/g" ./fedlet/sp.xml
sed -i "s/FEDLET_PORT/${FEDLET_PORT}/g" ./fedlet/sp.xml
sed -i "s/FEDLET_DEPLOY_URI/${FEDLET_DESCRIPTOR}/g" ./fedlet/sp.xml

sed -i "s+FEDLET_ENTITY_ID+${FEDLET_SP_ENTITY_ID}+g" ./fedlet/sp-extended.xml
sed -i "s/FEDLET_PROTOCOL/${FEDLET_PROTOCOL}/g" ./fedlet/sp-extended.xml
sed -i "s/FEDLET_HOST/${FEDLET_HOST}/g" ./fedlet/sp-extended.xml
sed -i "s/FEDLET_PORT/${FEDLET_PORT}/g" ./fedlet/sp-extended.xml
sed -i "s/FEDLET_DEPLOY_URI/${FEDLET_DESCRIPTOR}/g" ./fedlet/sp-extended.xml
sed -i "s/fedletcot/${FEDLET_COT}/g" ./fedlet/sp-extended.xml

sed -i "s,IDP_ENTITY_ID,${FEDLET_IDP_ENTITY_ID},g" ./fedlet/idp-extended.xml
sed -i "s/fedletcot/${FEDLET_COT}/g" ./fedlet/idp-extended.xml

#/usr/local/tomcat/bin/catalina.sh run
