[![Image Builder Build CI](https://github.com/prb17/image-builder/actions/workflows/image-builder-build.yml/badge.svg)](https://github.com/prb17/image-builder/actions/workflows/image-builder-build.yml)
[![Image Builder latest](https://github.com/prb17/image-builder/actions/workflows/image-builder-deploy.yml/badge.svg)](https://github.com/prb17/image-builder/actions/workflows/image-builder-deploy.yml)

# image-builder
Repo that creates a docker image that will build other docker images, as well as publish them.

This tool is meant to be normally run in a ci/cd workflow build for image-config repo, but other repos can use it as well

 ### Variables to set
  - `DOCKER_BUILD_CONTEXT` - location to build context
  - `DOCKER_BUILD_IMAGE_NAME` - name to give the newly built image
  - `DOCKER_BUILD_TAG` - what to tag the build with
  - `DOCKER_PUBLISH_REGISTRY` - where to publish the image
 
Example command run in workflow:
```
 run: |
        export DOCKER_BUILD_CONTEXT=`pwd` 
        export DOCKER_BUILD_IMAGE_NAME=${{ env.IMAGE_NAME }} 
        export DOCKER_BUILD_TAG=${{ env.IMAGE_TAG }}
        export DOCKER_PUBLISH_REGISTRY=${{ env.REGISTRY }}/${{ github.actor }}/${{ github.repository }}
        entrypoint.sh
```

Example command run locally:
```
cd /path/to/Dockerfile;
 DOCKER_BUILD_CONTEXT=`pwd` && \
 DOCKER_BUILD_TAG=latest && \
 docker run -v /var/run/docker.sock:/var/run/docker.sock \
    -v ${DOCKER_BUILD_CONTEXT}:${DOCKER_BUILD_CONTEXT} \
    -e DOCKER_BUILD_IMAGE_NAME=ubuntu-dev \
    -e DOCKER_BUILD_CONTEXT=${DOCKER_BUILD_CONTEXT} \
    -e DOCKER_BUILD_TAG=${DOCKER_BUILD_TAG} \
    -e DOCKER_PUBLISH_REGISTRY=ghcr.io/prb17/image-config \
    -it image-builder:local
 ```
