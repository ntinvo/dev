#!/bin/bash

# add your customization script here.
sudo -iu omsuser bash -c "
whoami
export REPO=\${REPO:-'localhost'}
export MODE=\${MODE:-'app'}
export WAR_FILES=\${WAR_FILES:-'smcfs'}

cd /opt/ssfs/runtime/container-scripts/imagebuild
./generateImages.sh --REPO=\$REPO --MODE=\$MODE --WAR_FILES=\$WAR_FILES --EXPORT=false

(echo '{ \"auths\": ' ; sudo cat \$PUSH_DOCKERCFG_PATH/.dockercfg ; echo '}') > /tmp/.dockercfg
for i in \$(echo \$MODE | tr ',' '\n'); do
  echo 'Pushing image \$REPO/om-\$i:10.0'
  buildah push --tls-verify=false --authfile=/tmp/.dockercfg \$REPO/om-\$i:10.0
done
"