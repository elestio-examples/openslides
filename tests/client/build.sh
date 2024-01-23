cp -rf ./openslides-client/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-client:latest | docker load