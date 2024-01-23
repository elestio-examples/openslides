cp -rf ./openslides-icc-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-icc:latest | docker load