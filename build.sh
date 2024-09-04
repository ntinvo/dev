#!/bin/bash

# add your customization script here.

export REPO=${REPO:-"localhost"}
export MODE=${MODE:-"base,agent"}
export WAR_FILES=${WAR_FILES:-"smcfs"}

# Go to the directory where the script is located
cd /opt/ssfs/runtime/container-scripts/imagebuild

# Generate the images
./generateImages.sh --REPO=$REPO --MODE=$MODE --WAR_FILES=$WAR_FILES --EXPORT=false

# Push the images to the registry
(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
for i in $(echo $MODE | tr "," "\n"); do
  echo "Pushing image $REPO/om-$i:10.0"
  buildah push --tls-verify=false --authfile=/tmp/.dockercfg $REPO/om-$i:10.0
done