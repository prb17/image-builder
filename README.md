[![Image Builder latest](https://github.com/prb17/image-builder/actions/workflows/image-builder-deploy.yml/badge.svg)](https://github.com/prb17/image-builder/actions/workflows/image-builder-deploy.yml)

# image-builder
Repo that creates a docker image that will build other docker images, as well as publish them.

This tool is meant to be normally run in a ci/cd workflow build for image-config repo.

but other repos can use it as well

 ### Variables to set
 `DOCKER_BUILD_CONTEXT` - location to build context
 `DOCKER_BUILD_TAG` - what image-builder should tag the build with
 `DOCKER_PUBLISH_REGISTRY` - where to publish the image
 
Example command:
```
 docker run -v /var/run/docker.sock:/var/run/docker.sock -v ${DOCKER_BUILD_CONTEXT}:${DOCKER_BUILD_CONTEXT} -e DOCKER_BUILD_CONTEXT=${DOCKER_BUILD_CONTEXT} -e DOCKER_BUILD_TAG=${DOCKER_BUILD_TAG} -e DOCKER_PUBLISH_REGISTRY=my-reg -it image-builder
 ```
