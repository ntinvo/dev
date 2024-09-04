#!/bin/bash

# add your customization script here.

cd /opt/ssfs/runtime/container-scripts/imagebuild
./generateImages.sh --MODE=app --WAR_FILES=smcfs --EXPORT=false

# Add authentication to access the Red Hat OpenShift Container Platform Docker registry. 
# Tag and push the images to Red Hat OpenShift Container Platform Docker registry.

(echo "{ \"auths\": " ; sudo cat $PUSH_DOCKERCFG_PATH/.dockercfg ; echo "}") > /tmp/.dockercfg
buildah tag om-app:10.0 ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}
buildah push --tls-verify=false --authfile=/tmp/.dockercfg ${OUTPUT_REGISTRY}/${OUTPUT_IMAGE}