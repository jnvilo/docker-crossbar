#
# This is used only for manual builds and testing.
# Our gitlab ci pipeline does not use this Makefile. 
# Use for local building and testing. 
# Locally built images should not be pushed to harbor. 
# Instead commit to gitlab and let gitlab do the build 
# and push. 
#

REGISTRY_URL=harbor.abakuscloud.com
PROJECT=library
IMAGE_NAME=crossbar
TAG=0.0.11

.PHONY: build  all build_image pull tag clean 

all:  build tag

build_image:
	docker build -t "${IMAGE_NAME}:latest" -f "Dockerfile" .

pull:   
	docker  pull ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest 

tag: build
	docker tag ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG} ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest


build: build_image 
	docker tag "${IMAGE_NAME}:latest"  ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest
	docker tag "${IMAGE_NAME}:latest"  ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG}
 
push: tag
	docker push "${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest"
	docker push "${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG}"

clean:
	docker rm ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:latest
	docker rm ${REGISTRY_URL}/${PROJECT}/${IMAGE_NAME}:${TAG}



