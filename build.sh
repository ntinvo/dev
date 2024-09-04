#!/bin/bash

# add your customization script here.

cd /opt/ssfs/runtime/container-scripts/imagebuild
./generateImages.sh --REPO="${OUTPUT_REGISTRY}/ntinvo" --MODE=base,agent --WAR_FILES=smcfs --EXPORT=false

# Add authentication to access the Red Hat OpenShift Container Platform Docker registry. 
# Tag and push the images to Red Hat OpenShift Container Platform Docker registry.

(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/ntinvo/oms-base:10.0
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/ntinvo/oms-agent:10.0
