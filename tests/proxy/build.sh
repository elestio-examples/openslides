cp -rf ./openslides-proxy/* ./
docker buildx build . --output type=docker,name=elestio4test/openslides-proxy:latest | docker load