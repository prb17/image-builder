#!/bin/bash

#debug docker build context env var
if [[ -z ${DOCKER_BUILD_CONTEXT} ]]; then
	echo "Cannot find env variable 'DOCKER_BUILD_CONTEXT'";
	exit -1;
else
	echo "The docker build context is: '${DOCKER_BUILD_CONTEXT}'";
fi

#debug the desired image tag
if [[ -z ${DOCKER_BUILD_TAG} ]]; then
	echo "Cannot find env variable 'DOCKER_BUILD_TAG'";
	exit -1;
else
	echo "The docker image to be built will be tagged with: '${DOCKER_BUILD_TAG}'";
fi

#debug docker registry to publish to
if [[ -z ${DOCKER_PUBLISH_REGISTRY+x} ]]; then
	echo "No docker registry to publish to, only performing build step";
	echo "If you would like to publish to a registry, set the 'DOCKER_PUBLISH_REGISTRY' env variable";
else
	echo "The docker registry to publish to: '${DOCKER_PUBLISH_REGISTRY}'";
fi

docker build ${DOCKER_BUILD_CONTEXT} -t ${DOCKER_BUILD_TAG}

# todo: check if we should publish the image first, if so, the publish to desired registry
if [[ -n "${DOCKER_PUBLISH_REGISTRY}" ]]; then
	echo "Publishing '${DOCKER_BUILD_TAG}' to '${DOCKER_PUBLISH_REGISTRY}'";
fi

docker rmi -f ${DOCKER_BUILD_TAG}
