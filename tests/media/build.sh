cp -rf ./openslides-media-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-media:latest | docker load