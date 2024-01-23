cp -rf ./openslides-autoupdate-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-autoupdate:latest | docker load