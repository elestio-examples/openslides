cp -rf ./openslides-manage-service/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-manage:latest | docker load